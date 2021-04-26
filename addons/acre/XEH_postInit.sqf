#include "script_component.hpp"

if (hasInterface) then {
	[FUNC(signalFunction)] call acre_api_fnc_setCustomSignalFunc;
};

// Radio Jamming
[QGVAR(equipRadioJammer), {
	params ["_unit", "_f"];

	_unit addItemToBackpack "ACRE_PRC117F";
	private _radios = [_unit] call acre_sys_data_fnc_getRemoteRadioList;
	private _newRadios = [];
	{
		if ([_x, "ACRE_PRC117F"] call acre_api_fnc_isKindOf) then {
			_newRadios pushBack _x;
		};
		
	} forEach _radios;
	reverse _newRadios;
	if (_newRadios isEqualTo []) exitWith {};
	private _radioID = _newRadios select 0;

	private _radioData = HASH_GET(acre_sys_data_radioData,_radioID);
	private _currentChannelId = HASH_GET(_radioData,"currentChannel");
	private _radioChannels = HASH_GET(_radioData,"channels");
	private _currentChannelData = HASHLIST_SELECT(_radioChannels, _currentChannelId);

	private _frequencyTX = HASH_SET(_currentChannelData,"frequencyTX",_f);

	[_unit, _unit, _radioID] call FUNC(enableJamming);

}] call CBA_fnc_addEventHandler;
