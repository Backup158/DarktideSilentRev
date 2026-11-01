local mod = get_mod("StealthRev")

local string = string
local string_regex_sub = string.gsub

mod:io_dofile("StealthRev/scripts/mods/StealthRev/utilities/FindChainWeapons")
local chain_weapon_names = mod.chain_weapon_names
local amount_of_chain_weapons = #chain_weapon_names

local localizations = {
    mod_name = {
        en = "Stealth Rev - Stealthily Operating Saws (SOS)",
    },
    mod_description = {
        en = "Reduces sound from activating the special action for chain weapons.",
    },
    -- Settings
    enable_debug_mode = {
        en = "Enable Debug Mode",
    },
    enable_debug_mode_description = {
        en = "Verbose printing for function execution",
    },
    silence_pcsea_events = {
        en = "Silencing Each Inital Startup",
    },
    silence_chain_weapon_effects = {
        en = "Silencing the Chain Speedup",
    },
    error_toggle_chain = {
        en = "Silencing the Chain Speedup cannot be toggled mid-game! You must restart the game for this change to take effect.",
    },
}

-- -------------
-- Generate Localizations for Individual weapon
-- -------------
-- Parameter(s):
--      string: setting_id
-- Description: Writes options in the localizations table for each weapon that can be disabled, using its real weapon localization
-- Return: N/A
-- -------------
local function generate_localization_for_individual_weapon(setting_id) 
    -- Fall back to mark 1, then fall back to nothing
    local weapon_pattern = Localize("loc_weapon_pattern_"..setting_id) or Localize("loc_weapon_pattern_"..string_regex_sub(setting_id, "_m%", "_m1")) or ""
	local weapon_mark = Localize("loc_weapon_mark_"..setting_id) or Localize("loc_weapon_mark_"..string_regex_sub(setting_id, "_m%", "_m1")) or ""
	local weapon_family = Localize("loc_weapon_family_"..setting_id) or Localize("loc_weapon_family_"..string_regex_sub(setting_id, "_m%", "_m1")) or ""
    localizations[setting_id] = { en = weapon_pattern.." "..weapon_mark.." "..weapon_family }
end

for i = 1, #chain_weapon_names do
    generate_localization_for_individual_weapon(chain_weapon_names[i])
end


return localizations
