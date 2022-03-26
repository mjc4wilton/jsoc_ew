#include "script_component.hpp"
/*
 * Author: Wilton
 * Adds intel to a hackable object
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_this] call jsoc_ew_hacking_fnc_removeIntel;
 *
 * Public: No
 */

params ["_obj"];

_obj setVariable [QGVAR(hackable), nil, true];
_obj setVariable [QGVAR(share), nil, true];
_obj setVariable [QGVAR(actionText), nil, true];
_obj setVariable [QGVAR(duration), nil, true];
_obj setVariable [QGVAR(title), nil, true];
_obj setVariable [QGVAR(text), nil, true];

private _currentIntelObjs = missionNamespace getVariable [QGVAR(intelObjects), []];
_currentIntelObjs deleteAt (_currentIntelObjs find _obj);
missionNamespace setVariable [QGVAR(intelObjects), _currentIntelObjs, true];
