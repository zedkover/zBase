ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('zTattoo:requestPlayerTattoos', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		MySQL.Async.fetchAll('SELECT tattoos FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			if result[1].tattoos then
				cb(json.decode(result[1].tattoos))
			else
				cb()
			end
		end)
	else
		cb()
	end
end)

RegisterServerEvent('zTattoo:annoncetattoo')
AddEventHandler('zTattoo:annoncetattoo', function(result)
	local _source = source  
	local xPlayers = ESX.GetPlayers()
	local name = GetPlayerName(source)
	for i=1, #xPlayers, 1 do 
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Annonce Blazing Tattoo', '~b~@'..name..'', result, 'CHAR_LIFEINVADER')
		end
end) 


ESX.RegisterServerCallback('zTattoo:purchaseTattoo', function(source, cb, tattooList, tattoo)
	local xPlayer = ESX.GetPlayerFromId(source)

		table.insert(tattooList, tattoo)
		MySQL.Async.execute('UPDATE users SET tattoos = @tattoos WHERE identifier = @identifier', {
			['@tattoos'] = json.encode(tattooList),
			['@identifier'] = xPlayer.identifier
		})	
		cb(true)
end)

RegisterServerEvent('zTattoo:changetattoo')
AddEventHandler('zTattoo:changetattoo', function(target, cr, pr)
	TriggerClientEvent('zTattoo:changetattoocl', target, cr, pr)
end)

RegisterServerEvent('zTattoo:changeclothe')
AddEventHandler('zTattoo:changeclothe', function(target, result, s, r)
	TriggerClientEvent('zTattoo:changeclothecl', target, result, s, r)
end)



RegisterServerEvent('zTattoo:getpedidclsource')
AddEventHandler('zTattoo:getpedidclsource', function(target, playerid)
	TriggerClientEvent('zTattoo:getpedid', target, playerid)
end)


--- stock
ESX.RegisterServerCallback('zTattoo:getinventorytattoo', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	cb({
		items = items
	})
end)

RegisterServerEvent('zTattoo:putStockItemstattoo')
AddEventHandler('zTattoo:putStockItemstattoo', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_tattoo", function(inventory)
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

ESX.RegisterServerCallback('zTattoo:getStockItemstattoo', function(source, cb, info)
	
end)     

ESX.RegisterServerCallback('zTattoo:getStockItemstattoo', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_tattoo', function(inventory)
        cb(inventory.items) 
    end)     
end)       

RegisterServerEvent('zTattoo:getStockItemtattoo')
AddEventHandler('zTattoo:getStockItemtattoo', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_tattoo", function(inventory)
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
