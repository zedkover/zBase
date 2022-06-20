ESX = nil
PlayerData = {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(a)
			ESX = a
		end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

local Notification = nil

function NotificationClear(msg)
if Notification then
RemoveNotification(Notification)
end
SetNotificationTextEntry("STRING")
AddTextComponentSubstringPlayerName(msg)
Notification = DrawNotification(0, 1)
end

local a = {}
Creator = {}
PMenu = {}
PMenu.Data = {}

onCreatorTick = {
    Tick = true,
    Scaleform = false,
    FaceTurnEnabled = false,
    LightRemote = false
}

local b = true;
local c = false;
local d = false;
local e;
local f = GetHashKey("prop_police_id_board")
local g, h = nil, GetHashKey("prop_police_id_text")
local j = nil;
local k = nil;

local function l() return vector3(404.834, -997.838, -98.841) end

local function m() return vector3(0, 0, -38) end

local function n()
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
        return "mp_character_creation@customise@male_a"
    else
        return "mp_character_creation@customise@male_a"
    end
end

local o, p, q = nil;

function AttachBoardToEntity(r, s, t, u, v)
    f = GetHashKey("prop_police_id_board")
    g, h = GetEntityCoords(r), GetHashKey("prop_police_id_text")
    j = CreateObject(f, g, false, true, false)
    k = CreateObject(h, g, false, true, false)
    o = t;
    p = u;
    q = v;
    AttachEntityToEntity(k, j, -1, 4103, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    SetModelAsNoLongerNeeded(f)
    SetModelAsNoLongerNeeded(h)
    AttachEntityToEntity(j, r, GetPedBoneIndex(r, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1)
    local w = "ID_Text"
    table.insert(a, {
        handleName = w,
        overlayModel = h,
        obj = {j, k},
        handle = CreateNamedRenderTargetForModel(w, h),
        scaleform = createScaleform("mugshot_board_01", {
            {name = "SET_BOARD", param = {s, t, u, "", 0, v, 116}}
        })
    })
    onCreatorTick.Scaleform = true
end

function UpdateBoardToEntity(r)
    AttachEntityToEntity(k, j, -1, 4103, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    SetModelAsNoLongerNeeded(f)
    SetModelAsNoLongerNeeded(h)
    AttachEntityToEntity(j, r, GetPedBoneIndex(r, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1)
end

function RegenCreatorCam() e = CamCreatorInit() end
function GetCreatorCam() return e end

function CreatorLoadContent()
    local player = GetPlayerPed(-1)
    SetPlayerInvincible(player, true)
    SetOverrideWeather("EXTRASUNNY")
    SetWeatherTypePersist("EXTRASUNNY")
    RegenCreatorCam()
    CreatorRequestAssets()
    Citizen.Wait(1000)
    DoScreenFadeIn(500)
    RemoveLoadingPrompt()
    Stage_01(e)
    Stage_01_A(e)
    RenderScriptCams(true, false, 3000, 1, 0, 0)
    Citizen.Wait(5000)
    OpenCreatorMenu()
    onCreatorTick.Tick = true
end
Streaming = {}
function Streaming:Scaleform(z)
    if z ~= nil then
        local A = RequestScaleformMovie(z)
        while not HasScaleformMovieLoaded(A) do Citizen.Wait(1) end
        return A
    else
        error("Missing argument : Movie")
    end
end
function SetScaleformParams(B, C)
    C = C or {}
    for D, E in pairs(C) do
        PushScaleformMovieFunction(B, E.name)
        if E.param then
            for x, F in pairs(E.param) do
                if math.type(F) == "integer" then
                    PushScaleformMovieFunctionParameterInt(F)
                elseif type(F) == "boolean" then
                    PushScaleformMovieFunctionParameterBool(F)
                elseif math.type(F) == "float" then
                    PushScaleformMovieFunctionParameterFloat(F)
                elseif type(F) == "string" then
                    PushScaleformMovieFunctionParameterString(F)
                end
            end
        end
        if E.func then E.func() end
        PopScaleformMovieFunctionVoid()
    end
end
function createScaleform(G, C)
    if not G or string.len(G) <= 0 then return end
    local B = Streaming:Scaleform(G)
    SetScaleformParams(B, C)
    return B
end
function CreateNamedRenderTargetForModel(H, I)
    local J = 0;
    if not IsNamedRendertargetRegistered(H) then
        RegisterNamedRendertarget(H, 0)
    end
    if not IsNamedRendertargetLinked(I) then LinkNamedRendertarget(I) end
    if IsNamedRendertargetRegistered(H) then
        J = GetNamedRendertargetRenderId(H)
    end
    return J
end
local function K(L)
    local M = {"outro", "outro_b", "outro_c", "outro_d"}
    return M[L]
end
local function N(L)
    local M = {"outro_loop", "outro_loop_b", "outro_loop_c", "outro_loop_d"}
    return M[L]
end
function LoopInRoom()
    ClearPedTasksImmediately(PlayerPedId())
    TaskPlayAnim(PlayerPedId(), n(), "Loop", 8.0, -4.0, -1, 513, 0, 0, 0, 0)
    TaskClearLookAt(PlayerPedId())
end
function CreatorUpdateModelAnim()
    UpdateBoardToEntity(PlayerPedId())
    local x, y = OpenSequenceTask(0)
    TaskPlayAnim(0, n(), "loop", 4.0, -4.0, -1, 513, 0, 0, 0, 0)
    CloseSequenceTask(y)
    TaskPerformSequence(PlayerPedId(), y)
    ClearSequenceTask(y)
end
function OnSelectedClothes()
    local O = PlayerPedId()
    local P = n()
    local Q = {
        [1] = "DROP_CLOTHES_A",
        [2] = "DROP_CLOTHES_B",
        [3] = "DROP_CLOTHES_C"
    }
    local R = math.random(0, 4)
    local x, y = OpenSequenceTask(1)
    TaskPlayAnim(0, P, Q[R], 8.0, -8.0, -1, 512, 0, 0, 0, 0)
    TaskPlayAnim(0, P, "DROP_LOOP", 8.0, -8.0, -1, 513, 0, 0, 0, 0)
    CloseSequenceTask(y)
    TaskPerformSequence(O, y)
    ClearSequenceTask(y)
end

function isPlayingAnimSelectedClothes(r)
    if IsEntityPlayingAnim(r, n(), "DROP_CLOTHES_A", 3) or
        IsEntityPlayingAnim(r, n(), "DROP_CLOTHES_B", 3) or
        IsEntityPlayingAnim(r, n(), "DROP_CLOTHES_C", 3) or
        IsEntityPlayingAnim(r, n(), "drop_intro", 3) then
        return true
    else
        return false
    end
end

function OnClothesOpen()
    local O = PlayerPedId()
    local x, y = OpenSequenceTask(1)
    TaskPlayAnim(0, n(), "drop_intro", 8.0, -8.0, -1, 512, 0, 0, 0, 0)
    TaskPlayAnim(0, n(), "drop_loop", 8.0, -8.0, -1, 513, 0, 0, 0, 0)
    CloseSequenceTask(y)
    TaskPerformSequence(O, y)
    ClearSequenceTask(y)
end

function OnClothesClose()
    local O = PlayerPedId()
    if IsEntityPlayingAnim(O, n(), "DROP_LOOP", 3) then
        local x, y = OpenSequenceTask(1)
        TaskPlayAnim(0, n(), "DROP_OUTRO", 8.0, -8.0, -1, 512, 0, 0, 0, 0)
        TaskPlayAnim(0, n(), "Loop", 8.0, -8.0, -1, 513, 0, 0, 0, 0)
        CloseSequenceTask(y)
        TaskPerformSequence(O, y)
        ClearSequenceTask(y)
    end
end

function GetDictionary()
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
        return "mp_character_creation@customise@male_a"
    else
        return "mp_character_creation@customise@male_a"
    end
end

function func_1513(Entity, Stats)
    local sVar1 = GetDictionary()
    local _, sequence
    if (Stats) then
        if
            (IsEntityPlayingAnim(Entity, sVar1, "Profile_L_Intro", 3)) and
                not (IsEntityPlayingAnim(Entity, sVar1, "Profile_L_Loop", 3))
         then
            if (GetEntityAnimCurrentTime(Entity, sVar1, "Profile_L_Intro") >= 0.4) then
                _, sequence = OpenSequenceTask(0)
                TaskPlayAnim(0, GetDictionary(), "Profile_L_Outro", 8.0, -8.0, -1, 512, 0, 0, 0, 0)
                TaskPlayAnim(0, GetDictionary(), "Loop", 8.0, -8.0, -1, 513, 0, 0, 0, 0)
                CloseSequenceTask(sequence)
            else
                return 0
            end
        elseif
            (IsEntityPlayingAnim(Entity, sVar1, "Profile_L_Loop", 3)) and
                not (IsEntityPlayingAnim(Entity, sVar1, "Profile_L_Intro", 3))
         then
            _, sequence = OpenSequenceTask(0)
            TaskPlayAnim(0, GetDictionary(), "Profile_L_Outro", 8.0, -8.0, -1, 512, 0, 0, 0, 0)
            TaskPlayAnim(0, GetDictionary(), "Loop", 8.0, -8.0, -1, 513, 0, 0, 0, 0)
            CloseSequenceTask(sequence)
        end
    else
        _, sequence = OpenSequenceTask(0)
        TaskPlayAnim(0, GetDictionary(), "Profile_L_Intro", 8.0, -8.0, -1, 512, 0, 0, 0, 0)
        TaskPlayAnim(0, GetDictionary(), "Profile_L_Loop", 8.0, -8.0, -1, 513, 0, 0, 0, 0)
        CloseSequenceTask(sequence)
    end
    TaskPerformSequence(PlayerPedId(), sequence)
    ClearSequenceTask(sequence)
    return 1
end

function func_1514(Entity, Stats)
    local sVar1 = GetDictionary()
    local _, sequence
    if (Stats) then
        if
            (IsEntityPlayingAnim(Entity, sVar1, "Profile_R_Intro", 3)) and
                not (IsEntityPlayingAnim(Entity, sVar1, "Profile_R_Loop", 3))
         then
            if (GetEntityAnimCurrentTime(Entity, sVar1, "Profile_R_Intro") >= 0.4) then
                _, sequence = OpenSequenceTask(0)
                TaskPlayAnim(0, GetDictionary(), "Profile_R_Outro", 8.0, -8.0, -1, 512, 0, 0, 0, 0)
                TaskPlayAnim(0, GetDictionary(), "Loop", 8.0, -8.0, -1, 513, 0, 0, 0, 0)
                CloseSequenceTask(sequence)
            else
                return 0
            end
        elseif
            (IsEntityPlayingAnim(Entity, sVar1, "Profile_R_Loop", 3)) and
                not (IsEntityPlayingAnim(Entity, sVar1, "Profile_R_Intro", 3))
         then
            _, sequence = OpenSequenceTask(0)
            TaskPlayAnim(0, GetDictionary(), "Profile_R_Outro", 8.0, -8.0, -1, 512, 0, 0, 0, 0)
            TaskPlayAnim(0, GetDictionary(), "Loop", 8.0, -8.0, -1, 513, 0, 0, 0, 0)
            CloseSequenceTask(sequence)
        end
    else
        _, sequence = OpenSequenceTask(0)
        TaskPlayAnim(0, GetDictionary(), "Profile_R_Intro", 8.0, -8.0, -1, 512, 0, 0, 0, 0)
        TaskPlayAnim(0, GetDictionary(), "Profile_R_Loop", 8.0, -8.0, -1, 513, 0, 0, 0, 0)
        CloseSequenceTask(sequence)
    end
    TaskPerformSequence(PlayerPedId(), sequence)
    ClearSequenceTask(sequence)
    return 1
end

function OnRenderCreatorScaleform()
    -- HideHudAndRadarThisFrame()
    for D, E in pairs(a) do
        SetTextRenderId(a[D].handle)
        SetScriptGfxDrawOrder(4)
        Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
        DrawScaleformMovie(a[D].scaleform, 0.405, 0.37, 0.81, 0.74, 255, 255,
                           255, 255, 0)
        Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
        SetTextRenderId(GetDefaultScriptRendertargetRenderId())
    end
end
function CreatorRequestAssets()
    local U = {"mp_character_creation@customise@male_a"}
    for x, E in pairs(U) do
        RequestAnimDict(E)
        while not HasAnimDictLoaded(E) do
            Citizen.Wait(1)
            RequestAnimDict(E)
        end
    end
    RequestScriptAudioBank("DLC_GTAO/MUGSHOT_ROOM", false, -1)
    RequestScriptAudioBank("Mugshot_Character_Creator", false, -1)
end

function CreatorDeleteAssets()
    local V = {"mp_character_creation@customise@male_a"}
    for x, E in pairs(V) do RemoveAnimDict(E) end
    for D, E in pairs(a) do
        DeleteObject(E.obj[1])
        DeleteObject(E.obj[2])
    end
    onCreatorTick.Scaleform = false;
    onCreatorTick.LightRemote = false;
    onCreatorTick.Tick = false;
    --local W = GetInteriorAtCoordsWithType(vector3(399.9, -998.7, -100.0), "v_mugshot")
    --UnpinInterior(W)
    local X = GetPlayerPed()
    SetEntityVisible(X, 1, 1)
    SetEntityInvincible(X, 0)
    FreezeEntityPosition(X, 0)
    RequestScriptAudioBank("DLC_GTAO/MUGSHOT_ROOM", false, -1)
    RequestScriptAudioBank("Mugshot_Character_Creator", false, -1)
end

local function Y(Z, _, a0, a1, a2)
    Citizen.InvokeNative(0xF55E4046F6F831DC, Z, _)
    Citizen.InvokeNative(0xE111A7C0D200CBC5, Z, a0)
    SetCamDofFnumberOfLens(Z, a1)
    SetCamDofMaxNearInFocusDistanceBlendLevel(Z, a2)
end

function CamCreatorInit()
    local e = {
        f_466 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false),
        f_465 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
    }
    e.f_466 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
    e.f_465 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
    return e
end

function Stage_01(O)
    SetCamCoord(O.f_466, 402.7553, -1000.622, -98.48412)
    SetCamRot(O.f_466, -6.716503, 0, -0.276376, 2)
    SetCamFov(O.f_466, 36.95373)
    Y(O.f_466, 3, 1, 1.2, 1)
    SetCamActive(O.f_466, true)
    StopCamShaking(O.f_466, 1)
end

function Stage_01_A(O)
    SetCamCoord(O.f_465, 402.7391, -1003.981, -98.43439)
    SetCamRot(O.f_465, -3.589798, 0, -0.276381, 2)
    SetCamFov(O.f_465, 36.95373)
    Y(O.f_465, 7, 1, 1, 1)
    SetCamActive(O.f_465, true)
    StopCamShaking(O.f_465, 1)
    SetCamActiveWithInterp(O.f_466, O.f_465, 6000, 1, 1)
end

function func_1678(O)
    PlaySoundFrontend(-1, "Zoom_Out", "MUGSHOT_CHARACTER_CREATION_SOUNDS", 0, 0,
                      1)
    local a3 = GetGameplayCamCoords()
    local a4 = GetCamRot(O.f_465, 2)
    local a5 = Citizen.InvokeNative(0x80ec114669daeff4)
    SetCamCoord(O.f_465, a3)
    SetCamRot(O.f_465, a4, 2)
    SetCamFov(O.f_465, a5)
    Y(O.f_465, 3.8, 1, 1.2, 1)
    SetCamActive(O.f_465, true)
    StopCamShaking(O.f_465, 1)
    SetCamCoord(O.f_466, 402.7553, -1000.622, -98.48412)
    SetCamRot(O.f_466, -6.716503, 0, -0.276376, 2)
    SetCamFov(O.f_466, 36.95373)
    StopCamShaking(O.f_466, 1)
    Y(O.f_466, 3, 1, 1.2, 1)
    SetCamActiveWithInterp(O.f_466, O.f_465, 300, 1, 1)
end

function func_1675(O, a6, S)
    local a3 = GetGameplayCamCoords()
    local a4 = GetCamRot(O.f_465, 2)
    local a5 = Citizen.InvokeNative(0x80ec114669daeff4)
    SetCamCoord(O.f_465, a3)
    SetCamRot(O.f_465, a4, 2)
    SetCamFov(O.f_465, a5)
    Y(O.f_465, 3.0, 1.0, 1.2, 1.0)
    SetCamActive(O.f_465, true)
    StopCamShaking(O.f_465, 1)
    if a6 == 1 then
        if not S then
            SetCamCoord(O.f_466, 402.7553, -1000.55, -98.48412)
            SetCamRot(O.f_466, 2.254577, 0, 0.893029, 2)
            SetCamFov(O.f_466, 9.999582)
            Y(O.f_466, 3.8, 1.0, 1.2, 1.0)
        else
            SetCamCoord(O.f_466, 402.7553, -1000.622, -98.48412)
            SetCamRot(O.f_466, 1.260873, 0, 0.834392, 2)
            SetCamFov(O.f_466, 10.01836)
            Y(O.f_466, 3.8, 1.0, 1.2, 1.0)
        end
    else
        if not S then
            SetCamCoord(O.f_466, 402.6852, -1000.129, -98.46554)
            SetCamRot(O.f_466, 2.366912, 0, -2.14811, 2)
            SetCamFov(O.f_466, 9.958394)
            Y(O.f_466, 4.0, 1.0, 1.2, 1.0)
        else
            SetCamCoord(O.f_466, 402.6852, -1000.129, -98.46554)
            SetCamRot(O.f_466, 0.861356, 0, -2.348183, 2)
            SetCamFov(O.f_466, 10.00255)
            Y(O.f_466, 4.0, 1.0, 1.2, 1.0)
        end
    end
    StopCamShaking(O.f_466, 1)
    SetCamActiveWithInterp(O.f_466, O.f_465, 300, 1, 1)
end

function CreatorZoomIn(e)
    PlaySoundFrontend(-1, "Zoom_In", "MUGSHOT_CHARACTER_CREATION_SOUNDS", 0, 0,
                      1)
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
        func_1675(e, 1, 1)
    else
        func_1675(e, 1, 0)
    end
    RenderScriptCams(true, false, 3000, 1, 0, 0)
end

function CreatorZoomOut(e)
    PlaySoundFrontend(-1, "Zoom_Out", "MUGSHOT_CHARACTER_CREATION_SOUNDS", 0, 0,
                      1)
    func_1678(e)
    RenderScriptCams(true, false, 3000, 1, 0, 0)
end

function CloseCreatorMenu()
    CloseMenu(creator)
    PrepareMusicEvent("FM_SUDDEN_DEATH_STOP_MUSIC")
    TriggerMusicEvent("FM_SUDDEN_DEATH_STOP_MUSIC")
    FreezeEntityPosition(playerPed, false)
    onCreatorTick.LightRemote = false
end

function OpenCreatorMenu()
    local playerPed = PlayerPedId()
    Wait(1000)
    CreateMenu(creator)
    PrepareMusicEvent("FM_INTRO_DRIVE_START")
    TriggerMusicEvent("FM_INTRO_DRIVE_START")
    FreezeEntityPosition(playerPed, true)
    onCreatorTick.LightRemote = true
end

RegisterNetEvent("instance:onCreate")
AddEventHandler("instance:onCreate", function(a7)
    if a7.type == "skin" then TriggerEvent("instance:enter", a7) end
end)

function UpdateCreatorTick(type, a8) onCreatorTick[type] = a8 end
AddEventHandler("onResourceStop", function(a9)
    if GetCurrentResourceName() ~= a9 then return end
    CreatorDeleteAssets()
end)
RegisterCommand('give', function()
    cutsceneavion()
end)

function cutsceneavion()
    TriggerEvent('skinchanger:getSkin', function(aa)
        TriggerEvent("exitInstance")
        TriggerServerEvent("addspawns", 'phone')
        TriggerServerEvent("addspawns", 'carte')
        if aa.sex == 1 then
            local playerPed = GetPlayerPed(-1)
            RequestCutsceneWithPlaybackList('mp_intro_concat', 103, 8)
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(aa, ab)
                SetOverrideWeather("EXTRASUNNY")
                SetWeatherTypePersist("EXTRASUNNY")
                SetCutsceneEntityStreamingFlags(aa.sex == 0 and
                                                    "MP_Female_Character" or
                                                    "MP_Male_Character", 0, 1)
                RegisterEntityForCutscene(0, aa.sex == 1 and
                                              "MP_Female_Character", 3,
                                          GetHashKey(
                                              aa.sex == 1 and "mp_f_freemode_01" or
                                                  "mp_m_freemode_01"), 0)
                do
                    i = 0;
                    while i <= 7 do
                        SetCutsceneEntityStreamingFlags(
                            "MP_Plane_Passenger_" .. tostring(i), 0, 1)
                        RegisterEntityForCutscene(0, "MP_Plane_Passenger_" ..
                                                      tostring(i), 3,
                                                  GetHashKey("mp_f_freemode_01"),
                                                  0)
                        RegisterEntityForCutscene(0, "MP_Plane_Passenger_" ..
                                                      tostring(i), 3,
                                                  GetHashKey("mp_m_freemode_01"),
                                                  0)
                        i = i + 1
                    end
                end
                SetCutsceneEntityStreamingFlags('MP_Female_Character', 0, 1)
                local ac = RegisterEntityForCutscene(0, "MP_Male_Character", 3,
                                                     0, 64)
                RegisterEntityForCutscene(PlayerPedId(), 'MP_Female_Character',
                                          0, GetEntityModel(playerPed), 64)
                GetEntityIndexOfCutsceneEntity('MP_Female_Character',
                                               GetHashKey(
                                                   GetEntityModel(
                                                       'MP_Female_Character')))
                NetworkSetEntityInvisibleToNetwork(ac, true)
                SetEntityCoords(playerPed, -1217.34, -2003.68, 9.669)
                SetEntityHeading(playerPed, 323.099)
                StartCutscene(4)
                Wait(31000)
                SetEntityCoords(playerPed, -1221.70, -2694.06, 34.07)
                SetEntityHeading(playerPed, 163.891)
                Wait(44000)
                DoScreenFadeOut(1000)
                Wait(1000)
                StopCutsceneImmediately()
                local player = GetPlayerPed(-1)
                SetPlayerInvincible(player, false)
                SetEntityCoords(playerPed, -491.0, -737.32, 23.92,
                SetEntityHeading(playerPed, 359.89), 0, 0, 1)
                ESX.ShowNotification("~b~Lamar~s~ vous a déposé en ville !")
                DoScreenFadeIn(1000)
            end)
        else
            local playerPed = GetPlayerPed(-1)
            RequestCutsceneWithPlaybackList('mp_intro_concat', 31, 8)
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(aa, ab)
                SetOverrideWeather("EXTRASUNNY")
                SetWeatherTypePersist("EXTRASUNNY")
                id = GetPlayerServerId(PlayerId())
                SetCutsceneEntityStreamingFlags(aa.sex == 0 and
                                                    "MP_Female_Character" or
                                                    "MP_Male_Character", 0, 1)
                RegisterEntityForCutscene(0, aa.sex == 0 and
                                              "MP_Female_Character" or
                                              "MP_Male_Character", 3,
                                          GetHashKey(
                                              aa.sex == 1 and "mp_f_freemode_01" or
                                                  "mp_m_freemode_01"), 0)
                do
                    i = 0;
                    while i <= 7 do
                        SetCutsceneEntityStreamingFlags(
                            "MP_Plane_Passenger_" .. tostring(i), 0, 1)
                        RegisterEntityForCutscene(0, "MP_Plane_Passenger_" ..
                                                      tostring(i), 3,
                                                  GetHashKey("mp_f_freemode_01"),
                                                  0)
                        RegisterEntityForCutscene(0, "MP_Plane_Passenger_" ..
                                                      tostring(i), 3,
                                                  GetHashKey("mp_m_freemode_01"),
                                                  0)
                        i = i + 1
                    end
                end
                SetCutsceneEntityStreamingFlags('MP_Male_Character', 0, 1)
                local ac = RegisterEntityForCutscene(0, "MP_Female_Character",
                                                     3, 0, 64)
                RegisterEntityForCutscene(PlayerPedId(), 'MP_Male_Character', 0,
                                          GetEntityModel(PlayerPedId()), 64)
                GetEntityIndexOfCutsceneEntity('MP_Female_Character',
                                               GetHashKey(
                                                   GetEntityModel(
                                                       'MP_Female_Character')))
                NetworkSetEntityInvisibleToNetwork(ac, true)
                SetEntityCoords(playerPed, -1217.34, -2003.68, 9.669)
                SetEntityHeading(playerPed, 323.099)
                StartCutscene(4)
                Wait(31000)
                SetEntityCoords(playerPed, -1221.70, -2694.06, 34.07)
                SetEntityHeading(playerPed, 163.891)
                Wait(40000)
                DoScreenFadeOut(1000)
                Wait(1000)
                StopCutsceneImmediately()
                SetEntityCoords(playerPed, -491.0, -737.32, 23.92,
                SetEntityHeading(playerPed, 359.89), 0, 0, 1)
                ESX.ShowNotification("~b~Lamar~s~ vous a déposé en ville !")
                DoScreenFadeIn(1000)
            end)
        end
    end)
end
---- Change Seat Slot 1,2,3,4
local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        if IsPedSittingInAnyVehicle(plyPed) then
            local plyVehicle = GetVehiclePedIsIn(plyPed, false)
			CarSpeed = GetEntitySpeed(plyVehicle) * 3.6
			if CarSpeed <= 60.0 then
				if IsControlJustReleased(0, 157) then
					SetPedIntoVehicle(plyPed, plyVehicle, -1)
					Citizen.Wait(10)
				end
				if IsControlJustReleased(0, 158) then
					SetPedIntoVehicle(plyPed, plyVehicle, 0)
					Citizen.Wait(10)
				end
				if IsControlJustReleased(0, 160) then
					SetPedIntoVehicle(plyPed, plyVehicle, 1)
					Citizen.Wait(10)
				end
				if IsControlJustReleased(0, 164) then
					SetPedIntoVehicle(plyPed, plyVehicle, 2)
					Citizen.Wait(10)
				end
			end
		end
		Citizen.Wait(10)
	end
end)

-- Ragdoll

local Player = {
    Ragdoll = false
}

RegisterCommand('ragdoll', function()
	Player.ragdoll = not Player.ragdoll
end, false)

Citizen.CreateThread(function()
    while true do
        local wait = 100000000
        local plyPed = PlayerPedId()
        local entityAlpha = GetEntityAlpha(GetPlayerPed(-1))
        if entityAlpha < 100 then
            wait = 10000
        else
            if Player.ragdoll and IsControlJustReleased(1, 22) or Player.ragdoll and IsControlJustReleased(1, 38) then
                Player.ragdoll = not Player.ragdoll
            end
            if Player.ragdoll then
                SetPedRagdollForceFall(plyPed)
                ResetPedRagdollTimer(PlayerPedId())
                SetPedToRagdoll(PlayerPedId(), 1000, 1000, 3, 0, 0, 0)
                ResetPedRagdollTimer(PlayerPedId())
                DrawTopNotification("Appuyez sur ~INPUT_JUMP~ ou ~INPUT_PICKUP~ pour ~b~vous relever~w~.")
            end
            wait = 10
        end
        Citizen.Wait(wait)
    end
end)

RegisterKeyMapping('ragdoll', 'Tomber par terre', 'keyboard', 'j')

-- Traffic/Stamina/Train

Citizen.CreateThread(function ()
    while true do
      Citizen.Wait(0)
      SetParkedVehicleDensityMultiplierThisFrame(0.0)
      SetRandomVehicleDensityMultiplierThisFrame(0.0)
      SetVehicleDensityMultiplierThisFrame(0.0)
      SetSomeVehicleDensityMultiplierThisFrame(0.0)
      RestorePlayerStamina(PlayerId(), 1.0)
      SwitchTrainTrack(0, true)
      SwitchTrainTrack(3, true)
      N_0x21973bbf8d17edfa(0, 120000)
      SetRandomTrains(true)
    end
end)

-- Get POS

RegisterCommand("pos", function(source, args, raw)
    local ped = GetPlayerPed(PlayerId())
    local coords = GetEntityCoords(ped, false)
    local heading = GetEntityHeading(ped)
    Citizen.Trace(tostring("X: " .. coords.x .. " Y: " .. coords.y .. " Z: " .. coords.z .. " HEADING: " .. heading))
end, false)

-- PVP
AddEventHandler("playerSpawned", function(spawn)
	SetCanAttackFriendly(GetPlayerPed(-1), true, false)
	NetworkSetFriendlyFireOption(true)
end)

-- LoadSreen

AddEventHandler("zscreen:saveData", function(varName, varValue)
	SendNUIMessage({ name = varName, value = varValue })
end)

local handsonhead = false

RegisterCommand("levelesmains", function()
    
    handonhead()
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests@busted", "idle_c", 3) then
                DisableControlAction(0, 24, true) -- attack
                DisableControlAction(0, 25, true) -- aim
                DisableControlAction(0, 37, true) -- weapon wheel
                DisableControlAction(0, 44, true) -- cover
                DisableControlAction(0, 45, true) -- reload
                DisableControlAction(0, 140, true) -- light attack
                DisableControlAction(0, 141, true) -- heavy attack
                DisableControlAction(0, 142, true) -- alternative attack
                DisablePlayerFiring(PlayerPedId(), true) -- Disable weapon firing
            end
        end
    end)
end)

RegisterKeyMapping("levelesmains", "Lever les mains", "keyboard", "X")

function handonhead()
	while not HasAnimDictLoaded("random@arrests@busted") do
        RequestAnimDict("random@arrests@busted")
        Citizen.Wait(5)
    end
	if not handsonhead then 
		handsonhead = true
		TaskPlayAnim(PlayerPedId(), "random@arrests@busted", "idle_c", 3.0, 1.0, -1, 50, 0, false, false, false)
	else
		handsonhead = false
		ClearPedTasks(PlayerPedId())
	end
end

local crouched = false
local GUI = {}
GUI.Time = 0


RegisterKeyMapping('crouch', "S'accroupir", 'keyboard', 'H')


RegisterCommand('crouch', function()
    local plyPed = PlayerPedId()

    if DoesEntityExist(plyPed) and not IsEntityDead(plyPed) then 
        DisableControlAction(1, 104, true)

        if not IsPauseMenuActive() then 
                RequestAnimSet("move_ped_crouched")

                while not HasAnimSetLoaded("move_ped_crouched") do 
                    Citizen.Wait(100)
                end 

                if crouched == true then 
                    ResetPedMovementClipset(plyPed, 1.2)
                    crouched = false 
                elseif crouched == false then
                    SetPedMovementClipset(plyPed, "move_ped_crouched", 1.2)
                    crouched = true 
                end 
                
                GUI.Time = GetGameTimer()
            end
    end 
end)

local mp_pointing = false
local keyPressed = false

local function startPointing()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Citizen.Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end

local once = true
local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if once then
            once = false
        end

        if not keyPressed then
            if IsControlPressed(1, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
                Citizen.Wait(200)
                if not IsControlPressed(1, 29) then
                    keyPressed = true
                    startPointing()
                    mp_pointing = true
                else
                    keyPressed = true
                    while IsControlPressed(1, 29) do
                        Citizen.Wait(50)
                    end
                end
            elseif (IsControlPressed(1, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
        end

        if keyPressed then
            if not IsControlPressed(1, 29) then
                keyPressed = false
            end
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
            stopPointing()
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
            if not IsPedOnFoot(PlayerPedId()) then
                stopPointing()
            else
                local ped = GetPlayerPed(-1)
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

            end
        end
    end
end)