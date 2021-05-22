#include "script_component.hpp"

if (hasInterface) then {
    [FUNC(signalFunction)] call acre_api_fnc_setCustomSignalFunc;
};

// Radio Jamming
[QGVAR(equipRadioJammer), {
    params ["_unit", "_f"];

    _unit addItemToBackpack "ACRE_PRC117F";
    private _radios = ["ACRE_PRC117F", _unit] call acre_api_fnc_getAllRadiosByType;
    reverse _radios;
    if (_radios isEqualTo []) exitWith {};
    private _radioID = _radios select 0;

    private _radioData = HASH_GET(acre_sys_data_radioData,_radioID);
    private _currentChannelId = HASH_GET(_radioData,"currentChannel");
    private _radioChannels = HASH_GET(_radioData,"channels");
    private _currentChannelData = HASHLIST_SELECT(_radioChannels, _currentChannelId);

    private _frequencyTX = HASH_SET(_currentChannelData,"frequencyTX",_f);

    [_unit, _unit, _radioID] call FUNC(enableJamming);

}] call CBA_fnc_addEventHandler;
