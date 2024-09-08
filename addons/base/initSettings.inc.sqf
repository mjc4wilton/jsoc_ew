// CBA Settings [ADDON: jsoc_ew_base]:

[
    QGVAR(enemyFrequency), "SLIDER",
    [LLSTRING(EnemyFrequency_DisplayName), LLSTRING(EnemyFrequency_Description)],
    [LLSTRING(Interaction), LLSTRING(AI)],
    [30, 2400, 71.750, 3], // [_min, _max, _default, _trailingDecimals, _isPercentage]
    true // isGlobal
] call CBA_fnc_addSetting;
