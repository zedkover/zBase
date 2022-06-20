ESX = nil
local PlayerData = {}

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

RegisterNetEvent('tenuelongue:usetenue')
AddEventHandler('tenuelongue:usetenue', function()
  if not UseTenu then

    cleanPlayer(playerPed)
    local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
    ESX.Streaming.RequestAnimDict(dict)
    TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(6500)
    
    TriggerEvent('skinchanger:getSkin', function(skin)

      if skin.sex == 0 then
		ExecuteCommand('me change sa tenue.')
		local clothesSkin = {
			['tshirt_1'] = 25, ['tshirt_2'] = 0,
			['torso_1'] = 105, ['torso_2'] = 0,
			['arms'] = 4,
			['pants_1'] = 50, ['pants_2'] = 0,
			['shoes_1'] = 32, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		  else
			ExecuteCommand('me change sa tenue.')
			local clothesSkin = {
				['tshirt_1'] = 15, ['tshirt_2'] = 0,
				['torso_1'] = 83, ['torso_2'] = 0,
				['arms'] = 0,
				['pants_1'] = 41, ['pants_2'] = 0,
			    ['shoes_1'] = 31, ['shoes_2'] = 0,
				['helmet_1'] = -1, ['helmet_2'] = 0,
			}
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
      end
      local playerPed = GetPlayerPed(-1)
      ClearPedBloodDamage(playerPed)
      ResetPedVisibleDamage(playerPed)
      ClearPedLastWeaponDamage(playerPed)
    end)
  else

    TriggerEvent('skinchanger:getSkin', function(skin)

      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, hasSkin)

        if hasSkin then

          cleanPlayer(playerPed)
          local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
          ESX.Streaming.RequestAnimDict(dict)
          TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
		  Citizen.Wait(6500)

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end
  UseTenu = not UseTenu
end)

RegisterNetEvent('tenuecourte:usetenue')
AddEventHandler('tenuecourte:usetenue', function()
  if not UseTenu then

    cleanPlayer(playerPed)
    local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
    ESX.Streaming.RequestAnimDict(dict)
    TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(6500)
    
    TriggerEvent('skinchanger:getSkin', function(skin)

      if skin.sex == 0 then
		ExecuteCommand('me change sa tenue.')
		local clothesSkin = {
			['tshirt_1'] = 25, ['tshirt_2'] = 0,
			['torso_1'] = 105, ['torso_2'] = 0,
			['arms'] = 4,
			['pants_1'] = 50, ['pants_2'] = 0,
			['shoes_1'] = 32, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		  else
			ExecuteCommand('me change sa tenue.')
			local clothesSkin = {
				['tshirt_1'] = 15, ['tshirt_2'] = 0,
				['torso_1'] = 83, ['torso_2'] = 0,
				['arms'] = 0,
				['pants_1'] = 41, ['pants_2'] = 0,
			    ['shoes_1'] = 31, ['shoes_2'] = 0,
				['helmet_1'] = -1, ['helmet_2'] = 0,
			}
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
      end
      local playerPed = GetPlayerPed(-1)
      ClearPedBloodDamage(playerPed)
      ResetPedVisibleDamage(playerPed)
      ClearPedLastWeaponDamage(playerPed)
    end)
  else

    TriggerEvent('skinchanger:getSkin', function(skin)

      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, hasSkin)

        if hasSkin then

          cleanPlayer(playerPed)
          local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
          ESX.Streaming.RequestAnimDict(dict)
          TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
		  Citizen.Wait(6500)

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end
  UseTenu = not UseTenu
end)

RegisterNetEvent('tenuecere:usetenue')
AddEventHandler('tenuecere:usetenue', function()
  if not UseTenu then

    cleanPlayer(playerPed)
    local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
    ESX.Streaming.RequestAnimDict(dict)
    TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(6500)
    
    TriggerEvent('skinchanger:getSkin', function(skin)

      if skin.sex == 0 then
		ExecuteCommand('me change sa tenue.')
		local clothesSkin = {
			['tshirt_1'] = 25, ['tshirt_2'] = 0,
			['torso_1'] = 105, ['torso_2'] = 0,
			['arms'] = 4,
			['pants_1'] = 50, ['pants_2'] = 0,
			['shoes_1'] = 32, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		  else
			ExecuteCommand('me change sa tenue.')
			local clothesSkin = {
				['tshirt_1'] = 15, ['tshirt_2'] = 0,
				['torso_1'] = 83, ['torso_2'] = 0,
				['arms'] = 0,
				['pants_1'] = 41, ['pants_2'] = 0,
			    ['shoes_1'] = 31, ['shoes_2'] = 0,
				['helmet_1'] = -1, ['helmet_2'] = 0,
			}
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
      end
      local playerPed = GetPlayerPed(-1)
      ClearPedBloodDamage(playerPed)
      ResetPedVisibleDamage(playerPed)
      ClearPedLastWeaponDamage(playerPed)
    end)
  else

    TriggerEvent('skinchanger:getSkin', function(skin)

      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, hasSkin)

        if hasSkin then

          cleanPlayer(playerPed)
          local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
          ESX.Streaming.RequestAnimDict(dict)
          TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
		  Citizen.Wait(6500)

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end
  UseTenu = not UseTenu
end)


RegisterNetEvent('tenuevelo:usetenue')
AddEventHandler('tenuevelo:usetenue', function()
  if not UseTenu then

    cleanPlayer(playerPed)
    local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
    ESX.Streaming.RequestAnimDict(dict)
    TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(6500)
    
    TriggerEvent('skinchanger:getSkin', function(skin)

      if skin.sex == 0 then
		ExecuteCommand('me change sa tenue.')
		local clothesSkin = {
			['tshirt_1'] = 25, ['tshirt_2'] = 0,
			['torso_1'] = 105, ['torso_2'] = 0,
			['arms'] = 4,
			['pants_1'] = 50, ['pants_2'] = 0,
			['shoes_1'] = 32, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		  else
			ExecuteCommand('me change sa tenue.')
			local clothesSkin = {
				['tshirt_1'] = 15, ['tshirt_2'] = 0,
				['torso_1'] = 83, ['torso_2'] = 0,
				['arms'] = 0,
				['pants_1'] = 41, ['pants_2'] = 0,
			    ['shoes_1'] = 31, ['shoes_2'] = 0,
				['helmet_1'] = -1, ['helmet_2'] = 0,
			}
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
      end
      local playerPed = GetPlayerPed(-1)
      ClearPedBloodDamage(playerPed)
      ResetPedVisibleDamage(playerPed)
      ClearPedLastWeaponDamage(playerPed)
    end)
  else

    TriggerEvent('skinchanger:getSkin', function(skin)

      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, hasSkin)

        if hasSkin then

          cleanPlayer(playerPed)
          local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
          ESX.Streaming.RequestAnimDict(dict)
          TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
		  Citizen.Wait(6500)

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end
  UseTenu = not UseTenu
end)

RegisterNetEvent('tenuepilote:usetenue')
AddEventHandler('tenuepilote:usetenue', function()
  if not UseTenu then

    cleanPlayer(playerPed)
    local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
    ESX.Streaming.RequestAnimDict(dict)
    TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(6500)
    
    TriggerEvent('skinchanger:getSkin', function(skin)

      if skin.sex == 0 then
		ExecuteCommand('me change sa tenue.')
		local clothesSkin = {
			['tshirt_1'] = 25, ['tshirt_2'] = 0,
			['torso_1'] = 105, ['torso_2'] = 0,
			['arms'] = 4,
			['pants_1'] = 50, ['pants_2'] = 0,
			['shoes_1'] = 32, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		  else
			ExecuteCommand('me change sa tenue.')
			local clothesSkin = {
				['tshirt_1'] = 15, ['tshirt_2'] = 0,
				['torso_1'] = 83, ['torso_2'] = 0,
				['arms'] = 0,
				['pants_1'] = 41, ['pants_2'] = 0,
			    ['shoes_1'] = 31, ['shoes_2'] = 0,
				['helmet_1'] = -1, ['helmet_2'] = 0,
			}
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
      end
      local playerPed = GetPlayerPed(-1)
      ClearPedBloodDamage(playerPed)
      ResetPedVisibleDamage(playerPed)
      ClearPedLastWeaponDamage(playerPed)
    end)
  else

    TriggerEvent('skinchanger:getSkin', function(skin)

      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, hasSkin)

        if hasSkin then

          cleanPlayer(playerPed)
          local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
          ESX.Streaming.RequestAnimDict(dict)
          TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
		  Citizen.Wait(6500)

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end
  UseTenu = not UseTenu
end)

RegisterNetEvent('tenuemoto:usetenue')
AddEventHandler('tenuemoto:usetenue', function()
  if not UseTenu then

    cleanPlayer(playerPed)
    local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
    ESX.Streaming.RequestAnimDict(dict)
    TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(6500)
    
    TriggerEvent('skinchanger:getSkin', function(skin)

      if skin.sex == 0 then
		ExecuteCommand('me change sa tenue.')
		local clothesSkin = {
			['tshirt_1'] = 25, ['tshirt_2'] = 0,
			['torso_1'] = 105, ['torso_2'] = 0,
			['arms'] = 4,
			['pants_1'] = 50, ['pants_2'] = 0,
			['shoes_1'] = 32, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		  else
			ExecuteCommand('me change sa tenue.')
			local clothesSkin = {
				['tshirt_1'] = 15, ['tshirt_2'] = 0,
				['torso_1'] = 83, ['torso_2'] = 0,
				['arms'] = 0,
				['pants_1'] = 41, ['pants_2'] = 0,
			    ['shoes_1'] = 31, ['shoes_2'] = 0,
				['helmet_1'] = -1, ['helmet_2'] = 0,
			}
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
      end
      local playerPed = GetPlayerPed(-1)
      ClearPedBloodDamage(playerPed)
      ResetPedVisibleDamage(playerPed)
      ClearPedLastWeaponDamage(playerPed)
    end)
  else

    TriggerEvent('skinchanger:getSkin', function(skin)

      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, hasSkin)

        if hasSkin then

          cleanPlayer(playerPed)
          local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
          ESX.Streaming.RequestAnimDict(dict)
          TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
		  Citizen.Wait(6500)

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end
  UseTenu = not UseTenu
end)

RegisterNetEvent('bmx:usebmx')
AddEventHandler('bmx:usebmx', function(car)
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then return ESX.ShowNotification("~r~Vous ne pouvez pas sortir votre "..car.." dans un véhicule.") end
    local model = car
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
    local ped = PlayerPedId()
    local veh = CreateVehicle(model, GetEntityCoords(PlayerPedId()) + GetEntityForwardVector(ped), GetEntityHeading(PlayerPedId()) - 90.0, true, true)
    SetEntityAsMissionEntity(veh, true, true)
    SetVehicleModColor_1(veh,0)
    SetVehicleModColor_2(veh,0)
	SetVehicleOnGroundProperly(veh)
end)