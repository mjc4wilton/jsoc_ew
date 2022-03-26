class CBA_Extended_EventHandlers_base;
class CBA_Extended_EventHandlers;
class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class jsoc_ew {
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
    class EGVAR(base,backpack_mc): Bag_Base {
        GVAR(isCellJammer) = QUOTE(true);
        GVAR(isRFJammer) = QUOTE(true);
    };
    // ZEUS Modules
    class EGVAR(base,ModuleBase);
    class GVAR(Cell_ConnectExplosive): EGVAR(base,ModuleBase) {
        curatorCanAttach = 1;
        category = "ace_zeus_Utility";
        displayName = CSTRING(Modules_Cell_ConnectExplosive);
        function = QFUNC(cell_connectExplosive);
        icon = "z\ace\addons\explosives\UI\Explosives_Menu_ca.paa";
    };
};
