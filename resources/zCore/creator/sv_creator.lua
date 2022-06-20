ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('creator:saveidentite')
AddEventHandler('creator:saveidentite', function(sexe, prenom, nom, datedenaissance, taille)
    _source = source
    mySteamID = GetPlayerIdentifiers(_source)
    mySteam = mySteamID[1]

    MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
      ['@identifier']		= mySteam,
      ['@firstname']		= prenom,
      ['@lastname']		= nom,
      ['@dateofbirth']	= datedenaissance,
      ['@sex']			= sexe,
      ['@height']			= taille
    }, function(rowsChanged)
      if callback then
        callback(true)
      end
    end)
end)

ESX.RegisterServerCallback('GetEntityPosition', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local TableTarace = {}
  MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {["@identifier"] = xPlayer.identifier}, function(result)
      TriggerClientEvent('GetEntityPosition', source, json.decode(result[1].position), result[1].vie)
  end)
end)

RegisterServerEvent('zcreator:giveitembread')
AddEventHandler('zcreator:giveitembread', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= 0 then
	xPlayer.removeMoney(0)
    	xPlayer.addInventoryItem('bread', 1)
	end
end)

RegisterServerEvent('zcreator:giveitemwater')
AddEventHandler('zcreator:giveitemwater', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= 0 then
	xPlayer.removeMoney(0)
    	xPlayer.addInventoryItem('water', 1)
      xPlayer.addMoney(1000)
	end
end)