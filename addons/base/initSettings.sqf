// CBA Settings [ADDON: jsoc_ew_base]:

[
    QGVAR(maxJamRange), "SLIDER",
    [LLSTRING(MaxJamRange_DisplayName), LLSTRING(MaxJamRange_Description)],
    [LLSTRING(Interaction), LLSTRING(IEDJamming)],
    [0, 20000, 2000, 0], // [_min, _max, _default, _trailingDecimals, _isPercentage]
    true // isGlobal
] call CBA_fnc_addSetting;

[
    QGVAR(exactRange), "SLIDER",
    [LLSTRING(ExactRange_DisplayName), LLSTRING(ExactRange_Description)],
    [LLSTRING(Interaction), LLSTRING(IEDJamming)],
    [0, 5000, 500, 0], // [_min, _max, _default, _trailingDecimals, _isPercentage]
    true // isGlobal
] call CBA_fnc_addSetting;

[
    QGVAR(enemyFrequency), "SLIDER",
    [LLSTRING(EnemyFrequency_DisplayName), LLSTRING(EnemyFrequency_Description)],
    [LLSTRING(Interaction), LLSTRING(AI)],
    [30, 2400, 71.750, 3], // [_min, _max, _default, _trailingDecimals, _isPercentage]
    true // isGlobal
] call CBA_fnc_addSetting;
