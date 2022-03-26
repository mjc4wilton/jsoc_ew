#include "script_component.hpp"
/*
 * Author: Wilton
 * Disables cell jamming on a specific jammer
 *
 * Arguments:
 * 0: Jammer <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [backpack player] call jsoc_ew_explosives_fnc_cell_disableJamming;
 *
 * Public: No
 */

params ["_jammer"];

// Ensure the item is a cell jammer
if !([_jammer] call FUNC(cell_isJammer)) exitWith {};

_jammer setVariable [QGVAR(cell_isJamming), nil, true];
