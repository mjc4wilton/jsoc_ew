// CBA Settings [ADDON: jsoc_ew_contact]:

[
    QGVAR(spectrumUpdateRate), "SLIDER",
    [LLSTRING(SpectrumUpdateRate_DisplayName), LLSTRING(SpectrumUpdateRate_Description)],
    [LELSTRING(Base,Interaction), LLSTRING(Category)],
    [0, 5, 0.5, 0], // [_min, _max, _default, _trailingDecimals, _isPercentage]
    false // isGlobal
] call CBA_fnc_addSetting;
