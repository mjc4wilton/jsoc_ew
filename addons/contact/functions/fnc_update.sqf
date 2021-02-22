#include "script_component.hpp"
/*
 * Author: Wilton
 * Updates the PFH that loops on the spectrum device.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: CurrentWeapon <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player, handgunWeapon ACE_player] call jsoc_ew_contact_fnc_update;
 *
 * Public: No
 */

params ["_unit", "_currentWeapon"]

private _antenna = (_unit weaponAccessories _currentWeapon) select 0;

if !(_antenna isKindOf ["muzzle_antenna_base_01_F", configFile >> "CfgWeapons"]) exitWith {_this call FUNC(disable);};

if !(GVAR(PFH) > -1) then {
	GVAR(PFH) = [
		{_this call FUNC(drawSignalPF)},
		1,
		[]
	] call CBA_fnc_addPerFrameHandler;
};