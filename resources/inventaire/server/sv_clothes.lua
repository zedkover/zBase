
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('zk:insertlunettes')
AddEventHandler('zk:insertlunettes', function(type, name, lunettes,variation, Nom1, Nom2)
  local ident = GetPlayerIdentifier(source)
  maskx = {[Nom1]=tonumber(lunettes),[Nom2]=tonumber(variation)} 
	MySQL.Async.execute('INSERT INTO zk_clothe (identifier, type, nom, clothe) VALUES (@identifier, @type, @nom, @clothe)',
	{ 
	['@identifier']   = ident,
    ['@type']   = type,
    ['@nom']   = name,
    ['@clothe'] = json.encode(maskx)
	}, function(rowsChanged) 
	end)
end) 

RegisterServerEvent('zk:inserttenue')
AddEventHandler('zk:inserttenue', function(type, name, clothe)
  local ident = GetPlayerIdentifier(source)
	MySQL.Async.execute('INSERT INTO zk_clothe (identifier, type, nom, clothe) VALUES (@identifier, @type, @nom, @clothe)',
	{ 
		['@identifier']   = ident,
    ['@type']   = type,
    ['@nom']   = name,
    ['@clothe'] = json.encode(clothe)
	}, function(rowsChanged) 
	end)
end) 

RegisterServerEvent('zk:changenom')
AddEventHandler('zk:changenom', function(id, Actif)   
	MySQL.Sync.execute('UPDATE zk_clothe SET nom = @nom WHERE id = @id', {
		['@id'] = id,   
		['@nom'] = Actif        
	})
end) 

RegisterServerEvent('zk:deleteitem')
AddEventHandler('zk:deleteitem', function(supprimer)
    MySQL.Async.execute('DELETE FROM zk_clothe WHERE id = @id', { 
            ['@id'] = supprimer 
    }) 
end)

ESX.RegisterServerCallback('Checkmoney', function(source, cb, price)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= price then
		cb(true)
		xPlayer.removeMoney(tonumber(price))
		TriggerClientEvent('esx:showNotification', source, "~b~Vous avez effectuer un payement de ~s~(~b~~h~$"..tonumber(price).."~h~~s~)")  
	else 
		TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")  
		cb(false)
	end
end)


RegisterServerEvent('zk:giveitem')
AddEventHandler('zk:giveitem', function(id, target)   
	local xaplayertarget = GetPlayerIdentifier(target)
	MySQL.Sync.execute('UPDATE zk_clothe SET identifier = @identifier WHERE id = @id', {
		['@id'] = id, 
		['@identifier'] = xaplayertarget        
	})
end) 

 
ESX.RegisterServerCallback('zk:getalltenues', function(source, cb)
	MySQL.Async.fetchAll('SELECT id, clothe, nom, type FROM zk_clothe', {}, function(result)
		cb(result)
	end)
end) 

ESX.RegisterServerCallback('zk:getzedkovermask', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local masque = {}
	MySQL.Async.fetchAll('SELECT * FROM zk_clothe WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result) 
		for i = 1, #result, 1 do  
			table.insert(masque, {      
                type      = result[i].type, 
				clothe      = result[i].clothe,
				id      = result[i].id,
				nom      = result[i].nom,

			})
		end  
		cb(masque) 
	end)  
end)    
