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

{
    if (_x getVariable [QGVAR(hack_hackable), false] isEqualTo true) then {
        // Object is hackable, add connect interaction
        private _action = [
            (str _x),                           // Action Name (STRING)
            (LLSTRING(Hack_Connect)),           // Name shown in menu
            "",                                 // Icon (STRING)
            {_this call FUNC(hack_connect)},    // Statement (CODE)
            {_this call FUNC(hack_canConnect)}, // Condition (CODE)
            {},                                 // Insert Children (CODE)
            [_target]                           // Parameters (ANY)
        ] call ace_interact_menu_fnc_createAction;
        [_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    };
} forEach (_target nearEntities GVAR(hack_connectorLength));

_player setVariable [QGVAR(hasConnector), true];
