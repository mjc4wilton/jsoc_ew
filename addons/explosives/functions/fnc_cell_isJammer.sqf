#include "script_component.hpp"
/*
 * Author: Wilton
 * Checks if an object is a cellular jammer
 *
 * Arguments:
 * 0: Jammer <OBJECT>
 *
 * Return Value:
 * 0: Is Jammer <BOOLEAN>
 *
 * Example:
 * [backpackContainer player] call jsoc_ew_explosives_fnc_cell_isJammer;
 *
 * Public: No
 */

params ["_obj"];

if (getText (configOf _obj >> QGVAR(isCellJammer)) isEqualTo "true") exitWith {
    true
};

false
