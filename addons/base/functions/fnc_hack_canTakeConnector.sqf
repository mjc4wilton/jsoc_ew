#include "script_component.hpp"
/*
 * Author: Wilton
 * Function called to control visibility of "Take Cable" action
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * 0: Can Take Connector <BOOLEAN>
 *
 * Example:
 * [ACE_player, cursorTarget] call jsoc_ew_base_fnc_hack_canTakeConnector;
 *
 * Public: No
 */

params ["_player", "_target"];

private _return = true;

if (_player getVariable [QGVAR(hasConnector), false] isEqualTo true) then {
    _return = false;
};

private _devices = _target getVariable [QGVAR(connectedDevices), []];
if (count _devices >= GVAR(hack_maxDevices)) then {
    _return = false;
};

_return
