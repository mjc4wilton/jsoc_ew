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

    // Get values from remote's radio
    private _remoteSettings = [_radioID] call FUNC(getJammerSettings);
    _remoteSettings params ["_frequencyTxRem", "", "_deviationRem"];
    private _remoteFLow = _frequencyTxRem - _deviationRem;
    private _remoteFHigh = _frequencyTxRem + _deviationRem;

    private _localRadios = [];
    // Get all radios ACE_player has
    {
        {
            _localRadios pushBackUnique _x;
        } forEach [_x] call acre_api_fnc_getAllRadiosByType;
    } forEach ([] call acre_api_fnc_getAllRadios select 0);

    // Check if player can listen to transmission and apply sound
    {
        private _localSettings = [_x] call FUNC(getJammerSettings);
        _localSettings params ["_frequencyTxLoc", "", "_deviationLoc"];
        private _localFLow = _frequencyTxLoc - _deviationLoc;
        private _localFHigh = _frequencyTxLoc + _deviationLoc;
        private _foundJammer = false;

        private _mult = 0;
        if (_remoteFHigh >= _localFHigh) then {
            if (_localFLow >= _remoteFLow) then {
                _mult = (0 max ((_remoteFHigh - _remoteFLow)/(_localFHigh - _localFLow))) min 1;
            };
            if (_localFLow < _remoteFLow) then {
                _mult = (0 max ((_localFHigh - _remoteFLow)/(_localFHigh - _localFLow))) min 1;
            };
        };
        if (_remoteFHigh < _localFHigh) then {
            if (_localFLow >= _remoteFLow) then {
                _mult = (0 max ((_remoteFHigh - _localFLow)/(_localFHigh - _localFLow))) min 1;
            };
            if (_localFLow < _remoteFLow) then {
                _mult = (0 max ((_remoteFHigh - _remoteFLow)/(_localFHigh - _localFLow))) min 1;
            };
        };

        if (_mult > 0) then {
            // Radio is capable of receiving transmission
            // Check if Rx radio is capable of hearing jammer
            {
                private _jammerSettings = [_x] call FUNC(getJammerSettings);
                _jammerSettings params ["_frequencyTxJ", "", "_deviationJ"];
                private _jFLow = _frequencyTxJ - _deviationJ;
                private _jFHigh = _frequencyTxJ + _deviationJ;

                private _multJ = 0;
                if (_jFHigh >= _localFHigh) then {
                    if (_localFLow >= _jFLow) then {
                        _multJ = (0 max ((_jFHigh - _jFLow)/(_localFHigh - _localFLow))) min 1;
                    };
                    if (_localFLow < _jFLow) then {
                        _multJ = (0 max ((_localFHigh - _jFLow)/(_localFHigh - _localFLow))) min 1;
                    };
                };
                if (_jFHigh < _localFHigh) then {
                    if (_localFLow >= _jFLow) then {
                        _multJ = (0 max ((_jFHigh - _localFLow)/(_localFHigh - _localFLow))) min 1;
                    };
                    if (_localFLow < _jFLow) then {
                        _multJ = (0 max ((_jFHigh - _jFLow)/(_localFHigh - _localFLow))) min 1;
                    };
                };

                if (_multJ > 0) exitWith {
                    _foundJammer = true;
                };
            } forEach (missionNamespace getVariable [QGVAR(jammers), []]);
        };
        if (_foundJammer isEqualTo true) exitWith {
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
    } forEach _localRadios;
};
