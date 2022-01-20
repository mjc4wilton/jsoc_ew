#include "script_component.hpp"
/*
 * Author: Wilton
 * Executes code every time a variable is updated
 *
 * Arguments:
 * 0: Variable to track <ANY>
 * 1: Code to execute <CODE>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call jsoc_ew_common_fnc_addVariableEventHandler;
 *
 * Public: No
 */

params [["_variableName", "", [""]], ["_code", {}, [{}]]];

// Ensure EH Loop is running, checks for existing loop are performed internally
[] call FUNC(initEHLoop);

GVAR(EH_trackedVariables) pushBackUnique _variableName;
GVAR(EH_trackedVariables_code) pushBackUnique _code;
