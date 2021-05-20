#include "script_component.hpp"
/*
 * Author: Wilton
 * Custom ACRE signal function to handle EW jamming capabilities
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call jsoc_ew_acre_fnc_sanitizeJammers;
 *
 * Public: No
 */

private _jammers = missionNamespace getVariable [QGVAR(jammers), []];
private _update = false;
{
	// Ensure jammer still exists, if not, remove it
	private _holder = [_x] call acre_sys_radio_fnc_getRadioObject;
    if (isNil {_holder} || isNull _holder) then {
        _jammers deleteAt _forEachIndex;
		_update = true;
    };
} forEach _jammers;

if (_update) then {
	missionNamespace setVariable [QGVAR(jammers), _jammmers, true];
};
