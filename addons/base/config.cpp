#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {
            "jsoc_ew_base_backpack_mc",
            QGVAR(ModuleBase),
            QGVAR(Laptop),
            QGVAR(LaptopObject)
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"jsoc_ew_main","ace_interaction","ace_explosives"};
        author = ECSTRING(main,Author);
        VERSION_CONFIG;
    };
};


#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
