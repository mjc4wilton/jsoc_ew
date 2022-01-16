#include "script_component.hpp"
/*
 * Author: Wilton
 * Checks if player is able to disable jamming
 *
 * Arguments:
 * 0: Unit <UNIT>
 * 1: Target <UNIT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, player] call jsoc_ew_acre_fnc_canDisableJamming;
 *
 * Public: No
 */

params ["_unit", "_target"];

// Check if they have a jammer
private _activeRadio = [] call acre_api_fnc_getCurrentRadio;

// Radio is not a jammer, return false
if !([_activeRadio, JSOC_EW_JAMMER_RADIO] call acre_api_fnc_isKindOf) exitWith { false };

private _stateJamming = GET_STATE_RADIO(_activeRadio, QGVAR(jamming));

// Radio is not actively jamming
if (isNil "_stateJamming" || !_stateJamming) exitWith { false };

true
