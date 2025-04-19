return {
    run = function()
        fassert(rawget(_G, "new_mod"), "`SilentRev` encountered an error loading the Darktide Mod Framework.")

        new_mod("SilentRev", {
            mod_script       = "SilentRev/scripts/mods/SilentRev/SilentRev",
            mod_data         = "SilentRev/scripts/mods/SilentRev/SilentRev_data",
            mod_localization = "SilentRev/scripts/mods/SilentRev/SilentRev_localization",
        })
    end,
    packages = {},
}
