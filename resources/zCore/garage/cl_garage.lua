ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
    PlayerData = ESX.GetPlayerData() 
    refreshBlips()
end)

RegisterNetEvent('esx:setJob') 
AddEventHandler('esx:setJob', function(job)       
    PlayerData.job = job        
    Citizen.Wait(5000) 
end)

RegisterNetEvent('zkgarage:rangementgarage') 
AddEventHandler('zkgarage:rangementgarage', function() 
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    local plaque = GetVehicleNumberPlateText(vehicle)
    local props = ESX.Game.GetVehicleProperties(vehicle) 
    TriggerServerEvent("zkgarage:up", 1, plaque)    
    TriggerServerEvent("zkgarage:name", plaque)
    TriggerServerEvent("zkgarage:change", props, plaque)
    TriggerEvent('esx:deleteVehicle')  
end)


Garage = {   
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_Green}, HeaderColor = {255, 255, 255}, Title = 'GARAGE'},
	Data = { currentMenu = "Garage", GetPlayerName()},
    Events = {
		onSelected = function(self, _, zkgarage, PMenu, Data, menuData, currentMenu, currentButton, currentBtn, currentSlt, result, slide)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) 
            if self.Data.currentMenu == "Garage" then 
                TriggerServerEvent("zkgarage:up", 0, zkgarage.plate)
                CloseMenu(true)
     
                ESX.Game.SpawnVehicle(zkgarage.value, {x = this_Garage.SpawnPoint.Pos.x,y = this_Garage.SpawnPoint.Pos.y,z = this_Garage.SpawnPoint.Pos.z + 1}, this_Garage.SpawnPoint.Heading, function(vehicle)
                    ESX.Game.SetVehicleProperties(vehicle, zkgarage.auto)  
                    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)       
                    -- SetVehicleNumberPlateText(vehicle, zkgarage.plaque) 
				end)     
			end
        end,     
	}, 
	Menu = { 
		["Garage"] = {
			b = {    
			}  
		},
	} 
}  
 
repa = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_Green}, HeaderColor = {255, 255, 255}, Title = 'Garage'},
    Data = { currentMenu = "Garage", GetPlayerName()},
    Events = {
        onSelected = function(self, _, zkgarage, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            if self.Data.currentMenu == "Garage ranger" then
                TriggerServerEvent("zkgarage:payementgarage", zkgarage.geld)
                CloseMenu(true)
            end
        end,
    },
    Menu = { 
        ["Garage ranger"] = {
            b = {
            }
        },
    }
}  


function saveveh()
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    local plaque = GetVehicleNumberPlateText(vehicle)
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle) 
    local model = GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))
    local vh = GetDisplayNameFromVehicleModel(model)  
    local engineHealth = GetVehicleEngineHealth(vehicle)
  if engineHealth < 950 then          
    repa.Menu["Garage ranger"].b = {}
      local payement = math.floor((1000 - engineHealth) * 4)  
        table.insert(repa.Menu["Garage ranger"].b, {name = 'Payement ~g~'..payement..'$', Description = "Votre voiture est trop endommagé", askX = true, geld = payement})  
        CreateMenu(repa)    
        OpenMenu('Garage ranger')      
  else 
        TriggerEvent("zkgarage:rangementgarage")
    end
end 
 
fourriere = {   
	Base = { Header = {"shopui_title_carmod2", "shopui_title_carmod2"}, Color = {color_Green}, HeaderColor = {255, 255, 255}},
	Data = { currentMenu = "Fourriere", GetPlayerName()},
    Events = { 
		onSelected = function(self, _, zkgarage, PMenu, Data, menuData, currentMenu, currentButton, currentBtn, currentSlt, result, slide)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) 
            if self.Data.currentMenu == "Fourriere" then  
                print(zkgarage.value)   
                    if PlayerData.job.name == "lscustom" then 
                            ESX.Game.SpawnVehicle(zkgarage.value, vector3(714.211, -1086.857, 22.33777), 458.42, function(vehicle)
                                ESX.Game.SetVehicleProperties(vehicle, zkgarage.auto)  
                                SetVehicleNumberPlateText(vehicle, zkgarage.plaque)
                                CloseMenu(true)
                            end)
                    elseif PlayerData.job.name == "police" then  
                    ESX.Game.SpawnVehicle(zkgarage.value, vector3(449.68, -1025.53, 27.58), 13.74, function(vehicle)
                        ESX.Game.SetVehicleProperties(vehicle, zkgarage.auto)  
                        SetVehicleNumberPlateText(vehicle, zkgarage.plaque)
                        CloseMenu(true)
                    end)
                end
            end
        end,     
	}, 
	Menu = { 
		["Fourriere"] = {
			b = {    
			}  
		},
	} 
}  



----

Citizen.CreateThread(function()

    while true do
		Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
  
        for k, v in pairs(Config.Garages) do
            if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
   
                if IsPedOnFoot(PlayerPedId()) then
                DrawMarker(v.SpawnPoint.Marker, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.SpawnPoint.Size.x, v.SpawnPoint.Size.y, v.SpawnPoint.Size.z, v.SpawnPoint.Color.r, v.SpawnPoint.Color.g, v.SpawnPoint.Color.b, 100, false, true, 2, true, false, false, false)
                elseif not IsPedOnFoot(PlayerPedId()) then
                DrawMarker(v.DeletePoint.Marker, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.DeletePoint.Size.x, v.DeletePoint.Size.y, v.DeletePoint.Size.z, v.DeletePoint.Color.r, v.DeletePoint.Color.g, v.DeletePoint.Color.b, 100, false, true, 2, true, false, false, false)
                end
            end
        end
    end
end)
local del = true
 
Citizen.CreateThread(function() 
    local currentZone = 'garage' 
    while true do
        Wait(0)
         
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local isInMarker = false
        for _, v in pairs(Config.Garages) do
            if (GetDistanceBetweenCoords(coords, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, true) < v.Size.x) and IsPedOnFoot( PlayerPedId()) then
				isInMarker = true
				ESX.ShowHelpNotification('~INPUT_PICKUP~ pour accéder a votre garage ~b~personelle')
				if IsControlJustPressed(0, 38) then
                    garage()
				end
                this_Garage = v
				currentZone = 'spawn'
			else    
            end
            if (GetDistanceBetweenCoords(coords, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, true) < v.Size.x) and not IsPedOnFoot( PlayerPedId())then
                isInMarker = true
                this_Garage = v 
				currentZone = 'delete'
				ESX.ShowHelpNotification('~INPUT_PICKUP~ pour ranger votre vehicule ~b~dans le garage')
				if IsControlJustPressed(1, 38) then 
                    del = false 
                    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                    local plaque = GetVehicleNumberPlateText(vehicle) 
        
                    ESX.TriggerServerCallback('esx_vehicleshop:giveBackVehicle', function(isRentedVehicle)
                        if isRentedVehicle then
                            ESX.ShowNotification('~r~Ce vehicule vous appartient pas.')
                            else
                            saveveh()  
                        end  
                    end, plaque) 
					isInMarker = false  
				end
            end
        end
        if isInMarker and not hasAlreadyEnteredMarker then
            hasAlreadyEnteredMarker = true
            LastZone = currentZone
            TriggerEvent('eden_garage:hasEnteredMarker', currentZone)
        end
        if not isInMarker and hasAlreadyEnteredMarker then
            hasAlreadyEnteredMarker = false
            TriggerEvent('eden_garage:hasExitedMarker', LastZone)
        end
    end
end)


function fourrier()
    fourriere.Menu["Fourriere"].b = {} 
    ESX.TriggerServerCallback('cacaacc', function(zkgarage)
        for k,v in pairs(zkgarage) do 
            local vehicleName = GetDisplayNameFromVehicleModel(v.vehicle.model) 
         
          if v.state == 0 then             
            table.insert(fourriere.Menu["Fourriere"].b,  {name = '[~b~'..v.plate..'~s~] - '..vehicleName..'', ask = v.name, askX = true, auto = v.vehicle, plaque = v.plate, value = v.vehicle.model})
          end
        end   
        CreateMenu(fourriere) 
    end)
end

function garage() 
    Garage.Menu["Garage"].b = {} 
    ESX.TriggerServerCallback('eden_garage:getVehicles', function(vehicles)
        for k,v in pairs(vehicles) do           
            local hashVehicule = v.vehicle.model
            local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule) 
            local labelvehicle 
            if v.state then
                labelvehicle = '~b~Garage~s~', GetLabelText(vehicleName) 
            else
                labelvehicle = '~o~Sorti du garage~s~', GetLabelText(vehicleName)   
            end
            print(v.state) 
            if v.state == 0 then 
                table.insert(Garage.Menu["Garage"].b,  {name = "[~o~Sorti du garage~s~] - "..vehicleName.."", ask = "→", askX = true, Description = "Votre vehicule est sûrement a la fourriere (allez chez le mécano / lspd)"})
            else 
                table.insert(Garage.Menu["Garage"].b,  {name = "["..labelvehicle.."]  - "..vehicleName.."", ask = "→", askX = true, Description = "Plaque [~g~"..v.plate.."~s~]", value = hashVehicule, plate = v.vehicle.plate, auto = v.vehicle, labelvehicle = labelvehicle})
            end
        end   
        CreateMenu(Garage)        
    end)       
end
 
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
    refreshBlips()
end)

function refreshBlips()
    local zones = {} 
    local blipInfo = {}
    for zoneKey, zoneValues in pairs(Config.Garages) do
        local blip = AddBlipForCoord(zoneValues.Pos.x, zoneValues.Pos.y, zoneValues.Pos.z)
        SetBlipSprite(blip, Config.Blipgarage.BlipInfos.Sprite)
        SetBlipDisplay(blip, 3)
        SetBlipScale(blip, 0.6)
        SetBlipColour(blip, Config.Blipgarage.BlipInfos.Color)
        SetBlipAsShortRange(blip, true) 
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Garage")
        EndTextCommandSetBlipName(blip)
    end
end