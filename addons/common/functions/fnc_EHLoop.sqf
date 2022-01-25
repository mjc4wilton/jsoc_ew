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

// Check if cache has changed
{
    _x params ["_var", "_namespace", "_code", "_cache"];
    private _val = _namespace getVariable [_x, nil];
    if (isNil "_val" && {!(isNil "_cache")}) then {
        // Variable went from defined to nil
        // Call EH with params [newValue, oldValue, Variable, Namespace]
        [_val, _cache, _var, _namespace] call _code;
        // Update cache
        (GVAR(EH_trackedVariables) select _forEachIndex) set [3, _val];
    } else if !(isNil "_val") then {
        if (_x isNotEqualTo (_gvarCache select _forEachIndex)) then {
            // Call EH with params [newValue, oldValue, Variable, Namespace]
            [_val, _cache, _var, _namespace] call _code;
            // Update cache
            (GVAR(EH_trackedVariables) select _forEachIndex) set [3, _val];
        };
    };
} forEach _trackedVariables;
