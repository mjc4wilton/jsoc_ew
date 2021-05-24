#define COMPONENT contact
#include "\z\jsoc_ew\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_CONTACT
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_OTHER
    #define DEBUG_SETTINGS DEBUG_SETTINGS_CONTACT
#endif

#include "\z\jsoc_ew\addons\main\script_macros.hpp"

#define SPECTRUM_FREQ_MIN 58
#define SPECTRUM_FREQ_MAX 75
#define SPECTRUM_SENS_MIN -90
#define SPECTRUM_SENS_MAX -10
