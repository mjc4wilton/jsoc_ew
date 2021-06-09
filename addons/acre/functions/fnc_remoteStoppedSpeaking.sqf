#include "script_component.hpp"
/*
 * Author: Wilton
 * Handles remote client stopping to speak and revokes jamming tone.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call jsoc_ew_acre_fnc_remoteStoppedSpeaking;
 *
 * Public: No
 */

params ["_unit"];

if (_unit in GVAR(tonedUnits)) then {
    GVAR(tonedUnits) deleteAt (GVAR(tonedUnits) find _unit);
    // Ensure tone isn't accentially stopped
    if (GVAR(tonedUnits isEqualTo [])) then {
        deleteVehicle GVAR(toneSpeaker);
    };
};
