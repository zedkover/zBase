ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('sitchairtarget')
AddEventHandler('sitchairtarget', function(target)
        TriggerClientEvent('sitchairtargetcl', target) 
end)

RegisterServerEvent('skinchanger:changetarget')
AddEventHandler('skinchanger:changetarget', function(target, type, var)
        TriggerClientEvent('skinchanger:changetargetcl', target, type, var) 
end)

RegisterServerEvent('annulertarget')
AddEventHandler('annulertarget', function(target)
        TriggerClientEvent('annulertargetcl', target) 
end)

RegisterServerEvent('saveskintarget')
AddEventHandler('saveskintarget', function(target)
        TriggerClientEvent('saveskintargetcl', target) 
end)

RegisterServerEvent('zBarber:annoncebarber')
AddEventHandler('zBarber:annoncebarber', function(result)
	local _source = source  
	local xPlayers = ESX.GetPlayers()
	local name = GetPlayerName(source)
	for i=1, #xPlayers, 1 do 
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Annonce Barbershop', '', result, 'CHAR_HITCHER_GIRL')
		end
end) 

ESX.RegisterServerCallback('zBarber:getinventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	cb({
		items = items
	})
end)

RegisterServerEvent('zBarber:putStockItems')
AddEventHandler('zBarber:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_barber", function(inventory)
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

ESX.RegisterServerCallback('zBarber:getStockItems', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_barber', function(inventory)
        cb(inventory.items) 
    end)     
end)       

RegisterServerEvent('zBarber:getStockItem')
AddEventHandler('zBarber:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_barber", function(inventory)
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