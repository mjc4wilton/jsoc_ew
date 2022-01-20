#include "script_component.hpp"
/*
 * Author: Wilton
 * Loop to check for raised events
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call jsoc_ew_common_fnc_EHLoop;
 *
 * Public: No
 */

// Cache global variables into private variables
private _trackedVariables = GVAR(EH_trackedVariables);
private _gvarCache = GVAR(EH_trackedVariables_cache);
private _trackedVaraibles_code = GVAR(EH_trackedVariables_code);

// Check if cache has changed
{
    private _val = missionNamespace getVariable [_x, nil];
    if !(isNil "_val") then {
        if (_x isNotEqualTo (_gvarCache select _forEachIndex)) then {
            // Call EH with params [newValue, oldValue, Variable]
            [_val, _gvarCache select _forEachIndex, _x] call (_trackedVaraibles_code select _forEachIndex);
            // Update cache
            GVAR(EH_trackedVariables_cache) set [_forEachIndex, _val];
        };
    };
} forEach _trackedVariables;
