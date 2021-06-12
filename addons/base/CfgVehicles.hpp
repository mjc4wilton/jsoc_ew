class CBA_Extended_EventHandlers_base;
class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {
                class GVAR(laptop_place) {
                    displayName = CSTRING(laptop_place);
                    condition = QUOTE([ARR_2(_player,QQGVAR(Laptop))] call ace_common_fnc_hasItem);
                    statement = QUOTE([ARR_2(_player,QQGVAR(Laptop))] call FUNC(hack_place));
                    showDisabled = 0;
                };
            };
            class jsoc_ew {
                displayName = CSTRING(Interaction);
                condition = QUOTE(true);
                exceptions[] = {"isNotInside", "isNotSitting"};
                statement = ""; // With no statement the action will only show if it has children

                class GVAR(cell) {
                    displayName = CSTRING(Cell_Jamming);
                    condition = QUOTE(true);
                    statement = ""; // With no statement the action will only show if it has children
                    priority = 0.5;
                    insertChildren = QUOTE(_this call FUNC(cell_addChildren));
                };
                class GVAR(rf) {
                    displayName = CSTRING(RF_Jamming);
                    condition = QUOTE(true);
                    statement = ""; // With no statement the action will only show if it has children
                    priority = 0.5;
                    insertChildren = QUOTE(_this call FUNC(rf_addChildren));
                };
            };
        };
    };

    // Gear
    class Bag_Base;
    class GVAR(backpack_mc): Bag_Base {
        author = "Chaser";
        scope = 2;
        model = "a3\Supplies_F_Enoch\Bags\B_RadioBag_01_F.p3d";
        displayName = "[JSOC] EW Backpack Multicam";
        picture = QPATHTOF(ui\UMB_Chaser.paa);
        hiddenSelections[] = { "Camo1" };
        hiddenSelectionsTextures[] = {
            QPATHTOF(data\GVAR(backpack_mc.paa))
        };
        maximumLoad = 250;
        mass = 150;
        GVAR(isCellJammer) = QUOTE(true);
        GVAR(isRFJammer) = QUOTE(true);
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
    class GVAR(Cell_ConnectExplosive): GVAR(ModuleBase) {
        curatorCanAttach = 1;
        category = "ace_zeus_Utility";
        displayName = CSTRING(Modules_Cell_ConnectExplosive);
        function = QFUNC(cell_connectExplosive);
        icon = "z\ace\addons\explosives\UI\Explosives_Menu_ca.paa";
    };

    // Equipment
    class Items_base_F;
    class GVAR(LaptopObject): Items_base_F {
        author = ECSTRING(main,Author);
        _generalMacro = QGVAR(LaptopObject);
        displayName = CSTRING(Hack_Laptop);
        hiddenSelections[] = {"Camo_1","Screen_1"};
        hiddenSelectionsTextures[] = {
            "a3\Props_F_Enoch\Military\Equipment\data\Laptop_03_black_CO.paa",
            QPATHTOF(data\GVAR(laptop_screen.paa))
        };
        icon = "iconObject_1x2";
        model = "\a3\Props_F_Enoch\Military\Equipment\Laptop_03_F.p3d";
        scope = 1;
        vehicleClass = "Cargo";

        class EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers {};
        };

        class ACE_Actions {
            class ACE_MainActions {
                class GVAR(Hack_TakeConnector) {
                    selection = "";
                    displayName = CSTRING(Hack_TakeConnector);
                    condition = QUOTE([ARR_2(_player,_target)] call FUNC(hack_canTakeConnector));
                    exceptions[] = {"isNotInside", "isNotSitting"};
                    statement = QUOTE([ARR_2(_player,_target)] call FUNC(hack_takeConnector));
                    showDisabled = 0;
                };
                class GVAR(Hack_Devices) {
                    selection = "";
                    displayName = CSTRING(Hack_Devices);
                    condition = QUOTE(true);
                    exceptions[] = {"isNotInside", "isNotSitting"};
                    statement = ""; // With no statement the action will only show if it has children
                    insertChildren = QUOTE(_this call FUNC(hack_devices_addChildren));
                    showDisabled = 0;
                };
                class GVAR(Hack_PickUp) {
                    selection = "";
                    displayName = CSTRING(Hack_Pickup);
                    condition = "true";
                    statement = QUOTE([ARR_2(_player,_target getVariable QUOTE(QGVAR(class)))] call ace_common_fnc_addToInventory;deleteVehicle _target;);
                };
            };
        };
    };
};
