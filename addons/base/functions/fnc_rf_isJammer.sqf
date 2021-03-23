#include "script_component.hpp"
/*
 * Author: Wilton
 * Checks if an object is a rfular jammer
 *
 * Arguments:
 * 0: Jammer <OBJECT>
 *
 * Return Value:
 * 0: Is Jammer <BOOLEAN>
 *
 * Example:
 * [backpackContainer player] call jsoc_ew_base_fnc_rf_isJammer;
 *
 * Public: No
 */

params ["_obj"];

if (getText (configOf _obj >> QGVAR(isRFJammer)) isEqualTo "true") exitWith {
	true
};

false