local mod = get_mod("StealthRev")

local chain_weapon_names = mod.chain_weapon_names
local amount_of_chain_weapons = #chain_weapon_names

local sub_widgets_per_chain_weapon_startup = Script.new_map( amount_of_chain_weapons )

-- Adds a widget to disable each startup rev sound
for i = 1, amount_of_chain_weapons do
    sub_widgets_per_chain_weapon_startup[i] = {
        setting_id = chain_weapon_names[i],
        type = "checkbox",
        default_value = true,
    }
end

return {
    name = mod:localize("mod_name"),
    description = mod:localize("mod_description"),
    is_togglable = true,
    options = {
		widgets = {
            {
                setting_id = "enable_debug_mode",
                type = "checkbox",
                default_value = false,
            },
            {
                setting_id = "silence_pcsea_events",
                type = "group",
                sub_widgets = sub_widgets_per_chain_weapon_startup,
            },
            {
                setting_id = "silence_chain_weapon_effects",
                type = "checkbox",
                default_value = true,
            },
        }
	}
}
