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
private _hasJammer = false;
private _radioID = "";

if ([_activeRadio, "ACRE_PRC117F"] call acre_api_fnc_isKindOf) then {
    _hasJammer = true;
    _radioID = _activeRadio;
};

// Check if radio is currently jamming
private _isJamming = _radioID in GVAR(jammers);

// Return
_hasJammer && _isJamming
