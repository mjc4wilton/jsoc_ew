#include "script_component.hpp"

if (hasInterface) then {
    // ACE Explosives Jamming
    [{
        _this call FUNC(handleAceDetonation)
    }] call ace_explosives_fnc_addDetonateHandler;
    [QGVAR(detonationAttempted), {_this call FUNC(handleDetonationAttempted)}] call CBA_fnc_addEventHandler;

    // Diary entry for logging explosion attempts
    [QGVAR(addExplosionAttempt), {
        params ["_title", "_text"];
        if !(player diarySubjectExists QGVAR(attemptedDetonations)) then {
            player createDiarySubject [QGVAR(attemptedDetonations), LLSTRING(Diary_AttemptedDetonations)];
        };

        player createDiaryRecord [QGVAR(attemptedDetonations), [_title, _text]];
    }] call CBA_fnc_addEventHandler;
};
