TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('zAmmu:BuyCranArret')
AddEventHandler('zAmmu:BuyCranArret', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local price = 700
	local xMoney = xPlayer.getMoney()

    if xMoney >= 700 then 
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('weapon_switchblade', 1)
		TriggerClientEvent('esx:showNotification', source, "Vous venez d'acheter un ~b~Cran d'arret~w~ !")
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent sur vous.")
    end
end)

RegisterNetEvent('zAmmu:45')
AddEventHandler('zAmmu:45', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local price = 5
	local xMoney = xPlayer.getMoney()

    if xMoney >= 5 then 
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('ammo_pistol', 5)
		TriggerClientEvent('esx:showNotification', source, "Vous venez d'acheter ~b~5 munitions .45")
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent sur vous.")
    end
end)


RegisterNetEvent('zAmmu:9mm')
AddEventHandler('zAmmu:9mm', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local price = 15
	local xMoney = xPlayer.getMoney()

    if xMoney >= 15 then 
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('ammo_smg', 5)
		TriggerClientEvent('esx:showNotification', source, "Vous venez d'acheter ~b~5 munitions 9mm")
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent sur vous.")
    end
end)


RegisterNetEvent('zAmmu:BuyCouteau')
AddEventHandler('zAmmu:BuyCouteau', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local price = 650
	local xMoney = xPlayer.getMoney()

    if xMoney >= 650 then 
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('weapon_knife', 1)
		TriggerClientEvent('esx:showNotification', source, "Vous venez d'acheter un ~b~Couteau~w~ !")
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent sur vous.")
    end
end)

RegisterNetEvent('zAmmu:BuyBat')
AddEventHandler('zAmmu:BuyBat', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local price = 800
	local xMoney = xPlayer.getMoney()

    if xMoney >= 800 then 
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('weapon_bat', 1)
		TriggerClientEvent('esx:showNotification', source, "Vous venez d'acheter une ~b~Batte de Baseball~w~ !")
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent sur vous.")
    end
end)


RegisterNetEvent('zAmmu:BuyMachette')
AddEventHandler('zAmmu:BuyMachette', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local price = 600
	local xMoney = xPlayer.getMoney()

    if xMoney >= 600 then 
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('weapon_machete', 1)
		TriggerClientEvent('esx:showNotification', source, "Vous venez d'acheter une ~b~Machette~w~ !")
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent sur vous.")
    end
end)

RegisterNetEvent('zAmmu:BuyPetoire')
AddEventHandler('zAmmu:BuyPetoire', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local price = 10000
	local xMoney = xPlayer.getMoney()

    if xMoney >= 10000 then 
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('weapon_snspistol', 1)
		TriggerClientEvent('esx:showNotification', source, "Vous venez d'acheter un ~b~Pétoire~w~ !")
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent sur vous.")
    end
end)