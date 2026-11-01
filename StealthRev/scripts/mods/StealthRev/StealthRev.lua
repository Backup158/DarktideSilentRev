local mod = get_mod("StealthRev")

-- #################################
-- Data
-- #################################
-- ################
-- Performance
-- ################
local table = table
local table_clone = table.clone
local string = string
local string_regex_match = string.gmatch

-- ################
-- Requirements
-- ################
local ChainWeaponEffects = require("scripts/extension_systems/visual_loadout/wieldable_slot_scripts/chain_weapon_effects")
local PlayerCharacterSoundEventAliases = require("scripts/settings/sound/player_character_sound_event_aliases")

-- ################
-- Mod Data
-- ################
-- Before changing anything, copy the original table
local original_pcsea = table_clone(PlayerCharacterSoundEventAliases)

-- #################################
-- Execution
-- #################################
-- ################
-- Silencing the Inital Startup
-- ################
-- Chain weapons are identified in utilities/FindChainWeapons.lua
-- For each chain weapon, if the setting is enabled in the mod options, mute it
local chain_weapon_names = mod.chain_weapon_names
if PlayerCharacterSoundEventAliases and PlayerCharacterSoundEventAliases.sfx_weapon_up and PlayerCharacterSoundEventAliases.sfx_weapon_up.events then 
    for i = 1, #chain_weapon_names do
        local weapon_id = chain_weapon_names[i]
        if mod:get(weapon_id) then 
            PlayerCharacterSoundEventAliases.sfx_weapon_up.events[weapon_id] = "wwise/events/weapon/play_weapon_silence"
        end
    end
end

-- ################
-- Silencing the Chain Speedup
-- ################
--[[
-- Only tells you about sound end
mod:hook_safe(ChainWeaponEffects, "_play_single_sfx", function(self, sound_alias, fx_source_name, ...)
    mod:echo("Chain playing single sfx")
    mod:echo(">>>> sound_alias: "..tostring(sound_alias))
    local sfx_source_id = self._fx_extension:sound_source(self._special_active_fx_source_name)
    mod:echo(">>>> sfx_source_id: "..tostring(sfx_source_id))
end)

-- Had no effect
mod:hook_origin(ChainWeaponEffects, "_update_active", function(func, self, ...)
    mod:echo("Chain updating active. But i killed them all. The dogs shall die.")
end)

-- no effect
mod:hook_origin(ChainWeaponEffects, "_update_base_intensity", function(func, self, dt, t, ...)
    -- mod:echo("Chain updating base intensity. But i killed them all. The dogs shall die.")
end)
]]
-- I'm just nuking the whole function
-- Haha!
if mod:get("silence_chain_weapon_effects") then
    mod:hook_origin(ChainWeaponEffects, "_update_intensity", function(func, self, dt, t, ...)
        -- mod:echo("Chain updating intensity. But i killed them all. The dogs shall die.")
        -- TODO: Figure out this fuckload of math so I can make this more modular. Perhaps even just reducing the sound? Or even making it louder lol.
    end)
end

-- #################################
-- Events
-- #################################
mod.on_setting_changed = function(setting_id)
    if setting_id == "silence_chain_weapon_effects" then
        mod:error(mod:Localize("error_toggle_chain"))
    -- If it's a weapon getting changed, unmute or remute
    elseif string_regex_match(setting_id, "_p%d_m%d") then
        --mod:echo("changing wepaon option: "..setting_id)
        -- Unmuting
        if not mod:get(setting_id) then
            --mod:echo("restoring: ".. tostring(original_pcsea.sfx_weapon_up.events[setting_id]))
            PlayerCharacterSoundEventAliases.sfx_weapon_up.events[setting_id] = original_pcsea.sfx_weapon_up.events[setting_id]
        -- Remuting
        else
            --mod:echo("remuting")
            PlayerCharacterSoundEventAliases.sfx_weapon_up.events[setting_id] = "wwise/events/weapon/play_weapon_silence"
        end
    end
end