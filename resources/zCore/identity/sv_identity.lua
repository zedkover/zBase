ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)  

RegisterServerEvent('11_giveIdentity') 
AddEventHandler('11_giveIdentity', function(target, playerIdentity, licenses) 
	  TriggerClientEvent('11_giveIdentityCL', target, playerIdentity, licenses)
end)   

RegisterServerEvent('11_refreshIdentity') 
AddEventHandler('11_refreshIdentity', function() 
    refreshIdentity(source)
end)

RegisterServerEvent('11_refreshLicenses') 
AddEventHandler('11_refreshLicenses', function() 
    refreshLicenses(source)
end)


RegisterServerEvent('11_controlLicense') 
AddEventHandler('11_controlLicense', function(type, bool, target) 
    local currentSource = target or source

    local xPlayer = ESX.GetPlayerFromId(currentSource)

    MySQL.Async.fetchAll('SELECT licenses FROM users WHERE identifier = @identifier', 
    {
        ['@identifier'] = xPlayer.identifier
    }, function(data)
      local data = json.decode(data[1].licenses)
  
      data[type] = bool

      MySQL.Async.execute('UPDATE users SET licenses = @licenses WHERE identifier = @identifier', {
          ['@identifier'] = xPlayer.identifier,
          ['@licenses'] = json.encode(data) 
      }) 
    end)
    Wait(2000)
    refreshLicenses(currentSource)
end)

function refreshIdentity(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', 
    {
      ['@identifier'] = xPlayer.identifier
    }, function(identity)

      TriggerClientEvent('11_refreshIdentityCL', source, identity)
    end)
end


function refreshLicenses(source)
  local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT licenses FROM users WHERE identifier = @identifier', 
    {
      ['@identifier'] = xPlayer.identifier
    }, function(licenses)

      TriggerClientEvent('11_refreshLicensesCL', source, licenses)
    end)
end


