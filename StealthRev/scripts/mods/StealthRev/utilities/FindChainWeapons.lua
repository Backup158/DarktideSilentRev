local mod = get_mod("StealthRev")

-- #################################
-- Data
-- #################################
-- ################
-- Performance
-- ################
local string = string
local string_match = string.match
-- ################
-- Requirements
-- ################
local PlayerCharacterSoundEventAliases = require("scripts/settings/sound/player_character_sound_event_aliases")

-- #################################
-- Execution
-- #################################s
-- Right now there's 3 families with 6, but I know the Adepta Sororitas will become 4
-- Making use of preallocated space, then expanding as need be
local amount_of_chain_weapons = 6
local actual_amount_of_chain_weapons = 0
local chain_weapon_names = Script.new_map( amount_of_chain_weapons )
-- These sounds are stored in "sfx_weapon_up"
if PlayerCharacterSoundEventAliases and PlayerCharacterSoundEventAliases.sfx_weapon_up and PlayerCharacterSoundEventAliases.sfx_weapon_up.events then 
    -- Looks for each individual chain weapon that revs up.
    for weapon_id, _ in pairs(PlayerCharacterSoundEventAliases.sfx_weapon_up.events) do
        if string_match(weapon_id, "chain") then
            chain_weapon_names[actual_amount_of_chain_weapons] = weapon_id
            actual_amount_of_chain_weapons = actual_amount_of_chain_weapons + 1
        end
    end
end
mod.chain_weapon_names = chain_weapon_names