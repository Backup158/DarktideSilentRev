return {
    run = function()
        fassert(rawget(_G, "new_mod"), "`StealthRev` encountered an error loading the Darktide Mod Framework.")

        new_mod("StealthRev", {
            mod_script       = "StealthRev/scripts/mods/StealthRev/StealthRev",
            mod_data         = "StealthRev/scripts/mods/StealthRev/StealthRev_data",
            mod_localization = "StealthRev/scripts/mods/StealthRev/StealthRev_localization",
        })
    end,
    packages = {},
}
