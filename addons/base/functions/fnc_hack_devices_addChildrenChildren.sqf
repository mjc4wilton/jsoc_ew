#include "script_component.hpp"
/*
 * Author: Wilton
 * Adds child interactions to "devices > device" interaction
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
 * [cursorTarget, player] call jsoc_ew_base_fnc_cell_addChildren;
 *
 * Public: No
 */

params ["_target", "_player", "_parameters"];
_parameters params ["_obj", "_laptop"];

private _actions = [];

// Start hack action
private _hack_name = _obj getVariable [QGVAR(hack_actionText), ""];
private _hack_action = [
    (str _x + "_hack"),                       // Action Name (STRING)
    _hack_name,                                    // Name shown in menu
    "",                                       // Icon (STRING)
    {_this call FUNC(hack_startHack)},        // Statement (CODE)
    {(_target getVariable [QGVAR(hack_isHacking), false] isNotEqualTo true)}, // Condition (CODE)
    {},                                       // Insert Children (CODE)
    [_obj, _laptop]                           // Parameters (ANY)
] call ace_interact_menu_fnc_createAction;

_actions pushBack [_hack_action, [], _target];

// Check hack progress action
private _progress_action = [
    (str _x + "_progress"),
    LLSTRING(Hack_CheckProgress),
    "",
    {_this call FUNC(hack_showProgress)},
    {(_target getVariable [QGVAR(hack_isHacking), false]) && {_target getVariable [QGVAR(hack_object), nil] isEqualTo ((_this select 2) select 0)}},
    {},
    [_obj, _laptop]
] call ace_interact_menu_fnc_createAction;

_actions pushBack [_progress_action, [], _target];

_actions
