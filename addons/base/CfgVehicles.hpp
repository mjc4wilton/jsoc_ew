class CBA_Extended_EventHandlers_base;
class CfgVehicles {
	class Man;
	class CAManBase: Man {
		class ACE_SelfActions {
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
};