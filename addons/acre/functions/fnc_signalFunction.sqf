#include "script_component.hpp"
/*
 * Author: Wilton
 * Custom ACRE signal function to handle EW jamming capabilities
 *
 * Arguments:
 * 0: Frequency (MHz) <NUMBER>
 * 1: Power (mW) <NUMBER>
 * 2: Receiving Radio ID <STRING>
 * 3: Transmitting Radio ID <STRING>
 *
 * Return Value:
 * Tuple of power and maximum signal strength <ARRAY>
 *
 * Example:
 * [30, 5000, "ACRE_PRC343_ID_1", "ACRE_PRC343_ID_2"] call jsoc_ew_acre_fnc_signalFunction;
 *
 * Public: No
 */

params ["_f", "_mW", "_receiverClass", "_transmitterClass"];

([_f, _mW, _receiverClass, _transmitterClass] call ACRE_FUNC(sys_signal,getSignalCore)) params ["_Px", "_maxSignal"];

if (ACRE_SIGNAL_DEBUGGING > 1) then {
    systemChat format ["PRE: Px: %1 | maxSignal: %2", _Px, _maxSignal];
};

// Get deviation of Rx radio
private _channelNumberRx = GET_CHANNEL_NUM(_receiverClass);
private _channelsRx = GET_STATE_RADIO(_receiverClass,"channels");
private _channelRx = HASHLIST_SELECT(_channelsRx, _channelNumberRx);
private _deviationRx = 0.006;
if (HASH_HASKEY(_channelRx,"deviation")) then {
    _deviationRx = 0.001 * (HASH_GET(_channelRx,"deviation")); // kHz to MHz
};

/*
 * Jamming
*/
private _maxPxJam = 0;
private _maxSignalJam = -993; // ACRE defined minimum for dbm

// Omni-directional jammers
{
    // Sanitize jammers (Ensure it still exists)
    private _radioIDJ = _x;
    private _holderJ = [_radioIDJ] call acre_sys_radio_fnc_getRadioObject;
    if !(isNil {_holderJ}) then {
        // Jammer still exists, process it.
        // Get required values from jammer (freq, power, deviation)
        private _channelNumberJ = GET_CHANNEL_NUM(_radioIDJ);
        private _channelsJ = GET_STATE_RADIO(_radioIDJ,"channels");
        private _channelJ = HASHLIST_SELECT(_channelsJ, _channelNumberJ);

        // Use "getChannelData" event to ensure vehicle rack interoperability
        private _channelDataJ = GET_CHANNEL_DATA(_radioIDJ);
        private _frequencyJ = HASH_GET(_channelDataJ,"frequencytx");
        private _powerJ = HASH_GET(_channelDataJ,"power");

        // Deviation is not returned from function calls and must be calculated manually
        private _deviationJ = BASE_RADIO_DEVIATION; // 6 kHz
        if (HASH_HASKEY(_channelJ,"deviation")) then {
            _deviationJ = 0.001 * (HASH_GET(_channelJ,"deviation")); // kHz to MHz
        };

        // Get frequency limits
        private _jFreqUp = (_frequencyJ + _deviationJ);
        private _jFreqLow = (_frequencyJ - _deviationJ);
        private _rFreqUp = (_f + _deviationRx);
        private _rFreqLow = (_f - _deviationRx);

        // Find effect over distance and terrain with respect to ACRE signal modeling
        private _jammer = [_frequencyJ, _powerJ, _receiverClass, _radioIDJ] call ACRE_FUNC(sys_signal,getSignalCore);
        _jammer params ["_PxJam", "_signalJam"];

        // Adjust effect with frequency (works by calculating the % of overlap between Rx frequency bandwidth and jamming frequency bandwidth)
        // TODO: Calculate it better than a simple linear percent overlap (difference of integrals?)
        private _mult = 0;
        if (_jFreqUp >= _rFreqUp) then {
            if (_rFreqLow >= _jFreqLow) then {
                _mult = (0 max ((_jFreqUp - _jFreqLow)/(_rFreqUp - _rFreqLow))) min 1;
            };
            if (_rFreqLow < _jFreqLow) then {
                _mult = (0 max ((_rFreqUp - _jFreqLow)/(_rFreqUp - _rFreqLow))) min 1;
            };
        };
        if (_jFreqUp < _rFreqUp) then {
            if (_rFreqLow >= _jFreqLow) then {
                _mult = (0 max ((_jFreqUp - _rFreqLow)/(_rFreqUp - _rFreqLow))) min 1;
            };
            if (_rFreqLow < _jFreqLow) then {
                _mult = (0 max ((_jFreqUp - _jFreqLow)/(_rFreqUp - _rFreqLow))) min 1;
            };
        };
        _PxJamF = _PxJam * _mult;
        _signalJamF = (-1 * (10 ^ ((log (abs _signalJam)) * (1/(0.0001 max _mult))))) max -993;

        // Debug screen logging
        if (ACRE_SIGNAL_DEBUGGING > 1) then {
            hintSilent format ["Reciever: %1\nJammer: %2\nFrequency: %3\nMultiplier: %4\nPxJam: %5\nSignalJam: %6\nPxJamF: %7\nSignalJamF: %8", _receiverClass, _radioIDJ, _frequencyJ, _mult, _PxJam, _signalJam, _PxJamF, _signalJamF];
        };

        // Adjust rolling values
        if (_PxJamF > _maxPxJam) then {
            _maxPxJam = _PxJamF;
        };
        if (_signalJamF > _maxSignalJam) then {
            _maxSignalJam = _signalJamF;
        };
    };
} forEach GVAR(jammers);

// TODO: Directional jammers (In theory would be handled via ACRE directional signal calculations which are not yet implemented)

_Px = _Px * (1 - _maxPxJam);

private _diffSignal = -1 * ((abs _maxSignalJam) - (abs _maxSignal));
_maxSignal = _maxSignal - (exp _diffSignal);

if (ACRE_SIGNAL_DEBUGGING > 1) then {
    private _signalTrace = missionNamespace getVariable [_transmitterClass + "_signal_trace", []];
    _signalTrace pushBack [_maxSignalJam, _Px, _maxSignal];
    missionNamespace setVariable [_transmitterClass + "_signal_trace", _signalTrace];
};

if (ACRE_SIGNAL_DEBUGGING > 1) then {
    systemChat format ["Px: %1 | maxSignal: %2", _Px, _maxSignal];
};

[_Px, _maxSignal]
