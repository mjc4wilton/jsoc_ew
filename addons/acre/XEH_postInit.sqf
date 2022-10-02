#include "script_component.hpp"

// Variables
GVAR(toneSpeaker) = objNull;
GVAR(tonedUnits) = [];

// Server events
if (isServer) then {
    // Server variable initialization (for publicVars to maintain JIP compatibility)
    GVAR(jammers) = [];

    [QGVAR(registerJammer), {
        params ["_radioID", ["_register", true, [true]]];

        // Ensure server has sanitize process running to filter deleted radios
        if (isNil QGVAR(sanitizePID)) then {
            GVAR(sanitizePID) = [{
                call FUNC(sanitizeJammers);
            }] call CBA_fnc_addPerFrameHandler;
        };

        // Ensure radio is a jammer
        if !([_radioID, JSOC_EW_JAMMER_RADIO] call acre_api_fnc_isKindOf) exitWith {};

        // Add/remove jammer to/from global jammer list
        if (_register) then {
            GVAR(jammers) pushBackUnique _radioID;
        } else {
            GVAR(jammers) deleteAt (GVAR(jammers) find _radioID);
        };

        publicVariable QGVAR(jammers);
    }] call CBA_fnc_addEventHandler;
};

// Client / interface events
if (hasInterface) then {
    // Custom Signal Function
    [FUNC(signalFunction)] call acre_api_fnc_setCustomSignalFunc;

    // Jammer tone start/stop
    ["acre_remoteStartedSpeaking", {_this call FUNC(remoteStartedSpeaking)}] call CBA_fnc_addEventHandler;
    ["acre_remoteStoppedSpeaking", {_this call FUNC(remoteStoppedSpeaking)}] call CBA_fnc_addEventHandler;
};

// Radio Jamming
[QGVAR(equipRadioJammer), {
    params ["_unit", "_f", "_caller"];

    if (_unit canAddItemToBackpack "ACRE_PRC117F") then {
        _unit addItemToBackpack "ACRE_PRC117F";
        private _radios = ["ACRE_PRC117F", _unit] call acre_api_fnc_getAllRadiosByType;
        reverse _radios;
        if (_radios isEqualTo []) exitWith {};
        private _radioID = _radios select 0;

        private _channelNumber = GET_CHANNEL_NUM(_radioID);
        private _channels = GET_STATE_RADIO(_radioID,"channels");
        private _channel = HASHLIST_SELECT(_channels,_channelNumber);

        HASH_SET(_channel,"frequencyRX",_f);
        HASH_SET(_channel,"frequencyTX",_f);

        HASHLIST_SET(_channels,_channelNumber,_channel);
        SET_STATE_RADIO(_radioID,"channels",_channels);

        [_unit, _unit, _radioID] call FUNC(enableJamming);
    } else {
        if (EGVAR(base,hasZEN)) then {
            [QEGVAR(zen,showErrorMessage), [LLSTRING(Error_NoSpace)], _caller] call CBA_fnc_targetEvent;
        };
    };
}] call CBA_fnc_addEventHandler;
