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
    disable_rev_up = {
        en = "Rev up (Special Action activation)",
    },
    disable_rev_idle = {
        en = "Rev idle [NOT WORKING]",
    },
    disable_rev_down = {
        en = "Rev down (Special Action deactivation)",
    },
}

for _, name in ipairs({"disable_rev_up", "disable_rev_idle", "disable_rev_down" }) do
    localizations[#localizations+1][name.."_option_1"] = {
        en = "Not Disabled"
    }
    localizations[#localizations+1][name.."_option_2"] = {
        en = "Silenced"
    }
    localizations[#localizations+1][name.."_option_3"] = {
        en = "Random Custom Audio"
    }
end

return localizations
