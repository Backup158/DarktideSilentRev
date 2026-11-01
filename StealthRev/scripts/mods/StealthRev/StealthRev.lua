local mod = get_mod("StealthRev")

-- #################################
-- Data
-- #################################
-- ################
-- Performance
-- ################
local string = string
local string_regex_match = string.gmatch
-- ################
-- Requirements
-- ################
local ChainWeaponEffects = require("scripts/extension_systems/visual_loadout/wieldable_slot_scripts/chain_weapon_effects")
local PlayerCharacterSoundEventAliases = require("scripts/settings/sound/player_character_sound_event_aliases")

-- #################################
-- Execution
-- #################################
-- ################
-- Silencing the Inital Startup
-- ################


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
mod:hook_origin(ChainWeaponEffects, "_update_intensity", function(func, self, dt, t, ...)
    -- mod:echo("Chain updating intensity. But i killed them all. The dogs shall die.")
end)