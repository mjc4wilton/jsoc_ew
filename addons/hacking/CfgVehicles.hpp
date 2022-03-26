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
                    statement = QUOTE([ARR_2(_player,QQGVAR(Laptop))] call FUNC(place));
                    showDisabled = 0;
                };
            };
        };
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
        displayName = CSTRING(Laptop);
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

                class GVAR(TakeConnector) {
                    selection = "";
                    displayName = CSTRING(TakeConnector);
                    condition = QUOTE([ARR_2(_player,_target)] call FUNC(canTakeConnector));
                    exceptions[] = {"isNotInside", "isNotSitting"};
                    statement = QUOTE([ARR_2(_player,_target)] call FUNC(takeConnector));
                    showDisabled = 0;
                };
                class GVAR(ReturnConnector) {
                    selection = "";
                    displayName = CSTRING(ReturnConnector);
                    condition = QUOTE([ARR_2(_player,_target)] call FUNC(canReturnConnector));
                    exceptions[] = {"isNotInside", "isNotSitting"};
                    statement = QUOTE([ARR_2(_player,_target)] call FUNC(returnConnector));
                    showDisabled = 0;
                };
                class GVAR(Devices) {
                    selection = "";
                    displayName = CSTRING(Devices);
                    condition = QUOTE(true);
                    exceptions[] = {"isNotInside", "isNotSitting"};
                    statement = ""; // With no statement the action will only show if it has children
                    insertChildren = QUOTE([ARR_2(_player,_target)] call FUNC(devices_addChildren));
                    showDisabled = 0;
                };
                class GVAR(PickUp) {
                    selection = "";
                    displayName = CSTRING(Pickup);
                    condition = "true";
                    statement = QUOTE([ARR_2(_player,_target)] call FUNC(pickup));
                };
            };
        };
    };
};
