#include "script_component.hpp"
/*
 * Author: Wilton
 * Disables jamming using the current active radio
 *
 * Arguments:
 * 0: Unit <UNIT>
 * 1: Target <UNIT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, player] call jsoc_ew_acre_fnc_disableJamming;
 *
 * Public: No
 */

params ["_unit", "_target"];

private _radioID = [] call acre_api_fnc_getCurrentRadio;
private _jammers = missionNamespace getVariable [QGVAR(jammers), []];
if !(_radioID in _jammers) exitWith {}; //Exit if radio is not jamming

private _index = _jammers find _radioID;
_jammers deleteAt _index;
missionNamespace setVariable [QGVAR(jammers), _jammers, true];

private _channelNumber = GET_CHANNEL_NUM(_radioID);
private _channels = GET_STATE_RADIO(_radioID,"channels");
private _channel = HASHLIST_SELECT(_channels, _channelNumber);
HASH_SET(_channel,"rxOnly",false);

HASHLIST_SET(_radioChannels,_channelNumber,_channel);
SET_STATE_RADIO(_radioID,"channels",_radioChannels);

[[LLSTRING(DisableJamming_Title), 1.3], true] call CBA_fnc_notify;

nil
