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
    class GVAR(backpack_mc): Bag_Base {
        author = "Chaser";
        scope = 2;
        model = "a3\Supplies_F_Enoch\Bags\B_RadioBag_01_F.p3d";
        displayName = CSTRING(Backpack_Multicam_DisplayName);
        picture = QPATHTOF(ui\UMB_Chaser.paa);
        hiddenSelections[] = { "Camo1" };
        hiddenSelectionsTextures[] = {
            QPATHTOF(data\GVAR(backpack_mc.paa))
        };
        maximumLoad = 250;
        mass = 150;
        GVAR(displayNameShort) = CSTRING(Backpack_DisplayName_Short);
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
