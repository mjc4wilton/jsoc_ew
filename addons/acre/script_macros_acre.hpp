// ACRE Defines
#define IS_HASH(hash) (hash isEqualType locationNull && {(type hash) isEqualTo "ACRE_FastHashNamespaceDummy"})

#define HASH_CREATE_NAMESPACE (createLocation ["ACRE_FastHashNamespaceDummy", [-1000, -1000, 0], 0, 0])
#define HASH_CREATE (call acre_main_fnc_fastHashCreate)
#define HASH_DELETE(hash) (ACRE_FAST_HASH_TO_DELETE pushBack hash)
#define HASH_HASKEY(hash, key) (!(isNil {hash getVariable key}))
#define HASH_SET(hash, key, val) (hash setVariable [key, val])
#define HASH_GET(hash, key) (hash getVariable key)
#define HASH_REM(hash, key) (hash setVariable [key, nil])
#define HASH_COPY(hash) (hash call acre_main_fnc_fastHashCopy)
#define HASH_KEYS(hash) (hash call acre_main_fnc_fastHashKeys)

#define HASHLIST_CREATELIST(keys) []
#define HASHLIST_CREATEHASH(hashList) HASH_CREATE
#define HASHLIST_SELECT(hashList, index) (hashList select index)
#define HASHLIST_SET(hashList, index, value) (hashList set[index, value])
#define HASHLIST_PUSH(hashList, value) (hashList pushBack value)

#define BASECLASS(radioId) ([radioId] call acre_sys_radio_fnc_getRadioBaseClassname)

#define SIGNAL_MODEL_CASUAL        0
#define SIGNAL_MODEL_LOS_SIMPLE    1
#define SIGNAL_MODEL_LOS_MULTIPATH 2
#define SIGNAL_MODEL_ITM           3
#define SIGNAL_MODEL_ITWOM         4  // This model is for now disabled.

#define SPEAKING_TYPE_DIRECT    0
#define SPEAKING_TYPE_RADIO     1
#define SPEAKING_TYPE_UNKNOWN   2
#define SPEAKING_TYPE_INTERCOM  3
#define SPEAKING_TYPE_SPECTATE  4
#define SPEAKING_TYPE_GOD       5
#define SPEAKING_TYPE_ZEUS      6

#define GET_STATE(id)            ([acre_main_currentRadioId, "getState", id] call acre_sys_data_fnc_dataEvent)
#define SET_STATE(id, val)        ([acre_main_currentRadioId, "setState", [id, val]] call acre_sys_data_fnc_dataEvent)
#define SET_STATE_CRIT(id, val)    ([acre_main_currentRadioId, "setStateCritical", [id, val]] call acre_sys_data_fnc_dataEvent)
#define GET_STATE_DEF(id, default)    ([id, default] call acre_main_fnc_getDefaultState)
#define SET_STATE_RADIO(radio, id, val) ([radio, "setState", [id, val]] call acre_sys_data_fnc_dataEvent)
#define GET_STATE_RADIO(radio, id)            ([radio, "getState", id] call acre_sys_data_fnc_dataEvent)

#define GET_CHANNEL_NUM(radio)    ([radio, "getCurrentChannel"] call acre_sys_data_fnc_dataEvent)
#define GET_CHANNEL_DATA(radio)     ([radio, "getCurrentChannelData"] call acre_sys_data_fnc_dataEvent)

// JSOC_EW Defines
#define BASE_RADIO_DEVIATION 0.006 // 6 kHz
#define ACRE_FUNC(var1,var2) TRIPLES(DOUBLES(acre,var1),fnc,var2)
