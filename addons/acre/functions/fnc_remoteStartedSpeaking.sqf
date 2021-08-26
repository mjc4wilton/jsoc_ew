#include "script_component.hpp"
/*
 * Author: Wilton
 * Handles remote client starting to speak and applies jamming tone.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Speaking Type <NUMBER>
 * 2: RadioID <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 1, "acre_prc117f_id_1"] call jsoc_ew_acre_fnc_remoteStartedSpeaking;
 *
 * Public: No
 */

params ["_unit", "_speakingType", "_radioID"];

// Check if there is a jammer
if ((missionNamespace getVariable [QGVAR(jammers), []]) isEqualTo []) exitWith {};

// Apply processing as jammer exists
if (_speakingType isEqualTo SPEAKING_TYPE_RADIO) then {
    // Remote is speaking on radio
    if (([_radioID, ACE_player] call jsoc_ew_acre_fnc_getAudibleTransmissions) isNotEqualTo []) then {
        // Unit can hear transmission
        private _foundJammer = false;
        {
            if (([_x, ACE_player] call jsoc_ew_acre_fnc_getAudibleTransmissions) isNotEqualTo []) exitWith {
                _foundJammer = true;
            };
        } forEach (missionNamespace getVariable [QGVAR(jammers), []]);

        if (_foundJammer isEqualTo true) then {
            // Apply sound
            if (GVAR(toneSpeaker) isEqualTo objNull) then {
                // Play 9s jamming tone
                switch (GVAR(jammedTone)) do {
                    case 275: {GVAR(toneSpeaker) = playSound QGVAR(sound_jammed_275);};
                    case 575: {GVAR(toneSpeaker) = playSound QGVAR(sound_jammed_575);};
                    case 1075: {GVAR(toneSpeaker) = playSound QGVAR(sound_jammed_1075);};
                    case 2075: {GVAR(toneSpeaker) = playSound QGVAR(sound_jammed_2075);};
                };
            };

            // Add unit to array to check to end tone at end of transmission
            GVAR(tonedUnits) pushBack _unit;
        };
    };
};
