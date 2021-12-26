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
 * [ACE_player, cursorTarget, [test01, test02]] call jsoc_ew_base_fnc_hack_showProgress;
 *
 * Public: No
 */

params ["_target", "_player", "_parameters"];
_parameters params ["_obj", "_laptop"];

private _duration = _obj getVariable [QGVAR(hack_duration), 1];
private _timeVar = QGVAR(hack_) + (str _obj) + "_time";
private _startTime = _laptop getVariable [_timeVar, []];
private _currTime = systemTimeUTC;

// Calculate time difference
private _timeDiffYr = (_currTime select 0) - (_startTime select 0);
private _timeDiffMo = (_currTime select 1) - (_startTime select 1);
private _timeDiffD = (_currTime select 2) - (_startTime select 2);
private _timeDiffH = (_currTime select 3) - (_startTime select 3);
private _timeDiffM = (_currTime select 4) - (_startTime select 4);
private _timeDiffS = (_currTime select 5) - (_startTime select 5);
private _timeDiffMs = (_currTime select 6) - (_startTime select 6);

private _timeDiffTotalS = (_timeDiffYr * 31536000) + (_timeDiffMo * 2592000) + (_timeDiffD * 86400) + (_timeDiffH * 3600) + (_timeDiffM * 60) + (_timeDiffS) + (_timeDiffMs * 0.001);

private _percentTimeElapsed = (_timeDiffTotalS / _duration) * 100;

if (_percentTimeElapsed < 100) then {
    [["Attack in progress:"], [(str _percentTimeElapsed + "% Complete")]] call CBA_fnc_notify;
};

