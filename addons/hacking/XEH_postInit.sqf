#include "script_component.hpp"

if (hasInterface) then {
    // Hacking Intel (Appears the same as ZEN intel)
    [QGVAR(addIntel), {
        params ["_title", "_text"];
        if !(player diarySubjectExists "zen_modules_intel") then {
            player createDiarySubject ["zen_modules_intel", localize "str_disp_intel_title"];
        };

        player createDiaryRecord ["zen_modules_intel", [_title, _text]];
    }] call CBA_fnc_addEventHandler;
};
