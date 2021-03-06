#include "script_component.hpp"
/*
 * Author: joko // Jonas - All credit to them. Copied from LAMBS_Danger github.
 *
 *
 * Arguments:
 *
 *
 * Return Value:
 *
 *
 * Example:
 *
 *
 * Public: No
*/
params ["_logic"];

if (_logic getVariable [QGVAR(skipInit), false]) exitWith {};
if (!local _logic) exitWith {};
private _logicConfig = configOf _logic;
private _fnc = getText (_logicConfig >> "function");
if (_fnc isEqualTo "") exitWith {};

if (isNil _fnc) then {
    _fnc = compile _fnc;
} else {
    _fnc = missionNamespace getVariable _fnc;
};
private _is3DEN = (getNumber (_logicConfig >> "is3DEN")) == 1;
if (_is3DEN) then {
    [_fnc, ["init", [_logic, true, true]]] call CBA_fnc_execNextFrame;
} else {
    [_fnc, [_logic, true, true]] call CBA_fnc_execNextFrame;
};
