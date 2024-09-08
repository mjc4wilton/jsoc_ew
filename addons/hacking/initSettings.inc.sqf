[
    QGVAR(connectorLength), "SLIDER",
    [LLSTRING(ConnectorLength_DisplayName), LLSTRING(ConnectorLength_Description)],
    [LELSTRING(Base,Interaction), LLSTRING(Hacking)],
    [0, 100, 10, 0], // [_min, _max, _default, _trailingDecimals, _isPercentage]
    true // isGlobal
] call CBA_fnc_addSetting;

[
    QGVAR(maxDevices), "SLIDER",
    [LLSTRING(MaxDevices_DisplayName), LLSTRING(MaxDevices_Description)],
    [LELSTRING(Base,Interaction), LLSTRING(Hacking)],
    [0, 10, 3, 0], // [_min, _max, _default, _trailingDecimals, _isPercentage]
    true // isGlobal
] call CBA_fnc_addSetting;
