local blips = {
    {title="Zone de Pêche", toggle = true, colour2 = 18, alpha = 128, scale =0.7, colour=18, id=68, x = 3864.19, y = 4463.78, z = 2.73},
    {title="Zone de Pêche", toggle = true, colour2 = 18, alpha = 128, scale =0.7, colour=18, id=68, x = -1604.809, y = 5257.754, z = 2.067383},
    {title="Zone de Pêche", toggle = true, colour2 = 18, alpha = 128, scale =0.7, colour=18, id=68, x = -286.2066, y = 6627.982, z = 7.240234},
    {title="Zone de Pêche", toggle = true, colour2 = 18, alpha = 128, scale =0.7, colour=18, id=68, x = 1340.519, y = 4225.016, z = 33.91357},
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        info.blip = AddBlipForRadius(info.x, info.y, info.z, 80.0)
        SetBlipHighDetail(info.blip, info.toggle)
        SetBlipColour(info.blip, info.colour2)
        SetBlipAlpha (info.blip, info.alpha)
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id) --sprite
        SetBlipDisplay(info.blip, 4) -- info -- display
        SetBlipScale(info.blip, info.scale) -- size
        SetBlipColour(info.blip, info.colour) -- colour
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)

function ShowNotificationWithButton(button, message, back)
	if back then ThefeedNextPostBackgroundColor(back) end
	SetNotificationTextEntry("jamyfafi")
	return EndTextCommandThefeedPostReplayInput(1, button, message)
end

local TimerBar;
local inFishing = false;
local HavePechet
local canStart = false;
local ScalFish;
local Pourcent = .0;
local timepeche = 0;
local inRecup = false;

local pospechet = {
    {pos = vec3(3864.19, 4463.78, 2.73)},
    {pos = vec3(-1604.809, 5257.754, 2.067383)},
    {pos = vec3(-286.2066, 6627.982, 7.240234)},
    {pos = vec3(1340.519, 4225.016, 33.91357)},
}

local ChanceFish = function()
    return
    math.random(30 * 1000, 120 * 1000)
end

local fProps = GetHashKey("apa_prop_yacht_float_1b")
local prop_namepech = GetHashKey("prop_fishing_rod_01")

local dictOne = "amb@world_human_stand_fishing@base"
local distFish = "amb@world_human_stand_fishing@idle_a"

local objectprop;
local notifPecheId
local ScalDeform = { { "INPUT_CONTEXT", 51 }, { "INPUT_ENTER", 23 }, { "INPUT_SPECIAL_ABILITY_SECONDARY", 29 }, { "INPUT_COVER", 44 }, { "INPUT_VEH_HEADLIGHT", 74 }, { "INPUT_CELLPHONE_CAMERA_FOCUS_LOCK", 182 }, { "INPUT_FRONTEND_ACCEPT", 201 }, { "INPUT_PUSH_TO_TALK", 249 } }
local notifPecheId1

local function getPos(pPedCoords)
    for _, v in pairs(pospechet) do
        if GetDistanceBetweenCoords(pPedCoords, v.pos) < 60 then
            return true
        end
    end
end

local function createIntroFish(bool)
    if not bool and HavePechet and DoesEntityExist(HavePechet) then
        SetEntityAsMissionEntity(HavePechet, 1, 1)
        DeleteObject(HavePechet)
        HavePechet = nil
    end
    if not bool and objectprop and DoesEntityExist(objectprop) then
        SetEntityAsMissionEntity(objectprop, 1, 1)
        DeleteObject(objectprop)
        hookfishingRodEntity = nil
    end
    if notifPecheId then
        RemoveNotification(notifPecheId)
        notifPecheId = nil
    end
    if not bool then
        inFishing = false;
        ClearPedTasks(GetPlayerPed(-1))
        if HasScaleformMovieLoaded(ScalFish) then
            SetScaleformMovieAsNoLongerNeeded(ScalFish)
            ScalFish = nil
        end ;
        RemoveTimerBar()
        RemoveAnimDict(dictOne)
        RemoveAnimDict(distFish)
        SetStreamedTextureDictAsNoLongerNeeded("Hunting")
    else
        TaskPlayAnim(GetPlayerPed(-1), dictOne, "base", 8.0, -8.0, -1, 1, .0, false, false, false)
    end ;
    inRecup = false;
    Pourcent = .0;
    timepeche = 0;
    canStart = bool;
    StopAllScreenEffects()
end


local function requestAnims()
    RequestAndWaitDict(dictOne)
    RequestAndWaitDict(distFish)
    RequestAndWaitModel(prop_namepech)
    RequestAndWaitModel(fProps)
    RequestStreamedTextureDict("Hunting", 0)
end

function SetScaleformParams(scaleform, data)
    data = data or {}
    for k, v in pairs(data) do
        PushScaleformMovieFunction(scaleform, v.name)
        if v.param then
            for _, par in pairs(v.param) do
                if math.type(par) == "integer" then
                    PushScaleformMovieFunctionParameterInt(par)
                elseif type(par) == "boolean" then
                    PushScaleformMovieFunctionParameterBool(par)
                elseif math.type(par) == "float" then
                    PushScaleformMovieFunctionParameterFloat(par)
                elseif type(par) == "string" then
                    PushScaleformMovieFunctionParameterString(par)
                end
            end
        end
        if v.func then
            v.func()
        end
        PopScaleformMovieFunctionVoid()
    end
end

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

Citizen.CreateThread(function()
    while true do
        local attente = 500

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
                    DrawText2(0, SecondsToClock(remainingTime / 1000), 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.valueOffsetX, drawY + ScreenCoords.valueOffsetY, remainingTime <= 0 and textColor or v.textColor, false, 2)
                end
            end
        end
        Wait(attente)
    end
end)


function createScaleform(name, data)
    if not name or string.len(name) <= 0 then
        return
    end
    local scaleform = RequestScaleformMovie(name)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    SetScaleformParams(scaleform, data)
    return scaleform
end

local function scalFishS()
    ScalFish = createScaleform(
            "INSTRUCTIONAL_BUTTONS",
            {
                { name = "CLEAR_ALL", param = {} },
                { name = "TOGGLE_MOUSE_BUTTONS", param = { 0 } },
                { name = "CREATE_CONTAINER", param = {} },
                { name = "SET_DATA_SLOT", param = { 0, GetControlInstructionalButton(2, 24, 0), "Ferrer" } },
                { name = "SET_DATA_SLOT", param = { 1, GetControlInstructionalButton(2, 73, 0), "Annuler" } },
                { name = "SET_DATA_SLOT", param = { 2, GetControlInstructionalButton(2, 173, 0), "Derrière" } },
                { name = "SET_DATA_SLOT", param = { 3, GetControlInstructionalButton(2, 172, 0), "Devant" } },
                { name = "SET_DATA_SLOT", param = { 4, GetControlInstructionalButton(2, 190, 0), "Droite" } },
                { name = "SET_DATA_SLOT", param = { 5, GetControlInstructionalButton(2, 189, 0), "Gauche" } },
                { name = "DRAW_INSTRUCTIONAL_BUTTONS", param = { -1 } }
            }
    )
    return ScalFish
end

function PecheStarting()
    local coord = GetEntityCoords(PlayerPedId())
    local ped = PlayerPedId()
    local pPed, pCoords = ped, coord
    if inFishing then
        if notifPecheId1 then
            RemoveNotification(notifPecheId1)
        end
        notifPecheId1 = ESX.ShowNotification("~r~Vous êtes déjà entrain de pêcher.")
        return
    end
    if not getPos(pCoords) then
        if notifPecheId1 then
            RemoveNotification(notifPecheId1)
        end
        notifPecheId1 = ESX.ShowNotification("~r~Vous n'êtes pas dans la zone de pêche.")
        return
    end
    createIntroFish()
    inFishing = true
    requestAnims()
    canStart = true
    TaskPlayAnim(pPed, dictOne, "base", 8.0, -8.0, -1, 1, .0, false, false, false)
    local verif, GTimers = false, GetGameTimer()
    while not verif and GTimers + 3000 > GetGameTimer() do
        Wait(1000)
    end
    objectprop = CreateObject(prop_namepech, GetEntityCoords(pPed), true, false, true)
    SetNetworkIdCanMigrate(ObjToNet(objectprop), false)
    SetModelAsNoLongerNeeded(prop_namepech)
    AttachEntityToEntity(objectprop, pPed, GetPedBoneIndex(pPed, 60309), .0, .0, .0, .0, .0, .0, false, false, false, false, false, true)
    SetPedKeepTask(pPed, true)
    SetBlockingOfNonTemporaryEvents(pPed, true)
    HavePechet = CreateObject(fProps, pCoords.x, pCoords.y, pCoords.z, false, false, true)
    SetModelAsNoLongerNeeded(fProps)
    SetEntityVisible(HavePechet, false, false)
    PlaceObjectOnGroundProperly(HavePechet)
    Citizen.Wait(1000)
    SetEntityAsMissionEntity(HavePechet, 1, 1)
    SetEntityCoordsNoOffset(HavePechet, GetEntityCoords(HavePechet) + GetEntityForwardVector(pPed) * 8, false, false, false)
    SetEntityVisible(HavePechet, true, true)

    ScalFish = scalFishS()
    TimerBar = AddTimerBar("Distance:", { percentage = 0.0, bg = { 0, 75, 100, 255 }, fg = { 0, 150, 200, 255 } })
    local ChanceDropFish = ChanceFish()
    Citizen.CreateThread(function()
        while inFishing do
            Citizen.Wait(0)
            if HavePechet and DoesEntityExist(HavePechet) then
                DrawMarker(0, GetEntityCoords(HavePechet) + vector3(.0, .0, 1.0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.25, 0, 110, 180, 225, 0, 0, 2, 0, 0, 0, 0)
            else
                createIntroFish()
                ChanceDropFish = ChanceFish()
            end

            local press172, press187, press175, press174 = IsControlPressed(1, 172), IsControlPressed(1, 173), IsControlPressed(1, 175), IsControlPressed(1, 174)
            if (press172 or press187 or press175 or press174) and canStart then
                local pPedCoords = GetEntityCoords(HavePechet)
                local pPedWat, pPedWat1 = GetWaterHeightNoWaves(pPedCoords.x, pPedCoords.y, pPedCoords.z)
                if pPedWat then
                    SetEntityHeading(HavePechet, GetEntityHeading(pPed))
                    local pPedMa1, pPedMatrix = GetEntityMatrix(pPed)
                    local Presses = press172 and pPedMa1 or press187 and -pPedMa1 or press174 and -pPedMatrix or press175 and pPedMatrix;
                    Presses = Presses * .025;
                    local getPedCords = pPedCoords + Presses
                    SetEntityCoordsNoOffset(HavePechet, getPedCords.x, getPedCords.y, pPedWat1, false, false, false)
                    TaskLookAtEntity(pPed, HavePechet, -1, 2048, 3)
                end
            end

            if inRecup and ScalFish and HasScaleformMovieLoaded(ScalFish) and TimerBar then
                UpdateTimerBar(TimerBar, { percentage = Pourcent })
                if IsControlJustPressed(1, 24) then
                    Pourcent = math.max(0, math.min(1.0, Pourcent + .02))
                    local s = GetDistanceBetweenCoords(GetEntityCoords(pPed), GetEntityCoords(HavePechet), true)
                    if s > 6 then
                        local YAtG_LV3 = GetEntityCoords(HavePechet)
                        SetEntityCoordsNoOffset(HavePechet, YAtG_LV3 - GetEntityForwardVector(pPed) * 0.075, false, false, false)
                    end
                end
            end ;
            if HasScaleformMovieLoaded(ScalFish) then
                DrawScaleformMovieFullscreen(ScalFish, 255, 255, 255, 255, 0)
            end ;
            if IsControlJustPressed(1, 73) then
                if notifPecheId1 then
                    RemoveNotification(notifPecheId1)
                end
                UpdateTimerBar(TimerBar, { percentage = 0 })
                notifPecheId1 = ESX.ShowNotification("~r~Vous avez abandonné.")
                createIntroFish()
                ChanceDropFish = ChanceFish()
            end
        end
    end)

    local GetTimerThread;
    local bJfct

    Citizen.CreateThread(function()
        local ChanceGood = 200
        while inFishing do
            Citizen.Wait(ChanceDropFish)
            if not inFishing then
                break
            end
            if not inRecup then
                if ChanceDropFish == ChanceGood then
                    ChanceDropFish = ChanceFish()
                elseif ChanceDropFish ~= ChanceGood then
                    canStart = false;
                    inRecup = true;
                    GetTimerThread = nil
                    StartScreenEffect()
                    ChanceDropFish = ChanceGood;
                    Pourcent = .2;
                    timepeche = GetGameTimer()
                    TaskPlayAnim(GetPlayerPed(-1), distFish, "idle_c", 8.0, -8.0, -1, 1, .0, false, false, false)
                    StartScreenEffect("MP_Celeb_Preload_Fade", 1500)
                end
            else

                if Pourcent <= 0 or (Pourcent < 1 and timepeche + 30000 < GetGameTimer()) then

                    createIntroFish(true)
                    PlaySoundFrontend(-1, "LOSER", "HUD_AWARDS", 1)
                    UpdateTimerBar(TimerBar, { percentage = 0 })
                    ESX.ShowNotification("~r~Le poisson s'est échappé.")
                    ChanceDropFish = ChanceFish()

                elseif Pourcent >= 1 then

                    if not GetTimerThread then
                        bJfct = ScalDeform[math.random(1, #ScalDeform)]
                        if notifPecheId then
                            RemoveNotification(notifPecheId)
                            notifPecheId = nil
                        end
                        notifPecheId = ShowNotificationWithButton("~" .. bJfct[1] .. "~", "Appuyez sur la touche.")
                        ChanceDropFish = 10;
                        GetTimerThread = nil;
                        bJfct = nil
                        PlaySoundFrontend(-1, "UNDER_THE_BRIDGE", "HUD_AWARDS", 1)
                        UpdateTimerBar(TimerBar, { percentage = 0 })
                        createIntroFish(true)
                        ChanceDropFish = ChanceFish()
                        TriggerServerEvent("zPeche:pechepoisson") -- Give l'item
                        GetTimerThread = GetGameTimer()
                    else
                        if GetTimerThread ~= nil and GetTimerThread + 2500 < GetGameTimer() then
                            ESX.ShowNotification("~r~Le poisson s'est échappé.")
                            UpdateTimerBar(TimerBar, { percentage = 0 })
                            GetTimerThread = nil;
                            bJfct = nil
                            PlaySoundFrontend(-1, "LOSER", "HUD_AWARDS", 1)
                            ChanceDropFish = ChanceGood;
                            createIntroFish(true)
                        end
                    end
                else
                    Pourcent = Pourcent - .01
                end
            end
        end
    end)
end

RegisterNetEvent('zPeche:usecanne')
AddEventHandler('zPeche:usecanne', function()
    PecheStarting()
end)


local resellerpeche = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Reseller", world = true},
    Data = { currentMenu = "Articles disponibles:"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if btn.name then
                TriggerServerEvent("reseller:item", btn.item, 1, btn.price, btn.name)
            end
        end
    },

    Menu = {
        ["Articles disponibles:"] = {
            b = {
                {name = "Cabillaud", price = 150, item = "cabillaud", askX = true},
                {name = "Saumon Rose", price = 120, item = "saumonrose", askX = true},
                {name = "Saumon", price = 120, item = "saumon", askX = true},
                {name = "Carpe", price = 100, item = "carpe", askX = true},
                {name = "Sardine", price = 100, item = "sardine", askX = true},
                {name = "Truite", price = 90, item = "truite", askX = true},
            }
        },
    }
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local dest = vector3(-413.5385, -2699.618, 5.993408)
        local dist = GetDistanceBetweenCoords(plyCoords, dest, true)
        if dist <= 1.7 then
            ESX.ShowHelpNotification('Appuyez ~INPUT_PICKUP~ pour accéder au ~b~reseller~s~.')
            if IsControlJustPressed(1, 51) then
                CreateMenu(resellerpeche)
            end
        end
    end
end)
