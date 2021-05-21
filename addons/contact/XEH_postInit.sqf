#include "script_component.hpp"

GVAR(PFH) = -1;

["weapon", {_this call FUNC(update)}] call CBA_fnc_addPlayerEventHandler;
["vehicle", {
	params ["_unit", "_newVehicle"];
	[] call FUNC(disable);
	[_unit, currentWeapon _unit] call FUNC(update);
}] call CBA_fnc_addPlayerEventHandler;
