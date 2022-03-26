#include "script_component.hpp"
/*
 * Author: Wilton
 * Script called by "Electronic Warfare - Add Hackable Intel" module
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * _this call jsoc_ew_zen_fnc_equipRadioJammer
 *
 * Public: No
 */

params ["_logic"];

// Define object and location
if (isNull _logic) exitWith {};

private _posASL = getPosASL _logic;
private _object = attachedTo _logic;

deleteVehicle _logic;

private _share = _object getVariable [QEGVAR(hacking,share), 2];
private _actionText = _object getVariable [QEGVAR(hacking,actionText), ""];
private _duration = _object getVariable [QEGVAR(hacking,duration), 20];
private _title = _object getVariable [QEGVAR(hacking,title), ""];
private _text = _object getVariable [QEGVAR(hacking,text), ""];

private _options = [
    ["TOOLBOX", localize "STR_ZEN_Modules_ModuleCreateIntel_ShareWith", [_share, 1, 3, ["str_eval_typeside", "str_word_allgroup", "str_disp_intel_none_friendly"]]],
    ["EDIT", localize "STR_ZEN_Modules_ModuleCreateIntel_ActionText", _actionText],
    ["SLIDER", localize "STR_ZEN_Modules_ModuleCreateIntel_ActionDuration", [0, 600, _duration, 0]],
    ["EDIT", localize "STR_ZEN_Modules_ModuleCreateIntel_IntelTitle", _title],
    ["EDIT:MULTI", localize "STR_ZEN_Modules_ModuleCreateIntel_IntelText", _text]
];



// Check object
// TODO: Replace strings
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


[LLSTRING(AddHackIntel_Title), _options, {
      params ["_values", "_args"];
      _values params ["_share", "_actionText", "_duration", "_title", "_text"];
      _args params ["_object"];

      [_object, _share, _actionText, _duration, _title, _text] call EFUNC(hacking,addIntel);
    },
{}, [_object]] call zen_dialog_fnc_create;
