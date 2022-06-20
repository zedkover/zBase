ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('zburgershot:getinventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	cb({
		items = items
	})
end)

RegisterServerEvent('zburgershot:buy')
AddEventHandler('zburgershot:buy', function(price, item, label)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= price then
	xPlayer.removeMoney(price)
    	xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Vous avez bien reçu votre ~b~Commande", "", 1)
	end
end)

RegisterServerEvent('zburgershot:putStockItems')
AddEventHandler('zburgershot:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_burgershot", function(inventory)
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

ESX.RegisterServerCallback('zburgershot:getStockItems', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_burgershot', function(inventory)
        cb(inventory.items) 
    end)     
end)       

RegisterServerEvent('zburgershot:getStockItem')
AddEventHandler('zburgershot:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_burgershot", function(inventory)
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

RegisterServerEvent('zedkover:annonceburgershot')
AddEventHandler('zedkover:annonceburgershot', function(result)
	local _source = source  
	local xPlayers = ESX.GetPlayers()
	local name = GetPlayerName(source)
	for i=1, #xPlayers, 1 do 
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Annonce BurgerShot', '', result, 'CHAR_LIFEINVADER')
		end
end)

RegisterServerEvent("zburgershot:giveMoney")
AddEventHandler("zburgershot:giveMoney", function(FirstPedSelectedOrderPrice)
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_burgershot', function(account)
		account.addMoney(30)
	end)
end)

RegisterServerEvent('zburgershot:Commande')
AddEventHandler('zburgershot:Commande', function(burger, client)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	MySQL.Async.execute('INSERT INTO burgershotcom (name, burger, boisson) VALUES (@name, @burger, @boisson)', {
        ['@identifier'] = xPlayer.identifier,
        ['@name'] = client,
        ['@burger'] = burger,
        ['@boisson'] = boisson,
        
    })
    TriggerClientEvent('esx:showNotification', source, "~b~Burgershot~s~\n Vous avez enregistrer une nouvelle commande")
  

end)

ESX.RegisterServerCallback('zburgershot:getcommande', function(source, cb)
    MySQL.Async.fetchAll('SELECT name, burger, id, boisson FROM burgershotcom ', {}, function(result)
        cb(result)  
    end)
end)


RegisterServerEvent('zburgershot:delete')
AddEventHandler('zburgershot:delete', function(id)
		MySQL.Async.execute('DELETE FROM burgershotcom WHERE id = @id', {
			['@id'] = id
		})
end)


RegisterServerEvent('Check')
AddEventHandler('Check', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local e = xPlayer.getInventoryItem("fromage").count
    local ee = xPlayer.getInventoryItem("steak").count
    local eee = xPlayer.getInventoryItem("cornichon").count
    local eeee = xPlayer.getInventoryItem("tomate").count
    local eeeee = xPlayer.getInventoryItem("poissonpane").count
    local eeeeee = xPlayer.getInventoryItem("pouletpane").count
end)

RegisterServerEvent("zburrgershot:cuisine")
AddEventHandler("zburrgershot:cuisine", function(item, fromage, steak, cornichon, tomate, poissonpane, pouletpane)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local zz = xPlayer.getInventoryItem("fromage").count
    local zzz = xPlayer.getInventoryItem("steak").count
    local zzzz = xPlayer.getInventoryItem("cornichon").count
    local zzzzz = xPlayer.getInventoryItem("tomate").count
    local zzzzzz = xPlayer.getInventoryItem("poissonpane").count
    local zzzzzzz = xPlayer.getInventoryItem("pouletpane").count
        if zz >= fromage then if zzz >= steak then if zzzzz >= tomate then if zzzzzz >= poissonpane then if zzzzzzz >= pouletpane then
                xPlayer.removeInventoryItem("fromage", fromage)
                xPlayer.removeInventoryItem("steak", steak)
                xPlayer.removeInventoryItem("cornichon", cornichon)
                xPlayer.removeInventoryItem("poissonpane", poissonpane)
                xPlayer.removeInventoryItem("tomate", tomate)
                xPlayer.removeInventoryItem("pouletpane", pouletpane)

                xPlayer.addInventoryItem(item, 1)
                print(item)
                TriggerClientEvent('esx:showNotification', source, "- ~g~Burgershot~s~\n- Vous avez cuisiner [x1] ~b~"..item.."")
                else
                    TriggerClientEvent('esx:showNotification', source, "- ~g~Burgershot\n- Il vous manque des ingrédients")
                    end
                end
            end
        end
    end
end)
       

