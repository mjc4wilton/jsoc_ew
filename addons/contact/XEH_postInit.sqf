#include "script_component.hpp"

[
	ACE_player,
	"AnimChanged",
	{
		params ["_unit"];
		if (GVAR(PFH) isEqualTo -1) then {
			if (currentWeapon _unit isEqualTo "hgun_esd_01_F") then {
				GVAR(PFH) = [{
						call FUNC(drawSignalPF);
					},
					0
				] call CBA_fnc_addPerFrameHandler;
			};
		} else {
			if !(currentWeapon _unit isEqualTo "hgun_esd_01_F") then {
				[GVAR(PFH)] call CBA_fnc_removePerFrameHandler;
			};
		};
	},
	[ACE_player]
] call CBA_fnc_addBISEventHandler;

[
	QGVAR(addSignal),
	{
		_this call FUNC(addSignal);
	}
] call CBA_fnc_addEventHandler;

[
	QGVAR(removeSignal),
	{
		_this call FUNC(removeSignal);
	}
] call CBA_fnc_addEventHandler;