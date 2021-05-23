#include "script_component.hpp"
/*
 * Author: Wilton
 * Returns various data about a jammer
 *
 * Arguments:
 * 0: Jammer Radio ID <STRING>
 *
 * Return Value:
 * 1: Frequency Tx <NUMBER>
 * 2: Power <NUMBER>
 * 3: Deviation (MHz) <NUMBER>
 *
 * Example:
 * ["acre_prc117f_id_1"] call jsoc_ew_acre_fnc_getJammerSettings;
 *
 * Public: No
 */

params ["_radioID"];

// Get values that can be returned from "getChannelData" event
private _channelData = GET_CHANNEL_DATA(_radioID);
private _frequencyTx = HASH_GET(_channelData,"frequencyTx");
private _power = HASH_GET(_channelData,"power");

// Get base hash of radio for items that are not returned from "getChannelData" event
private _channelNumber = GET_CHANNEL_NUM(_radioID);
private _channels = GET_STATE_RADIO(_radioID,"channels");
private _channel = HASHLIST_SELECT(_channels, _channelNumber);

private _deviation = BASE_RADIO_DEVIATION; // 6 kHz
if (HASH_HASKEY(_channel,"deviation")) then {
    _deviation = 0.001 * (HASH_GET(_channel,"deviation")); // kHz to MHz
};

// Return values
[_frequencyTx, _power, _deviation]
