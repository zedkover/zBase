ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('zedkover:getinventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	cb({
		items = items
	})
end)

RegisterServerEvent('LsCustoms')
AddEventHandler('LsCustoms', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local item = xPlayer.getInventoryItem('LsCustoms').count
    if item == 0  then
		xPlayer.addInventoryItem("LsCustoms", 1)
		TriggerClientEvent("esx:showNotification", source, "~b~Vous avez reçu votre tenue de ~b~service")
	else
		TriggerClientEvent("esx:showNotification", source, "~r~Vous avez déjà reçu votre tenue de ~b~service")
	end
end)

ESX.RegisterUsableItem('moteur', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('moteur', 1)
	TriggerClientEvent('zedkover:usemoteur', source)
	Citizen.Wait(10000)
end)

RegisterServerEvent('zedkover:annoncepolice')
AddEventHandler('zedkover:annoncepolice', function(result)
	local _source = source  
	local xPlayers = ESX.GetPlayers()
	local name = GetPlayerName(source)
	for i=1, #xPlayers, 1 do 
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Annonce LSPD', '', result, 'CHAR_CALL911')
		end
end)

RegisterServerEvent('tenuelongue')
AddEventHandler('tenuelongue', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local item = xPlayer.getInventoryItem('tenuelongue').count
    if item == 0  then
		xPlayer.addInventoryItem("tenuelongue", 1)
		TriggerClientEvent("esx:showNotification", source, "~b~Vous avez reçu votre tenue à Manche longue.")
	else
		TriggerClientEvent("esx:showNotification", source, "~r~Vous avez déjà reçu votre tenue à Manche longue.")
	end
end)

RegisterServerEvent('tenuecourte')
AddEventHandler('tenuecourte', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local item = xPlayer.getInventoryItem('tenuecourte').count
    if item == 0  then
		xPlayer.addInventoryItem("tenuecourte", 1)
		TriggerClientEvent("esx:showNotification", source, "~b~Vous avez reçu votre tenue à Manche courte.")
	else
		TriggerClientEvent("esx:showNotification", source, "~r~Vous avez déjà reçu votre tenue à Manche courte.")
	end
end)

RegisterServerEvent('tenuecere')
AddEventHandler('tenuecere', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local item = xPlayer.getInventoryItem('tenuecere').count
    if item == 0  then
		xPlayer.addInventoryItem("tenuecere", 1)
		TriggerClientEvent("esx:showNotification", source, "~b~Vous avez reçu votre tenue à Cérémonie.")
	else
		TriggerClientEvent("esx:showNotification", source, "~r~Vous avez déjà reçu votre tenue Cérémonie.")
	end
end)

RegisterServerEvent('tenuemoto')
AddEventHandler('tenuemoto', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local item = xPlayer.getInventoryItem('tenuemoto').count
    if item == 0  then
		xPlayer.addInventoryItem("tenuemoto", 1)
		TriggerClientEvent("esx:showNotification", source, "~b~Vous avez reçu votre tenue Moto.")
	else
		TriggerClientEvent("esx:showNotification", source, "~r~Vous avez déjà reçu votre tenue Moto.")
	end
end)

RegisterServerEvent('tenuevelo')
AddEventHandler('tenuevelo', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local item = xPlayer.getInventoryItem('tenuevelo').count
    if item == 0  then
		xPlayer.addInventoryItem("tenuevelo", 1)
		TriggerClientEvent("esx:showNotification", source, "~b~Vous avez reçu votre tenue Vélo.")
	else
		TriggerClientEvent("esx:showNotification", source, "~r~Vous avez déjà reçu votre tenue Vélo.")
	end
end)

RegisterServerEvent('tenuepilote')
AddEventHandler('tenuepilote', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local item = xPlayer.getInventoryItem('tenuepilote').count
    if item == 0  then
		xPlayer.addInventoryItem("tenuepilote", 1)
		TriggerClientEvent("esx:showNotification", source, "~b~Vous avez reçu votre tenue Pilote.")
	else
		TriggerClientEvent("esx:showNotification", source, "~r~Vous avez déjà reçu votre tenue Pilote.")
	end
end)

RegisterServerEvent('renfort')
AddEventHandler('renfort', function(coords, raison)
	local _source = source
	local _raison = raison
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'police' then
			TriggerClientEvent('renfort:setBlip', xPlayers[i], coords, _raison)
		end
	end
end)

RegisterServerEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policejob:handcuff', target)
	else
		TriggerClientEvent('esx_policejob:handcuff', target)
	end
end)

RegisterServerEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policejob:drag', target, source)
	else
		print(('LSPD: %s attempted to drag (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policejob:putInVehicle', target)
	else
		print(('LSPD: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policejob:OutVehicle', target)
	else
		print(('LSPD: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)


local playersWithoutSiren = {}

RegisterServerEvent('SilentSiren')

AddEventHandler('SilentSiren', function(Toggle)
local netID = source
TriggerClientEvent('updateSirens', -1, netID, Toggle)
playersWithoutSiren[netID] = Toggle
end)
