-- Link bluetooth device nodes to the stable virtual nodes used by the
-- software mixer:
--
--   bluez_input.* (Audio/Source)  ->  "bluetooth_in" virtual source
--   "bluetooth_out" virtual sink  ->  bluez_output.* (Audio/Sink)
--
-- PipeWire exposes a headset-head-unit input as two nodes: an internal
-- hardware node (Audio/Source/Internal, name like bluez_input.XX_XX....N)
-- and a public loopback node (Audio/Source, name like bluez_input.XX:XX:...).
-- Only the public one is meant to be consumed, so that is what we match.
-- Output sinks have no such split, but their names carry a volatile .N
-- suffix, hence the pattern matches on both sides.
--
-- Channel mapping: ports are paired by audio.channel (FL->FL, FR->FR, ...).
-- When an input channel is not part of the source node's declared layout
-- (audio.position) it is a genuine format conversion, so every source port is
-- routed into it and pipewire mixes them (FL/FR -> MONO downmix, MONO -> FL/FR
-- fan-out). An input channel that the source *is* expected to expose but hasn't
-- materialised yet is left for a later rescan, so ports never get mislinked
-- while the graph is still filling in.
--
-- Links are made per-port and re-evaluated whenever nodes or ports appear,
-- because ports show up some time after their node does.

local log = Log.open_topic("bt-autolink")

local ports_om = ObjectManager {
  Interest { type = "port" }
}

-- each rule links output ports of nodes matching `out_om` to input ports
-- of nodes matching `in_om`
local rules = {
  {
    out_om = ObjectManager {
      Interest {
        type = "node",
        Constraint { "media.class", "equals", "Audio/Source" },
        Constraint { "node.name", "matches", "bluez_input.*" },
      }
    },
    in_om = ObjectManager {
      Interest {
        type = "node",
        Constraint { "node.name", "equals", "bluetooth_in" },
      }
    },
  },
  {
    out_om = ObjectManager {
      Interest {
        type = "node",
        Constraint { "node.name", "equals", "bluetooth_out" },
      }
    },
    in_om = ObjectManager {
      Interest {
        type = "node",
        Constraint { "media.class", "equals", "Audio/Sink" },
        Constraint { "node.name", "matches", "bluez_output.*" },
      }
    },
  },
}

-- links we created, keyed by "<output-port-id>:<input-port-id>"
local links = {}

-- ordered channel layout declared by a node, e.g. "[ FL FR ]" -> {"FL","FR"};
-- nil when the node has no audio.position (the bluez_* device nodes)
local function node_positions(node)
  local pos = node.properties["audio.position"]
  if pos == nil then
    return nil
  end
  local list = {}
  for ch in pos:gmatch("[%w_]+") do
    table.insert(list, ch)
  end
  return list
end

local function node_ports(node, direction)
  local result = {}
  for port in ports_om:iterate(Interest {
    type = "port",
    Constraint { "node.id", "equals", tostring(node["bound-id"]) },
    Constraint { "port.direction", "equals", direction },
  }) do
    table.insert(result, port)
  end
  table.sort(result, function(a, b)
    return (tonumber(a.properties["port.id"]) or 0)
      < (tonumber(b.properties["port.id"]) or 0)
  end)
  return result
end

local function make_link(out_port, in_port)
  local key = out_port["bound-id"] .. ":" .. in_port["bound-id"]
  if links[key] ~= nil then
    return
  end

  log:info("linking port " .. key)

  local link = Link("link-factory", {
    ["link.output.port"] = out_port["bound-id"],
    ["link.input.port"] = in_port["bound-id"],
  })
  links[key] = link

  link:connect("state-changed", function(_, _, new_state)
    if new_state == "error" then
      -- drop it so the next rescan can retry
      log:warning("link " .. key .. " failed")
      links[key] = nil
    end
  end)

  link:activate(1)
end

local function link_nodes(out_node, in_node)
  local outs = node_ports(out_node, "out")
  local ins = node_ports(in_node, "in")

  -- ports not created yet; rescan runs again when they appear
  if #outs == 0 or #ins == 0 then
    return
  end

  -- map each present output port by its channel, and record the set of
  -- channels the output node is *expected* to expose. audio.position gives
  -- the declared layout (virtual nodes); when absent (bluez_* nodes) fall
  -- back to whatever ports are present so far.
  local out_by_channel = {}
  for _, o in ipairs(outs) do
    local channel = o.properties["audio.channel"]
    if channel ~= nil then
      out_by_channel[channel] = o
    end
  end

  local out_expected = {}
  local positions = node_positions(out_node)
  if positions ~= nil then
    for _, channel in ipairs(positions) do
      out_expected[channel] = true
    end
  else
    for channel in pairs(out_by_channel) do
      out_expected[channel] = true
    end
  end

  for _, in_port in ipairs(ins) do
    local channel = in_port.properties["audio.channel"]
    local match = channel ~= nil and out_by_channel[channel] or nil

    if match ~= nil then
      -- same channel on both sides: pair them directly (FL->FL, FR->FR, ...)
      make_link(match, in_port)
    elseif channel ~= nil and out_expected[channel] then
      -- the matching output port is expected but hasn't appeared yet; skip
      -- and let a later rescan pair them, rather than mislinking now
    else
      -- the input channel is not part of the output layout: this is a real
      -- format conversion (e.g. FL/FR -> MONO downmix, or MONO -> FL/FR
      -- fan-out). Route every present output port into it; pipewire mixes
      -- multiple links landing on one input port.
      for _, out_port in ipairs(outs) do
        make_link(out_port, in_port)
      end
    end
  end
end

local function rescan()
  for _, rule in ipairs(rules) do
    for out_node in rule.out_om:iterate() do
      for in_node in rule.in_om:iterate() do
        link_nodes(out_node, in_node)
      end
    end
  end
end

ports_om:connect("object-added", rescan)

-- pipewire destroys links whose ports go away; just drop our references so
-- the pair can be linked again later
ports_om:connect("object-removed", function(_, port)
  local id = tostring(port["bound-id"])
  for key in pairs(links) do
    local out_id, in_id = key:match("^(%d+):(%d+)$")
    if out_id == id or in_id == id then
      links[key] = nil
    end
  end
end)

ports_om:activate()

for _, rule in ipairs(rules) do
  rule.out_om:connect("object-added", rescan)
  rule.in_om:connect("object-added", rescan)
  rule.out_om:activate()
  rule.in_om:activate()
end
