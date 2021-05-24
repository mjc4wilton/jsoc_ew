#include "script_component.hpp"

GVAR(PFH) = -1;

if (hasInterface) then {
    // Spectrum device EH
    ["weapon", {_this call FUNC(update)}] call CBA_fnc_addPlayerEventHandler;
    ["vehicle", {
        params ["_unit", "_newVehicle"];
        [] call FUNC(disable);
        [_unit, currentWeapon _unit] call FUNC(update);
    }] call CBA_fnc_addPlayerEventHandler;

    // Setup spectrum device
    missionNamespace setVariable ["#EM_FMin", SPECTRUM_FREQ_MIN];
    missionNamespace setVariable ["#EM_FMax", SPECTRUM_FREQ_MAX];
    missionNamespace setVariable ["#EM_SMin", SPECTRUM_SENS_MIN];
    missionNamespace setVariable ["#EM_SMax", SPECTRUM_SENS_MAX];
};
