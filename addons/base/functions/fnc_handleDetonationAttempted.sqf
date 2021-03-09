#include "script_component.hpp"
/*
 * Author: Wilton
 * Handles detonation of ACE explosives (CLIENT SIDE)
 *
 * Arguments:
 * 0: Explosive <OBJECT>
 * 1: TriggerItem <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_explosive, _trigger] call jsoc_ew_base_fnc_handleDetonationAttempted;
 *
 * Public: No
 */

params ["_explosive","_trigger"];

[[LLSTRING(DetonationAttempted_Title), 1.3], [format [LLSTRING(DetonationAttempted_Angle), (ACE_player getDir _explosive)]], true] call CBA_fnc_notify;