// CBA Settings [ADDON: jsoc_ew_acre]:

[
    QGVAR(jammer_bandwidthMult), "SLIDER",
    [LLSTRING(Jammer_BandwidthMult_DisplayName), LLSTRING(Jammer_BandwidthMult_Description)],
    [LELSTRING(Base,Interaction), LLSTRING(Jammers_Settings)],
    [1, 80, 3, 0], // [_min, _max, _default, _trailingDecimals, _isPercentage]
    true // isGlobal
] call CBA_fnc_addSetting;

[
    QGVAR(jammer_powerMult), "SLIDER",
    [LLSTRING(Jammer_PowerMult_DisplayName), LLSTRING(Jammer_PowerMult_Description)],
    [LELSTRING(Base,Interaction), LLSTRING(Jammers_Settings)],
    [1, 30, 10, 2], // [_min, _max, _default, _trailingDecimals, _isPercentage]
    true // isGlobal
] call CBA_fnc_addSetting;