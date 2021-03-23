#include "script_component.hpp"
/*
 * Author: Wilton
 * Enables cell jamming on a specific jammer
 *
 * Arguments:
 * 0: Jammer <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [backpack player] call jsoc_ew_base_fnc_cell_enableJamming;
 *
 * Public: No
 */

params ["_jammer"];

// Ensure the item is a cell jammer
if !([_jammer] call FUNC(cell_isJammer)) exitWith {};

_jammer setVariable [QGVAR(cell_isJamming), true, true];
