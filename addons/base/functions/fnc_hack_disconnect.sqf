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
 * [ACE_player, cursorTarget] call jsoc_ew_base_fnc_hack_disconnect;
 *
 * Public: No
 */

params ["_player", "_target", "_params"];
_params params ["_obj", "_laptop"];

// Remove from laptop devices
private _devices = _laptop getVariable [QGVAR(connectedDevices), []];
_devices deleteAt (_devices find _obj);
_laptop setVariable [QGVAR(connectedDevices), _devices, true];

// Remove connection
_obj setVariable [QGVAR(connected), nil];
