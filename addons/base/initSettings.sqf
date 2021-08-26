// CBA Settings [ADDON: jsoc_ew_base]:

[
    QGVAR(maxJamRange), "SLIDER",
    [LLSTRING(MaxJamRange_DisplayName), LLSTRING(MaxJamRange_Description)],
    [LLSTRING(Interaction), LLSTRING(IEDJamming)],
    [0, 20000, 500, 0], // [_min, _max, _default, _trailingDecimals, _isPercentage]
    true // isGlobal
] call CBA_fnc_addSetting;

[
    QGVAR(exactRange), "SLIDER",
    [LLSTRING(ExactRange_DisplayName), LLSTRING(ExactRange_Description)],
    [LLSTRING(Interaction), LLSTRING(IEDJamming)],
    [0, 5000, 150, 0], // [_min, _max, _default, _trailingDecimals, _isPercentage]
    true // isGlobal
] call CBA_fnc_addSetting;

[
    QGVAR(enemyFrequency), "SLIDER",
    [LLSTRING(EnemyFrequency_DisplayName), LLSTRING(EnemyFrequency_Description)],
    [LLSTRING(Interaction), LLSTRING(AI)],
    [30, 2400, 71.750, 3], // [_min, _max, _default, _trailingDecimals, _isPercentage]
    true // isGlobal
] call CBA_fnc_addSetting;

[
    QGVAR(hack_connectorLength), "SLIDER",
    [LLSTRING(Hack_ConnectorLength_DisplayName), LLSTRING(Hack_ConnectorLength_Description)],
    [LLSTRING(Interaction), LLSTRING(Hacking)],
    [0, 100, 10, 0], // [_min, _max, _default, _trailingDecimals, _isPercentage]
    true // isGlobal
] call CBA_fnc_addSetting;

[
    QGVAR(hack_maxDevices), "SLIDER",
    [LLSTRING(Hack_MaxDevices_DisplayName), LLSTRING(Hack_MaxDevices_Description)],
    [LLSTRING(Interaction), LLSTRING(Hacking)],
    [0, 10, 3, 0], // [_min, _max, _default, _trailingDecimals, _isPercentage]
    true // isGlobal
] call CBA_fnc_addSetting;
