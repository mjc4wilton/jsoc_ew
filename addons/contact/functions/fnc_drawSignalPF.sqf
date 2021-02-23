#include "script_component.hpp"
/*
 * Author: Wilton
 * Ran on each frame to update the display of the spectrum device
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [handgunWeapon player] call jsoc_ew_contact_fnc_drawSignalPF;
 *
 * Public: No
 */

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

// Handle all vehicles
private _fVehicles = 135;
{
	if (isEngineOn _x) then {
		private _power = -993;
		private _fSpace = 2.5;
		if (unitIsUAV _x) then {
			_power = -24;
			_fSpace = 25
		} else {
			_power = -54;
		};
		if (_power > -993) then {
			private _distance = ACE_player distance _x;
			_power = ((_power * (1 / linearConversion [2500, 0, _distance, 0.0001, 1, true])) min 0) max -993;
			_fVehicles = _fVehicles + (_fSpace + random 15);
		};
		_sourceList pushBack [str _x, _fVehicles, _power];
	};
} forEach ACE_player nearEntities [["LandVehicle", "Air", "Ship"], 2500];

// Set vars for spectrum device
private _deviceEM = [];
{
	_deviceEM pushback (_x select 1);
	_deviceEM pushback (_x select 2);
} forEach _sourceList;
missionNamespace setVariable ["#EM_Values",_deviceEM];
