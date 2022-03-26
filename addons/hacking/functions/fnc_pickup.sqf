#include "script_component.hpp"
/*
 * Author: Wilton
 * Places EW Laptop
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Object to pickup <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "jsoc_ew_hacking_Laptop"] call jsoc_ew_hacking_fnc_pickup;
 *
 * Public: No
 */

params ["_player", "_target"];

private _devices = _laptop getVariable [QGVAR(connectedDevices), []];

{
    [_x, _player, [_x, _target]] call FUNC(disconnect);
} forEach _devices;

[_player, QGVAR(Laptop)] call CBA_fnc_addItem;
deleteVehicle _target;
