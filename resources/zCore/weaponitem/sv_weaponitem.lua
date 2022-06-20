ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterServerCallback("ESX:GetInventoryFromPlayer", function(source, cb, target)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    if targetXPlayer ~= nil then
        cb({inventory = targetXPlayer.inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.loadout})
    else
        cb(nil)
    end
end) 

RegisterServerEvent('Loadout:RemoveItem') -- Remove un item
AddEventHandler('Loadout:RemoveItem', function(item, count)
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeInventoryItem(item, count)
end)