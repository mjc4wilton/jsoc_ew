#include "script_component.hpp"
/*
 * Author: Wilton
 * Updates the PFH that loops on the spectrum device.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Current Weapon <STRING>
 * 2: Previous Weapon <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player, handgunWeapon ACE_player] call jsoc_ew_contact_fnc_update;
 *
 * Public: No
 */

params ["_unit", "_currentWeapon", "_oldWeapon"];

private _antenna = (_unit weaponAccessories _currentWeapon) select 0;

if !(_antenna isKindOf ["muzzle_antenna_base_01_F", configFile >> "CfgWeapons"]) exitWith {_this call FUNC(disable);};

if (GVAR(PFH) > -1) exitWith {};

GVAR(PFH) = [
    {_this call FUNC(drawSignalPF)},
    GVAR(spectrumUpdateRate),
    [_antenna]
] call CBA_fnc_addPerFrameHandler;
