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
 * [ACE_player, cursorTarget] call jsoc_ew_hacking_fnc_takeConnector;
 *
 * Public: No
 */

params ["_player", "_target"];

{
    private _obj = _x;
    if (((_obj getVariable [QGVAR(hasInteract), false]) isNotEqualTo true) && (_obj getVariable [QGVAR(hackable), false]) isEqualTo true) then {
        // Object is hackable, add connect interaction
        private _action = [
            (str _obj + "_connect"),                           // Action Name (STRING)
            LLSTRING(Connect),             // Name shown in menu
            "",                                 // Icon (STRING)
            {_this call FUNC(connect)},    // Statement (CODE)
            {_this call FUNC(canConnect)}, // Condition (CODE)
            {},                                 // Insert Children (CODE)
            [_obj, _target]                           // Parameters (ANY)
        ] call ace_interact_menu_fnc_createAction;
        [_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

        _obj setVariable [QGVAR(hasInteract), true];
    };
} forEach ((getPos _target) nearEntities [["WeaponHolder","ReammoBox_F","AllVehicles","Thing"], GVAR(connectorLength)]);

_player setVariable [QGVAR(hasConnector), true];
