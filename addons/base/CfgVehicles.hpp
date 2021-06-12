class CBA_Extended_EventHandlers_base;
class CBA_Extended_EventHandlers;
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
    class ThingX;
    class GVAR(LaptopObject): ThingX {
        ace_dragging_canDrag = 1;
        ace_dragging_dragPosition[] = {0,1,0};
        ace_dragging_dragDirection = 1;
        ace_dragging_canCarry = 1;
        ace_dragging_carryPosition[] = {0, 1, 0};
        ace_dragging_carryDirection = 1;
        author = ECSTRING(main,Author);
        _generalMacro = QGVAR(LaptopObject);
        displayName = CSTRING(Hack_Laptop);
        hiddenSelections[] = {"camo"};
        hiddenSelectionsMaterials[] = {"\A3\Structures_F\Items\Electronics\Data\electronics_screens.rvmat"};
        hiddenSelectionsTextures[] = {QPATHTOF(data\GVAR(laptop_screen.paa))};
        icon = "iconObject_3x2";
        model = "\A3\Structures_F\Items\Electronics\Laptop_unfolded_F.p3d";
        scope = 2;
        scopeCurator = 2;
        //vehicleClass = "Cargo";

        class EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers {};
        };

        class ACE_Actions {
            class ACE_MainActions {
                selection = "";
                distance = 5;
                condition = "(true)";

                class GVAR(Hack_TakeConnector) {
                    selection = "";
                    displayName = CSTRING(Hack_TakeConnector);
                    condition = QUOTE([ARR_2(_player,_target)] call FUNC(hack_canTakeConnector));
                    exceptions[] = {"isNotInside", "isNotSitting"};
                    statement = QUOTE([ARR_2(_player,_target)] call FUNC(hack_takeConnector));
                    showDisabled = 0;
                };
                class GVAR(Hack_ReturnConnector) {
                    selection = "";
                    displayName = CSTRING(Hack_ReturnConnector);
                    condition = QUOTE([ARR_2(_player,_target)] call FUNC(hack_canReturnConnector));
                    exceptions[] = {"isNotInside", "isNotSitting"};
                    statement = QUOTE([ARR_2(_player,_target)] call FUNC(hack_returnConnector));
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
                    statement = QUOTE([ARR_2(_player, QQGVAR(Laptop))] call CBA_fnc_addItem; deleteVehicle _target;);
                };
            };
        };
    };
};
