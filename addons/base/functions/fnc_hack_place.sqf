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

if ((_unit call CBA_fnc_getUnitAnim) select 0 == "stand") then {
    _unit playMove "AmovPercMstpSrasWrflDnon_diary";
};

[{
    params ["_unit"];

    // prevent collision damage
    ["ace_common_fixCollision", _unit] call CBA_fnc_localEvent;

    // Check for a place to land the laptop
    private _direction = getDir _unit;
    private _position = (getPosASL _unit) vectorAdd [0.8 * sin(_direction), 0.8 * cos(_direction), 0];
    private _vectorUp = [0, 0, 1];
    private _intersections = lineIntersectsSurfaces [_position vectorAdd [0, 0, 1.5], _position vectorDiff [0, 0, 1.5], _unit, objNull, true, 1, "GEOM", "FIRE"];
    if (_intersections isEqualTo []) then {
        TRACE_1("No intersections",_intersections);
    } else {
        (_intersections select 0) params ["_touchingPoint", "_surfaceNormal"];
        _position = _touchingPoint vectorAdd [0, 0, 0.05];
        _vectorUp = _surfaceNormal;
    };

    // Create the laptop and set its position and orientation
    private _laptop = QGVAR(LaptopObject) createVehicle [0, 0, 0];
    _laptop setDir _direction;
    _laptop setPosASL _position;
    _laptop setVectorUp _vectorUp;
    ["ace_common_fixPosition", _laptop, _laptop] call CBA_fnc_targetEvent;
    ["ace_common_fixFloating", _laptop, _laptop] call CBA_fnc_targetEvent;

    _unit reveal _laptop;

}, [_unit], 1, 0] call CBA_fnc_waitAndExecute;

