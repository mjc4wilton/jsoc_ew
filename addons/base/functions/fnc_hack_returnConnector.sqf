#include "script_component.hpp"
/*
 * Author: Wilton
 * Function called when player takes connector from laptop
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player, cursorTarget] call jsoc_ew_base_fnc_hack_takeConnector;
 *
 * Public: No
 */

params ["_player", "_target"];

_player setVariable [QGVAR(hasConnector), false];
