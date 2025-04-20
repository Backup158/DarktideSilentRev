local mod = get_mod("SilentRev")

local finalWidgets = {}

-- Appends a toggleable option for a new widget
local function addWidget(name)
    -- Write at (table size) + 1, ie inserting at the tail
    finalWidgets[#finalWidgets + 1] = {
        setting_id = name,
        type = "checkbox",
        default_value = false,
    }
end

local widgetsToggleableToAdd = {"enable_debug_mode", "use_audio"}
for _, name in pairs(widgetsToggleableToAdd) do
    addWidget(name)
end

-- creates group with empty subwidgets
local index_for_disable_group = #finalWidgets+1
finalWidgets[index_for_disable_group] = {
    setting_id = "disable_sounds",
    type = "group",
    sub_widgets = {},
}
-- fill up the subwidgets
local subwidgetsToggleableToAdd = {"disable_rev_up", "disable_rev_idle", "disable_rev_down" }
for _, name in pairs(subwidgetsToggleableToAdd) do
    local disable_sounds_group_subwidgets = finalWidgets[index_for_disable_group]["sub_widgets"]
    disable_sounds_group_subwidgets[#disable_sounds_group_subwidgets+1] = {
        setting_id = name,
        type = "dropdown",
        default_value = "silenced",
        options = {
            {text = name.."_option_1", value = "not_disabled"},
            {text = name.."_option_2", value = "silenced"},
            {text = name.."_option_3", value = "audio_plugin"},
        },
    }
end

return {
    name = mod:localize("mod_name"),
    description = mod:localize("mod_description"),
    is_togglable = true,
    options = {
		widgets = finalWidgets
	}
}
