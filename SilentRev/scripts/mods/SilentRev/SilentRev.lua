local mod = get_mod("SilentRev")
mod.version = "1.1"

--#################################
-- Requirements
--#################################
local ChainWeaponEffects = require("scripts/extension_systems/visual_loadout/wieldable_slot_scripts/chain_weapon_effects")
local PlayerCharacterSoundEventAliases = require("scripts/settings/sound/player_character_sound_event_aliases")
local PlayerCharacterLoopingSoundEventAliases = require("scripts/settings/sound/player_character_looping_sound_aliases")

--#################################
-- Helper Functions
--#################################
-- -------------
-- Replace Sounds
-- -------------
-- Parameter(s):
--      bool: settings_changed
--          indicates if we're calling this from on_settings_changed
-- Description: Replaces sounds in the player sound events tables
-- Return: N/A
-- -------------
local function replace_sounds(settings_changed)
    local debug = mod:get("enable_debug_mode")
    local use_audio = mod:get("use_audio")
    local audio_files
    local option_disable_rev_up = mod:get("disable_rev_up")
    local option_disable_rev_idle = mod:get("disable_rev_audio")
    local option_disable_rev_down = mod:get("disable_rev_down")

    if use_audio then
        Audio = get_mod("Audio")
        if not Audio then
            mod:error("Audio plugin is required for this option!")
            return
        end
        audio_files = Audio.new_files_handler()
    end

    if debug then
        mod:echo("Audio plugin option: "..tostring(use_audio))
        mod:echo("Disable rev up option: "..tostring(mod:get("disable_rev_up")))
        mod:echo("Disable rev idle option: "..tostring(mod:get("disable_rev_idle")))
        mod:echo("Disable rev down option: "..tostring(mod:get("disable_rev_down")))
    end

    -- Rev up VRRRRRRRRRRRRRR
    --  Reset
    if option_disable_rev_up == "not_disabled" or settings_changed then
        PlayerCharacterSoundEventAliases.sfx_weapon_up.events["chainaxe_p1_m1"] = "wwise/events/weapon/play_chainaxe_special_start"
        PlayerCharacterSoundEventAliases.sfx_weapon_up.events["chainaxe_p1_m2"] = "wwise/events/weapon/play_chainaxe_special_start"
        PlayerCharacterSoundEventAliases.sfx_weapon_up.events["chainsword_2h_p1_m1"] = "wwise/events/weapon/play_2h_chainsword_special_start"
        PlayerCharacterSoundEventAliases.sfx_weapon_up.events["chainsword_2h_p1_m2"] = "wwise/events/weapon/play_2h_chainsword_special_start"
        PlayerCharacterSoundEventAliases.sfx_weapon_up.events["chainsword_p1_m1"] = "wwise/events/weapon/play_combat_weapon_chainsword_special_start"
        PlayerCharacterSoundEventAliases.sfx_weapon_up.events["chainsword_p1_m2"] = "wwise/events/weapon/play_combat_weapon_chainsword_special_start"
    end
    --  Silenced
    if option_disable_rev_up == "silenced" then
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
            -- Screaming test to make it obvious I replaced something
            --PlayerCharacterSoundEventAliases.sfx_weapon_up.events[weapon_name] = "wwise/events/player/play_veteran_female_c__vce_scream_long" 
        end
    elseif option_disable_rev_up == "audio_plugin" then
        if not use_audio then
            mod:error("Audio plugin is required for this setting! (Rev up)")
            return
        end
        -- In lua, ? and * are . and .*, respectively
        Audio.hook_sound("play_.*_special_start", function()
            Audio.play_file(audio_files:random("revup"), { audio_type = "sfx" })
            return false
        end)
    end

    -- Unrev purr
    --  Reset sound
    if settings_changed or option_disable_rev_down == "not_disabled" then
        PlayerCharacterSoundEventAliases.weapon_special_end.events["chainaxe_p1_m1"] = "wwise/events/weapon/play_chainaxe_rev"
        PlayerCharacterSoundEventAliases.weapon_special_end.events["chainaxe_p1_m2"] = "wwise/events/weapon/play_chainaxe_rev"
    end
    if option_disable_rev_down == "silenced" then 
        -- Replacing sound with silence
        PlayerCharacterSoundEventAliases.weapon_special_end.events["chainaxe_p1_m1"] = "wwise/events/weapon/play_weapon_silence" 
        PlayerCharacterSoundEventAliases.weapon_special_end.events["chainaxe_p1_m2"] = "wwise/events/weapon/play_weapon_silence"
    elseif option_disable_rev_down == "audio_plugin" then
        if not use_audio then
            mod:error("Audio plugin is required for this setting! (Rev down)")
            return
        end
        Audio.hook_sound("play_chainaxe_rev", function()
            Audio.play_file(audio_files:random("revdown"), { audio_type = "sfx" })
            return false
        end)
    end

    -- Idle purr
    --  Why does this require the Audio plugin?
    --  The idle sound is also in PlayerCharacterSoundEventAliases, but in the looping_events table. The events table is the one that is returned, so that's the only one we can access.
    --  nvm that doesnt work either >:(
    -- 
    if not option_disable_rev_idle == "not_disabled" and not use_audio then
        mod:echo("Audio plugin is required for this setting! (Rev idle)")
        return
    end
    if option_disable_rev_idle == "silenced" then
        -- Swapping the active souns with the idle sounds
        --  Unfortunately, this includes swing sounds and idle does not include that, so game explodes
        --mod:hook_safe(ChainWeaponEffects, "init", function (self, context, slot, weapon_template, fx_sources)
        --    -- Replacing active sound with regular idle sound
        --    local special_active_fx_source_name = fx_sources._melee_idling
        --    self._special_active_fx_source_name = melee_idling_fx_source_name
        --end)

        --mod:hook_safe(ChainWeaponEffects, "init", function (self, context, slot, weapon_template, fx_sources)
        --    self._special_active_fx_source_name = melee_idling_fx_source_name
        --end)

        -- removing every special loop sound?
        --  didn't even work >:(
        --PlayerCharacterLoopingSoundEventAliases.weapon_special_loop.start.event_alias = "stop_weapon_special_loop"
        -- PlayerCharacterLoopingSoundEventAliases.weapon_special_loop.start.event_alias = nil

        -- Just prevent the vfx from working in the first place
        --  nope lol that just crashes
        --  also that wouldn've removed the sparks
        --mod:hook_origin(ChainWeaponEffects, "_start_vfx_loop", function (self)
        --    return
        --end)

        -- this table is immutable through currently known methods
        --PlayerCharacterSoundEventAliases.looping_events.equipped_item_passive.events["chainaxe_p1_m1"] = "wwise/events/weapon/%s_weapon_silence" 

        --Audio.silence_sounds({
        --    "wwise/events/weapon/%s_chainaxe", 
        --    "wwise/events/weapon/%s_2h_chainsword",
        --    "wwise/events/weapon/%s_combat_weapon_chainsword",
        --})

        --Audio.hook_sound("play_weapon_silence", function()
        --    return false
        --end)
        --Audio.hook_sound("combat_chainsword_throttle", function()
        --    return false
        --end)
        --Audio.hook_sound("combat_chainsword_cut", function()
        --    return false
        --end)
    elseif option_disable_rev_idle == "audio_plugin" then
        -- do audio plugin shit
        -- wont regex chain because there's psyker chain lightning
        Audio.hook_sound("wwise/events/weapon/%s_chainaxe", function()
            Audio.play_file(audio_files:random("revidle"), { audio_type = "sfx" })
            return false
        end)
        Audio.hook_sound("wwise/events/weapon/%s_2h_chainsword", function()
            Audio.play_file(audio_files:random("revidle"), { audio_type = "sfx" })
            return false
        end)
        Audio.hook_sound("wwise/events/weapon/%s_combat_weapon_chainsword", function()
            Audio.play_file(audio_files:random("revidle"), { audio_type = "sfx" })
            return false
        end)
    end
end

--#################################
-- Hooks
--#################################
mod.on_all_mods_loaded = function()
    mod:info("SilentRev v"..mod.version.." loaded uwu nya :3")
    replace_sounds(false)
end
mod.on_setting_changed = function()
    replace_sounds(true)
end
