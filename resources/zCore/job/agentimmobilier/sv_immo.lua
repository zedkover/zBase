RegisterServerEvent('zedkover:annonceimmo')
AddEventHandler('zedkover:annonceimmo', function(result)
	local _source = source  
	local xPlayers = ESX.GetPlayers()
	local name = GetPlayerName(source)
	for i=1, #xPlayers, 1 do 
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Annonce Dynasty 8', '', result, 'CHAR_ANTONIA')
		end
end)