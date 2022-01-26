#include "script_component.hpp"
/*
 * Author: Wilton
 * Used to add a signal to the spectrum device
 *
 * Arguments:
 * 0: Signal-Emitting Object <OBJECT>
 * 1: Frequency (MHz) <NUMBER>
 * 2: Transmitter Power (W) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, 50.25, 10] call jsoc_ew_contact_fnc_addSignal;
 *
 * Public: No
 */

params ["_obj", "_freq", "_power"];

private _signals = missionNamespace getVariable [QGVAR(signals), []];
_signals pushBack [_obj, _freq, _power];
missionNamespace setVariable [QGVAR(signals), _signals, true]; // Updates across MP network

// Add variables to object
_obj setVariable [QGVAR(power), _power];
_obj setVariable [QGVAR(frequency), _freq];
