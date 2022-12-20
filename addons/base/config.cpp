#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {
            QGVAR(backpack),
            QGVAR(backpack_multicam),
            QGVAR(backpack_multicamarctic),
            QGVAR(backpack_multicamblack),
            QGVAR(backpack_multicamtropic),
            QGVAR(backpack_od),
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
