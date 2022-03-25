#include "script_component.hpp"
/*
 * Author: Wilton
 * Used to calculate signal strength of object
 *
 * Arguments:
 * 0: Signal-Emitting Object <OBJECT>
 * 1: Transmitter Power (W) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, 100] call jsoc_ew_contact_fnc_getSignalStrength;
 *
 * Public: No
 */

params ["_obj", "_power"];

private _player = [] call CBA_fnc_currentUnit;

// Calculate angle
private _bearingFacing = getDir _player;
private _bearingJammer = _player getDir _obj;
private _angle = (_bearingFacing max _bearingJammer) - (_bearingFacing min _bearingJammer);
if (_angle > 180) then {
    _angle = 360 - _angle;
};
private _angleMultiplier = 1 - ((1 / 180) * _angle) ^ 2; // Quadratically varied with 1 at 0 angle and 0 at 180 angle.

// Calculate final
private _distance = (_obj distance _player); // distance 3D
private _rxPower = -7 * (1/_angleMultiplier) * (sqrt (_distance / (_power)));

// Return
_rxPower
