#include "script_component.hpp"
/*
 * Author: Wilton
 * Script called by "Electronic Warfare - Equip Radio Jammer" module
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
private _unit = attachedTo _logic;

deleteVehicle _logic;

// Check object
if (isNull _unit) exitWith {
    [localize "STR_ZEN_Modules_NoUnitSelected"] call zen_common_fnc_showMessage;
};

if !(_unit isKindOf "CAManBase") exitWith {
    [localize "STR_ZEN_Modules_OnlyInfantry"] call zen_common_fnc_showMessage;
};

if !(alive _unit) exitWith {
    [localize "STR_ZEN_Modules_OnlyAlive"] call zen_common_fnc_showMessage;
};

if (isPlayer _unit) exitWith {
    ["str_a3_cfgvehicles_moduleremotecontrol_f_errorPlayer"] call zen_common_fnc_showMessage;
};


[LLSTRING(EquipRadioJammer_Title), [
        [
          "EDIT",
          [LLSTRING(EquipRadioJammer_Frequency_Title), LLSTRING(EquipRadioJammer_Frequency_Tooltip)],
          [
              "59.625",
              {
                  // Sanitizing Function - Returns only number
                  parseNumber _this;
              }
          ],
          true
        ]
    ], {
      params ["_values", "_args"];
      _values params ["_fs"];
      _args params ["_unit"];
      private _f = parseNumber _fs;

      [QEGVAR(base,equipRadioJammer), [_unit, _f], _unit] call CBA_fnc_targetEvent;
    },
{}, [_unit]] call zen_dialog_fnc_create;
