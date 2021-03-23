#include "script_component.hpp"
/*
 * Author: Wilton
 * Checks if a jammer is currently jamming
 *
 * Arguments:
 * 0: Jammer <OBJECT>
 *
 * Return Value:
 * 0: Is Jamming <BOOLEAN>
 *
 * Example:
 * [backpackContainer player] call jsoc_ew_base_fnc_cell_isJamming;
 *
 * Public: No
 */

params ["_jammer"];

// Ensure it is already jamming
if !([_jammer] call FUNC(cell_isJammer)) exitWith {false};

_jammer getVariable [QGVAR(cell_isJamming), false];