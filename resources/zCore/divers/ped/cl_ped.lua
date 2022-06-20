Ped = setmetatable({}, Ped)
local registeredPeds = {}
local spawnedPeds = {}
function Ped:Add(Model, Pos, Anim,cb)
    local has, pos, bl, anim, mode, dist = Model, Pos, nil, Anim, nil, 4.5
    RegisterLocalPed({ Model = has, Pos = pos, data3D = { dist }, Anim = anim},cb)
end

function GetDistanceBetween3DCoords(x1, y1, z1, x2, y2, z2)

    if x1 ~= nil and y1 ~= nil and z1 ~= nil and x2 ~= nil and y2 ~= nil and z2 ~= nil then
        return math.sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2 + (z1 - z2) ^ 2)
    end
    return -1

end

function RegisterLocalPed(a, cb)
    a.cb = cb
    registeredPeds[#registeredPeds + 1] = a
end

local function CreateLocalPed(a)
    RequestAndWaitModel(a.Model)
    local ped = CreatePed(4, a.Model, a.Pos.x, a.Pos.y, a.Pos.z, a.Pos.a or 0.0, false, false)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedRandomComponentVariation(ped, true)
    if a.Struct then
        setPlayerSkin(a.Struct, { ped = ped })
    else
        SetPedRandomProps(ped)
        SetPedRandomComponentVariation(ped, true)
    end
    SetPedFleeAttributes(ped, 0, 0)
    SetPedKeepTask(ped, true)
    TaskSetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    PlaceObjectOnGroundProperly(ped)
    SetModelAsNoLongerNeeded(ped)

    if a.cb then
        a.cb(ped, a.stuff)
    end
    return ped
end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local Player = GetPlayerPed(-1)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        for k, v in pairs(registeredPeds) do
            local playerClose = GetDistanceBetween3DCoords(coords.x, coords.y, coords.z, v.Pos.x, v.Pos.y, v.Pos.z, true) < 25
            if not spawnedPeds[k] and playerClose then
                spawnedPeds[k] = CreateLocalPed(v)
                DrawText3D(v.Pos.x, v.Pos.y, v.Pos.z + 1.9, v.Anim, 5)
            elseif spawnedPeds[k] and not playerClose then
                DeleteEntity(spawnedPeds[k])
                spawnedPeds[k] = nil
            end
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        local attente = 1000
        local Player = GetPlayerPed(-1)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        for k, v in pairs(registeredPeds) do
            local playerClose = GetDistanceBetween3DCoords(coords.x, coords.y, coords.z, v.Pos.x, v.Pos.y, v.Pos.z, true) < 7
            if playerClose and v.Anim ~= nil then
                attente = 1
                DrawText3D(v.Pos.x, v.Pos.y, v.Pos.z + 1.9, v.Anim, 5)
            end
        end
        Wait(attente)
    end
end)
function InitPed()
    Ped:Add("a_m_y_business_03",{x=232.0088,y=365.3011,z=106.0308-0.98,a=150.56},"John",nil)
    Ped:Add("mp_m_weapexp_01",{x=23.22198,y=-1105.688,z=29.7854-0.98,a=150.56},"Jack",nil)
    Ped:Add("a_m_m_hasjew_01",{x=-505.3318,y=-671.0769,z=33.08789-0.98,a=0.56},"Bob",nil)
    Ped:Add("a_f_y_yoga_01",{x=-413.6044, y=-2699.71, z=5.993408-0.98,a=320.56},"Lidy",nil)
end

InitPed()