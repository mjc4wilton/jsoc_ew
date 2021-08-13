#include "script_component.hpp"

// Variables
GVAR(toneSpeaker) = objNull;
GVAR(tonedUnits) = [];

// Client / interface events
if (hasInterface) then {
    // Custom Signal Function
    [FUNC(signalFunction)] call acre_api_fnc_setCustomSignalFunc;

    // Jammer tone start/stop
    //["acre_remoteStartedSpeaking", {_this call FUNC(remoteStartedSpeaking)}] call CBA_fnc_addEventHandler;
    //["acre_remoteStoppedSpeaking", {_this call FUNC(remoteStoppedSpeaking)}] call CBA_fnc_addEventHandler;
};



// Radio Jamming
[QGVAR(equipRadioJammer), {
    params ["_unit", "_f"];

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

}] call CBA_fnc_addEventHandler;
