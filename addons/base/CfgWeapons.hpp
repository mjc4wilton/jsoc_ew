class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class GVAR(Laptop): ACE_ItemCore {
        scope = 2;
        author = ECSTRING(main,Author);
        displayName = CSTRING(Hack_Laptop);
        descriptionShort = "";
        picture = "\a3\Missions_F_Oldman\Props\data\Laptop_Unfolded_ca.paa";
        model = "\a3\Props_F_Enoch\Military\Equipment\Laptop_03_F.p3d";

        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 10;
        };
    };
};
