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

_obj setVariable [QGVAR(hack_hackable), nil];
_obj setVariable [QGVAR(hack_share), nil];
_obj setVariable [QGVAR(hack_actionText), nil];
_obj setVariable [QGVAR(hack_duration), nil];
_obj setVariable [QGVAR(hack_title), nil];
_obj setVariable [QGVAR(hack_text), nil];

private _currentIntelObjs = missionNamespace getVariable [QGVAR(hack_intelObjects), []];
_currentIntelObjs deleteAt (_currentIntelObjs find _obj);
missionNamespace setVariable [QGVAR(hack_intelObjects), _currentIntelObjs, true];
