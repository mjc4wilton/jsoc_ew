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