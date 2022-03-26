#include "script_component.hpp"
/*
 * Author: Wilton
 * Function called to control visibility of "Disconnect" action
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Target <OBJECT>
 * 2: Action Params <ARRAY>
 *
 * Return Value:
 * 0: Can Disconnect <BOOLEAN>
 *
 * Example:
 * [ACE_player, cursorTarget, [cursorTarget]] call jsoc_ew_hacking_fnc_canDisconnect;
 *
 * Public: No
 */

params ["_target", "_player", "_params"];
_params params ["_obj", "_laptop"];

private _device = _obj getVariable [QGVAR(connected), nil];

private _return = true;

// Laptop is currently disconnected
if (_device isEqualTo nil) then {
    _return = false;
};

// Laptop no longer exists
if (isNull _device) then {
    _return = false;
    _obj setVariable [QGVAR(connected), nil, true];
};

_return
