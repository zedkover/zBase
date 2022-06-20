
local menuautoecole = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = 'Auto École', world = true },
    Data = { currentMenu = "Auto école" },
    Events = {
        onSelected = function (self,_, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)

                local btn = btn.name

                if btn == "Permis voiture" then
                    permisvoiture()
                    CloseMenu(true)
                elseif btn == "Permis moto" then
                    permismoto()
                    CloseMenu(true)
                elseif btn == "Permis poids lourds" then
                    permislourd()
                    CloseMenu(true)
                end
        end,
    },

    Menu = {
        
        ["Auto école"] = {
            b = {
                {name = "Permis voiture", ask = "~b~200$", askX = true},
                {name = "Permis moto", ask = "~b~150$", askX = true},
                {name = "Permis poids lourds", ask = "~b~300$", askX = true},
            }
        },

    }
}


function permisvoiture()
    ESX.TriggerServerCallback('permis:PriceCar', function(price)
        if price then
            StartDriveTest('car')
        else
            CloseMenu(autoecole)
            ESX.ShowNotification("Vous n'avez pas assez ~r~d'argent~w~ pour payer votre examen")
        end
    end, 'car')
end


function permismoto()
    ESX.TriggerServerCallback('permis:PriceBike', function(price)
        if price then
            StartDriveTest('motor')
        else
            CloseMenu(autoecole)
            ESX.ShowNotification("Vous n'avez pas assez ~r~d'argent~w~ pour payer votre examen")
        end
    end, 'motor')
end


function permislourd()
    ESX.TriggerServerCallback('permis:PriceTruck', function(price)
        if price then
            StartDriveTest('heavycar')
        else
            CloseMenu(autoecole)
            ESX.ShowNotification("Vous n'avez pas assez ~r~d'argent~w~ pour payer votre examen")
        end
    end, 'heavycar')
end

local function DrawTopNotification(txt, beep)
	SetTextComponentFormat("jamyfafi")
	AddTextComponentString(txt)
	if string.len(txt) > 99 and AddLongString then AddLongString(txt) end
	DisplayHelpTextFromStringLabel(0, 0, beep, -1)
end

Citizen.CreateThread(function()
    while true do

        local wait = 750
        local v1 = vector3(232.2857, 365.2615, 106.0308)
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local autoecole = Vdist2(plyCoords, 232.2857, 365.2615, 106.0308)
        if autoecole < 1 then
            wait = 5
            DrawTopNotification("Appuyez sur ~INPUT_TALK~ pour passer votre ~b~examen~w~ avec John")
            if IsControlJustPressed(1,51) then 	
                CreateMenu(menuautoecole)
            end
        end
        Citizen.Wait(wait)
    end
end)

local color = {r = 255, g = 255, b = 255, alpha = 255}

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y= World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1/distance)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    if onScreen then
        SetTextScale(0.0 * scale, 0.25 * scale)
		SetTextFont(8)
		SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextCentre(1)
        SetTextEntry('STRING')
        AddTextComponentString(text)
		DrawText(_x,_y)
    end
end

ESX = nil
local CurrentAction     = nil
local CurrentActionMsg  = nil
local CurrentActionData = nil
local Licenses          = {}
local CurrentTest       = nil
local CurrentTestType   = nil
local CurrentVehicle    = nil
local CurrentCheckPoint, DriveErrors = 0, 0
local LastCheckPoint    = -1
local CurrentBlip       = nil
local CurrentZoneType   = nil
local IsAboveSpeedLimit = false
local LastVehicleHealth = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function DrawMissionText(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, true)
end

function StartDriveTest(type)
	ESX.Game.SpawnVehicle(Config.VehicleModels[type], Config.Zones.VehicleSpawnPoint.Pos, Config.Zones.VehicleSpawnPoint.Pos.h, function(vehicle)
		CurrentTest       = 'car'
		CurrentTestType   = type
		CurrentCheckPoint = 0
		LastCheckPoint    = -1
		CurrentZoneType   = 'residence'
		DriveErrors       = 0
		IsAboveSpeedLimit = false
		CurrentVehicle    = vehicle
		LastVehicleHealth = GetEntityHealth(vehicle)

		local playerPed   = PlayerPedId()
		Citizen.Wait(0)
		TimerBar = AddTimerBar3D("ERREUR :",{text=DriveErrors.."/5"})
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		SetVehicleFuelLevel(vehicle, 100.0)
		DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
	end)
end

function StopDriveTest(success)
	if success then
		TriggerServerEvent('11_controlLicense', CurrentTestType, true)
		RemoveTimerBar3D()
		ESX.ShowNotification("Vous avez ~b~réussi~s~ votre examen de conduite")
	else
		ESX.ShowNotification("Vous avez ~r~échoué~s~ votre examen de conduite")
	end

	CurrentTest     = nil
	CurrentTestType = nil
end

function SetCurrentZoneType(type)
CurrentZoneType = type
end

RegisterNetEvent('esx_dmvschool:loadLicenses')
AddEventHandler('esx_dmvschool:loadLicenses', function(licenses)
	Licenses = licenses
end)

local auto = {
    {x = 213.97, y = 391.20, z = 106.84}
}

local function DrawTopNotification(txt, beep)
	SetTextComponentFormat("jamyfafi")
	AddTextComponentString(txt)
	if string.len(txt) > 99 and AddLongString then AddLongString(txt) end
	DisplayHelpTextFromStringLabel(0, 0, beep, -1)
end

-- Drive test
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentTest == 'car' then
			local playerPed      = PlayerPedId()
			local coords         = GetEntityCoords(playerPed)
			local nextCheckPoint = CurrentCheckPoint + 1

			if Config.CheckPoints[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then
					RemoveBlip(CurrentBlip)
				end

				CurrentTest = nil

				ESX.ShowNotification("Votre test de conduite ~b~terminé~s~")

				if DriveErrors < Config.MaxErrors then
					StopDriveTest(true)
				else
					StopDriveTest(false)
				end
			else

				if CurrentCheckPoint ~= LastCheckPoint then
					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end

					CurrentBlip = AddBlipForCoord(Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z)
					SetBlipRoute(CurrentBlip, 1)

					LastCheckPoint = CurrentCheckPoint
				end

				local distance = GetDistanceBetweenCoords(coords, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, true)

				if distance <= 100.0 then
					DrawMarker(6, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3.0 then
					Config.CheckPoints[nextCheckPoint].Action(playerPed, CurrentVehicle, SetCurrentZoneType)
					CurrentCheckPoint = CurrentCheckPoint + 1
				end
			end
		else
			-- not currently taking driver test
			Citizen.Wait(500)
		end
	end
end)

-- Speed / Damage control
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentTest == 'car' then

			local playerPed = PlayerPedId()

			if IsPedInAnyVehicle(playerPed, false) then

				local vehicle      = GetVehiclePedIsIn(playerPed, false)
				local speed        = GetEntitySpeed(vehicle) * Config.SpeedMultiplier
				local tooMuchSpeed = false

				for k,v in pairs(Config.SpeedLimits) do
					if CurrentZoneType == k and speed > v then
						tooMuchSpeed = true

						if not IsAboveSpeedLimit then
							DriveErrors       = DriveErrors + 1
							IsAboveSpeedLimit = true

							UpdateTimerBar3D(TimerBar, {text=DriveErrors.."/5"})
							ESX.ShowNotification("Vous roulez trop ~b~vite~s~, la ~b~vitesse limite~s~ : ~b~"..v.."~s~ km/h")
						end
					end
				end

				if not tooMuchSpeed then
					IsAboveSpeedLimit = false
				end

				local health = GetEntityHealth(vehicle)
				if health < LastVehicleHealth then

					DriveErrors = DriveErrors + 1

					UpdateTimerBar3D(TimerBar, {text=DriveErrors.."/5"})
					ESX.ShowNotification("Vous avez ~r~endommagé~s~ le véhicule")

					-- avoid stacking faults
					LastVehicleHealth = health
					Citizen.Wait(1500)
				end
				
				if DriveErrors == 5 then 
					local PlayerPed = PlayerPedId()
					DoScreenFadeOut(800)
					Citizen.Wait(1500)
					ESX.Game.DeleteVehicle(vehicle)
					RemoveTimerBar3D()
					RemoveBlip(CurrentBlip)
					StopDriveTest(false)
					SetEntityCoords(PlayerPed, 213.702346,390.401367,106.8510)
					SetEntityHeading(PlayerPed, 348.58)
					DoScreenFadeIn(800)
					break
				end

			end
		else
			-- not currently taking driver test
			Citizen.Wait(500)
		end
	end
end)

--------- Bar

local ScreenCoords = { baseX = 0.918, baseY = 0.984, titleOffsetX = 0.012, titleOffsetY = -0.009, valueOffsetX = 0.0785, valueOffsetY = -0.0165, pbarOffsetX = 0.047, pbarOffsetY = 0.0015 }
local Sizes = {	timerBarWidth = 0.165, timerBarHeight = 0.035, timerBarMargin = 0.038, pbarWidth = 0.0616, pbarHeight = 0.0105 }

local activeBars = {}
function AddTimerBar3D(title, itemData)
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

function RemoveTimerBar3D()
	activeBars = {}
	SetStreamedTextureDictAsNoLongerNeeded("timerbars")
end

function UpdateTimerBar3D(barIndex, itemData)
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

function SecondsToClock1(seconds)
	seconds = tonumber(seconds)

	if seconds <= 0 then
		return "00:00"
	else
		mins = string.format("%02.f", math.floor(seconds / 60))
		secs = string.format("%02.f", math.floor(seconds - mins * 60))
		return string.format("%s:%s", mins, secs)
	end
end

function DrawText2(intFont, strText, floatScale, intPosX, intPosY, color, boolShadow, intAlign, addWarp)
	SetTextFont(intFont)
	SetTextScale(floatScale, floatScale)

	if boolShadow then
		SetTextDropShadow(0, 0, 0, 0, 0)
		SetTextEdge(0, 0, 0, 0, 0)
	end

	SetTextColour(color[1], color[2], color[3], 255)
	if intAlign == 0 then
		SetTextCentre(true)
	else
		SetTextJustification(intAlign or 1)
		if intAlign == 2 then
			SetTextWrap(.0, addWarp or intPosX)
		end
	end

	SetTextEntry("jamyfafi")
	AddLongString(strText)

	DrawText(intPosX, intPosY)
end

function AddLongString(txt)
	local maxLen = 100
	for i = 0, string.len(txt), maxLen do
		local sub = string.sub(txt, i, math.min(i + maxLen, string.len(txt)))
		AddTextComponentString(sub)
	end
end

Citizen.CreateThread(function()
	while true do
		local attente = 2000

		local safeZone = GetSafeZoneSize()
		local safeZoneX = (1.0 - safeZone) * 0.5
		local safeZoneY = (1.0 - safeZone) * 0.5

		if #activeBars > 0 then
			attente = 1
			HideHudComponentThisFrame(6)
			HideHudComponentThisFrame(7)
			HideHudComponentThisFrame(8)
			HideHudComponentThisFrame(9)

			for i,v in pairs(activeBars) do
				local drawY = (ScreenCoords.baseY - safeZoneY) - (i * Sizes.timerBarMargin);
				DrawSprite("timerbars", "all_black_bg", ScreenCoords.baseX - safeZoneX, drawY, Sizes.timerBarWidth, Sizes.timerBarHeight, 0.0, 255, 255, 255, 160)
				DrawText2(0, v.title, 0.3, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.titleOffsetX, drawY + ScreenCoords.titleOffsetY, v.textColor, false, 2)

				if v.percentage then
					local pbarX = (ScreenCoords.baseX - safeZoneX) + ScreenCoords.pbarOffsetX;
					local pbarY = drawY + ScreenCoords.pbarOffsetY;
					local width = Sizes.pbarWidth * v.percentage;

					DrawRect(pbarX, pbarY, Sizes.pbarWidth, Sizes.pbarHeight, v.pbarBgColor[1], v.pbarBgColor[2], v.pbarBgColor[3], v.pbarBgColor[4])

					DrawRect((pbarX - Sizes.pbarWidth / 2) + width / 2, pbarY, width, Sizes.pbarHeight, v.pbarFgColor[1], v.pbarFgColor[2], v.pbarFgColor[3], v.pbarFgColor[4])
				elseif v.text then
					DrawText2(0, v.text, 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.valueOffsetX, drawY + ScreenCoords.valueOffsetY, v.textColor, false, 2)
				elseif v.endTime then
					local remainingTime = math.floor(v.endTime - GetGameTimer())
					DrawText2(0, SecondsToClock1(remainingTime / 1000), 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.valueOffsetX, drawY + ScreenCoords.valueOffsetY, remainingTime <= 0 and textColor or v.textColor, false, 2)
				end
				wait = 5
			end
		end
		Wait(attente)
	end
end)

ESX = nil
local CurrentAction     = nil
local CurrentActionMsg  = nil
local CurrentActionData = nil
local Licenses          = {}
local CurrentTest       = nil
local CurrentTestType   = nil
local CurrentVehicle    = nil
local CurrentCheckPoint, DriveErrors = 0, 0
local LastCheckPoint    = -1
local CurrentBlip       = nil
local CurrentZoneType   = nil
local IsAboveSpeedLimit = false
local LastVehicleHealth = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function DrawMissionText(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, true)
end

function StartDriveTest(type)
	ESX.Game.SpawnVehicle(Config.VehicleModels[type], Config.Zones.VehicleSpawnPoint.Pos, Config.Zones.VehicleSpawnPoint.Pos.h, function(vehicle)
		CurrentTest       = 'car'
		CurrentTestType   = type
		CurrentCheckPoint = 0
		LastCheckPoint    = -1
		CurrentZoneType   = 'residence'
		DriveErrors       = 0
		IsAboveSpeedLimit = false
		CurrentVehicle    = vehicle
		LastVehicleHealth = GetEntityHealth(vehicle)

		local playerPed   = PlayerPedId()
		Citizen.Wait(0)
		TimerBar = AddTimerBar3D("ERREUR :",{text=DriveErrors.."/5"})
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		SetVehicleFuelLevel(vehicle, 100.0)
		DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
	end)
end

function StopDriveTest(success)
	if success then
		TriggerServerEvent('11_controlLicense', CurrentTestType, true)
		RemoveTimerBar3D()
		ESX.ShowNotification("Vous avez ~b~réussi~s~ votre examen de conduite")
	else
		ESX.ShowNotification("Vous avez ~r~échoué~s~ votre examen de conduite")
	end

	CurrentTest     = nil
	CurrentTestType = nil
end

function SetCurrentZoneType(type)
CurrentZoneType = type
end

local auto = {
    {x = 213.97, y = 391.20, z = 106.84}
}

local function DrawTopNotification(txt, beep)
	SetTextComponentFormat("jamyfafi")
	AddTextComponentString(txt)
	if string.len(txt) > 99 and AddLongString then AddLongString(txt) end
	DisplayHelpTextFromStringLabel(0, 0, beep, -1)
end

-- Drive test
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentTest == 'car' then
			local playerPed      = PlayerPedId()
			local coords         = GetEntityCoords(playerPed)
			local nextCheckPoint = CurrentCheckPoint + 1

			if Config.CheckPoints[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then
					RemoveBlip(CurrentBlip)
				end

				CurrentTest = nil

				ESX.ShowNotification("Votre test de conduite ~b~terminé~s~")

				if DriveErrors < Config.MaxErrors then
					StopDriveTest(true)
				else
					StopDriveTest(false)
				end
			else

				if CurrentCheckPoint ~= LastCheckPoint then
					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end

					CurrentBlip = AddBlipForCoord(Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z)
					SetBlipRoute(CurrentBlip, 1)

					LastCheckPoint = CurrentCheckPoint
				end

				local distance = GetDistanceBetweenCoords(coords, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, true)

				if distance <= 100.0 then
					DrawMarker(6, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3.0 then
					Config.CheckPoints[nextCheckPoint].Action(playerPed, CurrentVehicle, SetCurrentZoneType)
					CurrentCheckPoint = CurrentCheckPoint + 1
				end
			end
		else
			-- not currently taking driver test
			Citizen.Wait(500)
		end
	end
end)

-- Speed / Damage control
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentTest == 'car' then

			local playerPed = PlayerPedId()

			if IsPedInAnyVehicle(playerPed, false) then

				local vehicle      = GetVehiclePedIsIn(playerPed, false)
				local speed        = GetEntitySpeed(vehicle) * Config.SpeedMultiplier
				local tooMuchSpeed = false

				for k,v in pairs(Config.SpeedLimits) do
					if CurrentZoneType == k and speed > v then
						tooMuchSpeed = true

						if not IsAboveSpeedLimit then
							DriveErrors       = DriveErrors + 1
							IsAboveSpeedLimit = true

							UpdateTimerBar3D(TimerBar, {text=DriveErrors.."/5"})
							ESX.ShowNotification("Vous roulez trop ~b~vite~s~, la ~b~vitesse limite~s~ : ~b~"..v.."~s~ km/h")
						end
					end
				end

				if not tooMuchSpeed then
					IsAboveSpeedLimit = false
				end

				local health = GetEntityHealth(vehicle)
				if health < LastVehicleHealth then

					DriveErrors = DriveErrors + 1

					UpdateTimerBar3D(TimerBar, {text=DriveErrors.."/5"})
					ESX.ShowNotification("Vous avez ~r~endommagé~s~ le véhicule")

					-- avoid stacking faults
					LastVehicleHealth = health
					Citizen.Wait(1500)
				end
				
				if DriveErrors == 5 then 
					local PlayerPed = PlayerPedId()
					DoScreenFadeOut(800)
					Citizen.Wait(1500)
					ESX.Game.DeleteVehicle(vehicle)
					RemoveTimerBar3D()
					RemoveBlip(CurrentBlip)
					StopDriveTest(false)
					SetEntityCoords(PlayerPed, 213.702346,390.401367,106.8510)
					SetEntityHeading(PlayerPed, 348.58)
					DoScreenFadeIn(800)
					break
				end

			end
		else
			-- not currently taking driver test
			Citizen.Wait(500)
		end
	end
end)

--------- Bar

local ScreenCoords = { baseX = 0.918, baseY = 0.984, titleOffsetX = 0.012, titleOffsetY = -0.009, valueOffsetX = 0.0785, valueOffsetY = -0.0165, pbarOffsetX = 0.047, pbarOffsetY = 0.0015 }
local Sizes = {	timerBarWidth = 0.165, timerBarHeight = 0.035, timerBarMargin = 0.038, pbarWidth = 0.0616, pbarHeight = 0.0105 }

local activeBars = {}
function AddTimerBar3D(title, itemData)
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

function RemoveTimerBar3D()
	activeBars = {}
	SetStreamedTextureDictAsNoLongerNeeded("timerbars")
end

function UpdateTimerBar3D(barIndex, itemData)
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

function SecondsToClock1(seconds)
	seconds = tonumber(seconds)

	if seconds <= 0 then
		return "00:00"
	else
		mins = string.format("%02.f", math.floor(seconds / 60))
		secs = string.format("%02.f", math.floor(seconds - mins * 60))
		return string.format("%s:%s", mins, secs)
	end
end

function DrawText2(intFont, strText, floatScale, intPosX, intPosY, color, boolShadow, intAlign, addWarp)
	SetTextFont(intFont)
	SetTextScale(floatScale, floatScale)

	if boolShadow then
		SetTextDropShadow(0, 0, 0, 0, 0)
		SetTextEdge(0, 0, 0, 0, 0)
	end

	SetTextColour(color[1], color[2], color[3], 255)
	if intAlign == 0 then
		SetTextCentre(true)
	else
		SetTextJustification(intAlign or 1)
		if intAlign == 2 then
			SetTextWrap(.0, addWarp or intPosX)
		end
	end

	SetTextEntry("jamyfafi")
	AddLongString(strText)

	DrawText(intPosX, intPosY)
end

function AddLongString(txt)
	local maxLen = 100
	for i = 0, string.len(txt), maxLen do
		local sub = string.sub(txt, i, math.min(i + maxLen, string.len(txt)))
		AddTextComponentString(sub)
	end
end

Citizen.CreateThread(function()
	while true do
		local attente = 2000

		local safeZone = GetSafeZoneSize()
		local safeZoneX = (1.0 - safeZone) * 0.5
		local safeZoneY = (1.0 - safeZone) * 0.5

		if #activeBars > 0 then
			attente = 1
			HideHudComponentThisFrame(6)
			HideHudComponentThisFrame(7)
			HideHudComponentThisFrame(8)
			HideHudComponentThisFrame(9)

			for i,v in pairs(activeBars) do
				local drawY = (ScreenCoords.baseY - safeZoneY) - (i * Sizes.timerBarMargin);
				DrawSprite("timerbars", "all_black_bg", ScreenCoords.baseX - safeZoneX, drawY, Sizes.timerBarWidth, Sizes.timerBarHeight, 0.0, 255, 255, 255, 160)
				DrawText2(0, v.title, 0.3, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.titleOffsetX, drawY + ScreenCoords.titleOffsetY, v.textColor, false, 2)

				if v.percentage then
					local pbarX = (ScreenCoords.baseX - safeZoneX) + ScreenCoords.pbarOffsetX;
					local pbarY = drawY + ScreenCoords.pbarOffsetY;
					local width = Sizes.pbarWidth * v.percentage;

					DrawRect(pbarX, pbarY, Sizes.pbarWidth, Sizes.pbarHeight, v.pbarBgColor[1], v.pbarBgColor[2], v.pbarBgColor[3], v.pbarBgColor[4])

					DrawRect((pbarX - Sizes.pbarWidth / 2) + width / 2, pbarY, width, Sizes.pbarHeight, v.pbarFgColor[1], v.pbarFgColor[2], v.pbarFgColor[3], v.pbarFgColor[4])
				elseif v.text then
					DrawText2(0, v.text, 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.valueOffsetX, drawY + ScreenCoords.valueOffsetY, v.textColor, false, 2)
				elseif v.endTime then
					local remainingTime = math.floor(v.endTime - GetGameTimer())
					DrawText2(0, SecondsToClock1(remainingTime / 1000), 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.valueOffsetX, drawY + ScreenCoords.valueOffsetY, remainingTime <= 0 and textColor or v.textColor, false, 2)
				end
				wait = 5
			end
		end
		Wait(attente)
	end
end)