#include "script_component.hpp"
/*
 * Author: Wilton
 * Enables rf jamming on a specific jammer
 *
 * Arguments:
 * 0: Jammer <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [backpack player] call jsoc_ew_explosives_fnc_rf_enableJamming;
 *
 * Public: No
 */

params ["_jammer"];

// Ensure the item is a rf jammer
if !([_jammer] call FUNC(rf_isJammer)) exitWith {};

_jammer setVariable [QGVAR(rf_isJamming), true, true];
