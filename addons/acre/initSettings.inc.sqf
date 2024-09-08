// CBA Settings [ADDON: jsoc_ew_acre]:

[
    QGVAR(jammedTone), "LIST",
    [LLSTRING(JammedTone_DisplayName), LLSTRING(JammedTone_Description)],
    [LELSTRING(Base,Interaction), LLSTRING(Category)],
    [
        [275, 575, 1075, 2075], // Values
        ["275", "575", "1075", "2075"], // Value Titles
        1                       // Default Index
    ],
    false // isGlobal
] call CBA_fnc_addSetting;
