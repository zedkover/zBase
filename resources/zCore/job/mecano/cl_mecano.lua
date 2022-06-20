ESX = nil

local PlayerData = {}
local target = nil

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

garagelsc = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Garage", world = true},
    Data = { currentMenu = "Action", GetPlayerName() },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if self.Data.currentMenu == "Action" and zedkover.name ~= "Ranger le vehicule" then 
                TriggerEvent('esx:deleteVehicle')  
                ESX.Game.SpawnVehicle(zedkover.value, {x = Config.Spawngaragelsc.x,y = Config.Spawngaragelsc.y, z =  Config.Spawngaragelsc.z + 1}, Config.Spawngaragelsc.a, function(vehicle)
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

function repamoteur()
	local player = PlayerPedId()
	local pPed = player
	local pPos = GetEntityCoords(player)
	local pVeh = GetVehicleInSight()
	local time = 15000

    if not pVeh or not DoesEntityExist(pVeh) then ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.") return end
    createProgressBar("Réparation en cours", 0, 255, 185, 120, 15000)
	TaskPlayAnimToPlayer({"mini@repair","fixing_a_ped"}, time, 1)
	SetVehicleDoorOpen(pVeh, 4, false, false)
	SetVehicleUndriveable(pVeh, true)
	Wait(time)
	SetVehicleEngineHealth(pVeh, 1000.0)
	SetVehicleDoorShut(pVeh, 4, false, false)
	SetNetworkIdCanMigrate(VehToNet(pVeh), true)
    ESX.ShowNotification("~b~Vous avez réparé le moteur du véhicule.")
end

function repacaros()
    local playerPed = PlayerPedId()
    local vehicle   = ESX.Game.GetVehicleInDirection()
    local coords    = GetEntityCoords(playerPed)

    if IsPedSittingInAnyVehicle(playerPed) then
        ESX.ShowNotification('Veuillez descendre de la voiture.')
        return
    end

    if DoesEntityExist(vehicle) then
        isBusy = true
        exports['progressBars']:startUI(20000, "Réparation en cours")
        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
        Citizen.CreateThread(function()
            Citizen.Wait(20000)
            SetVehicleFixed(vehicle)
            SetVehicleUndriveable(vehicle,false)
            SetVehicleDeformationFixed(vehicle)
            SetVehicleBodyHealth(vehicle,1000.0)
            SetVehicleEngineOn(vehicle,true,false)
            ForceEntityAiAndAnimationUpdate(vehicle)
            SetVehicleUndriveable(vehicle, false)
            SetVehicleEngineOn(vehicle, true, true)
            ClearPedTasksImmediately(playerPed)

            ESX.ShowNotification('Le véhicule à bien été ~b~réparé.')
            isBusy = false
        end)
    else
        ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
    end
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
        exports['progressBars']:startUI(10000, "Crochetage en cours")
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
        ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
    end
end

function GetVehicleInDirection()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local inDirection = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
	local rayHandle = StartShapeTestRay(playerCoords, inDirection, 10, playerPed, 0)
	local numRayHandle, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)

	if hit == 1 and GetEntityType(entityHit) == 2 then
		return entityHit
	end

	return nil
end

function fourrierevehicle()
    local playerPed = PlayerPedId()

    if IsPedSittingInAnyVehicle(playerPed) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if GetPedInVehicleSeat(vehicle, -1) == playerPed then
            Wait(500)
            ESX.ShowNotification('Le véhicule a été placé en ~b~fourrière')
            ESX.Game.DeleteVehicle(vehicle)
            CloseMenu()
        else
            ESX.ShowNotification('Met toi place conducteur, ou sort de la voiture')
        end
    else
        local vehicle = ESX.Game.GetVehicleInDirection()

        if DoesEntityExist(vehicle) then
            Wait(500)
            ESX.ShowNotification('Le véhicule à été placé en ~b~fourriere')
            ESX.Game.DeleteVehicle(vehicle)
            CloseMenu()
        else
            ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
        end
    end
end

function plateauvehicle()
	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, true)
	local towmodel = GetHashKey('flatbed')
	local isVehicleTow = IsVehicleModel(vehicle, towmodel)
	if isVehicleTow then
		local targetVehicle = GetVehicleInDirection()
		if CurrentlyTowedVehicle == nil then
			if targetVehicle ~= 0 then
				if not IsPedInAnyVehicle(playerPed, true) then
					if vehicle ~= targetVehicle then
						AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						CurrentlyTowedVehicle = targetVehicle
						ESX.ShowNotification("~b~Le véhicule a été attaché avec succès")
					else
						ESX.ShowNotification("~r~Vous ne pouvez pas attacher votre propre Flatbed")
					end
				end
			else
				ESX.ShowNotification("~r~Il n\'y a pas de véhicule à attacher")
			end
		else
			AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
			DetachEntity(CurrentlyTowedVehicle, true, true)
			CurrentlyTowedVehicle = nil
			ESX.ShowNotification("~b~Vous avez détaché le véhicule")
		end
	else
		ESX.ShowNotification("~r~Vous devez avoir un Flatbed pour cette action")
	end
end

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

function pneuvehicle()
	local player = PlayerPedId()
	local pPed = player
	local pPos = GetEntityCoords(player)
	local pVeh = GetVehicleInSight()
	local pTires = {}
	local time = 15000

    if not pVeh or not DoesEntityExist(pVeh) then ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.") return end

	for i = 0, 10 do 
		pTires[i] = IsVehicleTyreBurst(pVeh, i)
	end
    createProgressBar("Remplacement du pneu en cours", 0, 255, 185, 120, 15000)
	UseTheJackFunction(pVeh, 4)
	TaskPlayAnimToPlayer("WORLD_HUMAN_VEHICLE_MECHANIC", time, 1)
	SetEntityHeading(pPed, GetEntityHeading(pPed)-180)
    SetEntityHeading(pPed, GetEntityHeading(pPed))
	Wait(time)
	for k, v in pairs(pTires) do 
		if v and (v == true or v == 1) then
			SetVehicleTyreFixed(pVeh, tonumber(k))
			ESX.ShowNotification("~b~Les pneus du véhicule viennent d'être changées")
		end 
	end

	UseTheJackFunction(pVeh, 4)
end

function nettoyagevehicle()
    local playerPed = PlayerPedId()
    local vehicle   = ESX.Game.GetVehicleInDirection()
    local coords    = GetEntityCoords(playerPed)

    if IsPedSittingInAnyVehicle(playerPed) then
        ESX.ShowNotification('~r~Veuillez sortir de la voiture')
        return
    end

    if DoesEntityExist(vehicle) then
        isBusy = true
        createProgressBar("Nettoyage", 0, 255, 185, 120, 10000)
        TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
        Citizen.CreateThread(function()
            Citizen.Wait(10000)

            SetVehicleDirtLevel(vehicle, 0)
            ClearPedTasksImmediately(playerPed)

            ESX.ShowNotification('Voiture ~b~néttoyé')
            isBusy = false
        end)
    else
        ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
    end
end

function opengaragelsc()
    garagelsc.Menu["Action"].b = {}
    for k, v in pairs(Config.carslsc) do
        table.insert(garagelsc.Menu["Action"].b, {name = v.label, value = v.name})
    end
    table.insert(garagelsc.Menu["Action"].b, {name = "Ranger le vehicule"})
    CreateMenu(garagelsc)
end 

f6lsc = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "LS Customs", world = true},
    Data = { currentMenu = "Action", GetPlayerName() },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if zedkover.name == "Effectuer une annonce" then 
                local result = KeyboardInput('', '', 255)
                if result ~= nil then 
                    TriggerServerEvent('zedkover:annoncelscustom', result)
                end
            elseif zedkover.name == "Réparation Moteur" then
                repamoteur()
            elseif zedkover.name == "Réparation Carrosserie" then
                repacaros()
            elseif zedkover.name == "Crocheter" then
                crochetagevehicle()
            elseif zedkover.name == "Remplacement Pneu" then
                pneuvehicle()
            elseif zedkover.name == "Nettoyage" then
                nettoyagevehicle()
            elseif zedkover.name == "Mettre le véhicule en fourrière" then
                fourrierevehicle()
            elseif zedkover.name == "Mettre le véhicule sur le plateau" then
                plateauvehicle()
            elseif zedkover.name == "Actions véhicules" then 
                OpenMenu("Actions véhicules")
            elseif zedkover.name == "Effectuer une facture" then 
                CreateFacture("society_lscustom")
            end
        end,
    },
    Menu = {
        ["Action"] = {
            b = {
                {name = "Effectuer une facture", ask = ">", askX = true},
                {name = "Effectuer une annonce", ask = ">", askX = true},
                {name = "Actions véhicules", ask = ">", askX = true},
            }
        },
        ["Actions véhicules"] = {
            b = {
                {name = "Réparation Moteur", ask = ">", askX = true},
                {name = "Réparation Carrosserie", ask = ">", askX = true},
                {name = "Remplacement Pneu", ask = ">", askX = true},
                {name = "Nettoyage", ask = ">", askX = true},
                {name = "Mettre le véhicule en fourrière", ask = ">", askX = true},
                {name = "Mettre le véhicule sur le plateau", ask = ">", askX = true},
                {name = "Crocheter", ask = ">", askX = true}
            }
        }
    }
}


Citizen.CreateThread(function()

    RequestModel(GetHashKey("mp_m_waremech_01"))
    while not HasModelLoaded(GetHashKey("mp_m_waremech_01")) do 
        Wait(1) 
    end
    ped = CreatePed(4, "mp_m_waremech_01", Config.Pedgaragelsc.x, Config.Pedgaragelsc.y, Config.Pedgaragelsc.z, false, true)
    FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
    SetEntityHeading(ped, Config.Pedgaragelsc.a) 
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
            if PlayerData.job.name == "lscustom" then 
                time = 350
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local distgaragelsc = Vdist(plyCoords, 721.36, -1084.32, 22.22-0.93)
            local diststockagelsc = Vdist(plyCoords, 735.03, -1064.85, 22.16-0.93)
            local distfourrierelsc = Vdist(plyCoords, 721.2, -1078.233, 22.20288-0.93)
      
                if diststockagelsc < 50 then
                    time = 0
                    DrawMarker(25, 735.03, -1064.85, 22.16-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false) 
                end
                if distfourrierelsc < 25 then
                    time = 0
                    DrawMarker(25, 721.2, -1078.233, 22.20288-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false) 
                end
                if distgaragelsc <= 1.5 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~garage")
                    if IsControlJustPressed(1,51) then
                        opengaragelsc()
                    end
                elseif diststockagelsc <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~stockage")
                    if IsControlJustPressed(1,51) then
                        CreateMenu(stockagelsc)
                    end
                elseif distfourrierelsc <= 1.5 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder à la ~b~fourrière")
                    if IsControlJustPressed(1,51) then
                        fourrier()
                    end
                end
        end
        Citizen.Wait(time)
    end
end)

function RequestAndWaitModel(modelName) -- Request un modèle de véhicule
	if modelName and IsModelInCdimage(modelName) and not HasModelLoaded(modelName) then
		RequestModel(modelName)
		while not HasModelLoaded(modelName) do Citizen.Wait(100) end
	end
end

function GetControlOfEntity(entity)
    local netTime = 15
    NetworkRequestControlOfEntity(entity)
    while not NetworkHasControlOfEntity(entity) and netTime > 0 do
        NetworkRequestControlOfEntity(entity)
        Citizen.Wait(100)
        netTime = netTime - 1
    end
end


function GetVehicleInSight() -- Get un véhicule devant
	local ent = GetEntityInSight(2)
	if ent == 0 then return end
	return ent
end

function TaskPlayAnimToPlayer(a,b,c,d,e)if type(a)~="table"then a={a}end;d,c=d or GetPlayerPed(-1),c and tonumber(c)or false;if not a or not a[1]or string.len(a[1])<1 then return end;if IsEntityPlayingAnim(d,a[1],a[2],3)or IsPedActiveInScenario(d)then ClearPedTasks(d)return end;Citizen.CreateThread(function()TaskForceAnimPlayer(a,c,{ped=d,time=b,pos=e})end)end;local f={"WORLD_HUMAN_MUSICIAN","WORLD_HUMAN_CLIPBOARD"}local g={["WORLD_HUMAN_BUM_WASH"]={"amb@world_human_bum_wash@male@high@idle_a","idle_a"},["WORLD_HUMAN_SIT_UPS"]={"amb@world_human_sit_ups@male@idle_a","idle_a"},["WORLD_HUMAN_PUSH_UPS"]={"amb@world_human_push_ups@male@base","base"},["WORLD_HUMAN_BUM_FREEWAY"]={"amb@world_human_bum_freeway@male@base","base"},["WORLD_HUMAN_CLIPBOARD"]={"amb@world_human_clipboard@male@base","base"},["WORLD_HUMAN_VEHICLE_MECHANIC"]={"amb@world_human_vehicle_mechanic@male@base","base"}}function TaskForceAnimPlayer(a,c,h)c,h=c and tonumber(c)or false,h or{}local d,b,i,j,k,l=h.ped or GetPlayerPed(-1),h.time,h.clearTasks,h.pos,h.ang;if IsPedInAnyVehicle(d)and(not c or c<40)then return end;if not i then ClearPedTasks(d)end;if not a[2]and g[a[1]]and GetEntityModel(d)==-1667301416 then a=g[a[1]]end;if a[2]and not HasAnimDictLoaded(a[1])then if not DoesAnimDictExist(a[1])then return end;RequestAnimDict(a[1])while not HasAnimDictLoaded(a[1])do Citizen.Wait(10)end end;if not a[2]then ClearAreaOfObjects(GetEntityCoords(d),1.0)TaskStartScenarioInPlace(d,a[1],-1,not TableHasValue(f,a[1]))else if not j then TaskPlayAnim(d,a[1],a[2],8.0,-8.0,-1,c or 44,1,0,0,0,0)else TaskPlayAnimAdvanced(d,a[1],a[2],j.x,j.y,j.z,k.x,k.y,k.z,8.0,-8.0,-1,1,1,0,0,0)end end;if b and type(b)=="number"then Citizen.Wait(b)ClearPedTasks(d)end;if not h.dict then RemoveAnimDict(a[1])end end;function TableHasValue(m,n,o)if not m or not n or type(m)~="table"then return end;for p,q in pairs(m)do if o and q[o]==n or q==n then return true,p end end end


function RequestAndWaitDict(dictName) -- Request une animation (dict)
	if dictName and DoesAnimDictExist(dictName) and not HasAnimDictLoaded(dictName) then
		RequestAnimDict(dictName)
		while not HasAnimDictLoaded(dictName) do Citizen.Wait(100) end
	end
end

local IsJackRaised 	= false
local CarJackObj	= nil
function SpawnJackProp(vehicle)
    local heading = GetEntityHeading(vehicle)
    local objPos = GetEntityCoords(vehicle)
	RequestAndWaitModel("prop_carjack")
    CarJackObj = CreateObject(GetHashKey("prop_carjack"), objPos.x, objPos.y, objPos.z - 0.95, true, true, true)
    SetEntityHeading(CarJackObj, heading)
    FreezeEntityPosition(CarJackObj, true)
end

function UseTheJackFunction(vehicle, count)
	local player = PlayerPedId()
	local pPed = player

	TaskTurnPedToFaceEntity(pPed, vehicle, 1.0)
	Citizen.Wait(1000)
	FreezeEntityPosition(vehicle, true)
	local vehPos = GetEntityCoords(vehicle)

	if not IsJackRaised then 
		SpawnJackProp(vehicle)
		Citizen.Wait(250)
	else
		if DoesEntityExist(CarJackObj) then
			GetControlOfEntity(CarJackObj)
			SetEntityAsMissionEntity(CarJackObj)
			SetVehicleHasBeenOwnedByPlayer(CarJackObj, true)
		else
			CarJackObj = GetClosestObjectOfType(vehPos.x, vehPos.y, vehPos.z, 1.2, GetHashKey("prop_carjack"), false, false, false)
			GetControlOfEntity(CarJackObj)
			SetEntityAsMissionEntity(CarJackObj)
			SetVehicleHasBeenOwnedByPlayer(CarJackObj, true)
		end
	end

	local objPos = GetEntityCoords(CarJackObj)
	-- Request & Load Animation:
	local anim_dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@"
	local anim_lib	= "weed_crouch_checkingleaves_idle_02_inspector"
	RequestAndWaitDict(anim_dict)
	-- progbar:
	-- Raise Jack Task:
	if not IsJackRaised then 
		TaskPlayAnim(pPed, anim_dict, anim_lib, 2.0, -3.5, -1, 1, false, false, false, false)
	end
	Citizen.Wait(1000)
	ClearPedTasks(pPed)
	local count = count or 3
	while true do
		vehPos = GetEntityCoords(vehicle)
		objPos = GetEntityCoords(CarJackObj)
		if count > 0 then 
			if not IsJackRaised then 
				TaskPlayAnim(pPed, anim_dict, anim_lib, 3.5, -3.5, -1, 1, false, false, false, false)
			end
			Citizen.Wait(1000)
			ClearPedTasks(pPed)
			if not IsJackRaised then
				SetEntityCoordsNoOffset(vehicle, vehPos.x, vehPos.y, (vehPos.z+0.10), true, false, false, true)
				SetEntityCoordsNoOffset(CarJackObj, objPos.x, objPos.y, (objPos.z+0.10), true, false, false, true)
			else
				SetEntityCoordsNoOffset(vehicle, vehPos.x, vehPos.y, (vehPos.z-0.10), true, false, false, true)
				SetEntityCoordsNoOffset(CarJackObj, objPos.x, objPos.y, (objPos.z-0.10), true, false, false, true)
			end
			FreezeEntityPosition(vehicle, true)
			FreezeEntityPosition(CarJackObj, true)
			count = count - 1
		end
		if count <= 0 then 
			ClearPedTasks(pPed)
			if IsJackRaised then
				FreezeEntityPosition(vehicle, false)
				if DoesEntityExist(CarJackObj) then 
					DeleteEntity(CarJackObj)
					DeleteObject(CarJackObj)
				end
				CarJackObj = nil
				IsJackRaised = false
			else
				IsJackRaised = true
			end
			usingJack = false
			break
		end
	end
	ClearPedTasks(pPed)
end

function GetEntityInSight(entityType) -- Get une entité par son hash (number)
	if entityType and type(entityType) == "string" then 
		entityType = entityType == "VEHICLE" and 2 or entityType == "PED" and 8 end
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped) + vector3(.0, .0, -.4)
	local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 20.0, 0.0) + vector3(.0, .0, -.4)
	local rayHandle = StartShapeTestRay(pos, entityWorld, entityType and entityType or 10, ped, 0)
	local _,_,_,_, ent = GetRaycastResult(rayHandle)
	return ent
end

RegisterNetEvent('zedkover:usemoteur')
AddEventHandler('zedkover:usemoteur', function()
    local playerPed = GetPlayerPed(-1)
	local PlayerCoords = GetEntityCoords(playerPed)
    repamoteur()
end)

RegisterNetEvent('zedkover:uselockpick')
AddEventHandler('zedkover:uselockpick', function()
	local playerPed = GetPlayerPed(-1)
	local PlayerCoords = GetEntityCoords(playerPed)
	crochetagevehicle()
end)

RegisterNetEvent('zedkover:usepneu')
AddEventHandler('zedkover:usepneu', function()
	local playerPed = GetPlayerPed(-1)
	local PlayerCoords = GetEntityCoords(playerPed)
	crochetagevehicle()
end)

RegisterKeyMapping('lscmenu', 'Menu LS Customs', 'keyboard', 'F6')

RegisterCommand('lscmenu', function()
    if PlayerData.job.name == "lscustom" then 
        CreateMenu(f6lsc)
    end    
end)
stockagelsc = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, HeaderScaleForm = "MP_MENU_GLARE", ScaleForm = false, Color = {color_black}, HeaderOpacity = 228, HeaderColor = {255, 255, 255}, Title = "Stockage LSC", world = true},
    Data = { currentMenu = "Stockage"}, 
    Events = {
        onSelected = function(self, _, zk, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
        if self.Data.currentMenu == "Stockage" then
        local result = OuvrirKeyboard("SID_BOX_ID", 'Quantité :', '', 1000)
            if result == "" or result == " " or result == "  " then
                ESX.ShowNotification("~r~La quantité est invalide !")
            else
                TriggerServerEvent("zedkover:buy", zk.itemname, result, zk.name, zk.prix)
            end
        end
    end, 
}, 
    Menu = {
        ["Stockage"] = {
            b = {
                {name = "Pneu", ask = "~b~5$", prix = 5, itemname = "pneu", askX = true},
                {name = "Kit de crochetage", ask = "~b~5$", prix = 5, itemname = "lockpick", askX = true},
                {name = "Kit Moteur", ask = "~b~5$", prix = 5, itemname = "moteur", askX = true},
            }
        }, 
	}
} 

Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end
end)
