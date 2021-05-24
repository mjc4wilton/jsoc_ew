#include "script_component.hpp"
/*
 * Author: Wilton
 * Ran on each frame to update the display of the spectrum device
 *
 * Arguments:
 * 0: Arguments from PFH <ARRAY>
 *     0: Antenna <STRING>
 * 1: PFH Handler ID <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call jsoc_ew_contact_fnc_drawSignalPF;
 *
 * Public: No
 */

params ["_args", "_handle"];
_args params ["_antenna"];

private _sourceList = [];

switch (_antenna) do {
    case "muzzle_antenna_01_f": {
        // SD Military Antenna (78-89 MHz)
        // Used for detecting ACRE / TFAR jammers

        if (EGVAR(base,hasRadio)) then {
            if (EGVAR(base,hasACRE)) then {
                // Handle ACRE Jammers
                {
                    // Function requires an AN/PRC-152 to utilize as a receiver
                    private _activeRadio = ["ACRE_PRC152", ACE_player] call acre_api_fnc_getRadioByType;
                    if (isNil {_activeRadio}) exitWith {
                        [[LLSTRING(DrawSignal_Error), 1.3], [LLSTRING(DrawSignal_ACRE_NoRadio), 1], true] call CBA_fnc_notify;
                    };

                    private _radioID = _x;
                    private _jammerSettings = [_radioID] call EFUNC(acre,getJammerSettings);
                    _jammerSettings params ["_frequency", "_power"];

                    private _jammerObject = [_x] call acre_sys_radio_fnc_getRadioObject;
                    private _signal = [_frequency, _power, _activeRadio, _radioID] call EFUNC(acre,signalFunctionJammer);
                    _signal params ["", "_maxSignal"];

                    private _bearingFacing = getDir ACE_player;
                    private _bearingJammer = ACE_player getDir _jammerObject;
                    private _angle = (_bearingFacing max _bearingJammer) - (_bearingFacing min _bearingJammer);
                    if (_angle > 180) then {
                        _angle = 360 - _angle
                    };
                    private _multiplier = 1 - ((1 / 180) * _angle) ^ 2; // Quadratically varied with 1 at 0 angle and 0 at 180 angle.
                    private _maxSignalFinal = (-1 * (10 ^ ((log (abs _maxSignal)) * (1/(0.0001 max _multiplier))))) max -993; // Vary signal strength with percent error

                    _sourceList pushBack [_frequency, _maxSignalFinal];
                } forEach (missionNamespace getVariable [QEGVAR(acre,jammers), []]);
            };
        };
    };
    case "muzzle_antenna_02_f": {
        // SD Experimential Antenna (390-500 MHz)
    };
    case "muzzle_antenna_03_f": {
        // SD Jammer Antenna (433 MHz)
    };
    default { };
};

// Set vars for spectrum device
private _deviceEM = [];
{
    _deviceEM append _x;
} forEach _sourceList;
missionNamespace setVariable ["#EM_Values",_deviceEM];
