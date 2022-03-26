#include "script_component.hpp"
/*
 * Author: Wilton
 * Adds child interactions to "devices" interaction
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * 0: Actions <ARRAY>
 *
 * Example:
 * [player] call jsoc_ew_hacking_fnc_devices_addChildren;
 *
 * Public: No
 */

params ["_player", "_target"];

private _actions = [];
private _devices = _target getVariable [QGVAR(connectedDevices), []];
{
    private _config = configOf _x;
    private _name = getText (_config >> "displayName");

    private _action = [
        (str _x),                           // Action Name (STRING)
        _name,                              // Name shown in menu
        "",                           // Icon (STRING)
        {},                                 // Statement (CODE)
        {true},                             // Condition (CODE)
        {_this call FUNC(devices_addChildrenChildren)}, // Insert Children (CODE)
        [_x, _target]                           // Parameters (ANY)
    ] call ace_interact_menu_fnc_createAction;
    _actions pushBack [_action, [], _target];
} forEach _devices;

_actions
