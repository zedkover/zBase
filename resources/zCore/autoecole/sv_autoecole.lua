ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_dmvschool:loadLicenses', source, licenses)
	end)
end)

ESX.RegisterServerCallback('permis:PriceCar', function (source, cb, price)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= 200 then
		xPlayer.removeMoney(200)
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('permis:PriceBike', function (source, cb, price)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= 150 then
		xPlayer.removeMoney(150)
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('permis:PriceTruck', function (source, cb, price)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= 300 then
		xPlayer.removeMoney(300)
		cb(true)
	else
		cb(false)
	end
end)