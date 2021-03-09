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
private _jammersClass = missionNamespace getVariable [QGVAR(jammersClass), []];
if !(_radioID in _jammersClass) exitWith {}; //Exit if radio is not jamming

private _jammers = missionNamespace getVariable [QGVAR(jammers), []];
private _index = _jammersClass find _radioID;
_jammers deleteAt _index;
_jammersClass deleteAt _index;
missionNamespace setVariable [QGVAR(jammers), _jammers, true];
missionNamespace setVariable [QGVAR(jammersClass), _jammersClass, true];

private _radioData = HASH_GET(acre_sys_data_radioData,_radioID);
private _currentChannelId = HASH_GET(_radioData,"currentChannel");
private _radioChannels = HASH_GET(_radioData,"channels");
private _currentChannelData = HASHLIST_SELECT(_radioChannels, _currentChannelId);
HASH_SET(_currentChannelData,"rxOnly",false);

[[LLSTRING(DisableJamming_Title), 1.3], true] call CBA_fnc_notify;

nil
