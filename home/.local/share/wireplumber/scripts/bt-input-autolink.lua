local log = Log.open_topic("bt-input-autolink")
local TARGET_NODE_NAME = "bluetooth"

log:notice("starting input auto link")

local bt_om = ObjectManager {
  Interest {
    type = "node",
    Constraint { "node.name", "equals", "bluez_input.3C_B0_ED_A8_CA_98.0" },
    -- Constraint { "api.bluez5.codec", "equals", "msbc" },
    -- Constraint { "api.bluez5.profile", "equals", "headset-head-unit" },
    -- Constraint { "api.bluez5.internal", "is-absent" },
  }
}

local target_om = ObjectManager {
  Interest {
    type = "node",
    Constraint { "node.name", "equals", TARGET_NODE_NAME },
  }
}

local current_link = nil

local function try_link()
  if current_link ~= nil then
    log:notice("already have a link, skipping")
    return
  end

  local bt_node = bt_om:lookup()
  local target_node = target_om:lookup()

  if bt_node == nil then
    log:notice("bluetooth node not found")
    return
  end

  if target_node == nil then
    log:notice("target node not found")
    return
  end

  current_link = Link("link-factory", {
    ["link.output.node"] = bt_node["bound-id"],
    ["link.input.node"]  = target_node["bound-id"],
    ["node.description"] = "BT input autolink",
  })

  log:notice("activating link")
  current_link:activate(1)
end

bt_om:connect("object-added", try_link)
target_om:connect("object-added", try_link)

bt_om:connect("object-removed", function()
  current_link = nil
end)

bt_om:activate()
target_om:activate()
