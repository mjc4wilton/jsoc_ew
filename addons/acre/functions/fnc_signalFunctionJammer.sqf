#include "script_component.hpp"
/*
 * Author: ACRE2Team, mjc4wilton
 * Wrapper function for calling the signal calculation (extension).
 *
 * Arguments:
 * 0: Frequency <NUMBER>
 * 1: Power <NUMBER>
 * 2: Receiving Radio ID <STRING>
 * 3: Transmitting Radio ID <STRING>
 *
 * Return Value:
 * Tuple of power and maximum signal strength <ARRAY>
 *
 * Example:
 * [30, 5000, "ACRE_PRC343_ID_1", "ACRE_PRC343_ID_2"] call jsoc_ew_acre_fnc_singalFunctionJammer
 *
 * Public: No
 */

/*
 * Start copied ACRE code (Credit to ACRE2 Development Team)
*/

params ["_f", "_mW", "_receiverClass", "_transmitterClass"];

private _count = (missionNamespace getVariable [_transmitterClass + "_running_count", 0]) max 0;
if (_count == 0) then {
    private _rxAntennas = [_receiverClass] call acre_sys_components_findAntenna;
    private _txAntennas = [_transmitterClass] call acre_sys_components_findAntenna;

    {
        private _txAntenna = _x;
        {
            private _rxAntenna = _x;
            private _model = acre_sys_signal_signalModel; // TODO: Change models on the fly if compatible (underwater, better frequency matching)

            // Make sure ITWOM is not used for the moment
            if (_model > SIGNAL_MODEL_ITWOM || {_model < SIGNAL_MODEL_CASUAL}) then {
                _model = SIGNAL_MODEL_LOS_MULTIPATH;  // Default to LOS Multipath if the model is out of range
                acre_sys_signal_signalModel = _model;           // And make sure we do not use an invalid mode next time
            };

            _count = _count + 1;
            private _id = format ["%1_%2_%3_%4", _transmitterClass, (_txAntenna select 0), _receiverClass, (_rxAntenna select 0)];
            [
                "process_signal",
                [
                    _model,
                    _id,
                    (_txAntenna select 2),
                    (_txAntenna select 3),
                    (_txAntenna select 0),
                    (_rxAntenna select 2),
                    (_rxAntenna select 3),
                    (_rxAntenna select 0),
                    _f,
                    _mW,
                    acre_sys_signal_terrainScaling,
                    diag_tickTime,
                    ACRE_SIGNAL_DEBUGGING,
                    acre_sys_signal_omnidirectionalRadios
                ],
                2,
                acre_sys_signal_fnc_handleSignalReturn,
                [_transmitterClass, _receiverClass]
            ] call acre_sys_core_fnc_callExt;
        } forEach _rxAntennas;
    } forEach _txAntennas;
    missionNamespace setVariable [_transmitterClass + "_running_count", _count];
};
private _maxSignal = missionNamespace getVariable [_transmitterClass + "_best_signal", -992];
private _Px = missionNamespace getVariable [_transmitterClass + "_best_px", 0];

[_Px, _maxSignal]