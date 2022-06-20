ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 

RegisterServerEvent('addsale')
AddEventHandler('addsale', function(price) 
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addMoney(price)
end)

RegisterServerEvent('alertepolice')
AddEventHandler('alertepolice', function(store) 
	local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
			TriggerClientEvent('zBraquage:msgPolice', xPlayer.source, store, src)
		end
	end
end)