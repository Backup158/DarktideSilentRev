local mod = get_mod("SilentRev")
mod.version = "1.0"

--#################################
-- Requirements
--#################################
local ChainWeaponEffects = require("scripts/extension_systems/visual_loadout/wieldable_slot_scripts/chain_weapon_effects")
local PlayerCharacterSoundEventAliases = require("scripts/settings/sound/player_character_sound_event_aliases")

--#################################
-- Hooks
--#################################
mod.on_all_mods_loaded = function()
    mod:info("SilentRev v" .. mod.version .. " loaded uwu nya :3")

    -- Table of chain weapons to iterate through
    local chain_weapons = {
        "chainaxe_p1_m1",
        "chainaxe_p1_m2",
        "chainsword_2h_p1_m1",
        "chainsword_2h_p1_m2",
        "chainsword_p1_m1",
        "chainsword_p1_m2",
    }
    -- Replacing sound with silence
    for _, weapon_name in ipairs(chain_weapons) do
        -- Rev up
        PlayerCharacterSoundEventAliases["sfx_weapon_up"]["events"][weapon_name] = "wwise/events/weapon/play_weapon_silence"
    end
end
