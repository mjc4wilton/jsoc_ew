#include "script_component.hpp"
/*
 * Author: Wilton
 * Ran on each frame to update the display of the spectrum device
 *
 * Arguments:
 * 0: Device <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [handgunWeapon player] call jsoc_ew_contact_fnc_drawSignalPF;
 *
 * Public: No
 */

params ["_device"];

// Cleanup source list
private _sourceList = missionNamespace getVariable [QGVAR(sources), []];
{
	if (!(_x select 3) && _x select 5 < diag_frameNo) then {
		_sourceList deleteAt _forEachIndex;
	};
} forEach _sourceList;
missionNamespace setVariable [QGVAR(sources), _sourceList];

// Check for jammers (ACRE)
if (isClass(configFile >> "CfgPatches" >> "jsoc_ew_acre") then {
	private _jammers = missionNamespace getVariable [QEGVAR(acre,jammers), []]
	{
		_x params ["_radioIDJ", "_frequencyJ", "_powerJ", "_deviationJ"];
		
	} forEach _jammers;
};

// Set vars for spectrum device
private _deviceEM = [];
{
	_deviceEM pushback (_x select 1);
	_deviceEM pushback (_x select 2);
} forEach _sourceList;
missionNamespace setVariable ["#EM_Values",_deviceEM];