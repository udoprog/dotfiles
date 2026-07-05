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
-- Channel mapping: ports are paired by matching audio.channel (FL->FL,
-- FR->FR, MONO->MONO). An input port whose same-named source port has not
-- appeared yet is left for a later rescan, so ports are never mislinked while
-- the graph is still filling in. The one format conversion these rules perform
-- is stereo -> mono: a MONO input port has no same-named source, so every
-- source port is linked into it and pipewire mixes them down (the stereo
-- "bluetooth_out" feeding an HFP headset sink that only exposes MONO).
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

  -- index the present source ports by their channel
  local out_by_channel = {}
  for _, out_port in ipairs(outs) do
    local channel = out_port.properties["audio.channel"]
    if channel ~= nil then
      out_by_channel[channel] = out_port
    end
  end

  for _, in_port in ipairs(ins) do
    local channel = in_port.properties["audio.channel"]
    local match = channel and out_by_channel[channel]

    if match then
      -- same channel on both sides (FL->FL, FR->FR, MONO->MONO)
      make_link(match, in_port)
    elseif channel == "MONO" then
      -- a mono sink with no same-named source: downmix every source into it,
      -- pipewire mixes the links landing on the one port
      for _, out_port in ipairs(outs) do
        make_link(out_port, in_port)
      end
    end
    -- otherwise the matching source port hasn't appeared yet; a later rescan
    -- will pair them
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
