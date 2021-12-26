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

{
    // Ensure jammer still exists, if not, remove it
    private _holder = [_x] call acre_sys_radio_fnc_getRadioObject;
    if (isNil {_holder}) then {
        [QGVAR(deregisterJammer), [_x]] call CBA_fnc_serverEvent;
    };
} forEach GVAR(jammers);
