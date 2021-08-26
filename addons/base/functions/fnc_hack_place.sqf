#include "script_component.hpp"
/*
 * Author: Wilton
 * Places EW Laptop
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Object to place <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "jsoc_ew_base_Laptop"] call jsoc_ew_base_fnc_hack_place;
 *
 * Public: No
 */

params ["_unit", "_class"];

_unit removeItem _class;

if (stance _unit == "STAND") then {
    [_unit, "AmovPercMstpSrasWrflDnon_diary"] call ace_common_fnc_doAnimation;
};

[{
    params ["_unit"];

    private _direction = getDir _unit;
    private _position = getPosASL _unit vectorAdd [0.8 * sin _direction, 0.8 * cos _direction, 0.02];

    // 180 degree rotation
    if (_direction > 180) then {
        _direction = _direction - 180;
    } else {
        _direction = _direction + 180;
    };

    private _laptop = "jsoc_ew_base_LaptopObject" createVehicle [0, 0, 0];

    [{
        (_this select 0) params ["_laptop", "_direction", "_position"];

        _laptop setDir _direction;
        _laptop setPosASL _position;

        if ((getPosATL _laptop select 2) - (getPos _laptop select 2) < 1E-5) then { // if not on object, then adjust to surface normale
            _laptop setVectorUp (surfaceNormal (position _laptop));
        };

        [_this select 1] call CBA_fnc_removePerFrameHandler;
    }, 0, [_laptop, _direction, _position]] call CBA_fnc_addPerFrameHandler;

}, [_unit], 1] call CBA_fnc_waitAndExecute;
