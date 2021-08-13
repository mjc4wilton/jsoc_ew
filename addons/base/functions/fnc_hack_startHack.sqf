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
 * [ACE_player, cursorTarget, [test01, test02]] call jsoc_ew_base_fnc_hack_startHack;
 *
 * Public: No
 */

params ["_target", "_player", "_parameters"];
_parameters params ["_obj", "_laptop"];

_laptop setVariable [QGVAR(hack_isHacking), true, true];

private _duration = _obj getVariable [QGVAR(hack_duration), 1];

[
    ["\a3\ui_f\data\igui\cfg\simpletasks\types\download_ca.paa", 1.25],
    [LLSTRING(Hack_HackStarted)],
    true
] call CBA_fnc_notify;

[
    {
        params ["_player", "_obj"];
        [_player, _obj] call FUNC(hack_foundIntel);
    },
    [_player, _obj],
    _duration
] call CBA_fnc_waitAndExecute;