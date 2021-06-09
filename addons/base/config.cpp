#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {
            "jsoc_ew_base_backpack_mc",
            QGVAR(ModuleBase),
            QGVAR(Cell_ConnectExplosive),
            QGVAR(Laptop)
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
#include "Ace_ZeusActions.hpp"
