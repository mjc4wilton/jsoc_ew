#include "script_component.hpp"

[QGVAR(showErrorMessage), {
    params ["_message"];
    [_message] call zen_common_fnc_showMessage;
}] call CBA_fnc_addEventHandler;
