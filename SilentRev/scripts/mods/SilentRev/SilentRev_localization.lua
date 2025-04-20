localizations = {
    mod_name = {
        en = "Silent Revving for Chain Weapons",
    },
    mod_description = {
        en = "Removes the sound for revving up a chain weapon",
    },
    -- Settings
    enable_debug_mode = {
        en = "Enable Debug Mode",
    },
    enable_debug_mode_description = {
        en = "Verbose printing for function execution",
    },
    use_audio = {
        en = "Use Audio Plugin",
    },
    use_audio_description = {
        en = "Enables usage of custom sound effects",
    },
    disable_sounds = {
        en = "Sounds to Disable",
    },
}

-- -------------
-- Generate Localizations for Subwidget Options
-- -------------
-- Parameter(s):
--      string: setting_id
--      string: localized name (English)
-- Description: Replaces sounds in the player sound events tables
-- Return: N/A
-- -------------
local function generateLocalizationsForSubwidgetOptions(setting_id, localized_name) 
    localizations[setting_id] = {en = localized_name}
    localizations[setting_id.."_option_1"] = {en = "Not Disabled"}
    localizations[setting_id.."_option_2"] = {en = "Silenced"}
    localizations[setting_id.."_option_3"] = {en = "Random Custom Audio"}
end
generateLocalizationsForSubwidgetOptions("disable_rev_up", "Rev up (Special Action activation)")
generateLocalizationsForSubwidgetOptions("disable_rev_idle", "Rev idle [NOT WORKING]")
generateLocalizationsForSubwidgetOptions("disable_rev_down", "Rev down (Special Action deactivation)")


return localizations
