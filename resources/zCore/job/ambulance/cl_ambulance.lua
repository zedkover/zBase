Death = Death or {}

if GetCurrentResourceName() ~= "zCore" then return end

ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(a)
            ESX = a 
        end)
    end 
end)

local PlayerData = {}
local target = nil

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

stock = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Stock", world = true },
    Data = { currentMenu = "Action", GetPlayerName() },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
                if self.Data.currentMenu == "Déposer un objet" then 
                    local result = KeyboardInput('Nombre', '', 10)
                    if result ~= nil then
                        TriggerServerEvent('zambulance:putStockItems', zedkover.value, result)
                        OpenMenu("Action")
                    end 
                elseif self.Data.currentMenu == "Retirer un objet" then 
                    local result = KeyboardInput('Nombre :', '', 10)
                    if result ~= nil then 
                        TriggerServerEvent('zambulance:getStockItem', zedkover.value, result)
                        OpenMenu("Action")
                    end  
                end

                if zedkover.name == "Déposer un objet" then 
                    stock.Menu["Déposer un objet"].b = {}
                    ESX.TriggerServerCallback('zambulance:getinventory', function(zedkover)
                        for i=1, #zedkover.items, 1 do
                            local item = zedkover.items[i]
                            if item.count > 0 then
                                table.insert(stock.Menu["Déposer un objet"].b,  {name = item.label .. ' x' .. item.count, askX = true, value = item.name})
                            end
                        end
                        OpenMenu("Déposer un objet")
                    end)
                elseif zedkover.name == "Reprendre vos affaires" then 
                        ESX.ShowNotification("~r~Vous êtes plus en tenue")
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                            TriggerEvent('skinchanger:loadSkin', skin)
                        end)
                        SetPedArmour(playerPed, 0)	   
                elseif zedkover.name == "Vestiaires" then
                    OpenMenu("Vestiaires")
                elseif zedkover.name == "Tenue Ambulancier" then
                    ESX.ShowNotification("~b~Vous êtes en tenue")
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        if skin.sex == 0 then
                            TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.ems_tenue.male)
                        elseif skin.sex == 1 then
                            TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.ems_tenue.female)
                        end
                    end)
                elseif zedkover.name == "Retirer un objet" then 
                    stock.Menu["Retirer un objet"].b = {}
                    ESX.TriggerServerCallback('zambulance:getStockItems', function(items)  
                        for i=1, #items, 1 do 
                            if items[i].count > 0 then
                                table.insert(stock.Menu["Retirer un objet"].b, {name = 'x' .. items[i].count .. ' ' .. items[i].label, askX = true, value = items[i].name})
                            end
                        end
                    OpenMenu('Retirer un objet')
                    end)
                end

       
        end,
    },
    Menu = {
        ["Action"] = {
            b = {
                {name = "Déposer un objet", ask = ">", askX = true, id = 33},
                {name = "Retirer un objet", ask = ">", askX = true, id = 33},
                {name = "Vestiaires", ask = ">", askX = true, id = 33}
            }
        },
        ["Vestiaires"] = {
            b = {
                {name = "Tenue Ambulancier", ask = ">", askX = true},
                {name = "Reprendre vos affaires", ask = ">", askX = true}
            }
        },
        ["Déposer un objet"] = { b = {} },
        ["Retirer un objet"] = { b = {} },
    }
}

garageems = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Garage", world = true  },
    Data = { currentMenu = "Action", GetPlayerName() },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if self.Data.currentMenu == "Action" and zedkover.name ~= "Ranger le vehicule" then 
                TriggerEvent('esx:deleteVehicle')  
                ESX.Game.SpawnVehicle(zedkover.value, {x = Config.Spawngarageems.x,y = Config.Spawngarageems.y, z =  Config.Spawngarageems.z + 1}, Config.Spawngarageems.a, function(vehicle)
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

RegisterNetEvent('zBase:RevivePlayerId')
AddEventHandler('zBase:RevivePlayerId', function()
    local pPed = PlayerPedId()
    local pPos = GetEntityCoords(pPed)

    Death.PlayerDead = false 
    Death.PlayerKO = false 
    ClearPedBloodDamage(pPed)
    PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
    SetEntityHealth(pPed, 120)
    Wait(250)
    Death.Invincible = false 
	TriggerEvent('playerSpawned', pPos.x, pPos.y, pPos.z)
	SetCurrentPedWeapon(pPed, GetHashKey('WEAPON_UNARMED'), true)

    ClearPedTasks(pPed)
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
    disablecontrol = true
    ESX.ShowNotification("~b~Réanimation\n~w~Vous venez d\'être réanimé.")
    RemoveTimerBar()
    DoScreenFadeOut(1000)
    Wait(1000)
    ClearTimecycleModifier()
    Wait(1000)
    DoScreenFadeIn(1000)
    Citizen.Wait(56000)
    disablecontrol = false
end)


function revivePlayer(closestPlayer)

    ESX.TriggerServerCallback('zbase:getItemAmount', function(qtty)
        if qtty > 0 then
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            local closestPlayerPed = GetPlayerPed(closestPlayer)
        
            if closestPlayer == -1 or closestDistance > 3.0 then
                ESX.ShowNotification('Il n\'y a ~r~aucune~s~ personne autour de vous.')
            else
                local closestPlayerPed = GetPlayerPed(closestPlayer)
        
                    local playerPed = GetPlayerPed(-1)
                    Citizen.CreateThread(function()
                    ESX.Streaming.RequestAnimDict("missheistfbi3b_ig8_2", function()
                        TaskPlayAnim(playerPed, "missheistfbi3b_ig8_2", "cpr_loop_paramedic", 8.0, -8.0, -1, 35, 0.0, false, false, false)
                    end)
                    Wait(10000)
                    ClearPedTasks(playerPed)
        
                    TriggerServerEvent('AmbulanceRevivePlayer', GetPlayerServerId(closestPlayer))
                end)
            end
        else
            ESX.ShowNotification("Vous ~b~n'avez~s~ pas de ~b~kit~s~ de ~b~soins~s~.")
        end
    end, 'medikit')
end

garageems2 = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Garage", world = true },
    Data = { currentMenu = "Action", GetPlayerName() },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if self.Data.currentMenu == "Action" and zedkover.name ~= "Ranger le vehicule" then 
                TriggerEvent('esx:deleteVehicle')  
                ESX.Game.SpawnVehicle(zedkover.value, {x = Config.Spawngarageems2.x,y = Config.Spawngarageems2.y, z =  Config.Spawngarageems2.z + 1}, Config.Spawngarageems2.a, function(vehicle)
                    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)       
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

function Soigner(closestPlayer)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer == -1 or closestDistance > 1.0 then
        ESX.ShowNotification('~b~Conseil~w~ : rapprochez-vous !')
    else 
        local closestPlayerPed = GetPlayerPed(closestPlayer)
        local health = GetEntityHealth(closestPlayerPed)
        if health > 0 then
		local playerPed = PlayerPedId()
        TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
        Citizen.Wait(10000)
        ClearPedTasks(playerPed)
        TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
        ESX.ShowNotification('~b~Vous avez soigner quelqu\'un.')
    else
        ESX.ShowNotification('~r~Vous êtes dans le inconscient !')
    end
end
end

function tableHasValue(tbl, value, k)
	if not tbl or not value or type(tbl) ~= "table" then return end
	for _,v in pairs(tbl) do
		if k and v[k] == value or v == value then return true, _ end
	end
end

local femaleFix = {
	["WORLD_HUMAN_BUM_WASH"] = {"amb@world_human_bum_wash@male@high@idle_a", "idle_a"},
	["WORLD_HUMAN_SIT_UPS"] = {"amb@world_human_sit_ups@male@idle_a", "idle_a"},
	["WORLD_HUMAN_PUSH_UPS"] = {"amb@world_human_push_ups@male@base", "base"},
	["WORLD_HUMAN_BUM_FREEWAY"] = {"amb@world_human_bum_freeway@male@base", "base"},
	["WORLD_HUMAN_CLIPBOARD"] = {"amb@world_human_clipboard@male@base", "base"},
	["WORLD_HUMAN_VEHICLE_MECHANIC"] = {"amb@world_human_vehicle_mechanic@male@base", "base"},
}

function forceAnim(animName, flag, args)
	flag, args = flag and tonumber(flag) or false, args or {}
	local ped, time, clearTasks, animPos, animRot, animTime = args.ped or GetPlayerPed(-1), args.time, args.clearTasks, args.pos, args.ang

	if IsPedInAnyVehicle(ped) and (not flag or flag < 40) then return end

	if not clearTasks then ClearPedTasks(ped) end

	if not animName[2] and femaleFix[animName[1]] and GetEntityModel(ped) == -1667301416 then
		animName = femaleFix[animName[1]]
	end

	if animName[2] and not HasAnimDictLoaded(animName[1]) then
		if not DoesAnimDictExist(animName[1]) then return end
		RequestAnimDict(animName[1])
		while not HasAnimDictLoaded(animName[1]) do
			Citizen.Wait(10)
		end
	end

	if not animName[2] then
		ClearAreaOfObjects(GetEntityCoords(ped), 1.0)
		TaskStartScenarioInPlace(ped, animName[1], -1, not tableHasValue(animBug, animName[1]))
	else
        if not animPos then
            TaskPlayAnim(ped, animName[1], animName[2], 8.0, -8.0, -1, flag or 44, 1, 0, 0, 0, 0)
            --TaskPlayAnim(ped, animName[1], animName[2], 8.0, -8.0, -1, 1, 1, 0, 0, 0)
		else
			TaskPlayAnimAdvanced(ped, animName[1], animName[2], animPos.x, animPos.y, animPos.z, animRot.x, animRot.y, animRot.z, 8.0, -8.0, -1, 1, 1, 0, 0, 0)
		end
	end

	if time and type(time) == "number" then
		Citizen.Wait(time)
		ClearPedTasks(ped)
	end

	if not args.dict then RemoveAnimDict(animName[1]) end
end
function forceAnim(animName, flag, args)
	flag, args = flag and tonumber(flag) or false, args or {}
	local ped, time, clearTasks, animPos, animRot, animTime = args.ped or GetPlayerPed(-1), args.time, args.clearTasks, args.pos, args.ang

	if IsPedInAnyVehicle(ped) and (not flag or flag < 40) then return end

	if not clearTasks then ClearPedTasks(ped) end

	if not animName[2] and femaleFix[animName[1]] and GetEntityModel(ped) == -1667301416 then
		animName = femaleFix[animName[1]]
	end

	if animName[2] and not HasAnimDictLoaded(animName[1]) then
		if not DoesAnimDictExist(animName[1]) then return end
		RequestAnimDict(animName[1])
		while not HasAnimDictLoaded(animName[1]) do
			Citizen.Wait(10)
		end
	end

	if not animName[2] then
		ClearAreaOfObjects(GetEntityCoords(ped), 1.0)
		TaskStartScenarioInPlace(ped, animName[1], -1, not tableHasValue(animBug, animName[1]))
	else
        if not animPos then
            TaskPlayAnim(ped, animName[1], animName[2], 8.0, -8.0, -1, flag or 44, 1, 0, 0, 0, 0)
            --TaskPlayAnim(ped, animName[1], animName[2], 8.0, -8.0, -1, 1, 1, 0, 0, 0)
		else
			TaskPlayAnimAdvanced(ped, animName[1], animName[2], animPos.x, animPos.y, animPos.z, animRot.x, animRot.y, animRot.z, 8.0, -8.0, -1, 1, 1, 0, 0, 0)
		end
	end

	if time and type(time) == "number" then
		Citizen.Wait(time)
		ClearPedTasks(ped)
	end

	if not args.dict then RemoveAnimDict(animName[1]) end
end


function crochetagevehicle()
    local playerPed = PlayerPedId()
    local vehicle = ESX.Game.GetVehicleInDirection()
    local coords = GetEntityCoords(playerPed)

    if IsPedSittingInAnyVehicle(playerPed) then
        ESX.ShowNotification('Action impossible')
        return
    end

    if DoesEntityExist(vehicle) then
        isBusy = true
        local dict, anim = "veh@break_in@0h@p_m_two@","std_locked_ds"
        ESX.Streaming.RequestAnimDict(dict)
        createProgressBar("Crochetage en cours", 0, 255, 185, 120, 10000)
        TaskPlayAnim(GetPlayerPed(-1), dict, anim, 8.0, 8.0, -1, 1, 1, 0, 0, 0)
        Citizen.CreateThread(function()
            Citizen.Wait(10000)

            SetVehicleDoorsLocked(vehicle, 1)
            SetVehicleDoorsLockedForAllPlayers(vehicle, false)
            ClearPedTasksImmediately(playerPed)
            PlaySoundFrontend(-1, 'Drill_Pin_Break', 'DLC_HEIST_FLEECA_SOUNDSET', false)

            ESX.ShowNotification('Véhicule ~b~dévérouillé')
            isBusy = false
        end)
    else
        ESX.ShowNotification("~b~Pas de véhicule a proximité")
    end
end

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		ESX.ShowNotification('~b~Vous avez été soigner par quelqu\'un.')
	end
end)

function createLegalObject(yA,XmVolesU)
    if#e>=10 then ShowAboveRadarMessage("~r~Vous avez atteint la limite d'objets.")return end;
	yA=type(yA)=="string"and GetHashKey(yA)or yA;
    if not IsModelInCdimage(yA)then return end;
	RequestAndWaitModel(yA)
    local eZ0l3ch,W_63_9=false,GetGameTimer()
    eZ0l3ch=true 
    while not eZ0l3ch and W_63_9+3000 >GetGameTimer()do
        Wait(1000)
    end
    local h9dyA_4T=CreateObject(yA,XmVolesU.x,XmVolesU.y,XmVolesU.z-1.0,true,false)
    SetNetworkIdCanMigrate(ObjToNet(h9dyA_4T),false)PlaceObjectOnGroundProperly(h9dyA_4T)
    SetEntityHeading(h9dyA_4T,GetEntityHeading(GetPlayerPed(-1)))
    table.insert(e,h9dyA_4T)
    return h9dyA_4T 
end;

function opengarageems()
    garageems.Menu["Action"].b = {}
    for k, v in pairs(Config.carsems) do
        table.insert(garageems.Menu["Action"].b, {name = v.label, value = v.name})
    end
    table.insert(garageems.Menu["Action"].b, {name = "Ranger le vehicule"})
    CreateMenu(garageems)
end 

function opengarageems2()
    garageems2.Menu["Action"].b = {}
    for k, v in pairs(Config.carsems2) do
        table.insert(garageems2.Menu["Action"].b, {name = v.label, value = v.name})
    end
    table.insert(garageems2.Menu["Action"].b, {name = "Ranger le vehicule"})
    CreateMenu(garageems2)
end 

f6ems = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Pillbox Hill Medical Center", world = true },
    Data = { currentMenu = "Action", GetPlayerName() },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if zedkover.name == "Effectuer une annonce" then 
                local result = KeyboardInput('', '', 255)
                if result ~= nil then 
                    TriggerServerEvent('zambulance:annonceambulance', result)
                end
            elseif zedkover.name == "Réanimer la personne" then
                revivePlayer(closestPlayer)
            elseif zedkover.name == "Soigner la personne" then
                Soigner(closestPlayer)
            elseif zedkover.name == "Crocheter un véhicule" then
                crochetagevehicle()
            elseif zedkover.name == "Gestion Civil" then 
                OpenMenu("Gestion Civil")
            elseif zedkover.name == "Animations" then 
                OpenMenu("Animations")
            elseif zedkover.name == "Prendre des notes" then 
                forceAnim({ "CODE_HUMAN_MEDIC_TIME_OF_DEATH" })
            elseif zedkover.name == "Ausculter" then 
                forceAnim({ "CODE_HUMAN_MEDIC_KNEEL" })
            elseif zedkover.name == "Prendre des photos" then 
                forceAnim({ "WORLD_HUMAN_PAPARAZZI" })
            elseif zedkover.name == "Massage cardiaque" then 
                forceAnim({ "CODE_HUMAN_MEDIC_TEND_TO_DEAD" })
            elseif zedkover.name == "~r~Arrêter l'animation" then 
                local pPed = GetPlayerPed(-1)
                ClearPedTasks(pPed)
            elseif zedkover.name == "Effectuer une facture" then 
                CreateFacture("society_ambulance")
            end
        end,
    },
    Menu = {
        ["Action"] = {
            b = {
                {name = "Effectuer une facture", ask = ">", askX = true},
                {name = "Effectuer une annonce", ask = ">", askX = true},
                {name = "Gestion Civil", ask = ">", askX = true},
                {name = "Animations", ask = ">", askX = true},
            }
        },
        ["Animations"] = {
            b = {
                {name = "Prendre des photos", ask = ">", askX = true},
                {name = "Prendre des notes", ask = ">", askX = true},
                {name = "Massage cardiaque", ask = ">", askX = true},
                {name = "Ausculter", ask = ">", askX = true},
                {name = "~r~Arrêter l'animation", ask = ">", askX = true},
            }
        },
        ["Gestion Civil"] = {
            b = {
                {name = "Réanimer la personne", ask = ">", askX = true},
                {name = "Soigner la personne", ask = ">", askX = true},
                {name = "Crocheter un véhicule", ask = ">", askX = true},
            }
        }
    }
}


Citizen.CreateThread(function()

    RequestModel(GetHashKey("s_m_m_paramedic_01"))
    while not HasModelLoaded(GetHashKey("s_m_m_paramedic_01")) do 
        Wait(1) 
    end
    ped = CreatePed(4, "s_m_m_paramedic_01", Config.Pedgarageems.x, Config.Pedgarageems.y, Config.Pedgarageems.z, false, true)
    FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
    SetEntityHeading(ped, Config.Pedgarageems.a) 
    SetBlockingOfNonTemporaryEvents(ped, true)
    ped = CreatePed(4, "s_m_m_paramedic_01", Config.Pedgarageems2.x, Config.Pedgarageems2.y, Config.Pedgarageems2.z, false, true)
    FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
    SetEntityHeading(ped, Config.Pedgarageems2.a) 
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
            if PlayerData.job.name == "ambulance" then 
                time = 350
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local diststock = Vdist(plyCoords, 299.32, -597.80, 43.28, 71)
            local distgarageems = Vdist(plyCoords, 340.93, -574.15, 28.79, 71-0.93)
            local distgarageems2 = Vdist(plyCoords, 340.80, -592.04, 74.16-0.93)
            local diststockage = Vdist(plyCoords, 308.83, -566.03, 43.28-0.93)

      
                if diststockage < 100 or diststock < 0 then
                    time = 0
                    DrawMarker(25, 299.32, -597.80, 43.28-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false) 
                    DrawMarker(25, 308.83, -566.03, 43.28-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false)  
                end

                if diststock <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~stock")
                    if IsControlJustPressed(1,51) then
                        CreateMenu(stock)
                    end
                elseif distgarageems <= 1.5 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~garage")
                    if IsControlJustPressed(1,51) then
                        opengarageems()
                    end
                elseif distgarageems2 <= 1.5 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~garage")
                    if IsControlJustPressed(1,51) then
                        opengarageems2()
                    end
                elseif diststockage <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~stockage")
                    if IsControlJustPressed(1,51) then
                        CreateMenu(stockage)
                    end
                end
        end
        Citizen.Wait(time)
    end
end)

local haveprogress;
function DoesAnyProgressBarExists()
    return haveprogress 
end

function DrawNiceText(Text,Text3,Taille,Text2,Font,Justi,havetext)
    SetTextFont(Font)
    SetTextScale(Taille,Taille)
    SetTextColour(255,255,255,255)
    SetTextJustification(Justi or 1)
    SetTextEntry("STRING")
        if havetext then 
            SetTextWrap(Text,Text+.1)
        end;
        AddTextComponentString(Text2)
    DrawText(Text,Text3)
end

local petitpoint = {".","..","...",""}
function getObjInSight()
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped) + vector3(.0, .0, -.4)
	local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 20.0, 0.0) + vector3(.0, .0, -.4)
	local rayHandle = StartShapeTestRay(pos, entityWorld, 16, ped, 0)
	local _, _, _, _, ent = GetRaycastResult(rayHandle)

	if not IsEntityAnObject(ent) then
		return
	end
	return ent
end

function createProgressBar(Text,r,g,b,a,Timing,NoTiming)
    if not Timing then 
        return 
    end
    killProgressBar()
    haveprogress = true
    Citizen.CreateThread(function()
        local Timing1, Timing2 = .0, GetGameTimer() + Timing
        local E, Timing3 = ""
        while haveprogress and (not NoTiming and Timing1 < 1) do
            Citizen.Wait(0)
            if not NoTiming or Timing1 < 1 then 
                Timing1 = 1-((Timing2 - GetGameTimer())/Timing)
            end
            if not Timing3 or GetGameTimer() >= Timing3 then
                Timing3 = GetGameTimer()+500;
                E = petitpoint[string.len(E)+1] or ""
            end;
            DrawRect(.5,.875,.15,.03,0,0,0,100)
            local y, endroit=.15-.0025,.03-.005;
            local chance = math.max(0,math.min(y,y*Timing1))
            DrawRect((.5-y/2)+chance/2,.875,chance,endroit,r,g,b,a) -- 0,155,255,125
            DrawNiceText(.5,.875-.0125,.3,(Text or"Action en cours")..E,0,0,false)
        end;
        killProgressBar()
    end)
end

function killProgressBar()
    haveprogress = nil 
end

RegisterNetEvent('zambulance:usemedikit')
AddEventHandler('zambulance:usemedikit', function()
    local playerPed = PlayerPedId()
	local PlayerCoords = GetEntityCoords(playerPed)
    forceAnim({ "CODE_HUMAN_MEDIC_KNEEL" })
    createProgressBar("Soins en cours", 0, 255, 185, 120, 10000)
    Citizen.Wait(10000)
    ClearPedTasks(playerPed)
    TriggerEvent('esx_ambulancejob:heal', 'big', true)
    ESX.ShowNotification("~b~Vous venez d'utiliser un kit de soin.")
end)

RegisterNetEvent('zambulance:usebandage')
AddEventHandler('zambulance:usebandage', function()
	local PlayerCoords = GetEntityCoords(playerPed)
    local playerPed = PlayerPedId()
    forceAnim({ "CODE_HUMAN_MEDIC_KNEEL" })
    createProgressBar("Soins en cours", 0, 255, 185, 120, 10000)
    Citizen.Wait(10000)
    ClearPedTasks(playerPed)
    TriggerEvent('esx_ambulancejob:heal', 'small', true)
    ESX.ShowNotification("~b~Vous venez d'utiliser un bandage.")
end)

RegisterNetEvent('zambulance:useparacetamol')
AddEventHandler('zambulance:useparacetamol', function()
	local PlayerCoords = GetEntityCoords(playerPed)
    local playerPed = PlayerPedId()
    forceAnim({ "CODE_HUMAN_MEDIC_KNEEL" })
    createProgressBar("Soins en cours", 0, 255, 185, 120, 10000)
    Citizen.Wait(10000)
    ClearPedTasks(playerPed)
    ESX.ShowNotification("~b~Vous venez d'utiliser un paracétamol.")
    SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) + 15)
end)

RegisterKeyMapping('ems', 'Menu EMS', 'keyboard', 'F6')

RegisterCommand('ems', function()
    if PlayerData.job.name == "ambulance" then 
        CreateMenu(f6ems)
    end    
end)
stockage = {

    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_green}, HeaderColor = {255, 255, 255}, Title = "Stockage", world = true  },
    Data = { currentMenu = "Liste des Objets" },
    Events = {

        onSelected = function(self, _, btn, CMenu, menuData, currentButton, currentSlt, result)
              if btn.name == "Bandage" then
                    TriggerServerEvent('zambulance:buy', 0, "bandage", "bandage")
              elseif btn.name == "Kit de soin" then
                    TriggerServerEvent('zambulance:buy', 0, "medikit", "medikit")
                elseif btn.name == "Paracétamol" then
                    TriggerServerEvent('zambulance:buy', 0, "paracetamol", "paracetamol")
              end
        end,
    },

    Menu = {
        ["Liste des Objets"] = {
            b = {
                {name = "Bandage", ask = ">", askX = true},
                {name = "Kit de soin", ask = ">", askX = true},
                {name = "Paracétamol", ask = ">", askX = true}
            }
        },
    }
}

local ascenseur = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black},  HeaderColor = {255, 255, 255},Title = "Ascenseur", world = true },
	Data = { currentMenu = "ACTIONS DISPONIBLES", GetPlayerName() }, 
    Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			local slide = btn.slidenum
			local btn = btn.name
			local check = btn.unkCheckbox
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)
			
		if btn == "Rez-de-chaussée : accueil" then                                      			
              SetEntityCoords(GetPlayerPed(-1), 332.07,-595.70, 43.28)
       elseif btn == "1er étage : toit" then    
               SetEntityCoords(GetPlayerPed(-1), 339.19,-584.04, 74.1684)
      elseif btn == "-1 étage : garage" then    
               SetEntityCoords(GetPlayerPed(-1), 339.36,-584.60, 28.79) 
end
end

	},
	
	Menu = { 
		["ACTIONS DISPONIBLES"] = { 
			b = { 
                {name = "1er étage : toit", ask = "", askX = true}, 
                {name = "Rez-de-chaussée : accueil", ask = "", askX = true}, 
                {name = "-1 étage : garage", ask = "", askX = true}, 
			}
        }
	}
}


local ascenseurpos = {
    { x = 332.07, y = -595.70, z = 43.28 },
	{ x = 339.36, y = -584.60, z = 28.79 },
	{ x = 339.19, y = -584.04, z = 74.16 },
}


Citizen.CreateThread(function()
    local attente = 150
    while true do
        Wait(attente)

        for k in pairs(ascenseurpos) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, ascenseurpos[k].x, ascenseurpos[k].y, ascenseurpos[k].z)
            DrawMarker(25, ascenseurpos[k].x, ascenseurpos[k].y, ascenseurpos[k].z - 1.0001, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1, 0, 153, 234, 255, 0, 0, 1, 0, 0, 0, 0)
			if dist <= 2.0 then
				attente = 1
				ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~b~interagir avec l'ascenseur")
				if IsControlJustPressed(1,51) then 
                    CreateMenu(ascenseur)
				end
				break
            else
                attente = 150
            end
        end
    end
end)

local ScreenCoords = { baseX = 0.918, baseY = 0.984, titleOffsetX = 0.012, titleOffsetY = -0.012, valueOffsetX = 0.0785, valueOffsetY = -0.0165, pbarOffsetX = 0.047, pbarOffsetY = 0.0015 }
local Sizes = {	timerBarWidth = 0.165, timerBarHeight = 0.035, timerBarMargin = 0.038, pbarWidth = 0.0616, pbarHeight = 0.0105 }
local activeBars = {}

function AddTimerBar(title, itemData) -- Add un timber bar
    if not itemData then return end
    RequestStreamedTextureDict("timerbars", true)

    local barIndex = #activeBars + 1
    activeBars[barIndex] = {
        title = title,
        text = itemData.text,
        textColor = itemData.color or { 255, 255, 255, 255 },
        percentage = itemData.percentage,
        endTime = itemData.endTime,
        pbarBgColor = itemData.bg or { 155, 155, 155, 255 },
        pbarFgColor = itemData.fg or { 255, 255, 255, 255 }
    }

    return barIndex
end

function RemoveTimerBar() -- Remove une timer bar
    activeBars = {}
    SetStreamedTextureDictAsNoLongerNeeded("timerbars")
end

function UpdateTimerBar(barIndex, itemData) -- Update une timer bar
    if not activeBars[barIndex] or not itemData then return end
    for k,v in pairs(itemData) do
        activeBars[barIndex][k] = v
    end
end

local HideHudComponentThisFrame = HideHudComponentThisFrame
local GetSafeZoneSize = GetSafeZoneSize
local DrawSprite = DrawSprite
local DrawText2 = DrawText2
local DrawRect = DrawRect
local SecondsToClock = SecondsToClock
local GetGameTimer = GetGameTimer
local textColor = { 200, 100, 100 }
local math = math

function SecondsToClock(seconds) -- Get les secondes
    seconds = tonumber(seconds)

    if seconds <= 0 then
        return "00:00"
    else
        mins = string.format("%02.f", math.floor(seconds / 60))
        secs = string.format("%02.f", math.floor(seconds - mins * 60))
        return string.format("%s:%s", mins, secs)
    end
end

AddEventHandler('esx:onPlayerDeath', function(data)
	OnPlayerDeath()
end)


function createAnEffect(style,default,time)
    Citizen.CreateThread(function()
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        SetTimecycleModifier(style or"spectator3")
        if default then 
            SetCamEffect(2)
        end;
        DoScreenFadeIn(1000)
        Citizen.Wait(time)
        local pPed = GetPlayerPed(-1)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        ResetPedMovementClipset(pPed,0)
        SetPedIsDrunk(pPed,false)
		SetCamEffect(0)
    end)
end

RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function()
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    local playerPed = PlayerPedId()
    createAnEffect("rply_vignette", false, 5000)
    KO = false
    Ko1 = false
    pouvoireeload = false
    hasnoko = false
    isDead = false
    dead = false
    TaskSetBlockingOfNonTemporaryEvents(GetPlayerPed(-1), false)
    NetworkResurrectLocalPlayer(GetEntityCoords(playerPed), 0, true, true, false)
    SetEntityInvincible(playerPed, false)
    SetEntityHealth(playerPed, 200)
    ESX.RemoveTimerBar()
    LocalPlayer():Set("Ko", false)
    LocalPlayer():Set("Dead", false)
    killProgressBar()
    ClearPedBloodDamage(playerPed)
    ResetScenarioTypesEnabled()
    SetEntityInvincible(playerPed, false)
    ClearTimecycleModifier()
    SetEntityInvincible(GetPlayerPed(-1), false)
    SetPedIsDrunk(playerPed, false)
    SetCamEffect(0)
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(playerPed, "move_m@injured", true)
    ShowAboveRadarMessage("~b~Réanimation\n~w~Vous venez d\'être réanimé par un médecin.")
    SetEntityInvincible(GetPlayerPed(-1), false)
    createAnEffect("rply_vignette", true, 25000)
end)

local function GetPlayerByEntityID(id)
    for i = 0, 255 do
        if (NetworkIsPlayerActive(i) and GetPlayerPed(i) == id) then
            return i
        end
    end
    return nil
end

function Death:TableGetValue(Y,Z,n)
    if not Y or not Z or type(Y)~="table"then 
        return 
    end
    for O,y in pairs(Y)do 
        if n and y[n]==Z or y==Z then 
            return true,O 
        end 
    end 
end

function Death:Revive()
    local pPed = PlayerPedId()
    NetworkResurrectLocalPlayer(GetEntityCoords(pPed), GetEntityHeading(pPed), true, true, false)
    SetTimeout(100, function()
        local pPed2 = GetPlayerPed(-1)
        if pPed ~= pPed2 then
            DeleteEntity(pPed)
        end
    end)
end

function Death:DrawTextScreen(Text,Text3,Taille,Text2,Font,Justi,havetext) -- Créer un text 2D a l'écran
    SetTextFont(Font)
    SetTextScale(Taille, Taille)
    SetTextColour(255, 255, 255, 255)
    SetTextJustification(Justi or 1)
    SetTextEntry("STRING")
    if havetext then 
        SetTextWrap(Text, Text + 0.1)
    end
    AddTextComponentString(Text2)
    DrawText(Text, Text3)
end

function Death:DrawCenterText(msg, time)
	ClearPrints()
	SetTextEntry_2("jamyfafi")
	AddTextComponentString(msg)
	DrawSubtitleTimed(time and math.ceil(time) or 0, true)
end

function Death:TeleportCoords(vector, peds)
	if not vector or not peds then return end
	local x, y, z = vector.x, vector.y, vector.z + 0.98
	peds = peds or PlayerPedId()

	RequestCollisionAtCoord(x, y, z)
	NewLoadSceneStart(x, y, z, x, y, z, 50.0, 0)

	local TimerToGetGround = GetGameTimer()
	while not IsNewLoadSceneLoaded() do
		if GetGameTimer() - TimerToGetGround > 3500 then
			break
		end
		Citizen.Wait(0)
	end

	SetEntityCoordsNoOffset(peds, x, y, z)

	TimerToGetGround = GetGameTimer()
	while not HasCollisionLoadedAroundEntity(peds) do
		if GetGameTimer() - TimerToGetGround > 3500 then
			break
		end
		Citizen.Wait(0)
	end

	local retval, GroundPosZ = GetGroundZCoordWithOffsets(x, y, z)
	TimerToGetGround = GetGameTimer()
	while not retval do
		z = z + 5.0
		retval, GroundPosZ = GetGroundZCoordWithOffsets(x, y, z)
		Wait(0)

		if GetGameTimer() - TimerToGetGround > 3500 then
			break
		end
	end

	SetEntityCoordsNoOffset(peds, x, y, retval and GroundPosZ or z)
	NewLoadSceneStop()
	return true
end

-- Effects
function Death:CreateEffect(style, default, time) -- Créer un effet
    Citizen.CreateThread(function()
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        SetTimecycleModifier(style or "spectator3")
        if default then 
            SetCamEffect(2)
        end
        DoScreenFadeIn(1000)
        Citizen.Wait(time or 20000)
        local pPed = GetPlayerPed(-1)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        SetPedIsDrunk(pPed,false)
		SetCamEffect(0)
    end)
end

function Death:GetAllCauseOfDeath(ped)
    local exist, lastBone = GetPedLastDamageBone(ped)
    local cause, what, timeDeath = GetPedCauseOfDeath(ped), Citizen.InvokeNative(0x93C8B64DEB84728C, ped), Citizen.InvokeNative(0x1E98817B311AE98A, ped)
    if what and DoesEntityExist(what) then
        if IsEntityAPed(what) then
            what = "Traces de combat"
        elseif IsEntityAVehicle(what) then
            what = "Écrasé par un véhicule"
        elseif IsEntityAnObject(what) then
            what = "Semble s'être pris un objet"
        end
    end
    what = type(what) == "string" and what or "Inconnue"

    if cause then
        if IsWeaponValid(cause) then
            cause = Death.weaponHashType[GetWeaponDamageType(cause)] or "Inconnue"
        elseif IsModelInCdimage(cause) then
            cause = "Véhicule"
        end
    end
    cause = type(cause) == "string" and cause or "Mêlée"

    local boneName = "Dos"
    if exist and lastBone then
        for k, v in pairs(Death.boneTypes) do
            if Death:TableGetValue(v, lastBone) then
                boneName = k
                break
            end
        end
    end

    return timeDeath, what, cause, boneName
end

function Death:RequestAndWaitDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do 
        Wait(50)
    end
end

local function ThinkDeath(player)
    Death:DrawTextScreen(0.16, 0.91, 0.4, "Origine: ~b~" .. (Death.deathCause[2] or "Inconnue"), 4)
    Death:DrawTextScreen(0.16, 0.93, 0.4, "Cause: ~b~" .. (Death.deathCause[3] or "Inconnue"), 4)
    Death:DrawTextScreen(0.16, 0.96, 0.4, "Blessure: ~b~" .. (Death.deathCause[4] or "Inconnu"), 4)
    if Death.PlayerDead then
        Death.PlayerKO = false 
        SetPedToRagdoll(player, 1000,1000,0,0,0,0)
        if IsControlJustPressed(1, 47) and Death.Call then 
            ESX.ShowNotification("Vous avez appelé les ~b~secours~s~.")
            TriggerServerEvent("call:makeCall", "ambulance", GetEntityCoords(player))
            Death.Call = false 
        end
        if GetGameTimer() >= Death.deathTime and Death.PlayerDead then
            SetTimecycleModifier("rply_vignette")
            Death:DrawCenterText('Appuyez sur ~b~Y~s~ pour contacter les internes.', 500)
            if IsControlJustPressed(1, 246) then 
                local pPed = player
                Death.PlayerDead = false 
                DoScreenFadeOut(1000)
                Wait(1000)
                Death:TeleportCoords(Death.RespawnPos, pPed)
                Wait(500)
                DoScreenFadeIn(1000)
                ClearPedBloodDamage(pPed)
                PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
                Citizen.Wait(10)
                ClearPedTasksImmediately(pPed)
                Death.HasRespawn = true 
                Death.HasRespawnTimer = GetGameTimer() or 0
                Death:CreateEffect("rply_vignette", true, 35000)
                SetEntityHealth(pPed, 120)
                RequestAnimSet("move_m@drunk@verydrunk")
                while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
                    Citizen.Wait(0)
                end
                PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
                Citizen.Wait(300)
                ESX.ShowNotification("~b~Réanimation\n~w~Vous venez d\'être réanimé par les internes.")
            end
        else
            ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
            SetTimecycleModifier("rply_vignette")
            while GetGameTimer() <= Death.deathTime and Death.PlayerDead do
                Death:DrawTextScreen(0.16, 0.91, 0.4, "Origine: ~b~" .. (Death.deathCause[2] or "Inconnue"), 4)
                Death:DrawTextScreen(0.16, 0.93, 0.4, "Cause: ~b~" .. (Death.deathCause[3] or "Inconnue"), 4)
                Death:DrawTextScreen(0.16, 0.96, 0.4, "Blessure: ~b~" .. (Death.deathCause[4] or "Inconnu"), 4)
                Death:DrawTextScreen(0.85, 0.82, 0.8, "Il vous reste ~b~"..math.floor((Death.deathTime - GetGameTimer()) / 1000).." ~s~secondes.", 4, 0)
                if IsControlJustPressed(1, 47) and Death.Call then 
                    ESX.ShowNotification("Vous avez appelé les ~b~secours~s~.")
                    TriggerServerEvent("call:makeCall", "ambulance", GetEntityCoords(player))
                    Death.Call = false 
                end
                SetPedToRagdoll(player, 1000,1000,0,0,0,0)
                Citizen.Wait(0)
            end
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            ClearTimecycleModifier()
            DoScreenFadeIn(1000)
        end
    elseif Death.PlayerKO then 
        Death.PlayerDead = false 
        SetPedToRagdoll(player, 1000,1000,0,0,0,0)
        if GetGameTimer() >= Death.deathTime and Death.PlayerKO then
            SetTimecycleModifier("rply_vignette")
            Death:DrawCenterText('Appuyez sur ~b~Y~s~ pour vous relever.', 5000)
            if IsControlJustPressed(1, 246) then 
                Death:RequestAndWaitDict('mini@cpr@char_b@cpr_str')
                Death:RequestAndWaitDict('mini@cpr@char_b@cpr_def')
                local pPed = player
                Death.PlayerKO = false 
                DoScreenFadeOut(1000)
                Wait(1000)
                DoScreenFadeIn(1000)
                ClearPedBloodDamage(pPed)
                SetEntityHealth(pPed, 120)
                TaskPlayAnim(pPed, 'mini@cpr@char_b@cpr_def', 'cpr_intro', 8.0, 8.0, -1, 0, 0, false, false, false)
                Citizen.Wait(5200)
                TaskPlayAnim(pPed, 'mini@cpr@char_b@cpr_str', 'cpr_success', 8.0, 8.0, 30590, 0, 0, false, false, false)	
                Citizen.Wait(30590)
                PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
                Citizen.Wait(10)
                ClearPedTasks(pPed)
                if Death.tranch then 
                    Death.HasRespawn = true 
                    Death.HasRespawnTimer = GetGameTimer() or 0
                end
                Death:CreateEffect("rply_vignette", true, Death.tranch and 20000 or 35000)
                RequestAnimSet("move_m@drunk@verydrunk")
                while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
                    Citizen.Wait(0)
                end
                PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
                Citizen.Wait(300)
                ESX.ShowNotification("~b~KO\n~w~Vous venez de vous relever.")
            end
        else
            ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
            SetTimecycleModifier("rply_vignette")
            while GetGameTimer() <= Death.deathTime and Death.PlayerKO do
                Death:DrawTextScreen(0.16, 0.91, 0.4, "Origine: ~b~" .. (Death.deathCause[2] or "Inconnue"), 4)
                Death:DrawTextScreen(0.16, 0.93, 0.4, "Cause: ~b~" .. (Death.deathCause[3] or "Inconnue"), 4)
                Death:DrawTextScreen(0.16, 0.96, 0.4, "Blessure: ~b~" .. (Death.deathCause[4] or "Inconnu"), 4)
                Death:DrawTextScreen(0.85, 0.82, 0.8, "Il vous reste ~b~"..math.floor((Death.deathTime - GetGameTimer()) / 1000).." ~s~secondes.", 4, 0)
                SetPedToRagdoll(player, 1000,1000,0,0,0,0)
                Citizen.Wait(0)
            end
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            ClearTimecycleModifier()
            DoScreenFadeIn(1000)
        end
    end
end

AddEventHandler('zCore:onPlayerDied', function(victimEntity, attackEntity)
    local player = PlayerPedId()
    local pPed = player
    local pPos = GetEntityCoords(player)
    if victimEntity and not Death.PlayerDead and not Death.PlayerKO and IsEntityDead(victimEntity) then
        Death.PlayerDead = true
        Death.Call = true 
        Death.deathCause = table.pack(Death:GetAllCauseOfDeath(pPed))
        Death.deathTime = GetGameTimer() + Death.waitTime
        Death.deathTime1 = GetGameTimer()

        ESX.ShowNotification("Appuyez sur ~b~G~s~ pour contacter les ~b~secours~s~.")

        Death:Revive()
        Death:CreateEffect("rply_vignette", true, Death.waitTime)
        SetPedToRagdollWithFall(pPed, 1500, 2000, 0, - GetEntityForwardVector(pPed), 1.0, 0.0, .0, .0, .0, .0, .0)
        SetTimecycleModifier("rply_vignette")
        Citizen.Wait(1000)
        SetPedToRagdollWithFall(pPed, 0, 0, 0, -GetEntityForwardVector(pPed), .0, 0.0, .0, .0, .0, .0, .0)

        Citizen.CreateThread(function()
            while Death.PlayerDead do 
                Wait(0)
                ThinkDeath(player)
            end
        end)
    end
end)

AddEventHandler('zCore:onPlayerKilled', function(victimEntity, _z)
    local player = PlayerPedId()
    local pPed = player
    local pPos = GetEntityCoords(player)
    if not Death.PlayerDead and not Death.PlayerKO then
        Death.PlayerKO = true
        Death.PlayerDead = false 

        if Death:TableGetValue(Death.WeaponHashcontend, _z) then 
            Death.contend = true 
        elseif Death:TableGetValue(Death.WeaponHashtranch, _z) then 
            Death.tranch = true 
        end

        Death.deathCause = table.pack(Death:GetAllCauseOfDeath(pPed))
        Death.deathTime = GetGameTimer() + (Death.tranch and Death.waitTimeKo + 15000 or Death.waitTimeKo)
        Death.deathTime1 = GetGameTimer()

        ESX.ShowNotification("Vous êtes tombé ~b~KO~s~.")

        Death:Revive()
        Death:CreateEffect("rply_vignette", true, (Death.tranch and Death.waitTimeKo + 15000 or Death.waitTimeKo))
        SetPedToRagdollWithFall(pPed, 1500, 2000, 0, - GetEntityForwardVector(pPed), 1.0, 0.0, .0, .0, .0, .0, .0)
        SetTimecycleModifier("rply_vignette")
        Citizen.Wait(1000)
        SetPedToRagdollWithFall(pPed, 0, 0, 0, -GetEntityForwardVector(pPed), .0, 0.0, .0, .0, .0, .0, .0)

        Citizen.CreateThread(function()
            while Death.PlayerKO do 
                Wait(0)
                ThinkDeath(player)
            end
        end)
    end
end)


Citizen.CreateThread(function()
    while true do
        local pPed = PlayerPedId()
        local wait = 2000

        if IsEntityDead(pPed) then
            local pCause = GetPedSourceOfDeath(pPed)
            local Cause = GetPedCauseOfDeath(pPed)
            local KO = IsPedArmed(pCause, 1) or Death:TableGetValue(Death.AllWeaponKO, Cause)
            TriggerEvent(KO and "zCore:onPlayerKilled" or "zCore:onPlayerDied", pPed, Cause)
        end

        if Death.PlayerDead or Death.PlayerKO then 
            wait = 5
			SetEntityHealth(pPed, 101)
			SetPedToRagdoll(pPed, 1000, 1000, 0, 1, 1, 0)
			ResetPedRagdollTimer(pPed)
			NetworkSetLocalPlayerInvincibleTime(1000)
		end

        if Death.HasRespawn then 
            wait = 5
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 21, true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 45, true)

            SetPedMovementClipset(pPed, "move_m@drunk@verydrunk", true)
        
            Death.RespawnTime = Death.HasRespawnTimer + Death.RespawnTimeClean
            if Death.RespawnTime <= GetGameTimer() then 
                Death.HasRespawn = false 
                Death.RespawnTime = 0
                Death.HasRespawnTimer = 0
                ResetPedMovementClipset(pPed)
            end
        end

        Citizen.Wait(wait)
    end
end)

AddEventHandler("gameEventTriggered", function(eventName, eventArguments)
    if eventName == "CEventNetworkEntityDamage" then
        local victimEntity, attackEntity, _, fatalBool, weaponUsed, _a, _z, _e, _r, _t, entityType = table.unpack(eventArguments)
        local ped = PlayerPedId()

        if ped ~= victimEntity then
            return
        end

        local KO = _a ~= 0 and (IsPedArmed(attackEntity, 1) or Death:TableGetValue(Death.AllWeaponKO, _z))
        if not Death.PlayerDead and not Death.PlayerKO then 
            TriggerEvent(KO and "zCore:onPlayerKilled" or _a ~= 0 and "zCore:onPlayerDied" or "zCore:EntityTakeDamage", victimEntity, attackEntity, _z)
        end
    end
end)


RegisterNetEvent('zAmbulance:revive')
AddEventHandler('zAmbulance:revive', function()
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    local playerPed = PlayerPedId()
    createAnEffect("rply_vignette", false, 5000)
    KO = false
    Ko1 = false
    pouvoireeload = false
    hasnoko = false
    isDead = false
    dead = false
    TaskSetBlockingOfNonTemporaryEvents(GetPlayerPed(-1), false)
    NetworkResurrectLocalPlayer(GetEntityCoords(playerPed), 0, true, true, false)
    SetEntityInvincible(playerPed, false)
    SetEntityHealth(playerPed, 200)
    RemoveTimerBar()
    killProgressBar()
    ClearPedBloodDamage(playerPed)
    ResetScenarioTypesEnabled()
    SetEntityInvincible(playerPed, false)
    ClearTimecycleModifier()
    SetEntityInvincible(GetPlayerPed(-1), false)
    SetPedIsDrunk(playerPed, false)
    SetCamEffect(0)
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(playerPed, "move_m@injured", true)
    SetEntityInvincible(GetPlayerPed(-1), false)
    createAnEffect("rply_vignette", true, 25000)
    ESX.ShowNotification("~r~Administration\n~w~Vous venez d\'être réanimé.")
    local pPed = PlayerPedId()
    local pPos = GetEntityCoords(pPed)

    Death.PlayerDead = false 
    Death.PlayerKO = false 
    ClearPedBloodDamage(pPed)
    PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
    SetEntityHealth(pPed, 200)
    Wait(250)
    Death.Invincible = false 
	TriggerEvent('playerSpawned', pPos.x, pPos.y, pPos.z)
	SetCurrentPedWeapon(pPed, GetHashKey('WEAPON_UNARMED'), true)
    ClearPedTasks(pPed)
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	TriggerServerEvent('esx_ambulance:setDeathStatus', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(50)
		end

		local formattedCoords = {
			x = ESX.Math.Round(coords.x, 1),
			y = ESX.Math.Round(coords.y, 1),
			z = ESX.Math.Round(coords.z, 1)
		}
		SetTimecycleModifier('')
		DoScreenFadeIn(800)
end)
end)