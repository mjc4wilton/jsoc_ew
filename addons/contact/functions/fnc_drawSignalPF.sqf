#include "script_component.hpp"
/*
 * Author: Wilton
 * Ran on each frame to update the display of the spectrum device
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call jsoc_ew_contact_fnc_drawSignalPF;
 *
 * Public: No
 */

// Cleanup source list
private _sourceList = missionNamespace getVariable [QGVAR(sources), []];
{
	if (!(_x select 3) && _x select 4 < diag_frameNo) then {
		_sourceList deleteAt _forEachIndex;
	};
} forEach _sourceList;
missionNamespace setVariable [QGVAR(sources), _sourceList];

// Set vars for spectrum device
private _deviceEM = [];
{
	_deviceEM pushback (_x select 1);
	_deviceEM pushback (_x select 2);
} forEach _sourceList;
missionNamespace setVariable ["#EM_Values",_deviceEM];