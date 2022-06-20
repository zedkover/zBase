Death = Death or {}

if GetCurrentResourceName() ~= "zCore" then return end

ESX.RegisterServerCallback('zambulance:getinventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	cb({
		items = items
	})
end)

RegisterServerEvent('AmbulanceRevivePlayer')
AddEventHandler('AmbulanceRevivePlayer', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('zBase:RevivePlayerId', target)
end)

RegisterServerEvent('removeItem')
AddEventHandler('removeItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem(item, 1)
end)

ESX.RegisterServerCallback('zbase:getItemAmount', function(source, cb, item)

	local xPlayer = ESX.GetPlayerFromId(source)
    local items = xPlayer.getInventoryItem(item)

    if items == nil then
        cb(0)
    else
        cb(items.count)
    end
end)

RegisterServerEvent('zambulance:buy')
AddEventHandler('zambulance:buy', function(price, item, label)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= price then
	xPlayer.removeMoney(price)
    	xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Vous avez bien reçu votre ~b~Commande", "", 1)
	end
end)

TriggerEvent('es:addGroupCommand', 'revive', 'mod', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			TriggerClientEvent('zCore:RevivePlayerId', tonumber(args[1]))
		end
	else
		TriggerClientEvent('zCore:RevivePlayerId', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient Permissions.")
end, {help = ('Réanimer'), params = {{name = 'id'}}})


ESX.RegisterUsableItem('medikit', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('medikit', 1)
		
	TriggerClientEvent('zambulance:usemedikit', source)

	Citizen.Wait(10000)
end)

ESX.RegisterUsableItem('bandage', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('bandage', 1)
		
	TriggerClientEvent('zambulance:usebandage', source)

	Citizen.Wait(10000)
end)

ESX.RegisterUsableItem('paracetamol', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('paracetamol', 1)
		
	TriggerClientEvent('zambulance:useparacetamol', source)

	Citizen.Wait(10000)
end)

RegisterServerEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(target)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	TriggerClientEvent('esx_ambulancejob:revive', target)
end)


RegisterServerEvent('zambulance:putStockItems')
AddEventHandler('zambulance:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_ambulance", function(inventory)
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

ESX.RegisterServerCallback('zambulance:getStockItems', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
        cb(inventory.items) 
    end)     
end)       

RegisterServerEvent('zambulance:getStockItem')
AddEventHandler('zambulance:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_ambulance", function(inventory)
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

RegisterServerEvent('zambulance:annonceambulance')
AddEventHandler('zambulance:annonceambulance', function(result)
	local _source = source  
	local xPlayers = ESX.GetPlayers()
	local name = GetPlayerName(source)
	for i=1, #xPlayers, 1 do 
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Annonce Pillbox Hill Medical Center', '', result, 'CHAR_CALL911')
		end
end)

ESX.RegisterCommand('revive', 'admin', function(xPlayer, args, showError)
	args.ID.triggerEvent('zAmbulance:revive')
end, true, {help = _U('revive_help'), validate = true, arguments = {
	{name = 'ID', help = 'ID du joueur', type = 'player'}
}})

TriggerEvent('esx:getSharedObject', function(a)
    ESX = a 
end)

RegisterServerEvent("zCore:RevivePlayerId")
AddEventHandler("zCore:RevivePlayerId", function(player)
    TriggerClientEvent("zCore:RevivePlayerId", player)
end)