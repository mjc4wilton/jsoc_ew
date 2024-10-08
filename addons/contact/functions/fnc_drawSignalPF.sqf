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
                    private _signal = [_frequency, _power, _activeRadio, _radioID] call acre_sys_signal_fnc_getSignalCore;
                    _signal params ["", "_maxSignal"];

                    private _bearingFacing = getDir ACE_player;
                    private _bearingJammer = ACE_player getDir _jammerObject;
                    private _angle = (_bearingFacing max _bearingJammer) - (_bearingFacing min _bearingJammer);
                    if (_angle > 180) then {
                        _angle = 360 - _angle;
                    };
                    private _multiplier = 1 - ((1 / GVAR(signalAngleFalloff)) * _angle) ^ 2; // Quadratically varied with 1 at 0 angle and 0 at 180 angle.
                    private _maxSignalFinal = (-1 * (10 ^ ((log (abs (_maxSignal min -2))) * (1/(0.0001 max _multiplier))))) max -993; // Vary signal strength with percent error

                    _sourceList pushBack [_frequency, _maxSignalFinal];
                } forEach (missionNamespace getVariable [QEGVAR(acre,jammers), []]);
            };
        };

        // Handle trackable signals
        {
            _x params ["_obj", "_freq", "_power"];

            // Sanitize or draw
            if (isNil "_obj" || _obj isEqualTo objNull) then {
                [_obj] call FUNC(removeSignal);
            } else {
                // Calculate angle
                private _bearingFacing = getDir ACE_player;
                private _bearingJammer = ACE_player getDir _obj;
                private _angle = (_bearingFacing max _bearingJammer) - (_bearingFacing min _bearingJammer);
                if (_angle > 180) then {
                    _angle = 360 - _angle;
                };
                private _multiplier = 1 - ((1 / GVAR(signalAngleFalloff)) * _angle) ^ 2; // Quadratically varied with 1 at 0 angle and 0 at 180 angle.

                private _distance = (_obj distance ACE_player);
                private _signalBase = -24.6 * (sqrt (_distance / (4*_power)));
                private _rxSignal = (-1 * (10 ^ ((log (abs (_signalBase min -2))) * (1/(0.0001 max _multiplier))))) max -993; // Vary signal strength with percent error
                _sourceList pushBack [_freq, _rxSignal];
            };
        } forEach (missionNamespace getVariable [QGVAR(signals), []]);
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
