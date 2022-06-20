
Config = {
    carslsc = {
        {name = "flatbed", label = "Plateau"},
        {name = "blista", label = "Blista"}, 
    },
	carslspd = {
        {name = "police", label = "Police"},
        {name = "fbi", label = "FBI"}, 
    },
	carsems = {
        {name = "ambulance", label = "Ambulance"},
    },
	carsems2 = {
        {name = "polmav", label = "Polmav"},
    },
	carsresto = {
        {name = "speedo", label = "Speedo"},
    },
    carsburgershot = {
        {name = "speedo", label = "Speedo"},
    },
    Spawngarageresto = {x = 830.97, y = -126.91, z = 80.04, a = 236.00},
    Pedgarageresto = {x = 826.62, y = -121.96, z = 79.39, a = 148.51},
    Spawngarageburgershot = {x = -1171.978, y = -891.6132, z = 13.91284, a = 35.00},
    Pedgarageburgershot = {x = -1175.512, y = -899.3143, z = 12.69373, a = 220.51},
    Spawngaragelsc = {x = 710.77, y = -1081.25, z = 22.38, a = 354.00},
	Pedgaragelsc = {x = 722.43, y = -1084.30, z = 21.19, a = 87.51},
	Spawngaragelspd = {x = 445.52, y = -1020.58, z = 28.53, a = 90.00},
	Pedgaragelspd = {x = 459.31, y = -1008.06, z = 27.25, a = 92.51},
	Spawngarageems = {x = 334.60, y = -572.60, z = 28.79, a = 340.00},
	Spawngarageems2 = {x = 350.84, y = -588.20, z = 74.16, a = 288.00},
	Pedgarageems = {x = 340.93, y = -574.15, z = 27.79, a = 71.51},
    Pedgarageems2 = {x = 340.10, y = -593.34, z = 73.16, a = 298.51}
}

LsCustoms = LsCustoms or {}
LsCustoms.Pos = {
	{pos = vector3(731.35, -1088.73, 22.16), job = "lscustom", notif = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au ~b~Hayes Auto~s~.", header = {"shopui_title_carmod", "shopui_title_carmod"}, world = true, size = 5.0, blips = {
		display = 446,
		colour = 1,
		size = 0.7,
		name = "~r~Los Santos Customs",
	}}
}

Config.Uniforms = {
	ems_tenue = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 13,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 92,
			['pants_1'] = 24,   ['pants_2'] = 5,
			['shoes_1'] = 9,    ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,    ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 73,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 109,
			['pants_1'] = 37,   ['pants_2'] = 5,
			['shoes_1'] = 1,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,    ['ears_2'] = 0
		}
	},
    unicorn_tenue = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 26,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 24,   ['pants_2'] = 0,
			['shoes_1'] = 10,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 27,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 27,   ['pants_2'] = 0,
			['shoes_1'] = 6,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
    burgershot_tenue = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 26,   ['torso_2'] = 9,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 24,   ['pants_2'] = 0,
			['shoes_1'] = 10,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 27,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 27,   ['pants_2'] = 0,
			['shoes_1'] = 6,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	resto_tenue = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 26,   ['torso_2'] = 9,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 24,   ['pants_2'] = 0,
			['shoes_1'] = 10,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 27,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 27,   ['pants_2'] = 0,
			['shoes_1'] = 6,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	}			
}

Config.Discord = "ton discord"

Death = Death or {}
Death.deathTime = 0
Death.deathTime1 = 0
Death.waitTime = 15 * 1000
Death.waitTimeKo = 10 * 1000
Death.deathCause = {}
Death.RespawnPos = vector3(297.62, -583.88, 43.26) -- Todo
Death.HasRespawn = false
Death.HasRespawnTimer = 0
Death.RespawnTimeClean = 33 * 1000
Death.RespawnTime = 0
Death.contend = false
Death.tranch = false 
Death.Call = true 

Death.Invincible = false

Death.IsSoigne = false

Death.weaponHashType = { "Inconnue", "Dégâts de mêlée", "Blessure par balle", "Chute", "Dégâts explosifs", "Feu", "Chute", "Éléctrique", "Écorchure", "Gaz", "Gaz", "Eau" }
Death.boneTypes = {
    ["Dos"] = { 0, 23553, 56604, 57597 },
    ["Crâne"] = { 1356, 11174, 12844, 17188, 17719, 19336, 20178, 20279, 20623, 21550, 25260, 27474, 29868, 31086, 35731, 43536, 45750, 46240, 47419, 47495, 49979, 58331, 61839, 39317 },
    ["Coude droit"] = { 2992 },
    ["Coude gauche"] = { 22711 },
    ["Main gauche"] = { 4089, 4090, 4137, 4138, 4153, 4154, 4169, 4170, 4185, 4186, 18905, 26610, 26611, 26612, 26613, 26614, 60309 },
    ["Main droite"] = { 6286, 28422, 57005, 58866, 58867, 58868, 58869, 58870, 64016, 64017, 64064, 64065, 64080, 64081, 64096, 64097, 64112, 64113 },
    ["Bras gauche"] = { 5232, 45509, 61007, 61163 },
    ["Bras droit"] = { 28252, 40269, 43810 },
    ["Jambe droite"] = { 6442, 16335, 51826, 36864 },
    ["Jambe gauche"] = { 23639, 46078, 58271, 63931 },
    ["Pied droit"] = { 20781, 24806, 35502, 52301 },
    ["Pied gauche"] = { 2108, 14201, 57717, 65245 },
    ["Poîtrine"] = { 10706, 64729, 24816, 24817, 24818 },
    ["Ventre"] = { 11816 },
}

Death.AllWeaponKO = {
    GetHashKey("weapon_bat"),
    GetHashKey("weapon_crowbar"),
    GetHashKey("weapon_unarmed"),
    GetHashKey("weapon_flashlight"),
    GetHashKey("weapon_golfclub"),
    GetHashKey("weapon_hammer"),
    GetHashKey("weapon_knuckle"),
    GetHashKey("weapon_nightstick"),
    GetHashKey("weapon_wrench"),
    GetHashKey("weapon_poolcue"),
    GetHashKey("weapon_snowball"),
    GetHashKey("weapon_ball"),
    GetHashKey("weapon_flare"),
    GetHashKey("weapon_flaregun"),
    GetHashKey("weapon_dagger"),
    GetHashKey("weapon_bottle"),
    GetHashKey("weapon_hatchet"),
    GetHashKey("weapon_knife"),
    GetHashKey("weapon_machete"),
    GetHashKey("weapon_switchblade"),
    GetHashKey("weapon_battleaxe"),
    GetHashKey("weapon_stone_hatchet"),
}

Death.WeaponHashcontend = {
    GetHashKey("weapon_bat"),
    GetHashKey("weapon_crowbar"),
    GetHashKey("weapon_unarmed"),
    GetHashKey("weapon_flashlight"),
    GetHashKey("weapon_golfclub"),
    GetHashKey("weapon_hammer"),
    GetHashKey("weapon_knuckle"),
    GetHashKey("weapon_nightstick"),
    GetHashKey("weapon_wrench"),
    GetHashKey("weapon_poolcue"),
    GetHashKey("weapon_snowball"),
    GetHashKey("weapon_ball"),
    GetHashKey("weapon_flare"),
    GetHashKey("weapon_flaregun"),
}

Death.WeaponHashtranch = {
    GetHashKey("weapon_dagger"),
    GetHashKey("weapon_bottle"),
    GetHashKey("weapon_hatchet"),
    GetHashKey("weapon_knife"),
    GetHashKey("weapon_machete"),
    GetHashKey("weapon_switchblade"),
    GetHashKey("weapon_battleaxe"),
    GetHashKey("weapon_stone_hatchet"),
}

Death.PlayerDead = false 
Death.PlayerKO = false 

-- Tattoo Job

Config.AllTattooList = json.decode(LoadResourceFile(GetCurrentResourceName(), 'AllTattoos.json'))

Config.TattooCats = {
	{"ZONE_HEAD", "Tête", {vec(0.0, 0.7, 0.7), vec(0.7, 0.0, 0.7), vec(0.0, -0.7, 0.7), vec(-0.7, 0.0, 0.7)}, vec(0.0, 0.0, 0.5)},
	{"ZONE_LEFT_LEG", "Jambe Gauche", {vec(-0.2, 0.7, -0.7), vec(-0.7, 0.0, -0.7), vec(-0.2, -0.7, -0.7)}, vec(-0.2, 0.0, -0.6)},
	{"ZONE_LEFT_ARM", "Bras Gauche", {vec(-0.4, 0.5, 0.2), vec(-0.7, 0.0, 0.2), vec(-0.4, -0.5, 0.2)}, vec(-0.2, 0.0, 0.2)},
	{"ZONE_RIGHT_LEG", "Jambe Droite", {vec(0.2, 0.7, -0.7), vec(0.7, 0.0, -0.7), vec(0.2, -0.7, -0.7)}, vec(0.2, 0.0, -0.6)},
	{"ZONE_TORSO", "Torse/Dos", {vec(0.0, 0.7, 0.2), vec(0.0, -0.7, 0.2)}, vec(0.0, 0.0, 0.2)},
	{"ZONE_RIGHT_ARM", "Bras Droit", {vec(0.4, 0.5, 0.2), vec(0.7, 0.0, 0.2), vec(0.4, -0.5, 0.2)}, vec(0.2, 0.0, 0.2)},
}

-- Auto Ecole

Config.DrawDistance    = 100.0
Config.MaxErrors       = 5
Config.SpeedMultiplier = 2.2369
Config.Locale          = 'fr'

Config.VehicleModels = {
	car       = 'oracle2',
	motor  = 'double',
	drive_truck = 'mule'
}

Config.SpeedLimits = {
	residence = 80,
	town      = 80,
	freeway   = 130
}

Config.Zones = {

	DMVSchool = {
		Pos   = {x = 213.97, y = 391.20, z = 106.84},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1
	},

	VehicleSpawnPoint = {
		Pos   = {x = 206.770, y = 382.234, z = 107.2351, h = 250.40},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = -1
	}

}

Config.CheckPoints = {

	{
		Pos = {x = 232.52, y = 347.95, z = 104.83},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = 208.27, y = 221.86, z = 104.88},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = 129.65, y = -9.89, z = 66.96},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = 484.93, y = -161.013, z = 55.142},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = 504.30, y = -337.52, z = 43.24},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			setCurrentZoneType('freeway')
			ESX.ShowNotification("Il est temps d\'aller sur ~b~l'autoroute~s~, limite : ~b~130~s~ km/h")
		end
	},

	{
		Pos = {x = -987.00, y = -545.69, z = 17.64},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			setCurrentZoneType('town')
			ESX.ShowNotification("Entrée en ~b~ville~s~, attention à votre vitesse, limite : ~b~80~s~ km/h")
		end
	},

	{
		Pos = {x = -1157.9725, y = -632.29, z = 21.80},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = -1527.57, y = -191.56, z = 54.01},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = -1070.88, y = -178.75, z = 37.17},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = -540.62, y = 110.61, z = 62.25},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},


	{
		Pos = {x = 200.00, y = 390.41, z = 106.82},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			ESX.Game.DeleteVehicle(vehicle)
		end
	}

}


-- Concessionnaire Automatique

Config.vehicleconcessionnaire = { 
    Categories = {
        ["Compacts"] = { 
            veh = { 
                { vehName = "blista", price = 800 },
                { vehName = "brioso", price = 750 },
                { vehName = "dilettante", price = 1000 }, 
                { vehName = "dilettante2", price = 1000 }, 
                { vehName = "issi2", price = 1000 }, 
                { vehName = "issi3", price = 1500 }, 
                { vehName = "panto", price = 500 }, 
                { vehName = "prairie", price = 800 }, 
                { vehName = "rhapsody", price = 800 }
            }
        },
        ["Coupés"] = {
            veh = {
                { vehName = "cogcabrio", price = 10000 },
                { vehName = "exemplar", price = 25000 },
                { vehName = "f620", price = 20000 },
                { vehName = "felon", price = 12000 },
                { vehName = "felon2", price = 13000 },
                { vehName = "jackal", price = 13000 },
                { vehName = "oracle", price = 8000 },
                { vehName = "oracle2", price = 18000 },
                { vehName = "sentinel", price = 11000 },
                { vehName = "sentinel2", price = 13000 },
                { vehName = "windsor", price = 30000 },
                { vehName = "windsor2", price = 35000 },
                { vehName = "zion", price = 7000 },
                { vehName = "zion2", price = 7500 }
            }
        },
        ["Motos"] = { 
            veh = {
                { vehName = "akuma", price = 3000 },
                { vehName = "avarus", price = 8000 },
                { vehName = "bagger", price = 4000 },
                { vehName = "bati", price = 5000 },
                { vehName = "bati2", price = 5000 }, 
                { vehName = "bf400", price = 4000 },
                { vehName = "carbonrs", price = 10000 },
                { vehName = "cliffhanger", price = 12000 },
                { vehName = "daemon", price = 4000 },
                { vehName = "daemon2", price = 4200 },
                { vehName = "defiler", price = 14000 },
                { vehName = "deathbike", price = 8000 },
                { vehName = "diablous", price = 9000},
                { vehName = "diablous2", price = 10000 },
                { vehName = "double", price = 13000 },
                { vehName = "enduro", price = 6000 },
                { vehName = "esskey", price = 7000 },
                { vehName = "faggio", price = 500 },
                { vehName = "faggio2", price = 750 },
                { vehName = "faggio3", price = 1000 }, 
                { vehName = "fcr", price = 6500 },
                { vehName = "fcr2", price = 7000 },
                { vehName = "gargoyle", price = 9500 },
                { vehName = "hakuchou", price = 10500},
                { vehName = "hakuchou2", price = 15400 },
                { vehName = "hexer", price = 1500 },
                { vehName = "innovation", price = 17000 },
                { vehName = "lectro", price = 7000 },
                { vehName = "manchez", price = 5500 },
                { vehName = "nemesis", price = 4000 },
                { vehName = "nightblade", price = 17000 },
                { vehName = "pcj", price = 3500 },
                { vehName = "ratbike", price = 2500 },
                { vehName = "ruffian", price = 3500 },
                { vehName = "sanctus", price = 20000 },
                { vehName = "sovereign", price = 4000 },
                { vehName = "thrust", price = 6000 },
                { vehName = "vader", price = 3500 },
                { vehName = "vindicator", price = 7000 },
                { vehName = "vortex", price = 21000 },
                { vehName = "wolfsbane", price = 4500},
                { vehName = "zombiea", price = 3000 },
                { vehName = "zombieb", price = 3500 },
                { vehName = "manchez2", price = 4000 },
            }
        }, 
        ["Muscles"] = { 
            veh = {
                { vehName = "blade", price = 3000 },
                { vehName = "buccaneer", price = 2500 },
                { vehName = "buccaneer2", price = 4000 },
                { vehName = "chino", price = 2000 },
                { vehName = "chino2", price = 3000 },
                { vehName = "clique", price = 1500 },
                { vehName = "coquette3", price = 3000 },
                { vehName = "deviant", price = 5000 },
                { vehName = "dominator", price = 11000 },
                { vehName = "dominator2", price = 13000 },
                { vehName = "dominator3", price = 21000 },
                { vehName = "dukes", price = 3000 },
                { vehName = "ellie", price = 7000 },
                { vehName = "faction", price = 4000 },
                { vehName = "faction2", price = 6000 },
                { vehName = "faction3", price = 8000 },
                { vehName = "gauntlet", price = 3000 },
                { vehName = "gauntlet2", price = 3500 },
                { vehName = "gauntlet3", price = 6000 },
                { vehName = "gauntlet4", price = 10000 },
                { vehName = "hermes", price = 4000 },
                { vehName = "hotknife", price = 8000 },
                { vehName = "hustler", price = 6000 },
                { vehName = "moonbeam", price = 3000 },
                { vehName = "moonbeam2", price = 4000 },
                { vehName = "nightshade", price = 6000 },
                { vehName = "peyote2", price = 8000 },
                { vehName = "phoenix", price = 3000 },
                { vehName = "picador", price = 2500 },
                { vehName = "ratloader", price = 1200 }, 
                { vehName = "ratloader2", price = 1500 },
                { vehName = "ruiner", price = 4000 },
                { vehName = "sabregt", price = 4000 },
                { vehName = "sabregt2", price = 7000 },
                { vehName = "slamvan", price = 3000 },
                { vehName = "slamvan2", price = 3500 },
                { vehName = "slamvan3", price = 5000 },
                { vehName = "stalion", price = 3000 },
                { vehName = "stalion2", price = 3500 },
                { vehName = "tampa", price = 4000 },
                { vehName = "tulip", price = 4000 },
                { vehName = "vamos", price = 3000 },
                { vehName = "vigero", price = 2500 },
                { vehName = "virgo", price = 3000 },
                { vehName = "virgo2", price = 4000 },
                { vehName = "virgo3", price = 3500 },
                { vehName = "voodoo", price = 1500 },
                { vehName = "voodoo2", price = 1400 },
                { vehName = "yosemite", price = 2000 }
            }
        }, 
        ["Offroad"] = {
            veh = { 
                { vehName = "bfinjection", price = 1500 },
                { vehName = "bifta", price = 2500 },
                { vehName = "blazer", price = 3000 },
                { vehName = "blazer2", price = 2000 },
                { vehName = "blazer3", price = 1500 },
                { vehName = "blazer4", price = 4000 },
                { vehName = "bodhi2", price = 2000 },
                { vehName = "brawler", price = 5000 },
                { vehName = "brutus", price = 12000 },
                { vehName = "dloader", price = 3500 },
                { vehName = "dubsta3", price = 12500 },
                { vehName = "freecrawler", price = 10000 },
                { vehName = "kalahari", price = 3000 },
                { vehName = "kamacho", price = 9000 },
                { vehName = "mesa3", price = 6000 },
                { vehName = "rancherxl", price = 2000 },
                { vehName = "rebel", price = 3000 },
                { vehName = "rebel2", price = 3500 },
                { vehName = "riata", price = 4000 },
                { vehName = "sandking", price = 4000 },
                { vehName = "sandking2", price = 5000 },
                { vehName = "trophytruck", price = 6000 },
                { vehName = "trophytruck2", price = 7500 },
            }
        }, 
        ["Sportives classiques"] = {
            veh = {
                { vehName = "ardent", price = 12000 },
                { vehName = "btype", price = 13000 },
                { vehName = "btype2", price = 14000 },
                { vehName = "btype3", price = 14500 },
                { vehName = "casco", price = 15000 },
                { vehName = "cheburek", price = 6000 },
                { vehName = "cheetah2", price = 25000 },
                { vehName = "coquette2", price = 14000 },
                { vehName = "dynasty", price = 4000 },
                { vehName = "fagaloa", price = 5000 },
                { vehName = "feltzer3", price = 26000 },
                { vehName = "gt500", price = 13000 },
                { vehName = "infernus2", price = 50000 },
                { vehName = "jester3", price = 20000 },
                { vehName = "mamba", price = 10000 },
                { vehName = "manana", price = 2000 },
                { vehName = "michelli", price = 2500 },
                { vehName = "monroe", price = 15000 },
                { vehName = "nebula", price = 14000 },
                { vehName = "peyote", price = 5000 },
                { vehName = "pigalle", price = 3000 },
                { vehName = "rapidgt3", price = 4000 },
                { vehName = "retinue", price = 3000 },
                { vehName = "stinger", price = 7000 },
                { vehName = "stingergt", price = 8000 },
                { vehName = "swinger", price = 23000 },
                { vehName = "torero", price = 47000 },
                { vehName = "tornado", price = 2000 },
                { vehName = "tornado2", price = 2500 },
                { vehName = "tornado3", price = 1500 },
                { vehName = "tornado4", price = 1500 },
                { vehName = "tornado5", price = 2000 },
                { vehName = "tornado6", price = 4000 },
                { vehName = "turismo2", price = 56000 },
                { vehName = "viseris", price = 17000 },
                { vehName = "z190", price = 6000 },
                { vehName = "zion3", price = 5000 },
                { vehName = "ztype", price = 11000 }
            }
        },
        ["Sportives"] = {
            veh = {
                { vehName = "alpha", price = 6000 },
                { vehName = "banshee", price = 8000 },
                { vehName = "bestiagts", price = 10000 },
                { vehName = "blista2", price = 4000 },
                { vehName = "blista3", price = 3000 },
                { vehName = "buffalo", price = 4000 },
                { vehName = "buffalo2", price = 12000 },
                { vehName = "buffalo3", price = 15000 },
                { vehName = "carbonizzare", price = 7000 },
                { vehName = "comet2", price = 21000 },
                { vehName = "comet3", price = 22000 },
                { vehName = "comet4", price = 6000 },
                { vehName = "comet5", price = 41000 },
                { vehName = "coquette", price = 36000 },
                { vehName = "drafter", price = 44000 },
                { vehName = "elegy", price = 34000 },
                { vehName = "elegy2", price = 43000 },
                { vehName = "feltzer2", price = 23000 },
                { vehName = "flashgt", price = 23000 },
                { vehName = "furoregt", price = 24000 },
                { vehName = "fusilade", price = 3000 },
                { vehName = "futo", price = 2000 },
                { vehName = "gb200", price = 2000 },
                { vehName = "hotring", price = 14000 },
		        { vehName = "komoda", price = 91000 },
                { vehName = "issi7", price = 7000 },
                { vehName = "jester", price = 45000 },
                { vehName = "jester2", price = 47000 },
                { vehName = "jugular", price = 38000 },
                { vehName = "khamelion", price = 27000 },
                { vehName = "kuruma", price = 19000 },
                { vehName = "locust", price = 21000 },
                { vehName = "lynx", price = 16000 },
                { vehName = "massacro", price = 32000 },
                { vehName = "massacro2", price = 33000 },
                { vehName = "neo", price = 56000 },
                { vehName = "neon", price = 150000 },
                { vehName = "ninef", price = 57000 },
                { vehName = "ninef2", price = 60000 },
                { vehName = "omnis", price = 13000 },
                { vehName = "revoleter", price = 35000 },
                { vehName = "paragon", price = 42000 },
                { vehName = "pariah", price = 45000 },
                { vehName = "penumbra", price = 9000 },
                { vehName = "raiden", price = 7000 },
                { vehName = "rapidgt", price = 37000 },
                { vehName = "rapidgt2", price = 39000 },
                { vehName = "raptor", price = 4000 },
                { vehName = "ruston", price = 7000 },
                { vehName = "schafter2", price = 12000 },
                { vehName = "schafter3", price = 20000 },
                { vehName = "schafter4", price = 35000 },
                { vehName = "schlagen", price = 60000 },
                { vehName = "schwarzer", price = 20000 },
                { vehName = "sentinel3", price = 10000 },
                { vehName = "seven70", price = 39000 },
                { vehName = "sultan", price = 8000 },
                { vehName = "surano", price = 12000 },
                { vehName = "tampa2", price = 11000 },
                { vehName = "tropos", price = 9000 },
                { vehName = "verlierer2", price = 6000 }
            }
        },
        ["Super-sportives"] = {
            veh = {
                { vehName = "adder", price = 110000 },
                { vehName = "autarch", price = 120000 },
                { vehName = "banshee2", price = 23000 },
                { vehName = "bullet", price = 31000 },
                { vehName = "cheetah", price = 125000 },
                { vehName = "cyclone", price = 210000 },
                { vehName = "deveste", price = 500000 },
                { vehName = "emerus", price = 300000 },
                { vehName = "entityxf", price = 115000 },
                { vehName = "entity2", price = 210000 },
                { vehName = "fmj", price = 200000 },
                { vehName = "gp1", price = 130000 },
                { vehName = "infernus", price = 40000 },
                { vehName = "italigtb", price = 125000 },
                { vehName = "italigtb2", price = 135000 },
                { vehName = "krieger", price = 140000 },
                { vehName = "le7b", price = 150000 },
                { vehName = "nero", price = 340000 },
                { vehName = "nero2", price = 420000 },
                { vehName = "osiris", price = 134000 },
                { vehName = "penetrator", price = 112000 },
                { vehName = "pfister811", price = 70000 },
                { vehName = "prototipo", price = 520000 },
                { vehName = "reaper", price = 340000 },
                { vehName = "s80", price = 230000 },
                { vehName = "sc1", price = 230000 },
                { vehName = "sheava", price = 230000 },
                { vehName = "sultanrs", price = 51000 }, 
                { vehName = "t20", price = 120000 },
                { vehName = "taipan", price = 210000 },
                { vehName = "tempesta", price = 312000 },
                { vehName = "tezeract", price = 421000 },
                { vehName = "thrax", price = 512000 },
                { vehName = "turismor", price = 210000 },
                { vehName = "tyrant", price = 312000 },
                { vehName = "tyrus", price = 135000 },
                { vehName = "vacca", price = 310000 },
                { vehName = "vagner", price = 213000 }, 
                { vehName = "visione", price = 231000 },
                { vehName = "voltic", price = 123000 },
                { vehName = "xa21", price = 214000 },
                { vehName = "zentorno", price = 312000 },
                { vehName = "zorrusso", price = 52000 }
            }
        },
        ["Vans"] = {
            veh = {
                {vehName = "bison", price = 4000 },
                {vehName = "bobcatxl", price = 6000 },
                {vehName = "burrito3", price = 5000 },
                {vehName = "gburrito2", price = 7000 },
                {vehName = "camper", price = 4500 },
                {vehName = "gburrito", price = 6000 },
                {vehName = "journey", price = 4000 },
                {vehName = "minivan", price = 5000 },
                {vehName = "moonbeam", price = 5000 },
                {vehName = "moonbeam2", price = 7000 },
                {vehName = "paradise", price = 5000 },
                {vehName = "rumpo", price = 5000 },
                {vehName = "rumpo3", price = 7300 },
                {vehName = "surfer", price = 3000 }, 
                {vehName = "youga", price = 1200 },
                {vehName = "youga2", price = 1400 },
            }
        }, 
        ["Berlines"] = { 
            veh = {
                { vehName = "asea", price = 3000 },
                { vehName = "asterope", price = 4000 },
                { vehName = "cog55", price = 12000 },
                { vehName = "cognoscenti", price = 14000 },
                { vehName = "emperor", price = 3000 },
                { vehName = "emperor2", price = 2500 },
                { vehName = "fugitive", price = 3000 },
                { vehName = "glendale", price = 4000 },
                { vehName = "ingot", price = 3000 },
                { vehName = "intruder", price = 3500 },
                { vehName = "primo", price = 4000 },
                { vehName = "primo2", price = 7000 },
                { vehName = "regina", price = 2000 },
                { vehName = "romero", price = 6000 },
                { vehName = "stafford", price = 22000 },
                { vehName = "stanier", price = 4000 },
                { vehName = "stratum", price = 3500 },
                { vehName = "superd", price = 13000 },
                { vehName = "surge", price = 7000 },
                { vehName = "tailgater", price = 6000 },
                { vehName = "warrener", price = 4000 },
                { vehName = "washington", price = 5000 }
            }
        },
        ["SUVs"] = {
            veh = {
                { vehName = "baller", price = 10000 },
                { vehName = "baller2", price = 16000 },
                { vehName = "baller3", price = 23000 },
                { vehName = "baller4", price = 25000 },
                { vehName = "bjxl", price = 14000 },
                { vehName = "cavalcade", price = 13000 },
                { vehName = "cavalcade2", price = 12000 },
                { vehName = "contender", price = 26000 },
                { vehName = "dubsta", price = 21000 },
                { vehName = "dubsta2", price = 31000 },
                { vehName = "fq2", price = 17000 },
                { vehName = "granger", price = 13000 },
                { vehName = "gresley", price = 8000 },
                { vehName = "habanero", price = 4000 },
                { vehName = "rebla", price = 51000 },
                { vehName = "huntley", price = 10000 },
                { vehName = "landstalker", price = 19000 },
                { vehName = "mesa", price = 4000 },
                { vehName = "mesa2", price = 6000 },
                { vehName = "novak", price = 50000 },
                { vehName = "patriot", price = 7000 },
                { vehName = "patriot2", price = 12000 },
                { vehName = "radi", price = 9000 },
                { vehName = "rocoto", price = 4000 },
                { vehName = "seminole", price = 4000 },
                { vehName = "serrano", price = 4000 },
                { vehName = "toros", price = 41000 },
                { vehName = "xls", price = 35000 }
            }
        }    
    }
}

Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

-- Weapon

ConfigWeapons = {}
ConfigWeapons.Weapons = {
  WEAPON_KNIFE = { item = 'weapon_knife', label = ('weapon_knife') },
  WEAPON_NIGHTSTICK = { item = 'weapon_nightstick', label = ('weapon_nightstick') },
  WEAPON_HAMMER = { item = 'weapon_hammer', label = ('weapon_hammer') },
  WEAPON_BAT = { item = 'weapon_bat', label = ('weapon_bat') },
  WEAPON_GOLFCLUB = { item = 'weapon_golfclub', label = ('weapon_golfclub') },
  WEAPON_CROWBAR = { item = 'weapon_crowbar', label = ('weapon_crowbar') },
  WEAPON_PISTOL = { item = 'weapon_pistol', label = ('weapon_pistol') },
  WEAPON_COMBATPISTOL = { item = 'weapon_combatpistol', label = ('weapon_combatpistol') },
  WEAPON_APPISTOL = { item = 'weapon_appistol', label = ('weapon_appistol') },
  WEAPON_PISTOL50 = { item = 'weapon_pistol50', label = ('weapon_pistol50') },
  WEAPON_MICROSMG = { item = 'weapon_microsmg', label = ('weapon_microsmg') },
  WEAPON_SMG = { item = 'weapon_smg', label = ('weapon_smg') },
  WEAPON_ASSAULTSMG = { item = 'weapon_assaultsmg', label = ('weapon_assaultsmg') },
  WEAPON_ASSAULTRIFLE = { item = 'weapon_assaultrifle', label = ('weapon_assaultrifle') },
  WEAPON_CARBINERIFLE = { item = 'weapon_carbinerifle', label = ('weapon_carbinerifle') },
  WEAPON_ADVANCEDRIFLE = { item = 'weapon_advancedrifle', label = ('weapon_advancedrifle') },
  WEAPON_MG = { item = 'weapon_mg', label = ('weapon_mg') },
  WEAPON_COMBATMG = { item = 'weapon_combatmg', label = ('weapon_combatmg') },
  WEAPON_PUMPSHOTGUN = { item = 'weapon_pumpshotgun', label = ('weapon_pumpshotgun') },
  WEAPON_SAWNOFFSHOTGUN = { item = 'weapon_sawnoffshotgun', label = ('weapon_sawnoffshotgun') },
  WEAPON_ASSAULTSHOTGUN = { item = 'weapon_assaultshotgun', label = ('weapon_assaultshotgun') },
  WEAPON_BULLPUPSHOTGUN = { item = 'weapon_bullpupshotgun', label = ('weapon_bullpupshotgun') },
  WEAPON_STUNGUN = { item = 'weapon_stungun', label = ('weapon_stungun') },
  WEAPON_SNIPERRIFLE = { item = 'weapon_sniperrifle', label = ('weapon_sniperrifle') },
  WEAPON_HEAVYSNIPER = { item = 'weapon_heavysniper', label = ('weapon_heavysniper') },
  WEAPON_REMOTESNIPER = { item = 'weapon_remotesniper', label = ('weapon_remotesniper') },
  WEAPON_GRENADELAUNCHER = { item = 'weapon_grenadelauncher', label = ('weapon_grenadelauncher') },
  WEAPON_RPG = { item = 'weapon_rpg', label = ('weapon_rpg') },
  WEAPON_MINIGUN = { item = 'weapon_minigun', label = ('weapon_minigun') },
  WEAPON_GRENADE = { item = 'weapon_grenade', label = ('weapon_grenade') },
  WEAPON_STICKYBOMB = { item = 'weapon_stickybomb', label = ('weapon_stickybomb') },
  WEAPON_SMOKEGRENADE = { item = 'weapon_smokegrenade', label = ('weapon_smokegrenade') },
  WEAPON_BZGAS = { item = 'weapon_bzgas', label = ('weapon_bzgas') },
  WEAPON_MOLOTOV = { item = 'weapon_molotov', label = ('weapon_molotov') },
  WEAPON_FIREEXTINGUISHER = { item = 'weapon_fireextinguisher', label = ('weapon_fireextinguisher') },
  WEAPON_PETROLCAN = { item = 'weapon_petrolcan', label = ('weapon_petrolcan') },
  WEAPON_BALL = { item = 'weapon_ball', label = ('weapon_ball') },
  WEAPON_SNSPISTOL = { item = 'weapon_snspistol', label = ('weapon_snspistol') },
  WEAPON_BOTTLE = { item = 'weapon_bottle', label = ('weapon_bottle') },
  WEAPON_GUSENBERG = { item = 'weapon_gusenberg', label = ('weapon_gusenberg') },
  WEAPON_SPECIALCARBINE = { item = 'weapon_specialcarbine', label = ('weapon_specialcarbine') },
  WEAPON_HEAVYPISTOL = { item = 'weapon_heavypistol', label = ('weapon_heavypistol') },
  WEAPON_BULLPUPRIFLE = { item = 'weapon_bullpuprifle', label = ('weapon_bullpuprifle') },
  WEAPON_DAGGER = { item = 'weapon_dagger', label = ('weapon_dagger') },
  WEAPON_VINTAGEPISTOL = { item = 'weapon_vintagepistol', label = ('weapon_vintagepistol') },
  WEAPON_FIREWORK = { item = 'weapon_firework', label = ('weapon_firework') },
  WEAPON_MUSKET = { item = 'musket', label = ('weapon_musket') },
  WEAPON_HEAVYSHOTGUN = { item = 'weapon_heavyshotgun', label = ('weapon_heavyshotgun') },
  WEAPON_MARKSMANRIFLE = { item = 'weapon_marksmanrifle', label = ('weapon_marksmanrifle') },
  WEAPON_HOMINGLAUNCHER = { item = 'weapon_hominglauncher', label = ('weapon_hominglauncher') },
  WEAPON_PROXMINE = { item = 'weapon_proxmine', label = ('weapon_proxmine') },
  WEAPON_SNOWBALL = { item = 'weapon_snowball', label = ('weapon_snowball') },
  WEAPON_FLAREGUN = { item = 'weapon_flaregun', label = ('weapon_flaregun') },
  WEAPON_GARBAGEBAG = { item = 'weapon_garbagebag', label = ('weapon_garbagebag') },
  WEAPON_HANDCUFFS = { item = 'weapon_handcuffs', label = ('weapon_handcuffs') },
  WEAPON_COMBATPDW = { item = 'weapon_combatpdw', label = ('weapon_combatpdw') },
  WEAPON_MARKSMANPISTOL = { item = 'weapon_marksmanpistol', label = ('weapon_marksmanpistol') },
  WEAPON_KNUCKLE = { item = 'weapon_knuckle', label = ('weapon_knuckle') },
  WEAPON_CERAMICPISTOL = { item = 'weapon_ceramicpistol', label = ('weapon_ceramicpistol') },
  WEAPON_HATCHET = { item = 'weapon_hatchet', label = ('weapon_hatchet') },
  WEAPON_MACHETE = { item = 'weapon_machete', label = ('weapon_machete') },
  WEAPON_MACHINEPISTOL = { item = 'weapon_machinepistol', label = ('weapon_machinepistol') },
  WEAPON_SWITCHBLADE = { item = 'weapon_switchblade', label = ('weapon_switchblade') },
  WEAPON_REVOLVER = { item = 'weapon_revolver', label = ('weapon_revolver') },
  WEAPON_DBSHOTGUN = { item = 'weapon_dbshotgun', label = ('weapon_dbshotgun') },
  WEAPON_COMPACTRIFLE = { item = 'weapon_compactrifle', label = ('weapon_compactrifle') },
  WEAPON_AUTOSHOTGUN = { item = 'weapon_autoshotgun', label = ('weapon_autoshotgun') },
  WEAPON_BATTLEAXE = { item = 'weapon_battleaxe', label = ('weapon_battleaxe') },
  WEAPON_COMPACTLAUNCHER = { item = 'weapon_compactlauncher', label = ('weapon_compactlauncher') },
  WEAPON_MINISMG = { item = 'weapon_minismg', label = ('weapon_minismg') },
  WEAPON_PIPEBOMB = { item = 'weapon_pipebomb', label = ('weapon_pipebomb') },
  WEAPON_POOLCUE = { item = 'weapon_poolcue', label = ('weapon_poolcue') },
  WEAPON_WRENCH = { item = 'weapon_wrench', label = ('weapon_wrench') },
  WEAPON_FLASHLIGHT = { item = 'weapon_flashlight', label = ('weapon_flashlight') },
  GADGET_NIGHTVISION = { item = 'gadget_nightvision', label = ('gadget_nightvision') },
  GADGET_PARACHUTE = { item = 'gadget_parachute', label = ('gadget_parachute') },
  WEAPON_FLARE = { item = 'weapon_flare', label = ('weapon_flare') }
}

ConfigWeapons.AmmoTypes = {
  AMMO_PISTOL = { item = 'ammo_pistol' },
  AMMO_SMG = { item = 'ammo_smg' },
  AMMO_RIFLE = { item = 'ammo_rifle' },
  AMMO_MG = { item = 'ammo_smg_large' },
  AMMO_SHOTGUN = { item = 'ammo_shotgun' },
  AMMO_SNIPER = { item = 'ammo_snp' },
  AMMO_RPG = { item = 'ammo_rpg' },
  AMMO_HOMINGLAUNCHER = { item = 'ammo_rpg' },
  AMMO_FIREWORK = { item = 'ammo_rpg' },
  AMMO_FLAREGUN = { item = 'weapon_flare' },
}

-- Braquage

Config.chance = {1, 5}

Config.timeinterval = 8000

Config.PedAccuracy = 50

Config.shops = {
    {coords = vector3(24.03, -1345.63, 28.5), heading = 266.0, money = {100, 500}, packet = {2, 6}, cooldownseconds = 60, ped = 0x4E0CE5D3},
    {coords = vector3(1697.10, 4923.20, 41.06), heading = 327.0, money = {100, 500}, packet = {2, 6}, cooldownseconds = 60, ped = 0x4E0CE5D3},
    {coords = vector3(1164.94, -323.76, 68.2), heading = 100.0, money = {100, 500}, packet = {2, 6}, cooldownseconds = 60, ped = 0x4F46D607},
    {coords = vector3(-706.06, -914.44, 18.22), heading = 91.0, money = {100, 500}, packet = {2, 6}, cooldownseconds = 60, ped = 0xA8C22996},
    {coords = vector3(372.85, 328.10, 102.56), heading = 266.0, money = {100, 500}, packet = {2, 6}, cooldownseconds = 60, ped = 0x61D201B3},
    {coords = vector3(1134.24, -983.14, 45.41), heading = 266.0, money = {100, 500}, packet = {2, 6}, cooldownseconds = 60, ped = 0x278C8CB7},
    {coords = vector3(-1221.40, -908.02, 11.32), heading = 40.0, money = {100, 500}, packet = {2, 6}, cooldownseconds = 60, ped = 0x893D6805},
    {coords = vector3(-47.39, -1758.72, 28.42), heading = 40.0, money = {100, 500}, packet = {2, 6}, cooldownseconds = 60, ped = 0xF42EE883},
    {coords = vector3(1728.62, 6416.81, 34.03), heading = 240.0, money = {100, 500}, packet = {2, 6}, cooldownseconds = 60, ped = 0x2DADF4AA},
    {coords = vector3(1959.16, 3741.52, 31.34), heading = 290.0, money = {100, 500}, packet = {2, 6}, cooldownseconds = 60, ped = 0x94562DD7},
    {coords = vector3(-2966.37, 391.57, 15.04), heading = 100.0, money = {100, 500}, packet = {2, 6}, cooldownseconds = 60, ped = 0x36E70600},
}

-- Skin

Config.BackpackWeight = {
	[40] = 16, [41] = 20, [44] = 25, [45] = 23
}

-- Status

Config.StatusMax      = 1000000
Config.TickTime       = 1000
Config.UpdateInterval = 10000

Config.Blipgarage = {

	DrawDistance = 20,

	BlipInfos = {
		Sprite = 524,
		Color = 38
	},
	
	BlipPound = {
		Sprite = 67,
		Color = 64
	}
}

Config.Garages = {
	Garage_Centre = {	
		Pos = {x = 215.789, y = -809.9736, z = 30.72888},
		Color = {r = 204, g = 204, b = 0},
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Marker = 1,
		
		SpawnPoint = {
			Pos = {x = 229.1604, y = -801.0066, z = 30.56042},
			Color = {r = 0, g = 255, b = 0},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			Marker = 36,
			Heading = 157.84
		},
		DeletePoint = {
			Pos = {x = 213.9429, y =  -795.0857, z = 30.84692},
			Color = {r = 255, g = 0, b = 0},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			Marker = 36,
			
		},
	},

		Garage_nordville = {
			Pos = {x = -1679.379, y = 74.156, z = 28.727},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Marker = 1,
			SpawnPoint = {
				Pos = {x = -1678.379, y = 73.156, z = 64.041},
				Color = {r = 0, g = 255, b = 0},
				Size = {x = 1.0, y = 1.0, z = 1.0},
				Marker = 36,
				Heading = 288.84
			},
			DeletePoint = {
				Pos = {x = -1669.502, y = 65.396, z = 63.646},
				Color = {r = 255, g = 0, b = 0},
				Size = {x = 1.0, y = 1.0, z = 1.0},
				Marker = 36,
			},
		},


		Garage_Quai = {	
			Pos = {x = 440.734, y = -1960.805, z = 21.997},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Marker = 1,
			
			SpawnPoint = {
				Pos = {x = 462.761, y = -1985.244, z = 22.940},
				Color = {r = 0, g = 255, b = 0},
				Size = {x = 1.0, y = 1.0, z = 1.0},
				Marker = 36,
				Heading = 130.84
			},
			DeletePoint = {
				Pos = {x = 446.745, y = -1965.034, z = 22.943},
				Color = {r = 255, g = 0, b = 0},
				Size = {x = 1.0, y = 1.0, z = 1.0},
				Marker = 36,
				
			},
		},

		Garage_Mid= {	
			Pos = {x = 1525.81, y = 1725.28, z = 110.98},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Marker = 1,
			
			SpawnPoint = {
				Pos = {x = 1525.81, y = 1725.28, z = 109.98},
				Color = {r = 0, g = 255, b = 0},
				Size = {x = 1.0, y = 1.0, z = 1.0},
				Marker = 36,
				Heading = 9.84
			},
			DeletePoint = {
				Pos = {x = 1532.1, y = 1711.48, z = 109.91},
				Color = {r = 255, g = 0, b = 0},
				Size = {x = 1.0, y = 1.0, z = 1.0},
				Marker = 36,
				
			},
		},

		Garage_Mid2 = {	
			Pos = {x = 319.85, y = 3405.75, z = 36.75},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Marker = 1,
			
			SpawnPoint = {
				Pos = {x = 319.85, y = 3405.75, z = 36.75},
				Color = {r = 0, g = 255, b = 0},
				Size = {x = 1.0, y = 1.0, z = 1.0},
				Marker = 36,
				Heading = 253.84
			},
			DeletePoint = {
				Pos = {x = 323.11, y = 3418.19, z = 36.63},
				Color = {r = 255, g = 0, b = 0},
				Size = {x = 1.0, y = 1.0, z = 1.0},
				Marker = 36,
				
			},
		},

		Garage_Marina = {	
			Pos = {x = -712.83, y = -1272.49, z = 5.000},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Marker = 1,
			
			SpawnPoint = {
				Pos = {x = -712.83, y = -1272.49, z = 5.000},
				Color = {r = 0, g = 255, b = 0},
				Size = {x = 1.0, y = 1.0, z = 1.0},
				Marker = 36,
				Heading = 137.777
			},
			DeletePoint = {
				Pos = {x = -707.68, y = -1276.28, z = 5.000},
				Color = {r = 255, g = 0, b = 0},
				Size = {x = 1.0, y = 1.0, z = 1.0},
				Marker = 36,
				
			},
		},

		Garage_Nord = {	
			Pos = {x = -79.81, y = 6492.13, z = 31.49},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Marker = 1,
			
			SpawnPoint = {
				Pos = {x = -79.81, y = 6492.13, z = 31.49},
				Color = {r = 0, g = 255, b = 0},
				Size = {x = 1.0, y = 1.0, z = 1.0},
				Marker = 36,
				Heading = 253.84
			},
			DeletePoint = {
				Pos = {x = -61.22, y = 6498.69, z = 31.49}, 
				Color = {r = 255, g = 0, b = 0},
				Size = {x = 1.0, y = 1.0, z = 1.0},
				Marker = 36,
				
			},
		},
} 

-- S'asseoir Chaise
Config.DrawDistance = 100

Config.Size         = {x = 1.5, y = 1.5, z = 1.5}

Config.Color        = {r = 0, g = 128, b = 255}

Config.Type         = 1

Config.coef         = 0.10

Config.Locale = 'fr'

Config.objects = {
	object = nil, ObjectVertX = nil, ObjectVertY = nil, ObjectVertZ = nil, OjbectDir = nil, isBed = nil,
	SitAnimation = 'PROP_HUMAN_SEAT_CHAIR_MP_PLAYER',
	LayBackAnimation = 'WORLD_HUMAN_SUNBATHE_BACK',
	LayStomachAnimation = 'WORLD_HUMAN_SUNBATHE',
	locations = {
		[1] = {object="v_med_bed2", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true},
		[2] = {object="v_serv_ct_chair02", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.0, direction=168.0, bed=false},
		[3] = {object="prop_off_chair_04", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		[4] = {object="prop_off_chair_03", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		[5] = {object="prop_off_chair_05", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		[6] = {object="prop_bench_01a", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		[7] = {object="v_club_officechair", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		[8] = {object="v_ilev_leath_chr", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		[9] = {object="v_corp_offchair", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		[10] = {object="v_med_emptybed", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true},
		[11] = {object="Prop_Off_Chair_01", verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		[12] = {object="gabz_pillbox_MRI_bed", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=0.0, bed=true},
		[13] = {object="gabz_pillbox_diagnostics_bed_01", verticalOffsetX=0.0, verticalOffsetY=0.2, verticalOffsetZ=-1.8, direction=0.0, bed=true},
		[14] = {object="gabz_pillbox_diagnostics_bed_02", verticalOffsetX=0.0, verticalOffsetY=0.2, verticalOffsetZ=-1.8, direction=0.0, bed=true},	
		[15] = {object="gabz_pillbox_diagnostics_bed_03", verticalOffsetX=0.0, verticalOffsetY=0.2, verticalOffsetZ=-1.8, direction=0.0, bed=true},
		[16] = {object="v_med_bed1", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true},
		[17] = {object="prop_cs_office_chair", verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		[18] = {object="v_med_cor_medstool", verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		[19] = {object="prop_chair_01a", verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false},
        [20] = {object="bs_ab_dinerchair", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=0.0, direction=0.0, bed=false},
        [21] = {object="bs_ab_burger_seat1c", verticalOffsetX=1.4, verticalOffsetY=0.0, verticalOffsetZ=0.0, direction=0.0, bed=false},
        [22] = {object="bs_ab_burger_seat2l", verticalOffsetX=1.0, verticalOffsetY=0.0, verticalOffsetZ=0.0, direction=270.0, bed=false},
        [23] = {object="bs_ab_dinerbench", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=0.0, direction=180.0, bed=false},
        [24] = {object="v_ilev_chair02_ped", verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
    }
}

-- Cayoperico

Config.Debug = false

Config.Control = {
  Key = "e",
  Name = "~INPUT_CONTEXT~"
}

Config.Cutscenes = {
  enabled = true,
  long = true
}

Config.DrawDistanceIsland = 20.0

Config.ActivationDistanceScaler = 1.2

Config.BlipIsland = {
  Sprite = 307,
  Color = 0,
  Size = 0.7,
  LosSantosName = "Voyage vers Cayo Perico",
  IslandName = "Voyage vers Los Santos",
  MinimapOnly = true
}

Config.TeleportLocationsIsland = {
  {
    LosSantosCoordinate = vector3(-1016.42, -2468.58, 12.99),
    LosSantosHeading = 233.31,
    IslandCoordinate = vector3(4425.68,-4487.06, 3.25),
    IslandHeading = 200.56
  }
}
