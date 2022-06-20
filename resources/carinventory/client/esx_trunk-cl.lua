ESX = nil
local GUI = {}
local PlayerData = {}
local lastVehicle = nil
local lastOpen = false
GUI.Time = 0
local vehiclePlate = {}
local arrayWeight = Config.localWeight
local entityWorld = nil
local globalplate = nil
local lastChecked = 0

local checkcoffre = false
local coffre = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(50)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(50)
	end

	 PlayerData = ESX.GetPlayerData()
end)

RegisterKeyMapping('opencoffre', 'Ouvrir le Coffre (Véhicule)', 'keyboard', 'K')

RegisterCommand('opencoffre', function()
  openmenuvehicle()
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
    PlayerData = xPlayer
    TriggerServerEvent("esx_trunk_inventory:getOwnedVehicule")
    lastChecked = GetGameTimer()
end)

AddEventHandler( "onResourceStart", function()
    PlayerData = xPlayer
    TriggerServerEvent("esx_trunk_inventory:getOwnedVehicule")
    lastChecked = GetGameTimer()
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
	local PlayerData = ESX.GetPlayerData()
	
	if PlayerData == nil then
		print ('Le coffre ne peut pas synchroniser la profession. Ce n\'est pas mal.')  -- Cannot sync job, not bad
	else
		print ('Trunk a synchronisé votre profession.') -- Can sync job
		PlayerData.job = job
	end
end)

RegisterNetEvent("esx_trunk_inventory:setOwnedVehicule")
AddEventHandler("esx_trunk_inventory:setOwnedVehicule", function(vehicle)
    vehiclePlate = vehicle
end)

function getItemyWeight(item)
  local weight = 0
  local itemWeight = 0
  if item ~= nil then
    itemWeight = Config.DefaultWeight
    if arrayWeight[item] ~= nil then
      itemWeight = arrayWeight[item]
    end
  end
  return itemWeight
end

function VehicleInFront()
  local pos = GetEntityCoords(GetPlayerPed(-1))
  local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
  local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
  local a, b, c, d, result = GetRaycastResult(rayHandle)
  return result
end

function openmenuvehicle()

  local playerPed = GetPlayerPed(-1)
  local coords = GetEntityCoords(playerPed)
  local vehicle = VehicleInFront()
  globalplate = GetVehicleNumberPlateText(vehicle)

  if not IsPedInAnyVehicle(playerPed) then
    myVeh = false
    local thisVeh = VehicleInFront()
    PlayerData = ESX.GetPlayerData()

    for i = 1, #vehiclePlate do
      local vPlate = all_trim(vehiclePlate[i].plate)
      local vFront = all_trim(GetVehicleNumberPlateText(thisVeh))

      if vPlate == vFront then
        myVeh = true
      elseif lastChecked < GetGameTimer() - 60000 then
        TriggerServerEvent("esx_trunk_inventory:getOwnedVehicule")
        lastChecked = GetGameTimer()
        Wait(2000)
        for i = 1, #vehiclePlate do
          local vPlate = all_trim(vehiclePlate[i].plate)
          local vFront = all_trim(GetVehicleNumberPlateText(thisVeh))
          if vPlate == vFront then
            myVeh = true
          end
        end
      end
    end

    if not Config.CheckOwnership or (Config.AllowPolice and PlayerData.job.name == "police") or (Config.CheckOwnership and myVeh) then
      if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
        local vehFront = VehicleInFront()
        local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
        local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)

        if vehFront > 0 and closecar ~= nil and GetPedInVehicleSeat(closecar, -1) ~= GetPlayerPed(-1) then
          lastVehicle = vehFront
          local model = GetDisplayNameFromVehicleModel(GetEntityModel(closecar))
          local locked = GetVehicleDoorLockStatus(closecar)
          local class = GetVehicleClass(vehFront)

            if locked == 1 or class == 15 or class == 16 or class == 14 then

              if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
                ExecuteCommand('me ouvre le coffre du véhicule')
                coffre = true
                Citizen.CreateThread(function()
                  while true do
                      Citizen.Wait(10)
                      
                      local ped = PlayerPedId()
                      local plyCoords = GetEntityCoords(ped)     
                      
                      if coffre then
                          if not checkcoffre then
                              checkcoffre = true
                              SetVehicleDoorOpen(vehFront, 5, false, false)
                            print('open')
                          elseif checkcoffre then
                          if IsControlJustReleased(0, 37) and checkcoffre then
                              checkcoffre = false
                              coffre = false
                              SetVehicleDoorShut(vehFront, 5, false)
                              print('close')
                              end
                          end
                      end
                  end
              end)
                OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), Config.VehicleWeight[class], myVeh)
                DisplayRadar(false)
                TriggerScreenblurFadeIn()
              end
            else
              ESX.ShowNotification("~r~Le véhicule est vérouillé.")
          end
        else
          ESX.ShowNotification("~r~Il n'y a pas de véhicule près de vous.")
        end
        lastOpen = true
        GUI.Time = GetGameTimer()
      end
    else
      ESX.ShowNotification("~r~Ce n'est pas votre véhicule.")
    end
  end
end

local count = 0

RegisterNetEvent("esx:playerLoaded")
AddEventHandler(
  "esx:playerLoaded",
  function(xPlayer)
    PlayerData = xPlayer
    TriggerServerEvent("esx_trunk_inventory:getOwnedVehicule")
    lastChecked = GetGameTimer()
  end
)

function OpenCoffreInventoryMenu(plate, max, myVeh)
  ESX.TriggerServerCallback(
    "esx_trunk:getInventoryV",
    function(inventory)
      text = _U("trunk_info", plate, (inventory.weight / 100), (max / 100))
      data = {plate = plate, max = max, myVeh = myVeh, text = text}
      TriggerEvent("esx_inventoryhud:openTrunkInventory", data, inventory.blackMoney, inventory.cashMoney, inventory.items, inventory.weapons)
    end,
    plate
  )
end

function all_trim(s)
  if s then
    return s:match "^%s*(.*)":match "(.-)%s*$"
  else
    return "noTagProvided"
  end
end

function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end
