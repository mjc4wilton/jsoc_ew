class CBA_Extended_EventHandlers_base;
class CBA_Extended_EventHandlers;
class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class jsoc_ew {
                displayName = CSTRING(Interaction);
                condition = QUOTE(true);
                exceptions[] = {"isNotInside", "isNotSitting"};
                statement = ""; // With no statement the action will only show if it has children
            };
        };
    };

    // Gear
    class Bag_Base;
    class GVAR(backpack) : Bag_Base {
        author = "Chaser";
        scope = 0;
        model = "a3\Supplies_F_Enoch\Bags\B_RadioBag_01_F.p3d";
        picture = QPATHTOF(ui\UMB_Chaser.paa);
        hiddenSelections[] = { "Camo1" };
        maximumLoad = 250;
        mass = 150;
        GVAR(displayNameShort) = CSTRING(Backpack_DisplayName_Short);
    };
    class GVAR(backpack_multicam): GVAR(backpack) {
        scope = 2;
        displayName = CSTRING(Backpack_Multicam_DisplayName);
        picture = QPATHTOF(ui\UMB_Chaser.paa);
        hiddenSelectionsTextures[] = {
            QPATHTOF(data\GVAR(backpack_multicam.paa))
        };
    };
    class GVAR(backpack_multicamarctic): GVAR(backpack) {
        scope = 2;
        displayName = CSTRING(Backpack_MulticamArctic_DisplayName);
        picture = QPATHTOF(ui\UMB_Chaser.paa);
        hiddenSelectionsTextures[] = {
            QPATHTOF(data\GVAR(backpack_multicamarctic.paa))
        };
    };
    class GVAR(backpack_multicamblack): GVAR(backpack) {
        scope = 2;
        displayName = CSTRING(Backpack_MulticamBlack_DisplayName);
        picture = QPATHTOF(ui\UMB_Chaser.paa);
        hiddenSelectionsTextures[] = {
            QPATHTOF(data\GVAR(backpack_multicamblack.paa))
        };
    };
    class GVAR(backpack_multicamtropic): GVAR(backpack) {
        scope = 2;
        displayName = CSTRING(Backpack_MulticamTropic_DisplayName);
        picture = QPATHTOF(ui\UMB_Chaser.paa);
        hiddenSelectionsTextures[] = {
            QPATHTOF(data\GVAR(backpack_multicamtropic.paa))
        };
    };
    class GVAR(backpack_od): GVAR(backpack) {
        scope = 2;
        displayName = CSTRING(Backpack_OD_DisplayName);
        picture = QPATHTOF(ui\UMB_Chaser.paa);
        hiddenSelectionsTextures[] = {
            QPATHTOF(data\GVAR(backpack_od.paa))
        };
    };

    // ZEUS Modules
    class Module_F;
    class GVAR(ModuleBase): Module_F {
        author = "77th JSOC";
        category = "NO_CATEGORY";
        function = "";
        functionPriority = 1;
        isGlobal = 0;
        isTriggerActivated = 0;
        scope = 1;
        scopeCurator = 2;
        class EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
            class ADDON {
                init = QUOTE(_this call FUNC(initModules));
            };
        };
    };
};
