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

// Calculate angle
private _bearingFacing = getDir ACE_player;
private _bearingJammer = ACE_player getDir _obj;
private _angle = (_bearingFacing max _bearingJammer) - (_bearingFacing min _bearingJammer);
if (_angle > 180) then {
    _angle = 360 - _angle;
};
private _angleMultiplier = 1 - ((1 / 180) * _angle) ^ 2; // Quadratically varied with 1 at 0 angle and 0 at 180 angle.

// Calculate final
private _distance = (_obj distance ACE_player) / 1000; // distance 3D in km
private _rxPower = -1 * ((20 / _power) * _distance)^3 * _angleMultiplier;

// Return
_rxPower
