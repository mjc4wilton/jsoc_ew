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
// TODO: Strings
if (isNull _object) exitWith {
    [localize "STR_ZEN_Modules_NoUnitSelected"] call zen_common_fnc_showMessage;
};

if (_object isKindOf "CAManBase") exitWith {
    [localize "STR_ZEN_Modules_OnlyInfantry"] call zen_common_fnc_showMessage;
};

if !(alive _object) exitWith {
    [localize "STR_ZEN_Modules_OnlyAlive"] call zen_common_fnc_showMessage;
};

if (isPlayer _object) exitWith {
    ["str_a3_cfgvehicles_moduleremotecontrol_f_errorPlayer"] call zen_common_fnc_showMessage;
};

[_object] call EFUNC(contact,removeSignal);
