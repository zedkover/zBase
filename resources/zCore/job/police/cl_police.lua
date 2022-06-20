ESX = nil
local PlayerData = {}
local target = nil

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function(t)
	local ped = GetPlayerPed(t)
	ClearPedTasksImmediately(ped)
	plyPos = GetEntityCoords(PlayerPedId(),  true)
	local xnew = plyPos.x+2
	local ynew = plyPos.y+2

	SetEntityCoords(PlayerPedId(), xnew, ynew, plyPos.z)
end) 

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function()

  local playerPed = PlayerPedId()
  local coords    = GetEntityCoords(playerPed)

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)

    if DoesEntityExist(vehicle) then

      local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
      local freeSeat = nil

      for i=maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle, i) then
          freeSeat = i
          break
        end
      end

      if freeSeat ~= nil then
        TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
      end

    end

  end

end)

RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(cop)
	IsDragged = not IsDragged
	CopPed = tonumber(cop)

end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsHandcuffed then
			if IsDragged then
				local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
				local myped = PlayerPedId()
				AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
			else
				DetachEntity(PlayerPedId(), true, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function()
	IsHandcuffed    = not IsHandcuffed
	local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		if IsHandcuffed then

			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(100)
			end

			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
		
		else
			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			FreezeEntityPosition(playerPed, false)
		end
	end)

end)

RegisterNetEvent('renfort:setBlip')
AddEventHandler('renfort:setBlip', function(coords, raison)
	if raison == 'petit' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowAdvancedNotification('Centrale', '~b~Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-2\n~w~Importance: ~g~Légère.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		color = 2
	elseif raison == 'importante' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowAdvancedNotification('Centrale', '~b~Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-3\n~w~Importance: ~o~Importante.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		color = 47
	elseif raison == 'omgad' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		PlaySoundFrontend(-1, "FocusIn", "HintCamSounds", 1)
		ESX.ShowAdvancedNotification('Centrale', '~b~Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-99\n~w~Importance: ~r~URGENTE !\nDANGER IMPORTANT', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "FocusOut", "HintCamSounds", 1)
		color = 1
	end
	local blipId = AddBlipForCoord(coords)
	SetBlipSprite(blipId, 161)
	SetBlipScale(blipId, 1.2)
	SetBlipColour(blipId, color)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Demande renfort')
	EndTextCommandSetBlipName(blipId)
	Wait(80 * 1000)
	RemoveBlip(blipId)
end)


garagelspd = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Garage LSPD", world = true},
    Data = { currentMenu = "Action", GetPlayerName() },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if self.Data.currentMenu == "Action" and zedkover.name ~= "Ranger le vehicule" then 
                TriggerEvent('esx:deleteVehicle')  
                ESX.Game.SpawnVehicle(zedkover.value, {x = Config.Spawngaragelspd.x,y = Config.Spawngaragelspd.y, z =  Config.Spawngaragelspd.z + 1}, Config.Spawngaragelspd.a, function(vehicle)
                    SetPedIntoVehicle(PlayerPedId(), vehicle, -1) 
                    local plate = GetVehicleNumberPlateText(vehicle)
                    TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate)           
				end)  
            end 
            if zedkover.name == "Ranger le vehicule" then 
                TriggerEvent('esx:deleteVehicle')  
            end 
        end,
    },
    Menu = {
        ["Action"] = {
            b = {
                {name = "Ranger le vehicule", ask = ">", askX = true, id = 33},
            }
        },
        ["Ranger le vehicule"] = { b = {} },
    }
}

function opengaragelspd()
    garagelspd.Menu["Action"].b = {}
    for k, v in pairs(Config.carslspd) do
        table.insert(garagelspd.Menu["Action"].b, {name = v.label, value = v.name})
    end
    table.insert(garagelspd.Menu["Action"].b, {name = "Ranger le vehicule"})
    CreateMenu(garagelspd)
end 

f6police = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "LSPD", world = true},
    Data = { currentMenu = "Action", GetPlayerName() },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if zedkover.name == "Effectuer une annonce" then 
                local result = KeyboardInput('', '', 255)
                if result ~= nil then 
                    TriggerServerEvent('zedkover:annoncepolice', result)
                end
            elseif zedkover.name == "Crocheter le véhicule" then
                crochetagevehicle()
            elseif zedkover.name == "Mettre le véhicule en fourrière" then
                fourrierevehicle()
            elseif zedkover.name == "Actions véhicules" then 
                OpenMenu("Actions véhicules")
            elseif zedkover.name == "Actions civils" then 
                OpenMenu("Actions civils")
            elseif zedkover.name == "Mettre une ammende" then 
                CreateFacture("society_police")
            elseif zedkover.name == "Demande de Renfort" then
                OpenMenu('Renfort')
            elseif zedkover.name == "Petite demande" then
                local raison = 'petit'
                local elements  = {}
                local playerPed = PlayerPedId()
                local coords  = GetEntityCoords(playerPed)
                local name = GetPlayerName(PlayerId())
                TriggerServerEvent('renfort', coords, raison)
            elseif zedkover.name == "Demande importante" then
                local raison = 'importante'
                local elements  = {}
                local playerPed = PlayerPedId()
                local coords  = GetEntityCoords(playerPed)
                local name = GetPlayerName(PlayerId())
                TriggerServerEvent('renfort', coords, raison)
            elseif zedkover.name == "Toute les unitées demandé" then
                local raison = 'omgad'
                local elements  = {}
                local playerPed = PlayerPedId()
                local coords  = GetEntityCoords(playerPed)
                local name = GetPlayerName(PlayerId())
                TriggerServerEvent('renfort', coords, raison)
            elseif zedkover.name == "Mettre les menottes à l'Individu" then 
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
				else
					ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
				end
			elseif zedkover.name == "Escorter l'Individu" then 
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
				else
					ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
				end
			elseif zedkover.name == "Mettre individu dans le véhicule" then 
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
				else
					ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
				end
			elseif zedkover.name == "Sortir individu dans le véhicule" then 
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
				else
					ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
				end
            elseif zedkover.name == "Donner le PPA" and PlayerData.job.grade_name == 'boss' then 
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					TriggerServerEvent('11_controlLicense', 'ppa', true)
				else
					ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
				end
            end
        end,
    },
    Menu = {
        ["Action"] = {
            b = {
                {name = "Mettre une ammende", ask = ">", askX = true},
                {name = "Effectuer une annonce", ask = ">", askX = true},
                {name = "Actions véhicules", ask = ">", askX = true},
                {name = "Actions civils", ask = ">", askX = true},
                {name = "Demande de Renfort", ask = ">", askX = true},
            }
        },
        ["Actions véhicules"] = {
            b = {
                {name = "Mettre le véhicule en fourrière", ask = ">", askX = true},
                {name = "Crocheter le véhicule", ask = ">", askX = true},
            }
        },
        ["Actions civils"] = {
            b = {
                {name = "Mettre les menottes à l'Individu", ask = ">", askX = true},
                {name = "Escorter l'Individu", ask = ">", askX = true},
                {name = "Mettre individu dans le véhicule", ask = ">", askX = true},
                {name = "Sortir individu dans le véhicule", ask = ">", askX = true},
                {name = "Donner le PPA", ask = ">", askX = true},
            }
        },
		["Renfort"] = {
			b = {
				{name = "Petite demande", ask = "→", askX = true},
				{name = "Demande importante", ask = "→", askX = true},
				{name = "Toute les unitées demandé", ask = "→", askX = true}
			}
		}
    }
}

vestiairelspd = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = { 255, 255, 255}, Title = 'Vestiaire', world = true},
    Data = { currentMenu = "Accès au casier de la LSPD", "    " },
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, playerPed)
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            local slide = btn.slidenum
            local btn = btn.name
            local check = btn.unkCheckbox
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

            if btn == 'Uniforme manches longues' then 
                TriggerServerEvent('tenuelongue')
            elseif btn == 'Uniforme manches courtes' then 
                TriggerServerEvent('tenuecourte')
            elseif btn == 'Uniforme cérémonie' then 
                TriggerServerEvent('tenuecere')
            elseif btn == 'Uniforme moto' then 
                TriggerServerEvent('tenuemoto')
            elseif btn == 'Uniforme vélo' then 
                TriggerServerEvent('tenuevelo')
            elseif btn == 'Uniforme pilote' then 
                TriggerServerEvent('tenuepilote')
            end
        end
    },

    Menu = {
        ["Accès au casier de la LSPD"] = {
            b = {
                {name = "Uniforme manches longues", askX = true},
                {name = "Uniforme manches courtes", askX = true},
                {name = "Uniforme cérémonie", askX = true},
                {name = "Uniforme moto", askX = true},
                {name = "Uniforme vélo", askX = true},
                {name = "Uniforme pilote", askX = true},
            }
        },
    }
}


Citizen.CreateThread(function()

    RequestModel(GetHashKey("s_m_y_cop_01"))
    while not HasModelLoaded(GetHashKey("s_m_y_cop_01")) do 
        Wait(1) 
    end
    ped = CreatePed(4, "s_m_y_cop_01", Config.Pedgaragelspd.x, Config.Pedgaragelspd.y, Config.Pedgaragelspd.z, false, true)
    FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
    SetEntityHeading(ped, Config.Pedgaragelspd.a) 
    SetBlockingOfNonTemporaryEvents(ped, true)

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()  



    while true do
        time = 200
            if PlayerData.job.name == "police" then 
                time = 35
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local distgaragelspd = Vdist(plyCoords, 458.78, -1008.14, 28.26-0.93)
            local distvestiairelspd = Vdist(plyCoords, 452.23, -992.80, 30.68-0.93)
            local distfourrierelspd = Vdist(plyCoords, 458.3736, -1024.062, 28.37-0.93)
                if distvestiairelspd < 30 then
                    time = 0
                    DrawMarker(25, 452.23, -992.80, 30.68-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false) 
                end
                if distfourrierelspd < 30 then
                    time = 0
                    DrawMarker(25, 458.3736, -1024.062, 28.37-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false) 
                end
                if distgaragelspd <= 1.5 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~garage LSPD")
                    if IsControlJustPressed(1,51) then
                        opengaragelspd()
                    end
                elseif distvestiairelspd <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~Vestiare LSPD")
                    if IsControlJustPressed(1,51) then
                        CreateMenu(vestiairelspd)
                    end
                elseif distfourrierelspd <= 1.5 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder à la ~b~fourrière LSPD")
                    if IsControlJustPressed(1,51) then
                        fourrier()
                    end
                end
        end
        Citizen.Wait(time)
    end
end)

RegisterKeyMapping('lspd', 'Menu LSPD', 'keyboard', 'F6')

RegisterCommand('lspd', function()
    if PlayerData.job.name == "police" then 
        CreateMenu(f6police)
    end    
end)

function isPlayerOnline(PID)
local playerExists = DoesEntityExist(GetPlayerPed(GetPlayerFromServerId(PID)))
return playerExists
end

Citizen.CreateThread(function()
while true do
    Citizen.Wait(0)
	if IsControlJustPressed(1, 58) then
		if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
			TriggerEvent('NoSiren')
		end
	end
end
end)

Citizen.CreateThread(function()
while true do
    Citizen.Wait(2000)
	local Ped = GetPlayerPed(-1)
	if IsPedInAnyVehicle(Ped, true) then
		local Veh = GetVehiclePedIsIn(Ped, false)

			local PF = GetVehiclePaintFade(Veh)
			local Toggle = false
			if PF < 0.04 then
				Toggle = true
			end
			TriggerServerEvent('SilentSiren', Toggle)
    end
end
end)

AddEventHandler('NoSiren', function()
Citizen.CreateThread(function()
	local Ped = GetPlayerPed(-1)
	if IsPedInAnyVehicle(Ped, true) then
		local Veh = GetVehiclePedIsIn(Ped, false)

		if GetPedInVehicleSeat(Veh, -1) == Ped then

			local OldPF = GetVehiclePaintFade(Veh)
			local Toggle = false
			if OldPF < 0.04 then
				Toggle = true
			end

			local PF = 0.1
			if not Toggle then
				PF = 0.0
			end

			SetVehiclePaintFade(Veh, PF)
			TriggerServerEvent('SilentSiren', not Toggle)
		end
	end

end)
end)

RegisterNetEvent('updateSirens')
AddEventHandler('updateSirens', function(PID, Toggle)
if isPlayerOnline(PID) then
local Veh = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(PID)), false)
DisableVehicleImpactExplosionActivation(Veh, Toggle)
end
end)
