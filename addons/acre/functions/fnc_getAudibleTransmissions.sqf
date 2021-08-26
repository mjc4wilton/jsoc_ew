#include "script_component.hpp"
/*
 * Author: Wilton
 * Returns which, if any, radios on a unit are able to listen to a transmission
 *
 * Arguments:
 * 0: Transmitting Radio ID <STRING>
 * 1: Unit to check <STRING>
 *
 * Return Value:
 * 0: Local Radio ID(s) which can hear transmission <ARRAY>
 *
 * Example:
 * ["acre_prc117f_id_1", player] call jsoc_ew_acre_fnc_getAudibleTransmissions;
 *
 * Public: No
 */

params ["_TxID", "_unit"];

private _return = [];
private _TxChData = GET_CHANNEL_DATA(_TxID);
private _TxF = HASH_GET(_TxChData,"frequencytx");
private _TxPower = HASH_GET(_TxChData, "power");

{
    private _radioBase = _x;
    private _sensitivityMin = getNumber (configfile >> "CfgAcreComponents" >> _radioBase >> "sensitivityMin");
    {
        private _RxID = _x;
        private _RxChData = GET_CHANNEL_DATA(_RxID);
        private _RxF = HASH_GET(_RxChData,"frequencyrx");
        private _RxSql = HASH_GET

        if (_RxF isEqualTo _TxF) then {
            ([_TxF, _TxPower, _RxID, _TxID] call jsoc_ew_acre_fnc_signalFunctionJammer) params ["", "_maxSignal"];
            if (_maxSignal >= _sensitivityMin) then {
                _return pushBack _RxID;
            };
        };
    } forEach ([_radioBase, _unit] call acre_api_fnc_getAllRadiosByType);
} forEach (([] call acre_api_fnc_getAllRadios) select 0);

_return
