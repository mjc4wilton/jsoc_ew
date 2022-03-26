#include "script_component.hpp"
/*
 * Author: Wilton
 * Adds child interactions to unit's self-interaction list
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * 0: Actions <ARRAY>
 *
 * Example:
 * [player] call jsoc_ew_explosives_fnc_cell_addChildren;
 *
 * Public: No
 */

params ["_unit"];

private _actions = [];
private _uniform = uniform _unit;
private _uniformContainer = uniformContainer _unit;
private _vest = vest _unit;
private _vestContainer = vestContainer _unit;
private _backpack = backpack _unit;
private _backpackContainer = backpackContainer _unit;

{
    _x params ["_class","_obj"];

    if ([_obj] call FUNC(cell_isJammer)) then {
        private _config = configOf _obj;
        private _name = getText (_config >> QEGVAR(base,displayNameShort));
        private _picture = getText (_config >> "picture");
        private _action = [
            str _obj,
            _name,
            _picture,
            {},
            {true},
            {_this call FUNC(cell_addChildrenChildren)},
            [_class, _obj]
        ] call ace_interact_menu_fnc_createAction;
        _actions pushBack [_action, [], _unit];
    };
} forEach [[_uniform, _uniformContainer], [_vest, _vestContainer], [_backpack, _backpackContainer]];

_actions
