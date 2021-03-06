#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "cba_main",
            "ace_main"
        };
        author = ECSTRING(main,Author);
        VERSION_CONFIG;
    };
};

#include "CfgEditorCategories.hpp"
#include "CfgFactionClasses.hpp"
