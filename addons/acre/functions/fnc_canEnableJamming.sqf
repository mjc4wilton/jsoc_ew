#include "script_component.hpp"
/*
 * Author: Wilton
 * Checks if player is able to enable jamming
 *
 * Arguments:
 * 0: Unit <UNIT>
 * 1: Target <UNIT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, player] call jsoc_ew_acre_fnc_canEnableJamming;
 *
 * Public: No
 */

params ["_unit", "_target"];

// Check if they have a jammer
private _radios = ["ACRE_PRC117F", _unit] call acre_api_fnc_getAllRadiosByType;
private _activeRadio = [] call acre_api_fnc_getCurrentRadio;
private _hasJammer = false;
private _radioID = "";
{
	if (_x isEqualTo _activeRadio) exitWith {
		_hasJammer = true;
		_radioID = _x;
	};	
} forEach _radios;

// Check if radio is currently jamming
private _isJamming = _radioID in (missionNamespace getVariable [QGVAR(jammers), []]);

// Return
_hasJammer && !_isJamming