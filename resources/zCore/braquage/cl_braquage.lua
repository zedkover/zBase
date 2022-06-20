ESX = nil

local currentPed
local object = {}
soundid = GetSoundId()

Citizen.CreateThread(function() 
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
        Citizen.Wait(0) 
    end 
end)

function drawsub(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, true)
end  

RegisterNetEvent('zBraquage:msgPolice')
AddEventHandler('zBraquage:msgPolice', function(store, robber)
    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(GetPlayerFromServerId(robber)))
	ESX.ShowAdvancedNotification("Supérette", 'Vol en cours', "Je me fais braquer mon êpicerie ! HELP", "CHAR_CALL911", 4)
    ESX.ShowNotification('~b~E~s~ Accepter ~o~X~s~ Refuser')
    UnregisterPedheadshot(mugshot)
    while true do
        if IsControlPressed(0, 38) then
            SetNewWaypoint(Config.shops[store].coords.x, Config.shops[store].coords.y)
            return
        elseif IsControlPressed(0, 73) then
            return
        end
        Wait(0)
    end
end)

peds = {}

function _CreatePed(hash, coords, heading)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(5)
    end
    local ped = CreatePed(4, hash, coords, false, false)
    SetEntityHeading(ped, heading)
    SetEntityAsMissionEntity(ped, true, true)
    SetPedHearingRange(ped, 0.0)
    SetPedSeeingRange(ped, 0.0)
    SetEntityInvincible(ped, true)
    SetPedAlertness(ped, 0.0)
    FreezeEntityPosition(ped, true) 
    SetPedFleeAttributes(ped, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedFleeAttributes(ped, 0, 0)
    return ped
end

local holdup = false

Citizen.CreateThread(function()    
    for k, v in pairs(Config.shops) do
        peds[k] = _CreatePed(v.ped, v.coords, v.heading)
    end
	while true do
		Wait(500)
        local ped = PlayerPedId()
        local pos =  GetEntityCoords(ped)
		for k, v in pairs(peds) do
            currentPed = k
            local dist = Vdist(pos, GetEntityCoords(peds[k]))    
		    if dist < 5 and not IsPedDeadOrDying(peds[k]) then


                if IsPedArmed(ped, 4) and not holdup then 
                    count = math.random(Config.shops[k].packet[1], Config.shops[k].packet[2])
                    holdup = true
                    TriggerServerEvent('policemess', k)
                    braquage(k) 
                end
                
                if IsPedArmed(ped, 1) and not holdup then 
                    local chance = math.random(Config.chance[1], Config.chance[2])

                    if chance == 1 then 
                        count = math.random(Config.shops[k].packet[1], Config.shops[k].packet[2])
                        holdup = true
                        TriggerServerEvent('policemess', k)
                        braquage(k) 
                    else
                        TriggerServerEvent('policemess', k)
                        SetPedAccuracy(peds[k], Config.PedAccuracy)
                        local weapon  = GetHashKey("weapon_ceramicpistol")
                        SetPedVisualFieldPeripheralRange(peds[k], 6)
                        GiveWeaponToPed(peds[k], weapon, 8, false, true)
                        TaskShootAtEntity(peds[k], PlayerPedId(), 5000, 0x5EF9FEC4)
                        Wait(Config.timeinterval)
                        RemoveWeaponFromPed(peds[k], weapon)
                    end 
                end

            end 
		end 
	end
end)

Citizen.CreateThread(function()
    while true do 
        time = 500
        if holdup then 
            time = 0
            local pos =  GetEntityCoords(PlayerPedId())
            local dist = Vdist(pos, GetEntityCoords(peds[currentPed]))  
            if dist > 15 then 
                stopbraquage(currentPed)
            end 
        end 
        Wait(time)
    end 
end)

local objeto = {}
local objetos = {}

local moneypack = false

count = nil

function braquage(result) 
    if count ~= 0 and holdup then 


            PlaySoundFromCoord(soundid, "VEHICLES_HORNS_AMBULANCE_WARNING", Config.shops[result].coords)
            ESX.Streaming.RequestAnimDict("mp_am_hold_up", function()
                TaskPlayAnim(peds[result], "mp_am_hold_up","handsup_base", 8.0, -8.0, 19000, 19000, 0, false, false, false)
            end)
            Citizen.Wait(7000)
            ESX.Streaming.RequestAnimDict("mp_am_hold_up", function()
                TaskPlayAnim(peds[result], "mp_am_hold_up","handsup_base", 8.0, -8.0, 19000, 19000, 0, false, false, false)
            end)
            Citizen.Wait(9000)
            ClearPedTasks(peds[result])
            spawnmoneypack(result)
            

            moneypack = true
            count = count - 1 
            Citizen.CreateThread(function()    
                while true do
                    Wait(0)
                    if moneypack then
                        local pos = GetEntityCoords(PlayerPedId())
                        local dist = Vdist(pos, Config.shops[result].coords) 
                        if dist < 3 then 
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour prendre ~b~l'argent")
                            if IsControlPressed(0, 51) then 
                                ESX.Streaming.RequestAnimDict("random@domestic", function()
                                    TaskPlayAnim(PlayerPedId(), "random@domestic", "pickup_low", 8.0, -8.0, -1, 0, 0.0, false, false, false)
                                end)
                                PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                for k, v in pairs(objetos) do
                                    DeleteObject(objetos[k].name)
                                end
                                moneypack = false
                                local pricemoney = math.random(Config.shops[result].money[1], Config.shops[result].money[2])
                                TriggerServerEvent('addsale', pricemoney)
                                drawsub('~r~Braquage~s~ : + ~b~'..pricemoney..'$~s~.', 2000)
                            end
                        end   
                    end
                end 
            end)
        braquage(result)
    else
        stopbraquage(result)
    end
end

function stopbraquage(result)
    ESX.ShowNotification("~r~Braquage terminé")
    holdup = false
    StopSound(soundid)
    local time = Config.shops[result].cooldownseconds * 1000
    Citizen.Wait(time)
    for k, v in pairs(objetos) do 
        table.remove(objetos, k)
        DeleteObject(objetos[k].name)
    end
end

function spawnmoneypack(result)
    TaskPlayAnim(peds[result], "mp_am_hold_up","purchase_cigarette_shopkeeper", 8.0, -8.0, -1, 2, 0, false, false, false)
    objeto = CreateObject(GetHashKey("prop_anim_cash_pile_01"), Config.shops[result].coords, true, true, true)
    table.insert(objetos, {name = objeto})
    NetworkRegisterEntityAsNetworked(objeto) 
    SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(objeto, true))
    SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(objeto, true))
    SetEntityAsMissionEntity(objeto)
    AttachEntityToEntity(objeto, peds[result], GetPedBoneIndex(peds[result],  28422), 0.0, -0.03, 0.0, 90.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
    Wait(3000)
    DetachEntity(objeto, true, false)
end