#include "script_component.hpp"
/*
 * Author: Wilton
 * Adds a new signal to the device which will last for 1 frame
 *
 * Arguments:
 * 0: SourceID <STRING>
 * 1: Frequency <NUMBER>
 * 2: Power <NUMBER>
 * 3: Permanent <BOOLEAN>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["acre_anprc117_id1"] call jsoc_ew_contact_fnc_drawSignalPF;
 *
 * Public: No
 */

params ["_source", "_f", "_power", ["_perm", false]];

private _sourceList = missionNamespace getVariable [QGVAR(sources), []];

if !((_sourceList findIf {_x select 0 isEqualTo _source}) isEqualTo -1) then {
	// Source already in list
	private _sourceIndex = _sourceList findIf {_x select 0 isEqualTo _source};
	_sourceList set [_sourceIndex, [_source, _f, _power, _perm, diag_frameNo]];
} else {
	_sourceList pushBack [_source, _f, _power, _perm, diag_frameNo];
};

missionNamespace setVariable [QGVAR(sources), _sourceList, false];
