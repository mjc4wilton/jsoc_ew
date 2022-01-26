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

private _power = missionNamespace getVariable [QEGVAR(contact,power), 10];
private _freq = missionNamespace getVariable [QEGVAR(contact,frequency), 72.25];

private _options = [
    ["SLIDER", LLSTRING(AddSignal_Frequency), [58, 75, _freq, 2]],
    ["SLIDER", LLSTRING(AddSignal_Power), [0, 100, _power, 0]]
];

[LLSTRING(AddSignal_Title), _options, {
        params ["_values", "_args"];
        _values params ["_freq", "_power"];
        _args params ["_obj"];

        [_obj, _freq, _power] call EFUNC(contact,addSignal);
    },
{}, [_object]] call zen_dialog_fnc_create;
