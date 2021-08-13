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
 * [_this] call jsoc_ew_base_fnc_hack_removeIntel;
 *
 * Public: No
 */

params ["_obj"];

_obj setVariable [QGVAR(hack_hackable), nil, true];
_obj setVariable [QGVAR(hack_share), nil, true];
_obj setVariable [QGVAR(hack_actionText), nil, true];
_obj setVariable [QGVAR(hack_duration), nil, true];
_obj setVariable [QGVAR(hack_title), nil, true];
_obj setVariable [QGVAR(hack_text), nil, true];

private _currentIntelObjs = missionNamespace getVariable [QGVAR(hack_intelObjects), []];
_currentIntelObjs deleteAt (_currentIntelObjs find _obj);
missionNamespace setVariable [QGVAR(hack_intelObjects), _currentIntelObjs, true];
