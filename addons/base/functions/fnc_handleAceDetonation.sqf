#include "script_component.hpp"
/*
 * Author: Wilton
 * Handles detonation of ACE explosives (Executed where detonator is local)
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: MaxRange <NUMBER>
 * 2: Explosive <OBJECT>
 * 3: FuzeTime <NUMBER>
 * 4: TriggerItem <STRING>
 *
 * Return Value:
 * 0: Allow explosion <BOOLEAN>
 *
 * Example:
 * [_unit, _range, _explosive, _fuse, _trigger] call jsoc_ew_base_fnc_handleAceDetonation;
 *
 * Public: No
 */

params ["_unit", "_range","_explosive","_fuse","_trigger"];

if (_range == -1) then {
    // Infinite detonation range
    _range = GVAR(maxJamRange);
};
private _return = true;
scopeName QGVAR(handleAceDetonation_main);

{
    if (_x isKindOf "Man") then {
        private _jammerUnit = _x;
        private _uniformContainer = uniformContainer _jammerUnit;
        private _vestContainer = vestContainer _jammerUnit;
        private _backpackContainer = backpackContainer _jammerUnit;
        {
            private _obj = _x;
            if (_trigger isEqualTo "ACE_Cellphone") then {
                if ([_obj] call FUNC(cell_isJammer)) then {
                    if (_obj getVariable [QGVAR(cell_isJamming),false]) then {
                        _return = false;
                        [QGVAR(detonationAttempted), [_explosive, _unit, _trigger], _jammerUnit] call CBA_fnc_targetEvent;
                        breakTo QGVAR(handleAceDetonation_main);
                    };
                };
            };
            if (_trigger isEqualTo "ACE_Clacker" || {_trigger isEqualTo "ACE_M26_Clacker"}) then {
                if ([_obj] call FUNC(rf_isJammer)) then {
                    if (_obj getVariable [QGVAR(rf_isJamming),false]) then {
                        _return = false;
                        [QGVAR(detonationAttempted), [_explosive, _unit, _trigger], _jammerUnit] call CBA_fnc_targetEvent;
                        breakTo QGVAR(handleAceDetonation_main);
                    };
                };
            };
        } forEach [_uniformContainer, _vestContainer, _backpackContainer];
    };
    if (_x isKindOf "WeaponHolder" || {_x isKindOf "ReammoBox_F"} || {_x isKindOf "AllVehicles"}) then {
        private _container = _x;
        {
            _x params ["_class", "_obj"];
            if (_trigger isEqualTo "ACE_Cellphone") then {
                if ([_obj] call FUNC(cell_isJammer)) then {
                    if (_obj getVariable [QGVAR(cell_isJamming),false]) then {
                        _return = false;
                        breakTo QGVAR(handleAceDetonation_main);
                    };
                };
            };
            if (_trigger isEqualTo "ACE_Clacker" || {_trigger isEqualTo "ACE_M26_Clacker"}) then {
                if ([_obj] call FUNC(rf_isJammer)) then {
                    if (_obj getVariable [QGVAR(rf_isJamming),false]) then {
                        _return = false;
                        breakTo QGVAR(handleAceDetonation_main);
                    };
                };
            };
        } forEach everyContainer _container;
    };
} forEach ((getPos _explosive) nearEntities [["CAManBase","WeaponHolder","ReammoBox_F","AllVehicles"], _range]);

_return
