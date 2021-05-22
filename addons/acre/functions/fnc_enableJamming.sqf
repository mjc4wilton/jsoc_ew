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

// Lockout transmitting
HASH_SET(_currentChannelData,"rxOnly",true);

// Get data to present to user
private _radioData = HASH_GET(acre_sys_data_radioData,_radioID);
private _currentChannelId = HASH_GET(_radioData,"currentChannel");
private _radioChannels = HASH_GET(_radioData,"channels");
private _currentChannelData = HASHLIST_SELECT(_radioChannels, _currentChannelId);

// Use function calls for freq and power
private _calledData = ["", "", "", _radioData] call acre_sys_prc117f_fnc_getCurrentChannelData;
private _frequencyTX = HASH_GET(_calledData,"frequencyTX");
private _powerTX = HASH_GET(_calledData,"power");

// Deviation is not returned from function calls and must be calculated manually
private _deviation = BASE_RADIO_DEVIATION; // 6 kHz
if (HASH_HASKEY(_currentChannelData,"deviation")) then {
    _deviation = 0.001 * (HASH_GET(_currentChannelData,"deviation")); // kHz to MHz
};

[[LLSTRING(EnableJamming_Title), 1.3], [format [LLSTRING(EnableJamming_Frequency), _frequencyTX], 1], [format [LLSTRING(EnableJamming_Power), _powerTX], 1], [format [LLSTRING(EnableJamming_Deviation), _deviation], 1], true] call CBA_fnc_notify;

nil
