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