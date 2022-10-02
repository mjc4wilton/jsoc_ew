#include "script_component.hpp"
/*
 * Author: Wilton
 * Condition for disabling rf jamming
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vehicle <OBJECT>
 *
 * Return Value:
 * 0: Can Enable <BOOLEAN>
 *
 * Example:
 * [vehicle player] call jsoc_ew_vehicles_fnc_canEnableRFJamming;
 *
 * Public: No
 */

params ["_unit", "_target"];

// Ensure vehicle is not jamming
if !(_target call EFUNC(explosives,rf_isJamming)) exitWith {false};

// Ensure player is in EWO position (Cargo[0])
if !((_target getCargoIndex _unit) isEqualTo 0) exitWith {
    false
};

true
