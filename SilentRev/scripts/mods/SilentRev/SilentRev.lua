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
    --
    local debug = mod:get("enable_debug_mode")
    local disable_rev_up = mod:get("disable_rev_up")
    local disable_rev_idle = mod:get("disable_rev_up")
    local disable_rev_down = mod:get("disable_rev_down")

    if disable_rev_up  then
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
            -- Rev up VRRRRRRRRRRRRRR
            PlayerCharacterSoundEventAliases["sfx_weapon_up"]["events"][weapon_name] = "wwise/events/weapon/play_weapon_silence" 
        end
    end
    -- Unrev purr
    if disable_rev_down then 
        PlayerCharacterSoundEventAliases["weapon_special_end"]["events"]["chainaxe_p1_m1"] = "wwise/events/weapon/play_weapon_silence" 
        PlayerCharacterSoundEventAliases["weapon_special_end"]["events"]["chainaxe_p1_m2"] = "wwise/events/weapon/play_weapon_silence" 
    end

    if disable_rev_idle then
        mod:hook_safe(ChainWeaponEffects, "init", function (self, context, slot, weapon_template, fx_sources)
            local special_active_fx_source_name = fx_sources._melee_idling
            self._special_active_fx_source_name = melee_idling_fx_source_name
        end)
    end
end
