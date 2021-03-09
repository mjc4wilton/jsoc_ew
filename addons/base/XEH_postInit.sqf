#include "script_component.hpp"

if (isServer) then {

	// ACE Explosives Jamming
	[{
		call FUNC(handleAceDetonate);
	}] call ace_explosives_fnc_addDetonateHandler;
};

if (hasInterface) then {
	[QGVAR(detonationAttempted), {_this call FUNC(handleDetonationAttempted)}] call CBA_fnc_addEventHandler;	
};
