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
 * [ACE_player, cursorTarget] call jsoc_ew_base_fnc_hack_canConnect;
 *
 * Public: No
 */

params ["_target", "_player", "_params"];
_params params ["_obj", "_laptop"];

private _return = false;

if ((_player getVariable [QGVAR(hasConnector), false]) isEqualTo true) then {
    _return = true;
};

if ((_obj getVariable [QGVAR(connected), false]) isEqualTo false) then {
    _return = true;
};

_return
