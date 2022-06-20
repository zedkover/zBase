ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

ESX.RegisterServerCallback("esx_inventoryhud:getPlayerInventory", function(source, cb, target)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if targetXPlayer ~= nil then
		cb({inventory = targetXPlayer.inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.loadout, weight = targetXPlayer.getWeight(), maxWeight = targetXPlayer.maxWeight})
	else
		cb(nil)
	end
end)

RegisterServerEvent(Shared.prefix.."deleteitem")
AddEventHandler(Shared.prefix.."deleteitem", function(delete)
    MySQL.Async.execute('DELETE FROM vetement WHERE id = @id', { 
            ['@id'] = delete 
    }) 
end)

RegisterServerEvent(Shared.prefix.."changename")
AddEventHandler(Shared.prefix.."changename", function(id, Actif)   
	MySQL.Sync.execute('UPDATE vetement SET nom = @nom WHERE id = @id', {
		['@id'] = id,   
		['@nom'] = Actif        
	})
end) 


ESX.RegisterServerCallback(Shared.prefix.."getalmodifiitems", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items = {}
	MySQL.Async.fetchAll('SELECT * FROM user_inventory WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
	}, function(result) 
		for i = 1, #result, 1 do  
			table.insert(items, {gdfsg = result[i].Nommodif, item = result[i].item})
		end  
		cb(items) 
	end)  
end)

RegisterServerEvent("esx_inventoryhud:tradePlayerItem")
AddEventHandler("esx_inventoryhud:tradePlayerItem",	function(from, target, type, itemName, itemCount)
	local _source = from

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if type == "item_standard" then
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		local targetItem = targetXPlayer.getInventoryItem(itemName)

		if itemCount > 0 and sourceItem.count >= itemCount then
			if targetXPlayer.canCarryItem(itemName, itemCount) then

				sourceXPlayer.removeInventoryItem(itemName, itemCount)
				targetXPlayer.addInventoryItem(itemName, itemCount)
			else
				sourceXPlayer.showNotification('~r~Impossible~s~~n~l\'inventaire de l\'individu est plein.')
			end
		end
	elseif type == "item_money" then
		if itemCount > 0 and sourceXPlayer.getMoney() >= itemCount then
			sourceXPlayer.removeMoney(itemCount)
			targetXPlayer.addMoney(itemCount)
		end
	elseif type == "item_account" then
		if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
			sourceXPlayer.removeAccountMoney(itemName, itemCount)
			targetXPlayer.addAccountMoney(itemName, itemCount)
		end
	elseif type == "item_weapon" then
		if not targetXPlayer.hasWeapon(itemName) then
			sourceXPlayer.removeWeapon(itemName)
			targetXPlayer.addWeapon(itemName, itemCount)
		end
	end
end)

RegisterCommand("openinventory", function(source, args, rawCommand)
	local target = tonumber(args[1])
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if targetXPlayer ~= nil then
		TriggerClientEvent("esx_inventoryhud:openPlayerInventory", source, target, targetXPlayer.name)
	end
end)

RegisterNetEvent('blockcontrol')
AddEventHandler('blockcontrol', function(target)

	TriggerClientEvent('esx_inventoryhud:blockcontrol1', target, source)
	TriggerClientEvent('esx_inventoryhud:blockcontrol', target, source)
end)

RegisterNetEvent('debloqueontrol')
AddEventHandler('debloqueontrol', function(target)
	TriggerClientEvent('esx_inventoryhud:debloqueontrol', target, source)
end)