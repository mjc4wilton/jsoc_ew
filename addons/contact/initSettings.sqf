// CBA Settings [ADDON: jsoc_ew_contact]:

[
    QGVAR(spectrumUpdateRate), "SLIDER",
    [LLSTRING(SpectrumUpdateRate_DisplayName), LLSTRING(SpectrumUpdateRate_Description)],
    [LELSTRING(Base,Interaction), LLSTRING(Category)],
    [0, 5, 0.5, 0], // [_min, _max, _default, _trailingDecimals, _isPercentage]
    false // isGlobal
] call CBA_fnc_addSetting;

[
    QGVAR(signal_coefficient), "SLIDER",
    [LLSTRING(Signal_Coefficient_DisplayName), LLSTRING(Signal_Coefficient_Description)],
    [LELSTRING(Base,Interaction), LLSTRING(Category)],
    [0, 2, 0.25, 4], // [_min, _max, _default, _trailingDecimals, _isPercentage]
    true // isGlobal
] call CBA_fnc_addSetting;
