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

-- -------------
-- Replace Sounds
-- -------------
-- Paramater(s):
--      bool: settings_changed
--          indicates if we're calling this from on_settings_changed
-- Description: Replaces sounds in the player sound events tables
-- Return: N/A
-- -------------
local function replace_sounds(settings_changed)
    local debug = mod:get("enable_debug_mode")
    use_audio = mod:get("use_audio")
    if use_audio then
        Audio = get_mod("Audio")
        if not Audio then
            mod:error("Audio plugin is required for this option!")
            return
        end
    end

    if debug then
        mod:echo("Audio plugin option: "..tostring(use_audio))
        mod:echo("Disable rev up option: "..tostring(mod:get("disable_rev_up")))
        mod:echo("Disable rev idle option: "..tostring(mod:get("disable_rev_idle")))
        mod:echo("Disable rev down option: "..tostring(mod:get("disable_rev_down")))
    end

    -- Rev up VRRRRRRRRRRRRRR
    if mod:get("disable_rev_up") then
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
            PlayerCharacterSoundEventAliases.sfx_weapon_up.events[weapon_name] = "wwise/events/weapon/play_weapon_silence" 
        end
    --  If not disabled and settings just got changed, put them back
    elseif settings_changed then
        PlayerCharacterSoundEventAliases.sfx_weapon_up.events["chainaxe_p1_m1"] = "wwise/events/weapon/play_chainaxe_special_start"
        PlayerCharacterSoundEventAliases.sfx_weapon_up.events["chainaxe_p1_m2"] = "wwise/events/weapon/play_chainaxe_special_start"
        PlayerCharacterSoundEventAliases.sfx_weapon_up.events["chainsword_2h_p1_m1"] = "wwise/events/weapon/play_2h_chainsword_special_start"
        PlayerCharacterSoundEventAliases.sfx_weapon_up.events["chainsword_2h_p1_m2"] = "wwise/events/weapon/play_2h_chainsword_special_start"
        PlayerCharacterSoundEventAliases.sfx_weapon_up.events["chainsword_p1_m1"] = "wwise/events/weapon/play_combat_weapon_chainsword_special_start"
        PlayerCharacterSoundEventAliases.sfx_weapon_up.events["chainsword_p1_m2"] = "wwise/events/weapon/play_combat_weapon_chainsword_special_start"
    end

    -- Unrev purr
    if mod:get("disable_rev_down") then 
        -- Replacing sound with silence
        PlayerCharacterSoundEventAliases.weapon_special_end.events["chainaxe_p1_m1"] = "wwise/events/weapon/play_weapon_silence" 
        PlayerCharacterSoundEventAliases.weapon_special_end.events["chainaxe_p1_m2"] = "wwise/events/weapon/play_weapon_silence"
    --  If not disabled and settings just got changed, put them back
    elseif settings_changed then
        PlayerCharacterSoundEventAliases.weapon_special_end.events["chainaxe_p1_m1"] = "wwise/events/weapon/play_chainaxe_rev"
        PlayerCharacterSoundEventAliases.weapon_special_end.events["chainaxe_p1_m2"] = "wwise/events/weapon/play_chainaxe_rev"
    end

    if mod:get("disable_rev_idle") then
        --mod:hook_safe(ChainWeaponEffects, "init", function (self, context, slot, weapon_template, fx_sources)
        --    -- Replacing active sound with regular idle sound
        --    local special_active_fx_source_name = fx_sources._melee_idling
        --    self._special_active_fx_source_name = melee_idling_fx_source_name
        --end)
        --mod:hook_safe(ChainWeaponEffects, "_start_vfx_loop", function (self)
        --    return
        --end)
        --PlayerCharacterSoundEventAliases.looping_events.equipped_item_passive.events["chainaxe_p1_m1"] = "wwise/events/weapon/%s_weapon_silence" 
        -- "wwise/events/weapon/%s_chainaxe",
    end

end

-- Calls replacer at appropriate times
mod.on_all_mods_loaded = function()
    mod:info("SilentRev v"..mod.version.." loaded uwu nya :3")
    replace_sounds(false)
end
mod.on_setting_changed = function()
    replace_sounds(true)
end
