ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('zrestaurant:getinventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	cb({
		items = items
	})
end)

RegisterServerEvent('zrestaurant:buy')
AddEventHandler('zrestaurant:buy', function(price, item, label)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= price then
	xPlayer.removeMoney(price)
    	xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Vous avez bien reçu votre ~b~Commande", "", 1)
	end
end)


ESX.RegisterUsableItem('biere', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('biere', 1)
	TriggerClientEvent('zedkover:usebiere', source)
	Citizen.Wait(10000)
end)

ESX.RegisterUsableItem('whisky', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('whisky', 1)
	TriggerClientEvent('zedkover:usewhisky', source)
	Citizen.Wait(10000)
end)

ESX.RegisterUsableItem('gin', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('gin', 1)
	TriggerClientEvent('zedkover:usegin', source)
	Citizen.Wait(10000)
end)

ESX.RegisterUsableItem('vodka', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('vodka', 1)
	TriggerClientEvent('zedkover:usevodka', source)
	Citizen.Wait(10000)
end)

ESX.RegisterUsableItem('calvados', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('calvados', 1)
	TriggerClientEvent('zedkover:usecalvados', source)
	Citizen.Wait(10000)
end)

RegisterServerEvent('zrestaurant:putStockItems')
AddEventHandler('zrestaurant:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_restaurant", function(inventory)
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

ESX.RegisterServerCallback('zrestaurant:getStockItems', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_restaurant', function(inventory)
        cb(inventory.items) 
    end)     
end)       

RegisterServerEvent('zrestaurant:getStockItem')
AddEventHandler('zrestaurant:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_restaurant", function(inventory)
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

RegisterServerEvent('zedkover:annoncerestaurant')
AddEventHandler('zedkover:annoncerestaurant', function(result)
	local _source = source  
	local xPlayers = ESX.GetPlayers()
	local name = GetPlayerName(source)
	for i=1, #xPlayers, 1 do 
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Annonce Irish Pub', '', result, 'CHAR_MECHANIC')
		end
end)

RegisterServerEvent("zrestaurant:giveMoney")
AddEventHandler("zrestaurant:giveMoney", function(FirstPedSelectedOrderPrice)
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_restaurant', function(account)
		account.addMoney(30)
	end)
end)
