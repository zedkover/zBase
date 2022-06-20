ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('zedkover:annonceunicorn')
AddEventHandler('zedkover:annonceunicorn', function(result)
	local _source = source  
	local xPlayers = ESX.GetPlayers()
	local name = GetPlayerName(source)
	for i=1, #xPlayers, 1 do 
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Annonce Unicorn', '', result, 'CHAR_ASHLEY')
		end
end)

ESX.RegisterServerCallback('zUnicorn:getinventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	cb({
		items = items
	})
end)

RegisterServerEvent('zUnicorn:buy')
AddEventHandler('zUnicorn:buy', function(price, item, label)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= price then
	xPlayer.removeMoney(price)
    	xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Vous avez bien reçu votre ~b~Commande", "", 1)
	end
end)
RegisterServerEvent('zUnicorn:putStockItems')
AddEventHandler('zUnicorn:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_unicorn", function(inventory)
		local item = inventory.getItem(itemName)
		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez ajouter [~b~x' .. count .. '~s~] ~b~' .. item.label)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~La quantité et invalid')
		end
	end)
end)

ESX.RegisterServerCallback('zUnicorn:getStockItems', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_unicorn', function(inventory)
        cb(inventory.items) 
    end)     
end)       

RegisterServerEvent('zUnicorn:getStockItem')
AddEventHandler('zUnicorn:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_unicorn", function(inventory)
		local item = inventory.getItem(itemName)
		if item.count >= tonumber(count) then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~La quantité et invalid')
		end
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez retirer [~b~x' .. count .. '~s~] ~b~' .. item.label)
	end)
end)