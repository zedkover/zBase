Properties = {}
Property = {}
Property.Current = {}
Property.Menus = {}
Property.MaxChest = {}
Properties.List = {}
Properties.Blips = {}
Properties.Garage = {}
Property.Garage = {}
Properties.Interior = {}
Property.Interior = {}
Property.ScalformGarage = {} 
Property.IsInInstance = false 
Property.JobRequired = "realestateagent"

Property.CommandCreator = "propertycreator"
Property.CommandClients = "propertyclients"

Property.ChestHUD = true
Property.UseZedkoverOrga = true

Properties.Garages = {
    { Space = 2,    Label = "2 places",     Multiplier = 1,     Enter = vector3(178.95910644531,-1000.5520019531,-100.0), Gestion = vector3(172.92,-1000.05,-99.0), Spaces = {
        vector4(174.54, -1004.38, -99, 180.0),
        vector4(171.61, -1004.38, -99, 180.0),
    }},
    { Space = 6,    Label = "6 places",     Multiplier = 1.2,   Enter = vector3(212.03924560547,-999.02685546875,-100.0), Gestion = vector3(205.93,-994.73,-99.0), Spaces = {
        vector4(196.55, -996.85, -99, 197.0),
        vector4(193.49, -997.47, -99, 197.0),
        vector4(193.85, -1003.58, -99, 348.0),
        vector4(197.29, -1004.28, -99, 348.0),
        vector4(200.48, -1004.87, -99, 348.0),
        vector4(203.99, -1005.01, -99, 348.0),
    }},
    { Space = 10,   Label = "10 places",    Multiplier = 1.3,   Enter = vector3(237.75, -1004.82, -100.0), Gestion = vector3(234.55,-976.46,-98.99), Spaces = {
        vector4(223.4, -1001.0, -99, 240),
        vector4(223.4, -996.0, -99, 240),
        vector4(223.4, -991.0, -99, 240),
        vector4(223.4, -986.0, -99, 240),
        vector4(223.4, -981.0, -99, 240),
        vector4(232.7, -1001.0, -99, -240),
        vector4(232.7, -996.0, -99, -240),
        vector4(232.7, -991.0, -99, -240),
        vector4(232.7, -986.0, -99, -240),
        vector4(232.7, -981.0, -99, -240),
    } },
    { Space = 11,   Label = "11 places",    Multiplier = 1.5,   Enter = vector3(-1521.75, -2978.57, -81.00), Gestion = vector3(-1507.52, -3005.32, -81.56), Spaces = {
        vector4(-1518.429565, -2997.498779, -82.572762, 178.2),
        vector4(-1496.924561, -2988.588623, -82.733238, 178.2),
        vector4(-1507.677734, -2997.499268, -82.777596, 178.2),
        vector4(-1513.053345, -2997.499268, -82.836784, 178.2),
        vector4(-1497.927612, -2997.499023, -82.633224, 178.2),
        vector4(-1502.30188, -2997.499512, -82.896584, 178.2),
        vector4(-1518.429565, -2988.587646, -82.572777, 178.2),
        vector4(-1513.053223, -2988.588135, -82.836807, 178.2),
        vector4(-1502.30188, -2988.587891, -82.896599, 178.2),
        vector4(-1507.677856, -2988.587646, -82.777573, 178.2),
        vector4(-1498.98, -2978.83, -82.0, 90.0),
    } },
    { Space = 19,   Label = "19 places",    Multiplier = 1.5,   Enter = vector3(-91.56,-821.11,221.0), Gestion = vector3(-78.35, -805.64, 222), Spaces = {
        vector4(-68.224518, -825.543274, 221.406281, 108.41),
        vector4(-71.026946, -821.806641, 221.508163, 139.52),
        vector4(-75.358902, -819.733276, 221.497177, 169.68),
        vector4(-80.601181, -818.75647, 221.913025, 175.71),
        vector4(-70.150597, -835.635193, 221.914963, 46.0),
        vector4(-67.643822, -830.637146, 221.343704, 81.77),
        vector4(-68.225082, -825.542664, 226.891388, 111.73),
        vector4(-71.024559, -821.80481, 227.046005, 140.98),
        vector4(-75.358917, -819.732361, 226.853409, 160.14),
        vector4(-80.600929, -818.756042, 226.842514, 160.14),
        vector4(-85.163536, -817.908081, 227.258423, 188.21),
        vector4(-70.151001, -835.635498, 226.890625, 43.37),
        vector4(-67.639793, -830.638672, 227.045715, 81.21),
        vector4(-70.12, -835.57, 232.199112, 51.41),
        vector4(-67.15, -830.66, 232.39183, 72.89),
        vector4(-68.71, -824.33, 232.237, 118.8),
        vector4(-74.15, -820.24, 232.258423, 159.37),
        vector4(-80.83, -819.46, 232.034805, 199.22),
        vector4(-85.18, -820.65, 232.604095, 217.44),
    } },
    { Space = 20,   Label = "20 places",    Multiplier = 1.5,   Enter = vector3(1295.39, 220.41, -50.0), Gestion = vector3(1295.35,225.81,-49.0), Spaces = { -- Uniquement si vous avez la MAJ du casino avec l'ip du garage
        vector4(1281.194, 239.252, -50.057, 270.238),
        vector4(1281.194, 243.384, -50.057, 270.238),
        vector4(1281.194, 247.328, -50.057, 270.238),
        vector4(1281.194, 252.607, -50.057, 270.238),
        vector4(1281.194, 256.068, -50.057, 270.238),
        vector4(1281.194, 260.195, -50.057, 270.238),
        vector4(1295.500, 251.565, -50.057, 272.435),
        vector4(1295.500, 247.587, -50.057, 93.551),
        vector4(1295.5006, 243.149, -50.057, 271.835),
        vector4(1295.500, 239.390, -50.057, 90.444),
        vector4(1295.522, 234.267, -50.057, 272.914),
        vector4(1295.522, 229.673, -50.057, 93.184),
        vector4(1309.913, 228.723, -50.057, 89.670),
        vector4(1309.218, 234.304, -50.057, 89.670),
        vector4(1309.059, 239.318, -50.057, 89.670),
        vector4(1309.303, 243.553, -50.057, 89.670),
        vector4(1309.510, 247.668, -50.057, 89.670),
        vector4(1309.516, 252.253, -50.057, 89.670),
        vector4(1309.581, 256.453, -50.057, 89.670),
        vector4(1309.564, 260.439, -50.057, 89.670),
    } },
    { Space = 95,   Label = "95 places",    Multiplier = 2,     Enter = vector3(-1538.43, -576.61, 25.71), Gestion = vector3(-1538.43, -576.61, 25.71), Spaces = {
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0),
        vector4(0, 0, 0, 0)
    } },
}

Properties.MaxChest = {
    { Max = 100, Mutliplier = 1.0, Label = "100kg" },
    { Max = 250, Mutliplier = 1.2, Label = "250kg" },
    { Max = 500, Mutliplier = 1.5, Label = "500kg" },
    { Max = 1000, Mutliplier = 2.0, Label = "1000kg" }
}

Property.JobCantAttribute = {
    "unemployed",
}

Properties.Interiors = {
    { name = "Appartement1",    label = "Appartement",       price = 500,  enter = vector3(266.0773, -1007.3900, -102.006), chest = vector3(259.78234863281,-1003.9431762695,-99.008674621582)},
    { name = "Appartement2",    label = "Appartement 2",     price = 750,  enter = vector3(346.52, -1012.96, -100.18),      chest = vector3(351.92272949219,-998.76806640625,-99.196296691895)},
    { name = "Appartement3",    label = "Petit bureau",     price = 1000, enter = vector3(-1902.36, -572.72, 18.10),       chest = vector3(-1909.5931396484,-571.4892578125,19.097232818604)},
    { name = "Local",           label = "Local",             price = 300,  enter = vector3(242.2, 361.4, 104.74),           chest = vector3(246.54747009277,370.55014038086,105.7381362915)},
    { name = "Lester",          label = "Lester",            price = 500,  enter = vector3(1274.197265625,-1719.6834716797,54.771450042725),       chest = vector3(1272.2496337891,-1712.2442626953,54.771476745605)},
    { name = "Micheal",         label = "Michael",           price = 1500, enter = vector3(-815.354, 178.479, 70.753),         chest = vector3(-799.96807861328,177.50047302246,72.834678649902)},
    { name = "Franklin1",       label = "Franklin",          price = 500,  enter = vector3(-14.52, -1427.48, 30.13),        chest = vector3(-15.133674621582,-1440.1832275391,31.101551055908)},
    { name = "Franklin2",       label = "Franklin 2",        price = 2000, enter = vector3(7.76, 538.44, 175.06),           chest = vector3(-7.1341805458069,530.45642089844,175.0)},
    { name = "Caravane",        label = "Caravane",          price = 150,  enter = vector3(1973.19, 3816.42, 33.42),        chest = vector3(1970.0017089844,3815.0546875,33.428688049316)},
    { name = "Trevor",          label = "Trevor",            price = 500,  enter = vector3(-1150.68, -1520.84, 9.66),       chest = vector3(-1153.1964111328,-1516.7958984375,10.63272857666)},
    { name = "Middle",          label = "Middle",            price = 750,  enter = vector3(-603.4308, 58.9184, 97.2001),    chest = vector3(-602.41223144531,44.552974700928,97.400001525879)},
    { name = "Modern",          label = "Modern",            price = 1000, enter = vector3(-786.87, 315.7497, 186.91),      chest = vector3(-793.30078125,342.01245117188,187.11361694336)},
    { name = "High1",           label = "High",              price = 1250, enter = vector3(-1451.6394, -523.5562, 55.9290), chest = vector3(-793.30078125,342.01245117188,187.11361694336)},
    { name = "High2",           label = "High 2",            price = 1250, enter = vector3(-774.0, 342.0, 195.70),          chest = vector3(-760.92608642578,319.68103027344,199.48628234863)},
    { name = "Villa1",          label = "Villa",             price = 2000, enter = vector3(-681.6273, 591.9663, 144.39),    chest = vector3(-674.51647949219,585.08251953125,145.16970825195)},
    { name = "Villa2",          label = "Villa 2",           price = 2000, enter = vector3(373.48, 423.6, 144.64),          chest = vector3(370.95361328125,412.57815551758,145.70002746582)},
    { name = "Ranch",           label = "Ranch",             price = 1500, enter = vector3(1396.899, 1141.876, 113.334),        chest = vector3(1401.5203857422,1132.2852783203,114.33358764648)},
    { name = "Motel",           label = "Motel",             price = 100,  enter = vector3(151.3258, -1007.7642, -99.95),   chest = vector3(151.48034667969,-1003.251953125,-99.000007629395)},
    { name = "Entrepot1",       label = "Entrepot (grand)",  price = 750,  enter = vector3(997.56, -3091.88, -39.9998),     chest = vector3(994.35009765625,-3100.046875,-38.995864868164)},
    { name = "Entrepot2",       label = "Entrepot (moyen)",  price = 1250, enter = vector3(1048.24, -3097.08, -39.9999),    chest = vector3(1048.970703125,-3100.7470703125,-38.999954223633)},
    { name = "Entrepot3",       label = "Entrepot (petit)",  price = 1750, enter = vector3(1087.72, -3099.32, -39.9999),    chest = vector3(1088.419921875,-3101.3464355469,-38.99995803833)},
    { name = "Biker1",          label = "Biker ClubHouse",   price = 500,  enter = vector3(980.853, -102.247, 73.845),         chest = vector3(977.15093994141,-103.94521331787,74.845191955566)},
    { name = "Biker2",          label = "Biker ClubHouse 2", price = 500,  enter = vector3(1121.0, -3152.76, -37.08),       chest = vector3(1116.9318847656,-3163.1340332031,-36.870578765869)},
    { name = "DocumentOffice",  label = "Document office",   price = 300,  enter = vector3(1173.510, -3196.522, -40.008),       chest = vector3(1156.6091308594,-3195.4558105469,-39.00798034668)},
    { name = "CEO",             label = "CEO Offices",       price = 1750, enter = vector3(-137.0, -624.2, 167.84),         chest = vector3(-124.31227111816,-641.2607421875,168.82046508789)},
    { name = "Labo1",             label = "Laboratoires de Weed",       price = 3500, enter = vector3(1066.033, -3183.431, -40.163),         chest = vector3(1044.4787597656,-3194.7563476563,-38.15816116333)},
    { name = "Labo2",             label = "Laboratoires de Cocaïne",       price = 1750, enter = vector3(1088.752, -3187.569, -39.993),         chest = vector3(1099.2387695313,-3193.6975097656,-38.993473052979)},
    { name = "Labo3",             label = "Laboratoires de Méthamphétamine",       price = 1750, enter = vector3(997.020, -3201.015, -37.394),         chest = vector3(998.18353271484,-3199.7492675781,-38.993141174316)},
}
Properties.Doors = {
    { model = "v_ilev_rc_door2", pos = vector3(1005.292, -2998.266, -47.49689) },
    { model = "v_ilev_fa_frontdoor", pos = vector3(-14.86892, -1441.182, 31.19323) },
    { model = "v_ilev_epsstoredoor", pos = vector3(241.3621, 361.047, 105.8883) },
    { model = "v_ilev_mm_doorm_l", pos = vector3(-816.716, 179.098, 72.82738) },
    { model = "v_ilev_mm_doorm_r", pos = vector3(-816.1068, 177.5109, 72.82738) },
    { model = "prop_bh1_48_backdoor_r", pos = vector3(-794.1853, 182.568, 73.04045) },
    { model = "prop_bh1_48_backdoor_l", pos = vector3(-793.3943, 180.5075, 73.04045) },
    { model = "prop_bh1_48_backdoor_r", pos = vector3(-794.5051, 178.0124, 73.04045) },
    { model = "prop_bh1_48_backdoor_l", pos = vector3(-796.5657, 177.2214, 73.04045) },
    { model = "v_ilev_trevtraildr", pos = vector3(1972.769, 3815.366, 33.66326) },
    { model = "v_ilev_trev_doorfront", pos = vector3(-1149.709, -1521.088, 10.78267) },
    { model = "v_ilev_mm_door", pos = vector3(-806.287, 185.785, 72.48) },
    { model = "v_ilev_lester_doorfront", pos = vector3(1273.82, -1720.7, 54.92) },
    { model = "v_ilev_fh_frontdoor", pos = vector3(7.52, 539.53, 176.18) },
    { model = "v_ilev_trev_doorfront", pos = vector3(-1149.71, -1521.09, 10.78) },
    { model = "v_ilev_janitor_frontdoor", pos = vector3(-107.54, -9.02, 70.67) },
    { model = "v_ilev_lostdoor", pos = vector3(981.15, -103.25, 74.99) },
}

local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["-"] = 84,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

Config = {}

Config.Locale = "fr"

Config.Limit = 25000

Config.DefaultWeight = 1
Config.UseLastVersionESX = false
Config.Cash = "money"
Config.CashLabel = "Cash"
Config.Blackmoney = "black_money"
Config.BlackmoneyLabel = "Argent Sale"

Config.localWeight = {
    bread = 1,
    water = 2,
}

Config.IncludeCash = true 
Config.IncludeAccounts = true 