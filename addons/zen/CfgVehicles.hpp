class CfgVehicles {
    class EGVAR(base,ModuleBase);
    class GVAR(EquipRadioJammer): EGVAR(base,ModuleBase) {
		scope = 2;
        curatorCanAttach = 1;
        category = "JSOC_EW";
        displayName = CSTRING(EquipRadioJammer_Title);
        function = QFUNC(equipRadioJammer);
    };
};
