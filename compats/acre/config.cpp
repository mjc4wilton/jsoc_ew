#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"jsoc_ew_main"};
        author = ECSTRING(main,Author);
        VERSION_CONFIG;
    };
};


#include "CfgEventHandlers.hpp"
