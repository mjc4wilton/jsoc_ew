#include "script_component.hpp"
/*
 * Author: Wilton
 * Starts hacking on object
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Player <OBJECT>
 * 2: Parameters <ARRAY>
 *
 * Return Value:
 * 0: Actions <ARRAY>
 *
 * Example:
 * [ACE_player, cursorTarget, [test01, test02]] call jsoc_ew_hacking_fnc_startHack;
 *
 * Public: No
 */

params ["_target", "_player", "_parameters"];
_parameters params ["_obj", "_laptop"];

_laptop setVariable [QGVAR(isHacking), true, true];
_laptop setVariable [QGVAR(object), _obj, true];
private _timeVar = QGVAR(hack_) + (str _obj) + "_time";
private _startTime = [time, serverTime] select isMultiplayer;
_laptop setVariable [_timeVar, _startTime];

private _duration = _obj getVariable [QGVAR(duration), 1];

[
    ["\a3\ui_f\data\igui\cfg\simpletasks\types\download_ca.paa", 1.25],
    [LLSTRING(HackStarted)],
    true
] call CBA_fnc_notify;

[
    {
        params ["_player", "_obj", "_laptop"];
        _laptop setVariable [QGVAR(isHacking), nil, true];
        _laptop setVariable [QGVAR(object), nil, true];
        [_player, _obj] call FUNC(foundIntel);
    },
    [_player, _obj, _laptop],
    _duration
] call CBA_fnc_waitAndExecute;
