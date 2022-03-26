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
 * [cursorTarget, player] call jsoc_ew_hacking_fnc_devices_addChildrenChildren;
 *
 * Public: No
 */

params ["_target", "_player", "_parameters"];
_parameters params ["_obj", "_laptop"];

private _actions = [];

// Start hack action
private _name = _obj getVariable [QGVAR(actionText), ""];
private _action = [
    (str _x + "_hack"),                       // Action Name (STRING)
    _name,                                    // Name shown in menu
    "",                                       // Icon (STRING)
    {_this call FUNC(startHack)},        // Statement (CODE)
    {(_target getVariable [QGVAR(isHacking), false] isNotEqualTo true)}, // Condition (CODE)
    {},                                       // Insert Children (CODE)
    [_obj, _laptop]                           // Parameters (ANY)
] call ace_interact_menu_fnc_createAction;

_actions pushBack [_action, [], _target];

// Check hack progress action
private _progress_action = [
    (str _x + "_progress"),
    LLSTRING(CheckProgress),
    "",
    {_this call FUNC(showProgress)},
    {(_target getVariable [QGVAR(isHacking), false]) && {_target getVariable [QGVAR(object), nil] isEqualTo ((_this select 2) select 0)}},
    {},
    [_obj, _laptop]
] call ace_interact_menu_fnc_createAction;

_actions pushBack [_progress_action, [], _target];

_actions
