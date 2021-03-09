#include "script_component.hpp"
/*
 * Author: Wilton
 * Handles detonation of ACE explosives (SERVER SIDE)
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: MaxRange <NUMBER>
 * 2: Explosive <OBJECT>
 * 3: FuzeTime <NUMBER>
 * 4: TriggerItem <STRING>
 *
 * Return Value:
 * 0: Allow explosion <BOOLEAN>
 *
 * Example:
 * [_unit, _range, _explosive, _fuse, _trigger] call jsoc_ew_base_fnc_handleAceDetonation;
 *
 * Public: No
 */

params ["_unit", "_range","_explosive","_fuse","_trigger"];

private _return = true;
private _cellJammers = missionNamespace getVariable [QGVAR(cellJammers), []];
private _rfJammers = missionNamespace getVariable [QGVAR(rfJammers), []];

// Check if detonator is within range of the explosive
if ((_unit distance _explosive) >= _range) exitWith {false};

// Check cellphone controlled IEDs
if (_trigger isEqualTo "ace_cellphone") then {
	{
		if ((_x distance _explosive) - (_unit distance explosive) <= 0) then {
			_return = false;
			[QGVAR(detonationAttempted), [_explosive, _trigger], _x] call CBA_fnc_targetEvent;
		};
	} forEach _cellJammers;
};

// Check rf controlled IEDs
if ((_trigger isEqualTo "ace_m26_clacker") || (_trigger isEqualTo "ACE_Clacker")) then {
	{
		if ((_x distance _explosive) - (_unit distance explosive) <= 0) then {
			_return = false;
			[QGVAR(detonationAttempted), [_explosive, _trigger], _x] call CBA_fnc_targetEvent;
		};
	} forEach _rfJammers;
};

_return