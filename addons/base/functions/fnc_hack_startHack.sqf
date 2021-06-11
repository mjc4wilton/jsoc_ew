#include "script_component.hpp"
/*
 * Author: Wilton
 * Adds child interactions to "devices > device" interaction
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Target <OBJECT>
 * 2: Parameters <ARRAY>
 *
 * Return Value:
 * 0: Actions <ARRAY>
 *
 * Example:
 * [player] call jsoc_ew_base_fnc_cell_addChildren;
 *
 * Public: No
 */

params ["_player", "_target", "_parameters"];
_parameters params ["_obj", "_laptop"];

_laptop setVariable [QGVAR(hack_isHacking), true, true];

private _duration = _obj getVariable [QGVAR(hack_duration), 1];

[
    ["\a3\ui_f\data\igui\cfg\simpletasks\types\download_ca.paa", 1.25],
    [LLSTRING(Hack_HackStarted)],
    true
] call CBA_fnc_notify;

[
    {_this call FUNC(hack_foundIntel)},
    [_obj],
    _duration
] call CBA_fnc_waitAndExecute;
