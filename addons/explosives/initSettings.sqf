
[
    QGVAR(maxJamRange), "SLIDER",
    [LLSTRING(MaxJamRange_DisplayName), LLSTRING(MaxJamRange_Description)],
    [LELSTRING(Base,Interaction), LLSTRING(IEDJamming)],
    [0, 20000, 500, 0], // [_min, _max, _default, _trailingDecimals, _isPercentage]
    true // isGlobal
] call CBA_fnc_addSetting;

[
    QGVAR(exactRange), "SLIDER",
    [LLSTRING(ExactRange_DisplayName), LLSTRING(ExactRange_Description)],
    [LELSTRING(Base,Interaction), LLSTRING(IEDJamming)],
    [0, 5000, 150, 0], // [_min, _max, _default, _trailingDecimals, _isPercentage]
    true // isGlobal
] call CBA_fnc_addSetting;
