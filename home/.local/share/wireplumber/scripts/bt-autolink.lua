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
-- Channel mapping: a single source port fans out to every destination
-- port, multiple source ports feeding a single destination port are all
-- linked to it (pipewire mixes them, downmixing stereo to mono), and
-- otherwise ports are paired by audio.channel with an index fallback.
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

  -- multiple channels into a single port: link all of them, pipewire
  -- mixes multiple links on one input port (stereo -> mono downmix)
  if #ins == 1 and #outs > 1 then
    for _, out_port in ipairs(outs) do
      make_link(out_port, ins[1])
    end
    return
  end

  for i, in_port in ipairs(ins) do
    local out_port = nil

    if #outs == 1 then
      -- single source port feeds every destination channel
      out_port = outs[1]
    else
      for _, o in ipairs(outs) do
        local channel = o.properties["audio.channel"]
        if channel ~= nil and channel == in_port.properties["audio.channel"] then
          out_port = o
          break
        end
      end
      out_port = out_port or outs[((i - 1) % #outs) + 1]
    end

    make_link(out_port, in_port)
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
