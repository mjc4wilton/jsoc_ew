#include "script_component.hpp"
/*
 * Author: Wilton
 * Checks if all active jammers still exist and removes ones which don't.
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
    if (isNil {_holder}) then {
        _jammers deleteAt _forEachIndex;
        _update = true;
    };
} forEach _jammers;

if (_update) then {
    missionNamespace setVariable [QGVAR(jammers), _jammers, true];
};
