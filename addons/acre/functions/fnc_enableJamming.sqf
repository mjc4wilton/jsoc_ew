#include "script_component.hpp"
/*
 * Author: Wilton
 * Enables jamming using the current active radio
 *
 * Arguments:
 * 0: Unit <UNIT>
 * 1: Target <UNIT>
 * 2: RadioID <STRING> (Optional: Default current active radio)
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, player] call jsoc_ew_acre_fnc_enableJamming;
 *
 * Public: No
 */

params ["_unit", "_target", ["_radioID", [] call acre_api_fnc_getCurrentRadio]];

private _jammers = missionNamespace getVariable [QGVAR(jammers), []];
if (_radioID in _jammers) exitWith {}; //Exit if radio is already jamming

// Add Jammer
_jammers pushBack _radioID;
missionNamespace setVariable [QGVAR(jammers), _jammers, true];

// Get data to present to user
private _channelNumber = GET_CHANNEL_NUM(_radioID);
private _channels = GET_STATE_RADIO(_radioID,"channels");
private _channel = HASHLIST_SELECT(_channels, _channelNumber);

// Deviation is not returned from "getChannelData" event, must be manually extracted
private _deviation = BASE_RADIO_DEVIATION; // 6 kHz
if (HASH_HASKEY(_channel,"deviation")) then {
    _deviation = 0.001 * (HASH_GET(_channel,"deviation")); // kHz to MHz
};

// Use "getChannelData" event to ensure vehicle rack interoperability
private _channelData = GET_CHANNEL_DATA(_radioID);
private _frequencyTX = HASH_GET(_channelData,"frequencyTX");
private _powerTX = HASH_GET(_channelData,"power");

// Lockout transmitting
HASH_SET(_channel,"rxOnly",true);

// Send ACRE DataEvent
HASHLIST_SET(_channels,_channelNumber,_channel);
SET_STATE_RADIO(_radioID,"channels",_channels);

[[LLSTRING(EnableJamming_Title), 1.3], [format [LLSTRING(EnableJamming_Frequency), _frequencyTX], 1], [format [LLSTRING(EnableJamming_Power), _powerTX], 1], [format [LLSTRING(EnableJamming_Deviation), _deviation], 1], true] call CBA_fnc_notify;

nil
