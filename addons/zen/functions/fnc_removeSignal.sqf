#include "script_component.hpp"
/*
 * Author: Wilton
 * Script called by "Electronic Warfare - Add Signal" module
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * _this call jsoc_ew_zen_fnc_addSignal
 *
 * Public: No
 */

params ["_logic"];

// Define object and location
if (isNull _logic) exitWith {};

private _posASL = getPosASL _logic;
private _object = attachedTo _logic;

deleteVehicle _logic;

// Check object
if (isNull _object) exitWith {
    [localize "STR_ZEN_Modules_NoObjectSelected"] call zen_common_fnc_showMessage;
};

if !(alive _object) exitWith {
    [localize "STR_ZEN_Modules_OnlyAlive"] call zen_common_fnc_showMessage;
};

[_object] call EFUNC(contact,removeSignal);
