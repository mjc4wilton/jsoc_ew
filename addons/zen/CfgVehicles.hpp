class CBA_Extended_EventHandlers_base;
class CfgVehicles {
    class Module_F;
    class GVAR(ModuleBase): Module_F {
        author = "77th JSOC";
        category = "NO_CATEGORY";
        function = "";
        scope = 1;
        scopeCurator = 2;
        class EventHandlers {
            init = "_this call zen_modules_fnc_initModule";
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };
    class GVAR(EquipRadioJammer): GVAR(ModuleBase) {
        curatorCanAttach = 1;
        category = "JSOC_EW";
        displayName = CSTRING(EquipRadioJammer_Title);
        function = QFUNC(equipRadioJammer);
    };
    class GVAR(AddHackIntel): GVAR(ModuleBase) {
        curatorCanAttach = 1;
        category = "JSOC_EW";
        displayName = CSTRING(AddHackIntel_Title);
        function = QFUNC(addHackIntel);
    };
    class GVAR(AddSignal): GVAR(ModuleBase) {
        curatorCanAttach = 1;
        category = "JSOC_EW";
        displayName = CSTRING(AddSignal_Title);
        function = QFUNC(addSignal);
    };
    class GVAR(RemoveSignal): GVAR(ModuleBase) {
        curatorCanAttach = 1;
        category = "JSOC_EW";
        displayName = CSTRING(RemoveSignal_Title);
        function = QFUNC(removeSignal);
    };
};
