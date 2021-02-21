#include "script_component.hpp"
/*
 * Author: Wilton
 * Removes signal from source list
 *
 * Arguments:
 * 0: SourceID <STRING>
 *
 * Return Value:
 * 0: Success <BOOLEAN>
 *
 * Example:
 * ["acre_anprc117_id1"] call jsoc_ew_contact_fnc_drawSignalPF;
 *
 * Public: No
 */

params ["_source"];

private _sourceList = missionNamespace getVariable [QGVAR(sources), []];
private _index = _sourceList findIf {_x select 0 isEqualTo _source};
if (_index != -1) then {
	_sourceList deleteAt _index;
	missionNamespace setVariable [QGVAR(sources), _sourceList];
};

(_index != -1)