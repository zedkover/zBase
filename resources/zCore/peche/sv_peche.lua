ESX              = nil
local PlayerData = {}
PlayersResell   = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('canneapeche', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent("zPeche:usecanne", source)
end)

RegisterServerEvent("zPeche:pechepoisson")
AddEventHandler("zPeche:pechepoisson", function()
    local chance = math.random(0, 99);
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if chance >= 0 and chance <= 18 then
        TriggerClientEvent('esx:DrawMissionText', source, 'Vous avez pêché un ~b~Saumon Rose.~b~ +1', 8500)
        xPlayer.addInventoryItem('saumonrose', 1)
    elseif chance >= 18 and chance <= 37 then
        TriggerClientEvent('esx:DrawMissionText', source, 'Vous avez pêché un ~b~Saumon.~b~ +1', 8500)
        xPlayer.addInventoryItem('saumon', 1)
    elseif chance >= 37 and chance <= 53 then
        TriggerClientEvent('esx:DrawMissionText', source, 'Vous avez pêché un ~b~Cabillaud.~b~ +1', 8500)
        xPlayer.addInventoryItem('sardine', 1)
    elseif chance >= 53 and chance <= 68 then
        TriggerClientEvent('esx:DrawMissionText', source, 'Vous avez pêché une ~b~Truite.~b~ +1', 8500)
        xPlayer.addInventoryItem('truite', 1)
    elseif chance >= 68 and chance <= 85 then
        TriggerClientEvent('esx:DrawMissionText', source, 'Vous avez pêché une ~b~Carpe.~b~ +1', 8500)
        xPlayer.addInventoryItem('carpe', 1)
    elseif chance >= 85 and chance <= 99 then
        TriggerClientEvent('esx:DrawMissionText', source, 'Vous avez pêché une ~b~Sardine.~b~ +1', 8500)
        xPlayer.addInventoryItem('cabillaud', 1)
    end
end)

RegisterServerEvent('reseller:item')
AddEventHandler('reseller:item', function(item, count, price, name)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xMoney = xPlayer.getMoney()
    local quantity = xPlayer.getInventoryItem(item).count
    if quantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez de poissons")
    else
        xPlayer.removeInventoryItem(item, count)
        TriggerClientEvent('esx:showNotification', source, "Vous avez acheté: ~b~"..name)
        xPlayer.addMoney(price)
    end
end)