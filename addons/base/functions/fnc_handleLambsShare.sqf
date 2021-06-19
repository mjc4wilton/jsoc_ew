#include "script_component.hpp"
/*
 * Author: Wilton
 * Handles sharing of LAMBS Danger FSM to check if it is being jammed
 *
 * Arguments:
 * 0: unit sharing information <OBJECT>
 * 1: enemy target <OBJECT>
 * 2: range to share information, default 350 <NUMBER>
 * 3: override radio ranges, default false <BOOLEAN>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call jsoc_ew_base_fnc_handleLambsShare;
 *
 * Public: No
 */

params ["_unit", ["_target", objNull], ["_range", 350], ["_override", false]];

private _return = false;

// Ignore direct speech (shouting)
if (_override) exitWith {false};

// Handle ACRE jammers
if (EGVAR(base,hasACRE)) then {
    // Sanitize jammers
    [] call EFUNC(acre,sanitizeJammers);
    private _jammers = missionNamespace getVariable [QEGVAR(acre,jammers), []];
    {
        private _radioID = _x;
        private _settings = [_radioID] call EFUNC(acre,getJammerSettings);
        _settings params ["_frequencyTx"];
        private _obj = [_radioID] call acre_sys_radio_fnc_getRadioObject;
        if (_frequencyTx == GVAR(enemyFrequency)) then {
            // Calculate basic signal
            // TODO: Utilize ACRE signal functions / extension
            private _distanceJammer = _obj distance2D _unit;    // Uses distance2D as attenuation through air to an aircraft is minimal.
            if ((_distanceJammer / 2) <= _range) exitWith { // Divided by 2 to account for having too much static to communicate effectively.
                _return = true;
            };
        };
    } forEach _jammers;
};

_return
