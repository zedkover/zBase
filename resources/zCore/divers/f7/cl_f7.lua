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

f7gang = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "F7", world = true},
    Data = { currentMenu = "Actions", GetPlayerName() },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if zedkover.name == "Mettre les menottes à l'Individu" then 
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
				else
					ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
				end
			elseif zedkover.name == "Trainer" then 
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
				else
					ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
				end
			elseif zedkover.name == "Mettre dans le véhicule" then 
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
				else
					ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
				end
			elseif zedkover.name == "Sortir du véhicule" then 
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
				else
					ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
				end
            elseif zedkover.name == "Fouiller" then 
                ExecuteCommand('fouiller')
            end
        end,
    },
    Menu = {
        ["Actions"] = {
            b = {
                {name = "Mettre les menottes à l'Individu", ask = ">", askX = true},
                {name = "Trainer", ask = ">", askX = true},
                {name = "Mettre dans le véhicule", ask = ">", askX = true},
                {name = "Sortir du véhicule", ask = ">", askX = true},
                {name = "Fouiller", ask = ">", askX = true},
            }
        }
    }
}

RegisterKeyMapping('f7gang', 'Menu F7', 'keyboard', 'F7')

RegisterCommand('f7gang', function()
    CreateMenu(f7gang)
end)