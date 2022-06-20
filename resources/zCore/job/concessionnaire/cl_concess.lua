ESX = nil
local spawn, cam, service = false, false, false
local lastVehicle, CurrentVehicleData
   
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0) 
	end
end) 

function camera() 
    local cam = {}				
    Citizen.Wait(1)
    cam = CreateCam("DEFAULT_SCRIPTED_Camera", 1)	
    SetCamCoord(cam, -32.23, -1101.78, 28.44, 0.0, 0.0, 200.455696105957, 15.0, false, 0)
    RenderScriptCams(1000, 1000, 1000, 1000, 1000) 
    PointCamAtCoord(cam, -41.2, -1097.95, 26.23)      
end 

function destorycam() 	 
    RenderScriptCams(false, false, 1000, 1000, 1000) 
    DestroyCam(cam, false)
end

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		if Config.PlateUseSpace then
			generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. ' ' .. GetRandomNumber(Config.PlateNumbers))
		else
			generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. GetRandomNumber(Config.PlateNumbers))
		end

		ESX.TriggerServerCallback('esx_vehicleshop:isPlateTaken', function (isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end

function IsPlateTaken(plate)
	local callback = 'waiting'

	ESX.TriggerServerCallback('esx_vehicleshop:isPlateTaken', function(isPlateTaken)
		callback = isPlateTaken
	end, plate)

	while type(callback) == 'string' do
		Citizen.Wait(0)
	end

	return callback
end

function GetRandomNumber(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

Catalogue = {   
	Base = { Header = {"shopui_title_ie_modgarage", "shopui_title_ie_modgarage"}, Color = {color_Green}, HeaderColor = {255, 255, 255}, Title = 'Concessionnaire'},
	Data = { currentMenu = "Listes véhicules", " "}, 
    Events = {
        onExited = function()
            ESX.Game.DeleteVehicle(lastVehicle) 
        end, 
        onSelected = function(self, _, btnData, PMenu, Data, menuData, currentMenu, currentButton, currentBtn, currentSlt, result, slide)

                 

             
 
            if self.Data.currentMenu == "Compacts" or self.Data.currentMenu == "Berlines" or self.Data.currentMenu == "Coupés" or self.Data.currentMenu == "Muscles" or self.Data.currentMenu == "Import"  or self.Data.currentMenu == "Offroad" or self.Data.currentMenu == "Sportives" or self.Data.currentMenu == "Sportives classiques" or self.Data.currentMenu == "Super-sportives" or self.Data.currentMenu == "SUVs" or self.Data.currentMenu == "Vans" or self.Data.currentMenu == "Motos" or self.Data.currentMenu == "Import" then
                ESX.TriggerServerCallback('Checkmoney', function(cb)
                    if cb then 
                        if lastVehicle then 
                            local newPlate     = GeneratePlate()
                            local vehicleProps = ESX.Game.GetVehicleProperties(lastVehicle)
                

                            vehicleProps.plate = newPlate

                
                            TriggerServerEvent('esx_vehiclelock:registerkey', vehicleProps.plate, GetPlayerServerId(PlayerId()), "no")
                
                            TriggerServerEvent('esx_vehicleshop:setVehicleOwnedPlayerId', GetPlayerServerId(PlayerId()), vehicleProps)
                            ESX.ShowNotification('~b~Concessionnaire~s~:\nVous venez d\'acheter une ~b~' ..vehicleProps.model.. '~s~. ~b~Merci de votre achat, votre véhicule vous attend dans le garage derrière.')
                            ESX.Game.DeleteVehicle(lastVehicle) 
                            ESX.Game.SpawnVehicle(vehicleProps.model, vector3(-773.3833, -234.0999, 37.0796), 200.38, function(vehicle)
                                SetVehicleNumberPlateText(vehicle, newPlate)
                                SetPedIntoVehicle(PlayerPedId(), lastVehicle, -1)   
                                SetEntityAsNoLongerNeeded(lastVehicle)
                            end)
                            lastVehicle = nil
                            CloseMenu(true)
                        end 
                    else
                        ESX.ShowNotification("~r~Vous n'avez pas assez d'argent")
                    end
                end, btnData.prix) 
            elseif self.Data.currentMenu == "Listes véhicules" and btnData.name ~= "Voir le catalogue" then 
                OpenMenu(btnData.name)    
            end

          
     

        end,
        onOpened = function(self, _, btnData, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)

            
            Catalogue.Menu["Berlines"].b, Catalogue.Menu["Compacts"].b, Catalogue.Menu["Coupés"].b, Catalogue.Menu["Muscles"].b, Catalogue.Menu["Offroad"].b, Catalogue.Menu["Sportives"].b, Catalogue.Menu["Sportives classiques"].b, Catalogue.Menu["Super-sportives"].b, Catalogue.Menu["SUVs"].b, Catalogue.Menu["Vans"].b, Catalogue.Menu["Import"].b = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
            for k, v in pairs (Config.vehicleconcessionnaire.Categories) do 
                if k == "Berlines" then
                    local myTable = v.veh 
                    for i = 1, #myTable, 1 do
                        table.insert(Catalogue.Menu["Berlines"].b, { name = GetLabelText(GetDisplayNameFromVehicleModel(myTable[i].vehName)), ask = "~b~" .. myTable[i].price .. "$", askX = true, prix = myTable[i].price, vehName = myTable[i].vehName, iterator = i })
                    end
                end
                if k == "Compacts" then
                    local myTable = v.veh
                    for i = 1, #myTable, 1 do
                        table.insert(Catalogue.Menu["Compacts"].b, { name = GetLabelText(GetDisplayNameFromVehicleModel(myTable[i].vehName)), ask = "~b~" .. myTable[i].price .. "$", askX = true, prix = myTable[i].price, vehName = myTable[i].vehName, iterator = i })
                    end
                end
                if k == "Coupés" then
                    local myTable = v.veh
                    for i = 1, #myTable, 1 do
                        table.insert(Catalogue.Menu["Coupés"].b, { name = GetLabelText(GetDisplayNameFromVehicleModel(myTable[i].vehName)), ask = "~b~" .. myTable[i].price .. "$", askX = true, prix = myTable[i].price, vehName = myTable[i].vehName, iterator = i })
                    end
                end
                if k == "Import" then
                    local myTable = v.veh
                    for i = 1, #myTable, 1 do
                        table.insert(Catalogue.Menu["Import"].b, { name = myTable[i].vehName, ask = "~b~" .. myTable[i].price .. "$", askX = true,  prix = myTable[i].price, vehName = myTable[i].vehName, iterator = i })
                    end
                end
         
                if k == "Offroad" then
                    local myTable = v.veh 
                    for i = 1, #myTable, 1 do
                        table.insert(Catalogue.Menu["Offroad"].b, { name = GetLabelText(GetDisplayNameFromVehicleModel(myTable[i].vehName)), ask = "~b~" .. myTable[i].price .. "$", askX = true, prix = myTable[i].price, vehName = myTable[i].vehName, iterator = i })
                    end
                end
                if k == "Sportives" then
                    local myTable = v.veh
                    for i = 1, #myTable, 1 do
                        table.insert(Catalogue.Menu["Sportives"].b, { name = GetLabelText(GetDisplayNameFromVehicleModel(myTable[i].vehName)), ask = "~b~" .. myTable[i].price .. "$", askX = true, prix = myTable[i].price, vehName = myTable[i].vehName, iterator = i })
                    end
                end
                if k == "Sportives classiques" then
                    local myTable = v.veh
                    for i = 1, #myTable, 1 do
                        table.insert(Catalogue.Menu["Sportives classiques"].b, { name = GetLabelText(GetDisplayNameFromVehicleModel(myTable[i].vehName)), ask = "~b~" .. myTable[i].price .. "$", askX = true, prix = myTable[i].price,  vehName = myTable[i].vehName, iterator = i })
                    end
                end
                if k == "Super-sportives" then
                    local myTable = v.veh
                    for i = 1, #myTable, 1 do
                        table.insert(Catalogue.Menu["Super-sportives"].b, { name = GetLabelText(GetDisplayNameFromVehicleModel(myTable[i].vehName)), ask = "~b~" .. myTable[i].price .. "$", askX = true, prix = myTable[i].price, vehName = myTable[i].vehName, iterator = i })
                    end
                end
                if k == "SUVs" then
                    local myTable = v.veh
                    for i = 1, #myTable, 1 do
                        table.insert(Catalogue.Menu["SUVs"].b, { name = GetLabelText(GetDisplayNameFromVehicleModel(myTable[i].vehName)), ask = "~b~" .. myTable[i].price .. "$", askX = true, prix = myTable[i].price, vehName = myTable[i].vehName, iterator = i })
                    end
                end
                if k == "Vans" then
                    local myTable = v.veh
                    for i = 1, #myTable, 1 do
                        table.insert(Catalogue.Menu["Vans"].b, { name = GetLabelText(GetDisplayNameFromVehicleModel(myTable[i].vehName)), ask = "~b~" .. myTable[i].price .. "$", askX = true, prix = myTable[i].price, vehName = myTable[i].vehName, iterator = i })
                    end 
                end  
                if k == "Motos" then
                    local myTable = v.veh 
                    for i = 1, #myTable, 1 do
                        table.insert(Catalogue.Menu["Motos"].b, { name = GetLabelText(GetDisplayNameFromVehicleModel(myTable[i].vehName)), ask = "~b~" .. myTable[i].price .. "$", askX = true, prix = myTable[i].price, vehName = myTable[i].vehName, iterator = i })
                    end 
                end
            end
        end,
      
    
		onButtonSelected = function(currentMenu, currentBtn, menuData, newButtons, self)
      
            if currentMenu == "Berlines" then 
                for k, v in pairs(Catalogue.Menu["Berlines"].b) do 
                    if currentBtn == v.iterator then 
           
                        ESX.Game.SpawnLocalVehicle(v.vehName, vector3(-783.5691, -223.9343, 37.3215), 31.2812, function(vehicle)     
                            lastVehicle = vehicle
                            SetEntityAsNoLongerNeeded(vehicle) 
                            FreezeEntityPosition(vehicle, true)
                        end)
                    end
                end
            end

            if currentMenu == "Import" then 
                for k, v in pairs(Catalogue.Menu["Import"].b) do 
                    if currentBtn == v.iterator then 
           
                        ESX.Game.SpawnLocalVehicle(v.vehName, vector3(-783.5691, -223.9343, 37.3215), 31.2812, function(vehicle)     
                            lastVehicle = vehicle
                            SetEntityAsNoLongerNeeded(vehicle) 
                            FreezeEntityPosition(vehicle, true)
                        end)
                    end
                end
            end

        
  
            if currentMenu == "Compacts" then 
                for k, v in pairs(Catalogue.Menu["Compacts"].b) do 
                    if currentBtn == v.iterator then               
                        ESX.Game.SpawnLocalVehicle(v.vehName, vector3(-783.5691, -223.9343, 37.3215), 31.2812, function(vehicle)
                            lastVehicle = vehicle
                            SetEntityAsNoLongerNeeded(vehicle)
                            FreezeEntityPosition(vehicle, true)
                        end)
                    end
                end
            end
      
 
            if currentMenu == "Coupés" then 
                for k, v in pairs(Catalogue.Menu["Coupés"].b) do 
                    if currentBtn == v.iterator then 
                        ESX.Game.SpawnLocalVehicle(v.vehName, vector3(-783.5691, -223.9343, 37.3215), 31.2812, function(vehicle)
                            lastVehicle = vehicle
                            SetEntityAsNoLongerNeeded(vehicle)
                            FreezeEntityPosition(vehicle, true)
                        end)
                    end
                end
            end
 
            if currentMenu == "Muscles" then 
                for k, v in pairs(Catalogue.Menu["Muscles"].b) do 
                    if currentBtn == v.iterator then 
                        ESX.Game.SpawnLocalVehicle(v.vehName, vector3(783.5691, -223.9343, 37.3215), 31.2812, function(vehicle)
						    lastVehicle = vehicle
                            SetEntityAsNoLongerNeeded(vehicle) 
                            FreezeEntityPosition(vehicle, true)
                        end)
                    end
                end
            end
 
            if currentMenu == "Offroad" then 
                for k, v in pairs(Catalogue.Menu["Offroad"].b) do 
                    if currentBtn == v.iterator then 
                        ESX.Game.SpawnLocalVehicle(v.vehName, vector3(-783.5691, -223.9343, 37.3215), 31.2812, function(vehicle)
						                            lastVehicle = vehicle
                            SetEntityAsNoLongerNeeded(vehicle)
                            FreezeEntityPosition(vehicle, true) 
                        end)
                    end
                end
            end
 
            if currentMenu == "Sportives" then 
                for k, v in pairs(Catalogue.Menu["Sportives"].b) do 
                    if currentBtn == v.iterator then 
                        ESX.Game.SpawnLocalVehicle(v.vehName, vector3(-783.5691, -223.9343, 37.3215), 31.2812, function(vehicle)
						                            lastVehicle = vehicle
                            SetEntityAsNoLongerNeeded(vehicle)
                            FreezeEntityPosition(vehicle, true)
                        end)
                    end
                end
            end
 
            if currentMenu == "Sportives classiques" then 
                for k, v in pairs(Catalogue.Menu["Sportives classiques"].b) do 
                    if currentBtn == v.iterator then 
                        ESX.Game.SpawnLocalVehicle(v.vehName, vector3(-783.5691, -223.9343, 37.3215), 31.2812, function(vehicle)
						                            lastVehicle = vehicle
                            SetEntityAsNoLongerNeeded(vehicle)
                            FreezeEntityPosition(vehicle, true)
                        end)
                    end
                end
            end
 
            if currentMenu == "Super-sportives" then 
                for k, v in pairs(Catalogue.Menu["Super-sportives"].b) do 
                    if currentBtn == v.iterator then 
                        ESX.Game.SpawnLocalVehicle(v.vehName, vector3(-783.5691, -223.9343, 37.3215), 31.2812, function(vehicle)
						                            lastVehicle = vehicle
                            SetEntityAsNoLongerNeeded(vehicle)
                            FreezeEntityPosition(vehicle, true)
                        end)
                    end
                end
            end
 
            if currentMenu == "SUVs" then 
                for k, v in pairs(Catalogue.Menu["SUVs"].b) do 
                    if currentBtn == v.iterator then 
                        ESX.Game.SpawnLocalVehicle(v.vehName, vector3(-783.5691, -223.9343, 37.3215), 31.2812, function(vehicle)
						                            lastVehicle = vehicle
                            SetEntityAsNoLongerNeeded(vehicle)
                            FreezeEntityPosition(vehicle, true)
                        end)
                    end
                end
            end
 
            if currentMenu == "Vans" then 
                for k, v in pairs(Catalogue.Menu["Vans"].b) do 
                    if currentBtn == v.iterator then 
                        ESX.Game.SpawnLocalVehicle(v.vehName, vector3(-783.5691, -223.9343, 37.3215), 31.2812, function(vehicle)
						                            lastVehicle = vehicle
                            SetEntityAsNoLongerNeeded(vehicle)
                            FreezeEntityPosition(vehicle, true)
                        end) 
                    end
                end
            end

            if currentMenu == "Motos" then 
                for k, v in pairs(Catalogue.Menu["Motos"].b) do 
                    if currentBtn == v.iterator then 
                       
                        ESX.Game.SpawnLocalVehicle(v.vehName, vector3(-783.5691, -223.9343, 37.3215), 31.2812, function(vehicle)
						                            lastVehicle = vehicle
                            SetEntityAsNoLongerNeeded(vehicle)
                            FreezeEntityPosition(vehicle, true)
                        end)
                    end
                end
            end


            
 
        end,
	},  
	Menu = { 
		["Listes véhicules"] = {
            b = { 
                { name = "Berlines", ask = ">", askX = true },
                { name = "Compacts", ask = ">", askX = true },
                { name = "Coupés", ask = ">", askX = true },
                { name = "Muscles", ask = ">", askX = true },
                { name = "Offroad", ask = ">", askX = true },
                { name = "Sportives", ask = ">", askX = true },
                { name = "Sportives classiques", ask = ">", askX = true },
                { name = "Super-sportives", ask = ">", askX = true },
                { name = "SUVs", ask = ">", askX = true },
                
            }
        },
		["Compacts"] = {
            b = {}
        },
        ["Liste vehicule"] = {
            b = {}
        },
        ["Coupés"] = {
            b = {}
        },
        ["Motos"] = { 
            b = {}
        },
        ["Muscles"] = { 
            b = {}
        }, 
        ["Offroad"] = {
            b = {}
        }, 
   
        ["Import"] = {
            b = {}
        },
        ["Sportives classiques"] = {
            b = {}
        },
        ["Sportives"] = {
            b = {}
        },
        ["Super-sportives"] = {
            b = {}
        },
        ["Vans"] = {
            b = {}
        },
        ["Berlines"] = { 
            b = {}
        },
        ["SUVs"] = {
            b = {}
        },  
        ["Garageconcess"] = {
            b = {}
        }    
	}
}  

Citizen.CreateThread(function()  
    while true do  
        Citizen.Wait(0)  
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false) 
        local dist = Vdist(plyCoords, -783.8572, -224.4906, 37.3215)
        if dist < 4 then 
            ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour accéder ~b~au catalogue')
            if IsControlJustPressed(0, 51) then 
                CreateMenu(Catalogue)
            end 
        end     
    end   
end)     