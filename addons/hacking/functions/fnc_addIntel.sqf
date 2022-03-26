#include "script_component.hpp"
/*
 * Author: Wilton
 * Adds intel to a hackable object
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Share With (0 - Side, 1 - Group, 2 - Nobody) <NUMBER>
 * 2: Action Text <STRING>
 * 3: Hacking Duration <NUMBER>
 * 4: Intel Title <STRING>
 * 5: Intel Text <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_this, 2, "Crack Password", 15, "Decrypted Password", "P4$$W0RD"] call jsoc_ew_hacking_fnc_addIntel;
 *
 * Public: No
 */

params ["_obj", "_share", "_actionText", "_duration", "_title", "_text"];

_obj setVariable [QGVAR(hackable), true, true];
_obj setVariable [QGVAR(share), _share, true];
_obj setVariable [QGVAR(actionText), _actionText, true];
_obj setVariable [QGVAR(duration), _duration, true];
_obj setVariable [QGVAR(title), _title, true];
_obj setVariable [QGVAR(text), _text, true];

private _currentIntelObjs = missionNamespace getVariable [QGVAR(intelObjects), []];
_currentIntelObjs pushBack _obj;
missionNamespace setVariable [QGVAR(intelObjects), _currentIntelObjs, true];
