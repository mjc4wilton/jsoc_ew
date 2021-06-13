#include "script_component.hpp"
/*
 * Author: Wilton
 * Function called from "Connect to Laptop" action
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Player <OBJECT>
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

params ["_target", "_player", "_params"];
_params params ["_obj", "_laptop"];

// Remove from laptop devices
private _devices = _laptop getVariable [QGVAR(connectedDevices), []];
_devices deleteAt (_devices find _obj);
_laptop setVariable [QGVAR(connectedDevices), _devices, true];

// Remove connection
_obj setVariable [QGVAR(connected), nil];

// Remove Interaction
private _interactDisconnect = (str _obj + "_disconnect");
private _interactConnect = (str _obj + "_connect");
[_obj, 0, ["ACE_MainActions", _interactDisconnect]] call ace_interact_menu_fnc_removeActionFromObject;
[_obj, 0, ["ACE_MainActions", _interactConnect]] call ace_interact_menu_fnc_removeActionFromObject;
