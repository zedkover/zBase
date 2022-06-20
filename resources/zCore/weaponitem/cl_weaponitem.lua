ESX = nil;
local a = {}
local b = {}
local c = nil;
local d = nil;
local e = false;
local f = 0;
local g = {}
for h, i in pairs(ConfigWeapons.Weapons) do
    a[GetHashKey(h)] = i
end
for h, i in pairs(ConfigWeapons.AmmoTypes) do
    b[GetHashKey(h)] = i
end
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(j)
            ESX = j
        end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    ESX.TriggerServerCallback("ESX:GetInventoryFromPlayer", function(k)
        g = {}
        for l, m in pairs(k.inventory) do
            if m.count ~= 0 then
                g[#g + 1] = m
            end
        end
    end, GetPlayerServerId(PlayerId()))
end)
function GetAmmoItemFromHash(n)
    for h, i in pairs(ConfigWeapons.Weapons) do
        if n == GetHashKey(i.name) then
            if i.ammo then
                return i.ammo
            else
                return nil
            end
        end
    end
    return nil
end
function GetInventoryItem(h)
    for l, m in pairs(g) do
        if m.name == h then
            return m
        end
    end
    return nil
end
RegisterNetEvent("ESX:RebuildLoadout")
AddEventHandler("ESX:RebuildLoadout", function()
    RebuildLoadout()
end)
function RebuildLoadout()
    ESX.TriggerServerCallback("ESX:GetInventoryFromPlayer", function(k)
        g = {}
        for l, m in pairs(k.inventory) do
            if m.count ~= 0 then
                g[#g + 1] = m
            end
        end
    end, GetPlayerServerId(PlayerId()))
    while not ESX.GetPlayerData() do
        Citizen.Wait(0)
    end
    local o = GetPlayerPed(-1)
    for p, m in pairs(a) do
        local i = GetInventoryItem(m.item)
        if i and i.count ~= 0 then
            local q = 0;
            local r = GetPedAmmoTypeFromWeapon(o, p)
            if r and b[r] then
                local s = GetInventoryItem(b[r].item)
                if s then
                    q = s.count
                end
            end
            if HasPedGotWeapon(o, p, false) then
                if GetAmmoInPedWeapon(o, p) ~= q then
                    SetPedAmmo(o, p, q)
                end
            else
                GiveWeaponToPed(o, p, q, false, false)
            end
        elseif HasPedGotWeapon(o, p, false) then
            RemoveWeaponFromPed(o, p)
        end
    end
end
function RemoveUsedAmmo()
    local o = GetPlayerPed(-1)
    local t = GetAmmoInPedWeapon(o, d)
    local r = b[GetPedAmmoTypeFromWeapon(o, d)]
    if r and r.item then
        local u = f - t;
        if u > 0 then
            TriggerServerEvent('Loadout:RemoveItem', r.item, u)
        end
    end
    return t
end
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(v)
    c = v;
    RebuildLoadout()
end)
AddEventHandler('playerSpawned', function()
    RebuildLoadout()
end)
AddEventHandler('skinchanger:modelLoaded', function()
    RebuildLoadout()
end)
RegisterNetEvent('esx:onAddInventoryItem')
AddEventHandler('esx:onAddInventoryItem', function(h, w)
    Citizen.Wait(1)
    c = ESX.GetPlayerData()
    RebuildLoadout()
    if d then
        f = GetAmmoInPedWeapon(GetPlayerPed(-1), d)
    end
end)
RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(h, w)
    Citizen.Wait(1)
    c = ESX.GetPlayerData()
    RebuildLoadout()
    if d then
        f = GetAmmoInPedWeapon(GetPlayerPed(-1), d)
    end
end)
Citizen.CreateThread(function()
    while true do
        local x = 500;
        local o = GetPlayerPed(-1)
        if IsPedArmed(o, 4) then
            x = 1;
            if d ~= GetSelectedPedWeapon(o) then
                e = false;
                RemoveUsedAmmo()
                d = GetSelectedPedWeapon(o)
                f = GetAmmoInPedWeapon(o, d)
            end
            if IsPedShooting(o) and not e then
                e = true
            elseif e and IsControlJustReleased(0, 24) then
                e = false;
                f = RemoveUsedAmmo()
            elseif not e and IsControlJustPressed(0, 45) then
                f = GetAmmoInPedWeapon(o, d)
            end
        end
        local d = GetSelectedPedWeapon(o)
        local y = GetAmmoInPedWeapon(o, d)
        if IsPedArmed(o, 3) and (y ~= 35 or GetMaxAmmo(o, d, y)) then
            x = 1;
            SetPedAmmo(o, d, 35)
            if d == 615608432 and IsControlJustReleased(0, 24) then
                Wait(1000)
                TriggerServerEvent('Loadout:RemoveItem', 'weapon_molotov', 1)
            elseif d == -1169823560 and IsControlJustReleased(0, 24) then
                Wait(1000)
                TriggerServerEvent('Loadout:RemoveItem', 'weapon_pipebomb', 1)
            elseif d == 600439132 and IsControlJustReleased(0, 24) then
                Wait(1000)
                TriggerServerEvent('Loadout:RemoveItem', 'weapon_ball', 1)
            end
        end
        Wait(x)
    end
end)
Citizen.CreateThread(function()
    Wait(10000)
    while true do 
        local x = 10000
        local o = GetPlayerPed(-1)
        if IsPedArmed(o, 4) then
            x = 5000
            TriggerEvent("ESX:RebuildLoadout")
        else
            x = 10000
            TriggerEvent("ESX:RebuildLoadout")
        end
        Wait(x)
    end
end)