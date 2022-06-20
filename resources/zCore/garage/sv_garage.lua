RegisterServerEvent('eden_garage:debug')
RegisterServerEvent('eden_garage:deletevehicle_sv')
RegisterServerEvent('eden_garage:modifystate')
RegisterServerEvent('eden_garage:pay')
RegisterServerEvent('eden_garage:payhealth')
RegisterServerEvent('eden_garage:logging')
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end) 

ESX.RegisterServerCallback('zkgarage:fourriere', function(source, cb)
	MySQL.Async.fetchAll('SELECT state, plate, vehicle FROM owned_vehicles', {}, function(result)
		cb(result)
	end)
end)


 

ESX.RegisterServerCallback('esx_vehicleshop:giveBackVehicle', function (source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE `owner` = @owner AND plate = @plate', {
        ['@owner'] = xPlayer.identifier,
		['@plate'] = plate  
	}, function (result)
		if result[1] ~= nil then 
	
		   cb(false)
		else
		    cb(true)
		end
	end)
end)
 
RegisterServerEvent('zkgarage:payementgarage')
AddEventHandler('zkgarage:payementgarage', function(price)
	local xPlayer = ESX.GetPlayerFromId(source) 
	if xPlayer.getMoney() >= tonumber(price) then
		xPlayer.removeMoney(tonumber(price)) 
		TriggerClientEvent('esx:showNotification', source, '~g~Vous avez effectuer le payement en cash ~g~$ ~s~[~b~'..price..'~s~]')        
		TriggerClientEvent('zkgarage:rangementgarage', source) 
		else
		if xPlayer.getAccount('bank').money >= tonumber(price) then 
			xPlayer.removeAccountMoney('bank', tonumber(price)) 
			TriggerClientEvent('esx:showNotification', source, '~g~Vous avez effectuer le payement en banque ~g~$ ~s~[~b~'..price..'~s~]')
			TriggerClientEvent('zkgarage:rangementgarage', source) 
		else  
			TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas assez d\'argent sûre vous') 
		end
	end  	
end) 
 

-- Vehicle fetch 
ESX.RegisterServerCallback('cacaacc', function(source, cb)
    local vehicules = {}
    MySQL.Async.fetchAll('SELECT state, plate, vehicle, name FROM owned_vehicles', {
    }, function(data)
        for _, v in pairs(data) do
            local vehicle = json.decode(v.vehicle)
            table.insert(vehicules, {
                vehicle = vehicle,
                state = v.state,
                plate = v.plate,
                name = v.name
            })
        end
        cb(vehicules)
    end)
end)

-- Vehicle fetch
ESX.RegisterServerCallback('eden_garage:getVehicles', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local vehicules = {}

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner=@identifier', {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(data)
        for _, v in pairs(data) do
            local vehicle = json.decode(v.vehicle)

            table.insert(vehicules, {
                vehicle = vehicle,
                state = v.state,
                plate = v.plate

            })
        end

        cb(vehicules)
    end)
end)

-- End vehicle fetch
-- Store & update vehicle properties
ESX.RegisterServerCallback('eden_garage:stockv', function(source, cb, vehicleProps)
    local isFound = false
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local vehicules = getPlayerVehicles(xPlayer.getIdentifier())
    local plate = vehicleProps.plate 
    print(plate)

    for _, v in pairs(vehicules) do
        if (plate == plate) then
            local vehprop = json.encode(vehicleProps)

            MySQL.Sync.execute('UPDATE owned_vehicles SET vehicle=@vehprop WHERE plate=@plate', {
                ['@vehprop'] = vehprop,
                ['@plate'] = plate
            })

            isFound = true
            break
        end
    end

    cb(isFound)
end)

AddEventHandler('eden_garage:deletevehicle_sv', function(vehicle)
    TriggerClientEvent('eden_garage:deletevehicle_cl', -1, vehicle)
end)

-- End vehicle store
-- Change state of vehicle
AddEventHandler('eden_garage:modifystate', function(vehicle, state)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local vehicules = getPlayerVehicles(xPlayer.getIdentifier())
    local state = state
    local plate = vehicle.plate
    print('UPDATING STATE...')

    if plate ~= nil then
        print('plate')
        plate = plate:gsub('^%s*(.-)%s*$', '%1')
        print(plate)
    else
        print('vehicle')
        print(vehicle)
    end

    for _, v in pairs(vehicules) do
        if v.plate == plate then
            MySQL.Sync.execute('UPDATE owned_vehicles SET state =@state WHERE plate=@plate', {
                ['@state'] = state,
                ['@plate'] = plate
            })

            print('STATE UPDATED...')
            break
        end
    end
end)

-- End state update
-- Function to recover plates deprecated and removed.
-- Get list of vehicles already out
ESX.RegisterServerCallback('eden_garage:getOutVehicles', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local vehicules = {}

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner=@identifier AND state=false', {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(data)
        for _, v in pairs(data) do
            local vehicle = json.decode(v.vehicle)
            table.insert(vehicules, vehicle)
        end

        cb(vehicules)
    end)
end)

-- End out list
-- Check player has funds
ESX.RegisterServerCallback('eden_garage:checkMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.get('money') >= Config.Price then
        cb(true)
    else
        cb(false)
    end
end)

-- End funds check
-- Withdraw money
AddEventHandler('eden_garage:pay', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeMoney(Config.Price)
    TriggerClientEvent('esx:showNotification', source, _U('you_paid', Config.Price))
end)

-- End money withdraw
-- Find player vehicles
function getPlayerVehicles(identifier)
    local vehicles = {}

    local data = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner=@identifier', {
        ['@identifier'] = identifier
    })

    for _, v in pairs(data) do
        local vehicle = json.decode(v.vehicle)

        table.insert(vehicles, {
            id = v.id,
            plate = v.plate
        })
    end

    return vehicles
end

-- End fetch vehicles
-- Debug
AddEventHandler('eden_garage:debug', function(var)
    print(to_string(var))
end)

function table_print(tt, indent, done)
    done = done or {}
    indent = indent or 0

    if type(tt) == 'table' then
        local sb = {}

        for key, value in pairs(tt) do
            table.insert(sb, string.rep(' ', indent)) -- indent it

            if type(value) == 'table' and not done[value] then
                done[value] = true
                table.insert(sb, '{\n')
                table.insert(sb, table_print(value, indent + 2, done))
                table.insert(sb, string.rep(' ', indent)) -- indent it
                table.insert(sb, '}\n')
            elseif 'number' == type(key) then
                table.insert(sb, string.format('\'%s\'\n', tostring(value)))
            else
                table.insert(sb, string.format('%s = \'%s\'\n', tostring(key), tostring(value)))
            end
        end

        return table.concat(sb)
    else
        return tt .. '\n'
    end
end

function to_string(tbl)
    if 'nil' == type(tbl) then
        return tostring(nil)
    elseif 'table' == type(tbl) then
        return table_print(tbl)
    elseif 'string' == type(tbl) then
        return tbl
    else
        return tostring(tbl)
    end
end

-- End debug
-- Return all vehicles to garage (state update) on server restart
AddEventHandler('onMySQLReady', function()
    MySQL.Sync.execute('UPDATE owned_vehicles SET state=true WHERE state=false', {})
end)

-- End vehicle return
-- Pay vehicle repair cost
AddEventHandler('eden_garage:payhealth', function(price)
    local xPlayer = ESX.GetPlayerFromId(source)

    if price < 0 then
        print('CHEATER?')
    else
        xPlayer.removeMoney(price)
        TriggerClientEvent('esx:showNotification', source, _U('you_paid', price))
    end
end)

-- End repair cost
-- Log to the console
AddEventHandler('eden_garage:logging', function(logging)
    RconPrint(logging)
end)
-- End console log
 
RegisterServerEvent('zkgarage:sotred')
AddEventHandler('zkgarage:sotred', function(plate, vehicle)
	MySQL.Sync.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', { 
		['@plate'] = plate,  
		['@stored'] = instant      
	})
end) 

RegisterServerEvent('zkgarage:savepee')
AddEventHandler('zkgarage:savepee', function(owner, vehicle)
	local ident = GetPlayerIdentifier(owner)  
	MySQL.Async.execute('INSERT INTO owned_vehicles (identifier, vehicle) VALUES (@identifier, @vehicle)',
	{    
		['@identifier']   = ident, 
		['@vehicle'] = json.encode(vehicle),    
	}, function(rowsChanged) 
	end)
end)  

RegisterServerEvent('zkgarage:up')
AddEventHandler('zkgarage:up', function(state, plate)  
	MySQL.Sync.execute('UPDATE owned_vehicles SET state = @state WHERE plate = @plate', {
		['@state'] = state,    
		['@plate'] = plate         
	})
end) 

RegisterServerEvent('zkgarage:change')
AddEventHandler('zkgarage:change', function(vehicle, plate)  
	MySQL.Sync.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
		['@vehicle'] = json.encode(vehicle),      
		['@plate'] = plate         
	})
end) 
 

RegisterServerEvent('zkgarage:name')
AddEventHandler('zkgarage:name', function(plate)  
    local name = GetPlayerName(source)  
	MySQL.Sync.execute('UPDATE owned_vehicles SET name = @name WHERE plate = @plate', {
		['@name'] = name,        
		['@plate'] = plate         
	})
end) 

