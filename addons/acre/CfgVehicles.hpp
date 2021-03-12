class CfgVehicles {
	class Man;
	class CAManBase: Man {
		class ACE_SelfActions {
			class jsoc_ew_acre {
				class jsoc_ew_acre_enableJamming {
					displayName = CSTRING(EnableJamming);
					condition = "([[] call acre_api_fnc_getCurrentRadio, 'ACRE_PRC117F'] call acre_api_fnc_isKindOf) && !(([] call acre_api_fnc_getCurrentRadio) in (missionNamespace getVariable ['jsoc_ew_acre_jammersClass', []]))";
					statement = QUOTE([ARR_2(_player,_target)] call FUNC(enableJamming));
					priority = 1;
				};
				class jsoc_ew_acre_disableJamming {
					displayName = CSTRING(DisableJamming);
					condition = "([[] call acre_api_fnc_getCurrentRadio, 'ACRE_PRC117F'] call acre_api_fnc_isKindOf) && (([] call acre_api_fnc_getCurrentRadio) in (missionNamespace getVariable ['jsoc_ew_acre_jammersClass', []]))";
					statement = QUOTE([ARR_2(_player,_target)] call FUNC(disableJamming));
					priority = 1;
				};
			};
		};
	};
};