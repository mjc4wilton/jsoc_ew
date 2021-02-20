#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {
            "jsoc_m1152_ew_usarmy_wd",
            "jsoc_m1152_ew_usarmy_d"
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "rhsusf_c_m11xx",
            "ace_interact_menu"
        };
        author = ECSTRING(main,Author);
        VERSION_CONFIG;
    };
};

#include "CfgVehicles.hpp"
#include "CfgEventHandlers.hpp"
