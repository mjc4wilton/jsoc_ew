#include "script_component.hpp"
/*
 * Author: Wilton
 * Used to remove a signal from the spectrum device
 *
 * Arguments:
 * 0: Signal-Emitting Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject] call jsoc_ew_contact_fnc_removeSignal;
 *
 * Public: No
 */

params ["_obj"];

private _signals = missionNamespace getVariable [QGVAR(signals), []];
private _index = -1;
{
    if ((_x select 0) isEqualTo _obj) exitWith {
        _index = _forEachIndex;
    };
} forEach _signals;

_signals deleteAt _index;
missionNamespace setVariable [QGVAR(signals), _signals, true]; // Propagate across MP

// Remove variables
if !(isNil "_obj" || _obj isEqualTo objNull) then {
    _obj setVariable [QGVAR(power), nil];
    _obj setVariable [QGVAR(frequency), nil];
};

