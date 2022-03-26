#include "script_component.hpp"

/*
 *	Check for mods
 */

// ACRE
GVAR(hasACRE) = false;
if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
    GVAR(hasACRE) = true;
};
// TFAR
GVAR(hasTFAR) = false;
if (isClass(configFile >> "CfgPatches" >> "tfar_core")) then {
    GVAR(hasTFAR) = true;
};

GVAR(hasRadio) = GVAR(hasACRE) || GVAR(hasTFAR);

// Zeus Enhanced (ZEN)
GVAR(hasZEN) = false;
if (isClass(configFile >> "CfgPatches" >> "zen_common")) then {
    GVAR(hasZEN) = true;
};
// Achilles
GVAR(hasAchilles) = false;
if (isClass(configFile >> "CfgPatches" >> "achilles_functions_f_achilles")) then {
    GVAR(hasAchilles) = true;
};

// LAMBS Danger FSM
GVAR(hasLAMBS) = false;
if (isClass(configFile >> "CfgPatches" >> "lambs_main")) then {
    GVAR(hasLAMBS) = true;
};


if (hasInterface) then {
    // ACE Explosives Jamming
    [{
        _this call FUNC(handleAceDetonation)
    }] call ace_explosives_fnc_addDetonateHandler;
    [QGVAR(detonationAttempted), {_this call FUNC(handleDetonationAttempted)}] call CBA_fnc_addEventHandler;

    // LAMBS AI Information Sharing Jammer
    if (GVAR(hasLAMBS)) then {
        [{
            _this call FUNC(handleLambsShare)
        }] call lambs_main_fnc_addShareInformationHandler;
    };
};

// Radio Jamming
[QGVAR(equipRadioJammer), {
    params ["_unit", "_f"];

    if (GVAR(hasACRE)) then {
        [QEGVAR(acre,equipRadioJammer), [_unit, _f]] call CBA_fnc_localEvent;
    };
}] call CBA_fnc_addEventHandler;

// Time variables
GVAR(missionTime) = {[] call {[time, serverTime] select isMultiplayer}};
