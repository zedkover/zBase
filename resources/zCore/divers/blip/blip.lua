local listblip = {
	{"~p~Galaxy", vector3(355.36, 302.52, 3103.76), 93, 8, 0.7},
	{"~y~Hippodromes", vector3(1147.6693115234,119.81089019775,81.822616577148), 309, 24, 0.7},
	{"~p~Fête foraine", vector3(-1667.8676757813,-1085.9140625,17.600215911865), 266, 27, 0.7},
	{"~c~CarWash", vector3(-700.01,-921.57,19.01), 100, 0, 0.7},
    {"Banque", vector3(150.266, -1040.203,29.374), 108, 2, 0.7},
    {"Banque", vector3(-1212.980,-330.841,37.787), 108, 2, 0.7},
    {"Banque", vector3(-2962.582,482.627,15.703), 108, 2, 0.7},
    {"Banque", vector3(-112.202,6469.295,31.626), 108, 2, 0.7},
    {"Banque", vector3(314.187,-278.621,54.170), 108, 2, 0.7},
	{"~c~Driving School", vector3(231.5209, 363.9297, 105.8455), 408, 0, 0.7},
	{"~r~Ammunation LS", vector3(22.20659, -1106.822, 29.7854), 313, 1, 0.7},
	{"~p~Unicorn", vector3(128.2418, -1296.686, 29.26306), 121, 27, 0.7},
	{"~g~Irish Pub", vector3(842.85, -114.61, 79.77), 93, 2, 0.7},
	{"~b~Pillbox Hill Medical Center", vector3(293.15, -582.15, 43.19), 61, 3, 0.7},
	{"~c~Herr Kutz Barber", vector3(138.20, -1708.28, 29.30), 71, 62, 0.7},
	{"~g~Car Dealer", vector3(-794.32, -218.61, 37.08), 326, 11, 0.7},
	{"~b~Los Santos Police Department", vector3(442.44, -982.85, 30.68), 60, 3, 0.7},
	{"~r~Blazing Tattoo", vector3(321.56, 180.38, 103.58), 75, 1, 0.7},
	{"~g~Location Vélo", vector3(-505.1868, -670.4967, 33.08789), 480, 11, 0.7},
	{"Reseller Pêche", vector3(-413.5385, -2699.618, 5.993408), 480, 18, 0.7},
	{"~r~BurgerShot", vector3(-1186.352, -886.5231, 13.98022), 52, 1, 0.7},
	{"PawnShop", vector3(-1459.451, -413.6044, 35.75024), 566, 46, 0.7},
}

function createBlip(vector3Pos, intSprite, intColor, stringText, boolRoad, floatScale, intDisplay, intAlpha)
	local blip = AddBlipForCoord(vector3Pos.x, vector3Pos.y, vector3Pos.z)
	SetBlipSprite(blip, intSprite)
	SetBlipAsShortRange(blip, true)
	if intColor then 
		SetBlipColour(blip, intColor) 
	end
	if floatScale then 
		SetBlipScale(blip, floatScale) 
	end
	if boolRoad then 
		SetBlipRoute(blip, boolRoad) 
	end
	if intDisplay then 
		SetBlipDisplay(blip, intDisplay) 
	end
	if intAlpha then 
		SetBlipAlpha(blip, intAlpha) 
	end
	if stringText and (not intDisplay or intDisplay ~= 8) then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(stringText)
		EndTextCommandSetBlipName(blip)
	end
	return blip
end

function InitiateBlip()
	for _, v in pairs(listblip) do
        createBlip(v[2] ,v[3],v[4],v[1],false,v[5])
    end
end

InitiateBlip()