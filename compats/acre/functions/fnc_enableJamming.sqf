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
private _powerTX = 10 * HASH_GET(_currentChannelData,"power"); // added power boost
if (HASH_HASKEY(_currentChannelData,"deviation")) then {
	private _deviation = HASH_GET(_currentChannelData,"deviation"); // multipies deviation by a factor of 100 (treats a kHz value as a MHz value for jamming boost)
} else {
	private _deviation = 6;
};

private _jammers = missionNamespace getVariable [QGVAR(jammers), []];

_jammers pushBack [_radioID, _frequencyTX, _powerTX, _deviation];
_jammersClass pushBack _radioID;
missionNamespace setVariable [QGVAR(jammers), _jammers, true];
missionNamespace setVariable [QGVAR(jammersClass), _jammersClass, true];
HASH_SET(_currentChannelData,"rxOnly",true);

hintSilent format ["Jamming Enabled\nFrequency: %1\nPower: %2\nDeviation: %3", _frequencyTX, _powerTX, _deviation];

if (isClass(configFile >> "CfgPatches" >> "jsoc_ew_contact")) then {
	// Add jamming signal to device
	[_radioID, _frequencyTX, _powerTX, true] call EFUNC(contact,addSignal);
};

nil
