ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

function GetPlayers()
    local players = {}

    for _,player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)

        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end

    return players
end

RegisterCommand('facture', function()
    local pPedJob = ESX.PlayerData.job.name
    CreateFacture("society_"..pPedJob.."")
end)

RegisterNetEvent("facture:get")
AddEventHandler("facture:get",function(_facture)
    ESX.ShowNotification("Facture :\n~b~Motif : ~s~".._facture.title.."\n~b~Montant : ~s~".._facture.montant.."~b~$")
    ESX.ShowNotification("Accepter : ~b~E")
    local veuxpayer = false
    local paied = false
    veuxpayer = true
    Citizen.CreateThread(function()
        while true do 
            Wait(1)
            if veuxpayer and IsControlJustPressed(1, 51) then 
                veuxpayer = false
                TriggerServerEvent("facture:pay",_facture.montant, _facture.account)
                TriggerPlayerEvent("esx:showNotification",_facture.source,"~g~La personne a accepté de payer.")
                local dict, anim = "mp_common", "givetake2_a"
                ESX.Streaming.RequestAnimDict(dict)
                TaskPlayAnim(GetPlayerPed(-1), dict, anim, 2.0, 2.0, 1000, 51, 0, false, false, false)
                PlaySoundFrontend(-1, 'Bus_Schedule_Pickup', 'DLC_PRISON_BREAK_HEIST_SOUNDS', false)
                paied = true
            end
            if veuxpayer and IsControlJustPressed(1, 73) then 
                veuxpayer = false
                ESX.ShowNotification("~r~Vous avez refusé de payer.")
                TriggerPlayerEvent("esx:showNotification",_facture.source,"~r~La personne a refusé de payer.")
                paied = true
            end
        end
    end)
    Wait(6000)
    if not paied then
        ESX.ShowNotification("~r~Vous avez refusé de payer.")
        TriggerPlayerEvent("esx:showNotification",_facture.source,"~r~La personne n'a pas payé.")
    end
    veuxpayer = false
    _facture = {}
end)

-- Facture Entreprise

TriggerPlayerEvent = function(name, source, ...)
    TriggerServerEvent("zfacture:PlayerEvent",name,source,...)
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end
RegisterNetEvent('randPickupAnim')
AddEventHandler('randPickupAnim', function()
    loadAnimDict('pickup_object')
    TaskPlayAnim(PlayerPedId(),'pickup_object', 'putdown_low',5.0, 1.5, 1.0, 48, 0.0, 0, 0, 0)
    Wait(1000)
    ClearPedSecondaryTask(PlayerPedId())
end)

function GetPlayerServerIdInDirection(range)
    local players, closestDistance, closestPlayer = GetPlayers(), -1, -1
    local coords, usePlayerPed = coords, false
    local playerPed, playerId = PlayerPedId(), PlayerId()

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end

    for i=1, #players, 1 do
        local target = GetPlayerPed(players[i])
            if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
                local targetCoords = GetEntityCoords(target)
                local distance = #(coords - targetCoords)

                if closestDistance == -1 or closestDistance > distance then
                    closestPlayer = players[i]
                    closestDistance = distance
                end
            end
    end

    if closestDistance > 7.0 or closestDistance == -1 then
        closestPlayer = nil
    end

    return closestPlayer ~= nil and GetPlayerServerId(closestPlayer) or false
end


function CreateFacture(account)
    local playerId = GetPlayerServerIdInDirection(4.0)
	if playerId ~= false then
		TriggerEvent("randPickupAnim")
        TaskStartScenarioInPlace(GetPlayerPed(-1), "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, true)
        local _facture = {
            title = KeyboardInput("Motif de la facture","",30),
            montant = tonumber(KeyboardInput("Montant de la facture","",30)),
            playerId = playerId,
            account = account
        }

        if _facture.title ~= nil and _facture.title ~= "" and tonumber(_facture.montant) ~= nil and _facture.montant ~= 0 then
            TriggerServerEvent("facture:send",_facture)
            ESX.ShowNotification("~b~La facture a bien été envoyée.")
            ClearPedTasks(GetPlayerPed(-1))
            _facture = {}
        else
            _facture = {}
            ESX.ShowNotification("~r~Votre facture est invalide.")
            ClearPedTasks(GetPlayerPed(-1))
        end
    else
        ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
    end
end