#include "script_component.hpp"
/*
 * Author: Wilton
 * Creates EH Loop if it is not yet created.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call jsoc_ew_common_fnc_initEHLoop;
 *
 * Public: No
 */

if (isNil QGVAR(EHLoopPID)) then {
    GVAR(EHLoopPID) = [{_this call FUNC(EHLoop)}] call CBA_fnc_addPerFrameHandler;
};
