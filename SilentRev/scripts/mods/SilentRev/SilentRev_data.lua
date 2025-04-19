local mod = get_mod("SilentRev")

local finalWidgets = {
    {
        setting_id = "enable_debug_mode",
		type = "checkbox",
		default_value = false,
    },
}
local widgetsToggleableToAdd = {"disable_rev_up", "disable_rev_idle", "disable_rev_down" }
-- Appends a toggleable option for a new widget
local function addWidget(name)
    -- Write at (table size) + 1, ie inserting at the tail
    finalWidgets[#finalWidgets + 1] = {
        setting_id = name,
        type = "checkbox",
        default_value = true,
    }
end
-- Adds a widget for each one in the list of names
for _, name in pairs(widgetsToggleableToAdd) do
    addWidget(name)
end

return {
    name = mod:localize("mod_name"),
    description = mod:localize("mod_description"),
    is_togglable = true,
    options = {
		widgets = finalWidgets
	}
}
