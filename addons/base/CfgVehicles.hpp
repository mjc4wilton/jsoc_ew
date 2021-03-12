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
};