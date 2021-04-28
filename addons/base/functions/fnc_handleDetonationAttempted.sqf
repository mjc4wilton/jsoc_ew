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

params ["_explosive","_trigger"];

private _direction = ACE_player getDir _explosive;
private _distance = ACE_player distance _explosive;
private _directionFormatted = "";

if (_distance > GVAR(exactRange)) then {
	switch (true) do {
		case (_direction >= (360 - 22.5) || {_direction < (0 + 22.5)}): { 
			_directionFormatted = "N";
		};
		case (_direction >= (45 - 22.5) && {_direction < (45 + 22.5)}): { 
			_directionFormatted = "NE";
		};
		case (_direction >= (90 - 22.5) && {_direction < (90 + 22.5)}): { 
			_directionFormatted = "E";
		};
		case (_direction >= (135 - 22.5) && {_direction < (135 + 22.5)}): { 
			_directionFormatted = "SE";
		};
		case (_direction >= (180 - 22.5) && {_direction < (180 + 22.5)}): { 
			_directionFormatted = "S";
		};
		case (_direction >= (225 - 22.5) && {_direction < (225 + 22.5)}): { 
			_directionFormatted = "SW";
		};
		case (_direction >= (275 - 22.5) && {_direction < (275 + 22.5)}): { 
			_directionFormatted = "W";
		};
		case (_direction >= (325 - 22.5) && {_direction < (325 + 22.5)}): { 
			_directionFormatted = "NW";
		};
		default { 
			_directionFormatted = "ERROR";
		};
	};
} else {
	_directionFormatted = format [LLSTRING(DegreesFormat), round _direction];
};

private _detonatorType = "";
switch (_trigger) do {
	case "ACE_Cellphone": {_detonatorType = LLSTRING(Cell)};
	case "ACE_Clacker": {_detonatorType = LLSTRING(RF)};
	case "ACE_M26_Clacker": {_detonatorType = LLSTRING(RF)};
	default { };
};

[[LLSTRING(DetonationAttempted_Title), 1.3], [format [LLSTRING(DetonationAttempted_Type), _detonatorType]], [format [LLSTRING(DetonationAttempted_Angle), _directionFormatted]], true] call CBA_fnc_notify;
playSound "Spawn";
