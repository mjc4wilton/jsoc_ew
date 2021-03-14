class CfgVehicles {
	class Man;
	class CAManBase: Man {
		class ACE_SelfActions {
			class jsoc_ew_acre {
				displayName = CSTRING(Interaction);
                condition = "true";
                exceptions[] = {"isNotInside", "isNotSitting"};
                statement = ""; // With no statement the action will only show if it has children
                priority = 0.05;
			};
		};
	};

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
	};
};