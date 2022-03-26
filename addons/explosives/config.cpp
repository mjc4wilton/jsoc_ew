#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {
            QGVAR(Cell_ConnectExplosive)
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "jsoc_ew_main",
            "jsoc_ew_base",
            "ace_interaction",
            "ace_explosives"
        };
        author = ECSTRING(main,Author);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"

#include "Ace_ZeusActions.hpp"
