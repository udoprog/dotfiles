-- Link bluetooth capture nodes to the "bluetooth" virtual source so the
-- software mixer picks them up.
--
-- PipeWire exposes a headset-head-unit input as two nodes: an internal
-- hardware node (Audio/Source/Internal, name like bluez_input.XX_XX....N)
-- and a public loopback node (Audio/Source, name like bluez_input.XX:XX:...).
-- Only the public one is meant to be consumed, and only it has a stable
-- name, so that is what we match here.
--
-- Links are made per-port and re-evaluated whenever nodes or ports appear,
-- because ports show up some time after their node does.

local log = Log.open_topic("bt-input-autolink")

local TARGET_NODE_NAME = "bluetooth"

local bt_om = ObjectManager {
  Interest {
    type = "node",
    Constraint { "media.class", "equals", "Audio/Source" },
    Constraint { "node.name", "matches", "bluez_input.*" },
  }
}

local target_om = ObjectManager {
  Interest {
    type = "node",
    Constraint { "node.name", "equals", TARGET_NODE_NAME },
  }
}

local ports_om = ObjectManager {
  Interest { type = "port" }
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

local function link_nodes(bt_node, target_node)
  local outs = node_ports(bt_node, "out")
  local ins = node_ports(target_node, "in")

  -- ports not created yet; rescan runs again when they appear
  if #outs == 0 or #ins == 0 then
    return
  end

  for i, in_port in ipairs(ins) do
    local out_port = nil

    if #outs == 1 then
      -- mono source feeds every target channel
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
  local target = target_om:lookup()
  if target == nil then
    return
  end

  for bt_node in bt_om:iterate() do
    link_nodes(bt_node, target)
  end
end

bt_om:connect("object-added", rescan)
target_om:connect("object-added", rescan)
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

bt_om:activate()
target_om:activate()
ports_om:activate()
