ByzzonUI = ByzzonUI or {}

local peacebloom = {
    iconPath = [[Interface\icons\Inv_misc_flower_02]],
    name = "Peacebloom",
    orangeLevel = 1,
    yellowLevel = 25,
    greenLevel = 50,
    grayLevel = 100,
    marginTop = 0,
    locations = "All low level zones"
}

local silverleaf = {
    iconPath = [[Interface\icons\Inv_misc_herb_10]],
    name = "Silverleaf",
    orangeLevel = 1,
    yellowLevel = 25,
    greenLevel = 50,
    grayLevel = 100,
    marginTop = -45,
    locations = "All low level zones"
}

local earthroot = {
    iconPath = [[Interface\icons\Inv_misc_herb_07]],
    name = "Earthroot",
    orangeLevel = 15,
    yellowLevel = 40,
    greenLevel = 70,
    grayLevel = 115,
    marginTop = -90,
    locations = "All low level zones"
}

local mageroyal = {
    iconPath = [[Interface\icons\inv_jewelry_talisman_03]],
    name = "Mageroyal",
    orangeLevel = 50,
    yellowLevel = 75,
    greenLevel = 100,
    grayLevel = 150,
    marginTop = -135,
    locations = "All low level zones"
}

local briarthorn = {
    iconPath = [[Interface\icons\inv_misc_root_01]],
    name = "Briarthorn",
    orangeLevel = 70,
    yellowLevel = 95,
    greenLevel = 120,
    grayLevel = 170,
    marginTop = -180,
    locations = "All low level zones, especially Silverpine Forest"
}

local swiftthistle = {
    iconPath = [[Interface\icons\inv_misc_herb_04]],
    name = "Swiftthistle",
    orangeLevel = "",
    yellowLevel = "",
    greenLevel = "",
    grayLevel = "",
    marginTop = -225,
    locations = "All low level zones, found on  [Briarthorn] and  [Mageroyal]"
}

ByzzonUI.flowerList = { peacebloom, silverleaf, earthroot, mageroyal, briarthorn, swiftthistle }
