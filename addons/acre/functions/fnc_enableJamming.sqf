#include "script_component.hpp"
/*
 * Author: Wilton
 * Enables jamming using the current active radio
 *
 * Arguments:
 * 0: Unit <UNIT>
 * 1: Target <UNIT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, player] call jsoc_ew_acre_fnc_enableJamming;
 *
 * Public: No
 */

params ["_unit", "_target"];

private _radioID = [] call acre_api_fnc_getCurrentRadio;
private _jammersClass = missionNamespace getVariable [QGVAR(jammersClass), []];
if (_radioID in _jammersClass) exitWith {}; //Exit if radio is already jamming

private _radioData = HASH_GET(acre_sys_data_radioData,_radioID);
private _currentChannelId = HASH_GET(_radioData,"currentChannel");
private _radioChannels = HASH_GET(_radioData,"channels");
private _currentChannelData = HASHLIST_SELECT(_radioChannels, _currentChannelId);

private _frequencyTX = HASH_GET(_currentChannelData,"frequencyTX");
private _powerTX = GVAR(jammer_powerMult) * HASH_GET(_currentChannelData,"power"); // added power boost
private _deviation = (GVAR(jammer_bandwidthMult) ^ 2) * 0.006; // 6 kHz with 3x (default) boost
if (HASH_HASKEY(_currentChannelData,"deviation")) then {
	_deviation = (GVAR(jammer_bandwidthMult) ^ 2) * 0.001 * (HASH_GET(_currentChannelData,"deviation")); // kHz to MHz with x3 (default) boost (covers wider frequency)
};

private _jammers = missionNamespace getVariable [QGVAR(jammers), []];

_jammers pushBack [_radioID, _frequencyTX, _powerTX, _deviation];
_jammersClass pushBack _radioID;
missionNamespace setVariable [QGVAR(jammers), _jammers, true];
missionNamespace setVariable [QGVAR(jammersClass), _jammersClass, true];
HASH_SET(_currentChannelData,"rxOnly",true);

[[LLSTRING(EnableJamming_Title), 1.3], [format [LLSTRING(EnableJamming_Frequency), _frequencyTX], 1], [format [LLSTRING(EnableJamming_Power), _powerTX], 1], [format [LLSTRING(EnableJamming_Deviation), _deviation], 1], true] call CBA_fnc_notify;

nil
