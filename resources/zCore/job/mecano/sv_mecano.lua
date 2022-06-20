ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('zedkover:getinventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	cb({
		items = items
	})
end)

RegisterServerEvent('zedkover:buy')
AddEventHandler('zedkover:buy', function(item, count, itemname, price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= price then
		if tonumber(count) > 1 then
			local multiplication = count * price
			xPlayer.removeMoney(multiplication)
			xPlayer.addInventoryItem(item, count)
			TriggerClientEvent('esx:showNotification', _source, "~b~LS Customs\n~s~Vous avez pris ~b~x"..count.." "..itemname.."~s~ pour ~b~"..math.floor(multiplication).."$~s~.")
		else
			if tonumber(count) == 1 then
				xPlayer.removeMoney(price)
				xPlayer.addInventoryItem(item, count)
				TriggerClientEvent('esx:showNotification', _source, "~b~LS Customs\n~s~Vous avez pris ~b~x"..count.." "..itemname.."~s~ pour ~b~"..math.floor(price).."$~s~.")
			end
		end
	else
		TriggerClientEvent('esx:showNotification', _source, "~r~LS Customs\nVous n'avez pas assez d'argent")
	end
end)


ESX.RegisterUsableItem('moteur', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('moteur', 1)
	TriggerClientEvent('zedkover:usemoteur', source)
	Citizen.Wait(10000)
end)

ESX.RegisterUsableItem('lockpick', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('lockpick', 1)
	TriggerClientEvent('zedkover:uselockpick', source)
	Citizen.Wait(10000)
end)

ESX.RegisterUsableItem('pneu', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('pneu', 1)
	TriggerClientEvent('zedkover:usepneu', source)
	Citizen.Wait(10000)
end)

RegisterServerEvent('zedkover:putStockItems')
AddEventHandler('zedkover:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_lscustom", function(inventory)
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

ESX.RegisterServerCallback('zedkover:getStockItems', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lscustom', function(inventory)
        cb(inventory.items) 
    end)     
end)       

RegisterServerEvent('zedkover:getStockItem')
AddEventHandler('zedkover:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_lscustom", function(inventory)
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

RegisterServerEvent('zedkover:annoncelscustom')
AddEventHandler('zedkover:annoncelscustom', function(result)
	local _source = source  
	local xPlayers = ESX.GetPlayers()
	local name = GetPlayerName(source)
	for i=1, #xPlayers, 1 do 
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Annonce LS Customs', '', result, 'CHAR_LS_CUSTOMS')
		end
end)

RegisterCommand("co", function(source, args, rawCommand)
	local player = source
    local ped = GetPlayerPed(player)
    local playerCoords = GetEntityCoords(ped)
	print(playerCoords)
end)