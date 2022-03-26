#include "script_component.hpp"
/*
 * Author: Wilton
 * Adds child interactions for each cell jammer
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Player <OBJECT>
 * 2: Params <ARRAY>
 *   0: Jammer Class <STRING>
 *   1: Jammer Object <OBJECT>
 *
 * Return Value:
 * 0: Actions <ARRAY>
 *
 * Example:
 * [player] call jsoc_ew_explosives_fnc_cell_addChildrenChildren;
 *
 * Public: No
 */

params ["_target", "_player", "_params"];
_params params ["_class","_obj"];

private _actionEnable = [
    QGVAR(cell_enableJamming),
    LLSTRING(Cell_EnableJamming),
    "",
    {
        // Statement
        (_this select 2) params ["_class","_obj"];
        [_obj] call FUNC(cell_enableJamming);
    },
    {
        // Condition
        (_this select 2) params ["_class","_obj"];
        !([_obj] call FUNC(cell_isJamming))
    },
    {},
    [_class, _obj]
] call ace_interact_menu_fnc_createAction;

private _actionDisable = [
    QGVAR(cell_disableJamming),
    LLSTRING(Cell_DisableJamming),
    "",
    {
        (_this select 2) params ["_class","_obj"];
        [_obj] call FUNC(cell_disableJamming);
    },
    {
        (_this select 2) params ["_class","_obj"];
        [_obj] call FUNC(cell_isJamming)
    },
    {},
    [_class, _obj]
] call ace_interact_menu_fnc_createAction;

[[_actionEnable, [], _target], [_actionDisable, [], _target]]
