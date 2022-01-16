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

params ["_unit", "_target", ["_radioID", [] call acre_api_fnc_getCurrentRadio]];

//Exit if radio is not jamming
private _stateJamming = GET_STATE_RADIO(_radioID, QGVAR(jamming))
if (isNil "_stateJamming" || !_stateJamming) exitWith {};

// deregister radio from jammers list
[QGVAR(deregisterJammer), [_radioID]] call CBA_fnc_serverEvent;
SET_STATE_RADIO(_radioID, QGVAR(jamming), nil);

private _channelNumber = GET_CHANNEL_NUM(_radioID);
private _channels = GET_STATE_RADIO(_radioID,"channels");
private _channel = HASHLIST_SELECT(_channels, _channelNumber);
HASH_SET(_channel,"rxOnly",false);

HASHLIST_SET(_channels,_channelNumber,_channel);
SET_STATE_RADIO(_radioID,"channels",_channels);

[[LLSTRING(DisableJamming_Title), 1.3], true] call CBA_fnc_notify;

nil
