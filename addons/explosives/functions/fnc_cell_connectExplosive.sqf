#include "script_component.hpp"
/*
 * Author: Wilton
 * Adds connection between ACE explosive and zeus cellphone
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * _this call jsoc_ew_explosives_fnc_connectExplosive;
 *
 * Public: No
 */

params ["_logic"];

// Handle module logic
if (isNull _logic) exitWith {};

private _posASL = getPosASL _logic;
private _explosive = attachedTo _logic;

deleteVehicle _logic;

if (isNull _explosive) exitWith {
    if (GVAR(hasZEN)) then {
        [localize "STR_ZEN_Modules_NoObjectSelected"] call zen_common_fnc_showMessage;
    };
};

if (_explosive isKindOf "CAManBase") exitWith {
    if (GVAR(hasZEN)) then {
        [localize "STR_ZEN_Modules_OnlyNonInfantry"] call zen_common_fnc_showMessage;
    };
};

if (isPlayer _explosive) exitWith {
    if (GVAR(hasZEN)) then {
        ["str_a3_cfgvehicles_moduleremotecontrol_f_errorPlayer"] call zen_common_fnc_showMessage;
    };
};

if !(alive _explosive) exitWith {
    if (GVAR(hasZEN)) then {
        [localize "STR_ZEN_Modules_OnlyAlive"] call zen_common_fnc_showMessage;
    };
};



private _unit = player;

// Ensure unit has detonator
if !([_unit, "ACE_Cellphone"] call BIS_fnc_hasItem) then {
    _unit addItem "ACE_Cellphone";
};

// Works because ace_explosives_fnc_addCellphoneIED only uses _magazineClass to pull the fusetime, which is currently the same on all ACE explosives
private _magazineClass = "IEDUrbanBig_Remote_Mag";
private _class = ConfigFile >> "ACE_Triggers" >> "Cellphone";

// Connect Explosive
[_unit, _explosive, _magazineClass, _class] call ace_explosives_fnc_addCellphoneIED;
