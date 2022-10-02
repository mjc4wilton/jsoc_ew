class CfgVehicles {
    class rhsusf_m1152_sicps_usarmy_wd;
    class rhsusf_m1152_sicps_usarmy_d;
    class jsoc_m1152_ew_usarmy_wd: rhsusf_m1152_sicps_usarmy_wd {
        editorCategory = "JSOC_EW";
        editorSubcategory = "JSOC_EW_Car";
        displayName="M1152A1 Electronic Warfare (Woodland)";
        author="RHS, 77th JSOC";

        EGVAR(explosives,isCellJammer) = "true";
        EGVAR(explosives,isRFJammer) = "true";

        class ACE_SelfActions {
            class GVAR(EnableCellJamming) {
                displayName = CSTRING(CellJamming_Enable);
                condition = QUOTE([ARR_2(_player,_target)] call FUNC(canEnableCellJamming));
                statement = QUOTE([_target] call EFUNC(explosives,cell_enableJamming));
            };
            class GVAR(DisableCellJamming) {
                displayName = CSTRING(CellJamming_Disable);
                condition = QUOTE([ARR_2(_player,_target)] call FUNC(canDisableCellJamming));
                statement = QUOTE([_target] call EFUNC(explosives,cell_disableJamming));
            };
            class GVAR(EnableRFJamming) {
                displayName = CSTRING(RFJamming_Enable);
                condition = QUOTE([ARR_2(_player,_target)] call FUNC(canEnableRFJamming));
                statement = QUOTE([_target] call EFUNC(explosives,rf_enableJamming));
            };
            class GVAR(DisableRFJamming) {
                displayName = CSTRING(RFJamming_Disable);
                condition = QUOTE([ARR_2(_player,_target)] call FUNC(canDisableRFJamming));
                statement = QUOTE([_target] call EFUNC(explosives,rf_disableJamming));
            };
        };

        class AcreRacks {
            class Rack_1 {
                displayName = "Dashboard Upper";
                shortName = "D.Up";
                componentName = "ACRE_VRC103";
                allowedPositions[] = {"driver", {"Turret", "all"}};
                disabledPositions[] = {};
                defaultComponents[] = {};
                mountedRadio = "ACRE_PRC117F";
                isRadioRemovable = 0;
                intercom[] = {"Intercom_1"};
            };
            class Rack_2 {
                displayName = "Dashboard Lower";
                shortName = "D.Low";
                componentName = "ACRE_VRC103";
                allowedPositions[] = {"driver", {"Turret", "all"}};
                disabledPositions[] = {};
                defaultComponents[] = {};
                mountedRadio = "ACRE_PRC117F";
                isRadioRemovable = 0;
                intercom[] = {"Intercom_1"};
            };
            class Rack_3 {
                displayName = "EWO A";
                shortName = "EWO A";
                componentName = "ACRE_VRC103";
                allowedPositions[] = {{"cargo", 0}, "external"};
                disabledPositions[] = {};
                defaultComponents[] = {};
                mountedRadio = "ACRE_PRC117F";
                isRadioRemovable = 0;
                intercom[] = {};
            };
            class Rack_4 {
                displayName = "EWO B";
                shortName = "EWO B";
                componentName = "ACRE_VRC103";
                allowedPositions[] = {{"cargo", 0}, "external"};
                disabledPositions[] = {};
                defaultComponents[] = {};
                mountedRadio = "ACRE_PRC117F";
                isRadioRemovable = 0;
                intercom[] = {};
            };
            class Rack_5 {
                displayName = "EWO C";
                shortName = "EWO C";
                componentName = "ACRE_VRC103";
                allowedPositions[] = {{"cargo", 0}, "external"};
                disabledPositions[] = {};
                defaultComponents[] = {};
                mountedRadio = "ACRE_PRC117F";
                isRadioRemovable = 0;
                intercom[] = {};
            };
            class Rack_6 {
                displayName = "EWO D";
                shortName = "EWO D";
                componentName = "ACRE_VRC103";
                allowedPositions[] = {{"cargo", 0}, "external"};
                disabledPositions[] = {};
                defaultComponents[] = {};
                mountedRadio = "ACRE_PRC117F";
                isRadioRemovable = 0;
                intercom[] = {};
            };
            class Rack_7 {
                displayName = "EWO E";
                shortName = "EWO E";
                componentName = "ACRE_VRC103";
                allowedPositions[] = {{"cargo", 0}, "external"};
                disabledPositions[] = {};
                defaultComponents[] = {};
                mountedRadio = "ACRE_PRC117F";
                isRadioRemovable = 0;
                intercom[] = {};
            };
            class Rack_8 {
                displayName = "EWO F";
                shortName = "EWO F";
                componentName = "ACRE_VRC103";
                allowedPositions[] = {{"cargo", 0}, "external"};
                disabledPositions[] = {};
                defaultComponents[] = {};
                mountedRadio = "ACRE_PRC117F";
                isRadioRemovable = 0;
                intercom[] = {};
            };
        };
        class AcreIntercoms {
            class Intercom_1 {
                displayName = "Crew intercom";
                shortName = "Crew";
                allowedPositions[] = {"inside"};
                disabledPositions[] = {};
                limitedPositions[] = {};
                numLimitedPositions = 1;
                masterPositions[] = {};
                connectedByDefault = 1;
            };
        };
    };
    class jsoc_m1152_ew_usarmy_d: rhsusf_m1152_sicps_usarmy_d {
        editorCategory = "JSOC_EW";
        editorSubcategory = "JSOC_EW_Car";
        displayName="M1152A1 Electronic Warfare (Desert)";
        author="RHS, 77th JSOC";

        EGVAR(explosives,isCellJammer) = "true";
        EGVAR(explosives,isRFJammer) = "true";

        class ACE_SelfActions {
            class GVAR(EnableCellJamming) {
                displayName = CSTRING(CellJamming_Enable);
                condition = QUOTE([ARR_2(_player,_target)] call FUNC(canEnableCellJamming));
                statement = QUOTE([_target] call EFUNC(explosives,cell_enableJamming));
            };
            class GVAR(DisableCellJamming) {
                displayName = CSTRING(CellJamming_Disable);
                condition = QUOTE([ARR_2(_player,_target)] call FUNC(canDisableCellJamming));
                statement = QUOTE([_target] call EFUNC(explosives,cell_disableJamming));
            };
            class GVAR(EnableRFJamming) {
                displayName = CSTRING(RFJamming_Enable);
                condition = QUOTE([ARR_2(_player,_target)] call FUNC(canEnableRFJamming));
                statement = QUOTE([_target] call EFUNC(explosives,rf_enableJamming));
            };
            class GVAR(DisableRFJamming) {
                displayName = CSTRING(RFJamming_Disable);
                condition = QUOTE([ARR_2(_player,_target)] call FUNC(canDisableRFJamming));
                statement = QUOTE([_target] call EFUNC(explosives,rf_disableJamming));
            };
        };

        class AcreRacks {
            class Rack_1 {
                displayName = "Dashboard Upper";
                shortName = "D.Up";
                componentName = "ACRE_VRC103";
                allowedPositions[] = {"driver", {"Turret", "all"}};
                disabledPositions[] = {};
                defaultComponents[] = {};
                mountedRadio = "ACRE_PRC117F";
                isRadioRemovable = 0;
                intercom[] = {"Intercom_1"};
            };
            class Rack_2 {
                displayName = "Dashboard Lower";
                shortName = "D.Low";
                componentName = "ACRE_VRC103";
                allowedPositions[] = {"driver", {"Turret", "all"}};
                disabledPositions[] = {};
                defaultComponents[] = {};
                mountedRadio = "ACRE_PRC117F";
                isRadioRemovable = 0;
                intercom[] = {"Intercom_1"};
            };
            class Rack_3 {
                displayName = "EWO A";
                shortName = "EWO A";
                componentName = "ACRE_VRC103";
                allowedPositions[] = {{"cargo", 0}, "external"};
                disabledPositions[] = {};
                defaultComponents[] = {};
                mountedRadio = "ACRE_PRC117F";
                isRadioRemovable = 0;
                intercom[] = {};
            };
            class Rack_4 {
                displayName = "EWO B";
                shortName = "EWO B";
                componentName = "ACRE_VRC103";
                allowedPositions[] = {{"cargo", 0}, "external"};
                disabledPositions[] = {};
                defaultComponents[] = {};
                mountedRadio = "ACRE_PRC117F";
                isRadioRemovable = 0;
                intercom[] = {};
            };
            class Rack_5 {
                displayName = "EWO C";
                shortName = "EWO C";
                componentName = "ACRE_VRC103";
                allowedPositions[] = {{"cargo", 0}, "external"};
                disabledPositions[] = {};
                defaultComponents[] = {};
                mountedRadio = "ACRE_PRC117F";
                isRadioRemovable = 0;
                intercom[] = {};
            };
            class Rack_6 {
                displayName = "EWO D";
                shortName = "EWO D";
                componentName = "ACRE_VRC103";
                allowedPositions[] = {{"cargo", 0}, "external"};
                disabledPositions[] = {};
                defaultComponents[] = {};
                mountedRadio = "ACRE_PRC117F";
                isRadioRemovable = 0;
                intercom[] = {};
            };
            class Rack_7 {
                displayName = "EWO E";
                shortName = "EWO E";
                componentName = "ACRE_VRC103";
                allowedPositions[] = {{"cargo", 0}, "external"};
                disabledPositions[] = {};
                defaultComponents[] = {};
                mountedRadio = "ACRE_PRC117F";
                isRadioRemovable = 0;
                intercom[] = {};
            };
            class Rack_8 {
                displayName = "EWO F";
                shortName = "EWO F";
                componentName = "ACRE_VRC103";
                allowedPositions[] = {{"cargo", 0}, "external"};
                disabledPositions[] = {};
                defaultComponents[] = {};
                mountedRadio = "ACRE_PRC117F";
                isRadioRemovable = 0;
                intercom[] = {};
            };
        };
        class AcreIntercoms {
            class Intercom_1 {
                displayName = "Crew intercom";
                shortName = "Crew";
                allowedPositions[] = {"inside"};
                disabledPositions[] = {};
                limitedPositions[] = {};
                numLimitedPositions = 1;
                masterPositions[] = {};
                connectedByDefault = 1;
            };
        };
    };
};
