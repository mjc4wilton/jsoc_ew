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


if !(isServer) exitWith {};

{
    // Ensure jammer still exists, if not, remove it
    private _holder = [_x] call acre_sys_radio_fnc_getRadioObject;
    if (isNil "_holder" || _holder isEqualTo objNull) then {
        // Wait 2 seconds before de-registering to ensure radio is actually deceased
        // This is done because when moving between inventories the radio can disappear for a few frames
        [{
            params ["_radioID"];
            // Get new / same holder
            private _holder = [_radioID] call acre_sys_radio_fnc_getRadioObject;
            // Ensure radio is still dead
            if (isNil "_holder" || _holder isEqualTo objNull) then {
                // Radio is still dead, delete it
                [QGVAR(registerJammer), [_radioID, false]] call CBA_fnc_serverEvent;
            };
        }, [_x], 2] call CBA_fnc_waitAndExecute;
    };
} forEach GVAR(jammers);
