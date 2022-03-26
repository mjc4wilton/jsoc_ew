#include "script_component.hpp"
/*
 * Author: Wilton
 * Function called to control visibility of "Connect to Laptop" action
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * 0: Can Connect <BOOLEAN>
 *
 * Example:
 * [ACE_player, cursorTarget] call jsoc_ew_hacking_fnc_canConnect;
 *
 * Public: No
 */

params ["_target", "_player", "_params"];
_params params ["_obj", "_laptop"];

private _return = true;

// Player does not have connector
if ((_player getVariable [QGVAR(hasConnector), false]) isNotEqualTo true) then {
    _return = false;
};

// Device is not already connected to something
if ((_obj getVariable [QGVAR(connected), nil]) isNotEqualTo nil) then {
    _return = false;
};

_return
