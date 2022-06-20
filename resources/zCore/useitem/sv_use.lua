ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('tenuelongue', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('tenuelongue:usetenue', source)
end)

ESX.RegisterUsableItem('tenuecourte', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('tenuecourte:usetenue', source)
end)

ESX.RegisterUsableItem('tenuecere', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('tenuecere:usetenue', source)
end)

ESX.RegisterUsableItem('tenuemoto', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('tenuemoto:usetenue', source)
end)

ESX.RegisterUsableItem('tenuemoto', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('tenuemoto:usetenue', source)
end)

ESX.RegisterUsableItem('tenuevelo', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('tenuevelo:usetenue', source)
end)

ESX.RegisterUsableItem('tenuepilote', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('tenuepilote:usetenue', source)
end)

local velo = {
    {'bmx', 'bmx'},
    {'fixter', 'fixter'},
    {'scorcher', 'scorcher'},
    {'tribike', 'tribike'},
}

for _,v in pairs(velo) do
    ESX.RegisterUsableItem(v[1], function(source)
       local _source = source
       local xPlayer = ESX.GetPlayerFromId(_source)

       TriggerClientEvent('bmx:usebmx', source, v[2])
       xPlayer.removeInventoryItem(v[2], 1)
    end)
end

RegisterNetEvent('addbmx')
AddEventHandler('addbmx', function(item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx:DrawMissionText', source, "Vous avez ramassé votre ~b~"..item.."~s~. (~b~+1~s~)", 1500)
	xPlayer.addInventoryItem(item, 1)
end)