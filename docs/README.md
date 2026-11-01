
# Description
Reduces sound from activating the special action for chain weapons.

Revving up a chain weapon has two parts: the quick *VRR* on start, and the following *vrrRRRRR* that lingers for a bit. These both play at the same time, so think of it like the engine revving up and the actual chains spinning faster. These work off of separate systems, so they can be disabled separately.

## Silencing the Inital Startup
This is part of the general player sound files. This 

## Silencing the Chain Speedup
This is done by editing how the game handles chain weapon events in general. This means it's all or nothing. However, it's not a true silencing. Some weapons will still have a bit of speed up, though it's much quieter.
- *Assault Chainaxe*: Quiet rev
- *Assault Chainsword*: Quiet rev
- *Heavy Eviscerator*: Completely silent

On the technical side, this basically nukes `ChainWeaponEffects._update_intensity`, so there may be incompatibility issues with mods that try to edit the same thing. I don't know of any such mods, but it's a possibility that a mod that relies on that function will break when used with this mod.