#include "\x\cba\addons\main\script_macros_common.hpp"

#define DFUNC(var1) TRIPLES(ADDON,fnc,var1)
#define DEFUNC(var1,var2) TRIPLES(DOUBLES(PREFIX,var1),fnc,var2)

#ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
    #define LINKFUNC(x) {_this call FUNC(x)}
#else
    #undef PREP
    #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
    #define LINKFUNC(x) FUNC(x)
#endif

// nextcba
#ifndef COMPILE_SCRIPT
    #define COMPILE_SCRIPT(var1) compileScript ['PATHTO_SYS(PREFIX,COMPONENT_F,var1)']
#endif
