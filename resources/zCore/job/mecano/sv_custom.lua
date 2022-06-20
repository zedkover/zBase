ESX = nil
TriggerEvent('esx:getSharedObject', function(a)
    ESX = a 
end)

RegisterServerEvent('zCustom:BuyLsCustoms')
AddEventHandler('zCustom:BuyLsCustoms', function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	price = tonumber(price)
	local societyAccount = nil
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_lscustom', function(account)
		societyAccount = account
	end)
	
	if price < societyAccount.money then
		TriggerClientEvent('zCustom:InstallLsCustoms', _source)
		societyAccount.removeMoney(price)
	else
		TriggerClientEvent('zCustom:CancelLsCustoms', _source)
		TriggerClientEvent('esx:showNotification', _source, "~r~La commande a été refusé car l'entreprise n'a plus assez de fonds nécessaires.")
	end
end)