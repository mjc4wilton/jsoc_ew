#include "script_component.hpp"
/*
 * Author: Wilton
 * Handles detonation of ACE explosives (Executed where jammer is local)
 *
 * Arguments:
 * 0: Explosive <OBJECT>
 * 1: TriggerItem <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_explosive, _trigger] call jsoc_ew_base_fnc_handleDetonationAttempted;
 *
 * Public: No
 */

params ["_explosive", "_unit", "_trigger"];

private _directionExp = ACE_player getDir _explosive;
private _distanceExp = ACE_player distance _explosive;
private _directionFormattedExp = "";

private _directionTrig = ACE_player getDir _unit;
private _distanceTrig = ACE_player distance _unit;
private _directionFormattedTrig = "";

// Find direction to explosive
if (_distanceExp > GVAR(exactRange)) then {
    switch (true) do {
        case (_directionExp >= (360 - 22.5) || {_directionExp < (0 + 22.5)}): {
            _directionFormattedExp = "N";
        };
        case (_directionExp >= (45 - 22.5) && {_directionExp < (45 + 22.5)}): {
            _directionFormattedExp = "NE";
        };
        case (_directionExp >= (90 - 22.5) && {_directionExp < (90 + 22.5)}): {
            _directionFormattedExp = "E";
        };
        case (_directionExp >= (135 - 22.5) && {_directionExp < (135 + 22.5)}): {
            _directionFormattedExp = "SE";
        };
        case (_directionExp >= (180 - 22.5) && {_directionExp < (180 + 22.5)}): {
            _directionFormattedExp = "S";
        };
        case (_directionExp >= (225 - 22.5) && {_directionExp < (225 + 22.5)}): {
            _directionFormattedExp = "SW";
        };
        case (_directionExp >= (275 - 22.5) && {_directionExp < (275 + 22.5)}): {
            _directionFormattedExp = "W";
        };
        case (_directionExp >= (325 - 22.5) && {_directionExp < (325 + 22.5)}): {
            _directionFormattedExp = "NW";
        };
        default {
            _directionFormattedExp = "ERROR";
        };
    };
} else {
    _directionFormattedExp = format [LLSTRING(DegreesFormat), round _directionExp];
};

// Find direction to Trigger-Man
if (_distanceTrig > GVAR(exactRange)) then {
    switch (true) do {
        case (_directionTrig >= (360 - 22.5) || {_directionTrig < (0 + 22.5)}): {
            _directionFormattedTrig = "N";
        };
        case (_directionTrig >= (45 - 22.5) && {_directionTrig < (45 + 22.5)}): {
            _directionFormattedTrig = "NE";
        };
        case (_directionTrig >= (90 - 22.5) && {_directionTrig < (90 + 22.5)}): {
            _directionFormattedTrig = "E";
        };
        case (_directionTrig >= (135 - 22.5) && {_directionTrig < (135 + 22.5)}): {
            _directionFormattedTrig = "SE";
        };
        case (_directionTrig >= (180 - 22.5) && {_directionTrig < (180 + 22.5)}): {
            _directionFormattedTrig = "S";
        };
        case (_directionTrig >= (225 - 22.5) && {_directionTrig < (225 + 22.5)}): {
            _directionFormattedTrig = "SW";
        };
        case (_directionTrig >= (275 - 22.5) && {_directionTrig < (275 + 22.5)}): {
            _directionFormattedTrig = "W";
        };
        case (_directionTrig >= (325 - 22.5) && {_directionTrig < (325 + 22.5)}): {
            _directionFormattedTrig = "NW";
        };
        default {
            _directionFormattedTrig = "ERROR";
        };
    };
} else {
    _directionFormattedTrig = format [LLSTRING(DegreesFormat), round _directionTrig];
};

private _detonatorType = "";
switch (_trigger) do {
    case "ACE_Cellphone": {_detonatorType = LLSTRING(Cell)};
    case "ACE_Clacker": {_detonatorType = LLSTRING(RF)};
    case "ACE_M26_Clacker": {_detonatorType = LLSTRING(RF)};
    default { };
};

[[LLSTRING(DetonationAttempted_Title), 1.3], [format [LLSTRING(DetonationAttempted_Type), _detonatorType]], [format [LLSTRING(DetonationAttempted_Angle), _directionFormattedTrig]], [format [LLSTRING(DetonationAttempted_Explosive_Angle), _directionFormattedExp]], false] call CBA_fnc_notify;
playSound "Spawn";
