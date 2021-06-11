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

private _actions = [];
private _name = _obj getVariable [QGVAR(hack_actionText), ""];

private _action = [
    (str _x),                           // Action Name (STRING)
    _name,                              // Name shown in menu
    "",                                 // Icon (STRING)
    {_this call FUNC(hack_startHack)},  // Statement (CODE)
    {_target getVariable [QGVAR(hack_isHacking), false]}, // Condition (CODE)
    {},                                 // Insert Children (CODE)
    [_obj, _laptop]                           // Parameters (ANY)
] call ace_interact_menu_fnc_createAction;

_actions pushBack [_action, [], _target];

_actions
