ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_vehicleshop:isPlateTaken', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)

RegisterServerEvent('esx_vehicleshop:setVehicleOwnedPlayerId')
AddEventHandler('esx_vehicleshop:setVehicleOwnedPlayerId', function(playerId, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(playerId)


	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps)
	}, function(rowsChanged)
	end)
end) 

ESX.RegisterServerCallback('Checkmoney', function(source, cb, price)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xMoney = xPlayer.getMoney()
	
	if xPlayer.getMoney() >= tonumber(price) then
		cb(true)
		xPlayer.removeMoney(price)
	else 
		cb(false)
	end
end)