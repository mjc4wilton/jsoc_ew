#include "script_component.hpp"
/*
 * Author: Wilton
 * Handles gathered intel from an object
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_this] call jsoc_ew_hacking_fnc_foundIntel;
 *
 * Public: No
 */

params ["_unit", "_obj"];

private _share = _obj getVariable [QGVAR(share), 2];
private _actionText = _obj getVariable [QGVAR(actionText), "Hack"];
private _duration = _obj getVariable [QGVAR(duration), 1];
private _title = _obj getVariable [QGVAR(title), "Intel"];
private _text = _obj getVariable [QGVAR(text), "Intel"];

private _targets = switch (_share) do {
    case 0: {
        call CBA_fnc_players select {side group _x == side _unit}
    };
    case 1: {
        units _unit select {isPlayer _x}
    };
    case 2: {
        [_unit]
    };
};

// Notify zeus player has found intel if ZEN is installed
if (GVAR(hasZEN)) then {
    [
        "zen_common_showMessage",
        [format [localize "STR_ZEN_Modules_ModuleCreateIntel_PlayerFoundIntel", name _unit, _title]],
        allCurators
    ] call CBA_fnc_targetEvent;
};

// Notify player that hack has finished
playSound QGVAR(sound_hack_notification);
[
    ["\a3\ui_f\data\igui\cfg\simpletasks\types\download_ca.paa", 1.25],
    [LLSTRING(HackFinished)],
    false
] call CBA_fnc_notify;

// Relay intel to diary entry
[QGVAR(addIntel), [_title, _text], _targets] call CBA_fnc_targetEvent;
