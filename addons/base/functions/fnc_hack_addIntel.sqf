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
 * [_this, 2, "Crack Password", 15, "Decrypted Password", "P4$$W0RD"] call jsoc_ew_base_fnc_hack_addIntel;
 *
 * Public: No
 */

params ["_obj", "_share", "_actionText", "_duration", "_title", "_text"];

_obj setVariable [QGVAR(hack_hackable), true];
_obj setVariable [QGVAR(hack_share), _share];
_obj setVariable [QGVAR(hack_actionText), _actionText];
_obj setVariable [QGVAR(hack_duration), _duration];
_obj setVariable [QGVAR(hack_title), _title];
_obj setVariable [QGVAR(hack_text), _text];

private _currentIntelObjs = missionNamespace getVariable [QGVAR(hack_intelObjects), []];
_currentIntelObjs pushBack _obj;
missionNamespace setVariable [QGVAR(hack_intelObjects), _currentIntelObjs, true];
