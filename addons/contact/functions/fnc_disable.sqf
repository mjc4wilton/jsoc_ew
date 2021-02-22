#include "script_component.hpp"
/*
 * Author: Wilton
 * Disables PFH
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call jsoc_ew_contact_fnc_disable;
 *
 * Public: No
 */

// Ensure we already have loop running
if !(GVAR(PFH) > -1) exitWith {};

[GVAR(PFH)] call CBA_fnc_removePerFrameHandler;
GVAR(PFH) = -1;
