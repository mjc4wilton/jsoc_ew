#include "script_component.hpp"
/*
 * Author: Wilton
 * Shows hacking progress to player
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Player <OBJECT>
 * 2: Parameters <ARRAY>
 *
 * Return Value:
 * 0: Actions <ARRAY>
 *
 * Example:
 * [ACE_player, cursorTarget, [test01, test02]] call jsoc_ew_hacking_fnc_showProgress;
 *
 * Public: No
 */

params ["_target", "_player", "_parameters"];
_parameters params ["_obj", "_laptop"];

private _duration = _obj getVariable [QGVAR(hack_duration), 1];
private _timeVar = QGVAR(hack_) + (str _obj) + "_time";
private _startTime = _laptop getVariable [_timeVar, 0];
private _currentTime = [time, serverTime] select isMultiplayer;
private _deltaTime = _currentTime - _startTime;
private _percentTimeElapsed = (_deltaTime / _duration) * 100;
private _percentTimeElapsedString = [_percentTimeElapsed, 1, 0, false] call CBA_fnc_formatNumber;

if (_percentTimeElapsed < 100) then {
    [["Attack in progress:"], [(_percentTimeElapsedString + "% Complete")]] call CBA_fnc_notify;
};

