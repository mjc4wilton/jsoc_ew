class CfgVehicles {
	class Man;
	class CAManBase: Man {
		class ACE_SelfActions {
			class jsoc_ew {
				class GVAR(enableJamming) {
					displayName = CSTRING(EnableJamming);
					condition = QUOTE([ARR_2(_player,_target)] call FUNC(canEnableJamming));
					statement = QUOTE([ARR_2(_player,_target)] call FUNC(enableJamming));
					priority = 1;
				};
				class GVAR(disableJamming) {
					displayName = CSTRING(DisableJamming);
					condition = QUOTE([ARR_2(_player,_target)] call FUNC(canDisableJamming));
					statement = QUOTE([ARR_2(_player,_target)] call FUNC(disableJamming));
					priority = 1;
				};
			};
		};
	};
};