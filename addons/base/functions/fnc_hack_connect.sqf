#include "script_component.hpp"
/*
 * Author: Wilton
 * Function called from "Connect to Laptop" action
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Target <OBJECT>
 * 2: Params <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player, cursorTarget] call jsoc_ew_base_fnc_hack_connect;
 *
 * Public: No
 */

params ["_player", "_target", "_params"];
_params params ["_laptop"];

_player setVariable [QGVAR(hasConnector), nil];
_target setVariable [QGVAR(connected), true];

private _devices = _laptop getVariable [QGVAR(connectedDevices), []];
_devices pushBack _target;
_laptop setVariable [QGVAR(connectedDevices), _devices, true];

private _action = [
    (str _target),                      // Action Name (STRING)
    LLSTRING(hack_disconnect),          // Name shown in menu
    "",                                 // Icon (STRING)
    {_this call FUNC(hack_disconnect)}, // Statement (CODE)
    {_target getVariable [QGVAR(connected), false]}, // Condition (CODE)
    {},                                 // Insert Children (CODE)
    [_target, _laptop]                  // Parameters (ANY)
] call ace_interact_menu_fnc_createAction;

[_target, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
