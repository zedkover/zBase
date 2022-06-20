local IsOnIsland = false
local IsInSideTeleportLocation = false
local ClosestTeleportLocation = nil
local IsTeleporting = false
local PedCoordinates = vector3(0.0, 0.0, 0.0)

local IslandBounds = {x1 = 6093.88, y1 = -5966.44, x2 = 3283.17, y2 = -4199.8}
local Blips = {}

local function GetFromCoordinate(location)
    local coordinate = location.LosSantosCoordinate
    local heading = location.LosSantosHeading
    if IsOnIsland then
        coordinate = location.IslandCoordinate
        heading = location.IslandHeading
    end

    return coordinate, heading
end

local function GetToCoordinate(location)
    local coordinate = location.IslandCoordinate
    local heading = location.IslandHeading

    if IsOnIsland then
        coordinate = location.LosSantosCoordinate
        heading = location.LosSantosHeading
    end

    return coordinate, heading
end

local function CreateNewBlips()
    for _, blip in pairs(Blips) do RemoveBlip(blip) end

    Blips = {}

    for _, location in pairs(Config.TeleportLocationsIsland) do
        local blip = nil
        local blipName = Config.BlipIsland.LosSantosName
        if not IsOnIsland then
            blip = AddBlipForCoord(location.LosSantosCoordinate.x,
                                   location.LosSantosCoordinate.y,
                                   location.LosSantosCoordinate.z)
        else
            blip = AddBlipForCoord(location.IslandCoordinate.x,
                                   location.IslandCoordinate.y,
                                   location.IslandCoordinate.z)
            blipName = Config.BlipIsland.IslandName
        end

        if blip then
            SetBlipAsShortRange(blip, Config.BlipIsland.MinimapOnly)
            SetBlipSprite(blip, Config.BlipIsland.Sprite)
            SetBlipColour(blip, Config.BlipIsland.Color)
            SetBlipScale(blip, Config.BlipIsland.Size)
            SetBlipDisplayIndicatorOnBlip(blip, false)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(blipName)
            EndTextCommandSetBlipName(blip)
        end
        table.insert(Blips, blip)
    end
end

local function DisplayTeleportHelpText()
    local key = Config.Control

    if not key or not IsInSideTeleportLocation then return end

    local destination = "Cayo Perico"
    if IsOnIsland then destination = "Los Santos" end

    BeginTextCommandDisplayHelp("DOPE_PERICO_HELP")
    AddTextComponentSubstringPlayerName(key.Name)
    AddTextComponentSubstringPlayerName(destination)
    EndTextCommandDisplayHelp(0, false, false, -1)

end

local function GetClosestLocation()
    local closestLocation = Config.TeleportLocationsIsland[1]
    local closestLocationCoords = GetFromCoordinate(closestLocation)

    for index, location in pairs(Config.TeleportLocationsIsland) do
        local startCoordinate = GetFromCoordinate(location)

        local distance = #(PedCoordinates - startCoordinate)
        local currentClosestDistance = #(PedCoordinates - closestLocationCoords)

        if distance < currentClosestDistance then
            closestLocation = location
            closestLocationCoords = startCoordinate
        end
    end

    ClosestTeleportLocation = closestLocation

    local dist = #(PedCoordinates - closestLocationCoords)
    if #(PedCoordinates - closestLocationCoords) < Config.DrawDistanceIsland then
        IsInSideTeleportLocation = true
    end

end

local function IsPointInsideRectangle(x, y, x1, y1, x2, y2)
    return (x1 < x and x < x2) and (y1 < y and y < y2)
end

-- Refresh client's ped coordinates only once 500ms
Citizen.CreateThread(function()
    if IsScreenFadedOut() then DoScreenFadeIn(500) end
    while true do
        PedCoordinates = GetEntityCoords(PlayerPedId(), true)
        Wait(500)
    end
end)

Citizen.CreateThread(function()
    local waitTime = 500
    AddTextEntry("DOPE_PERICO_HELP",
                 "Appuyez sur ~a~ pour payer votre billet ~g~100$~s~ vers ~b~~a~~s~")
    CreateNewBlips()
    while true do
        Wait(waitTime)

        if not IsInSideTeleportLocation then
            GetClosestLocation()
        else
            local closestLocationCoords = GetFromCoordinate(
                                              ClosestTeleportLocation)

            local distance = #(PedCoordinates - closestLocationCoords)
            if distance > 20.0 then
                IsInSideTeleportLocation = false
                waitTime = 500
            else
                waitTime = 0

                if distance < (Config.ActivationDistanceScaler) then
                    DisplayTeleportHelpText()
                    if IsControlJustPressed(1, 51) then
                        TriggerServerEvent('cayoperico:buy')
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('tpisland')
AddEventHandler('tpisland', function()
    if not IsInSideTeleportLocation then
      return
    end

    local endCoordinate, endHeading = GetToCoordinate(ClosestTeleportLocation)

    if not IsTeleporting then
      Citizen.CreateThread(
        function()
          if not IsPlayerTeleportActive() then
            IsTeleporting = true

            local ped = PlayerPedId()
            FreezeEntityPosition(ped, true)
            if IsScreenFadedIn() then
              DoScreenFadeOut(500)
              while not IsScreenFadedOut() do
                Wait(50)
              end
            end

            if (Config.Cutscenes.enabled) then BeginLeaving(IsOnIsland) end
              
            if (Config.Cutscenes.enabled) then BeginLanding(IsOnIsland) end

            StartPlayerTeleport(PlayerId(), endCoordinate.x, endCoordinate.y, endCoordinate.z, endHeading, true, true, false)

            local start = GetGameTimer()
            while IsPlayerTeleportActive() do
              if GetGameTimer() - start > 20000 then
                print("^1Impossible de vous téléporter, contacter un staff pour être TP.^7")
                if IsScreenFadedOut() then
                  DoScreenFadeIn(0)
                end
                return
              end
              Wait(500)
            end

            SetGameplayCamRelativePitch(0.0, 1.0)
            SetGameplayCamRelativeHeading(0.0)

            if IsScreenFadedOut() then
              DoScreenFadeIn(1000)
              while not IsScreenFadedIn() do
                Wait(50)
              end
            end

            IsTeleporting = false
            IsOnIsland = not IsOnIsland

            CreateNewBlips()
            FreezeEntityPosition(ped, false)
          end
        end)
    end
end)

Citizen.CreateThread(function()
    pedls()
    pedcayo()
end)

function pedls()
    local hash = GetHashKey("s_m_m_pilot_01")
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Citizen.Wait(0)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "s_m_m_pilot_01", -1016.42, -2468.58,
                    12.94, 238.37, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GUARD_STAND")
end

function pedcayo()
    local hash22 = GetHashKey("g_m_m_cartelguards_01")
    while not HasModelLoaded(hash22) do
        RequestModel(hash22)
        Citizen.Wait(0)
    end
    ped22 = CreatePed("PED_TYPE_CIVFEMALE", "g_m_m_cartelguards_01", 4425.68,
                      -4487.06, 3.22, 200.55, false, true)
    SetBlockingOfNonTemporaryEvents(ped22, true)
    FreezeEntityPosition(ped22, true)
    SetEntityInvincible(ped22, true)
    TaskStartScenarioInPlace(ped22, "WORLD_HUMAN_GUARD_STAND")
end

local v1 = vector3(-1016.42, -2468.58, 14.9)
local color = {r = 255, g = 255, b = 255, alpha = 255}

local distance = 8

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Vdist2(GetEntityCoords(PlayerPedId(), false), v1) < distance then
            Draw3DText(v1.x, v1.y, v1.z, "Robert")
        end
    end
end)

