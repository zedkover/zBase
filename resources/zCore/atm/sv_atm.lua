ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("zBank:RetirerArgent")
AddEventHandler("zBank:RetirerArgent", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local xMoney = xPlayer.getAccount('bank').money
    
    if xMoney >= total then

    xPlayer.removeAccountMoney('bank', total)
    xPlayer.addMoney(total)
 
         TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque', 'FLEECA', "Vous avez retiré ~b~"..total.." $ .", 'CHAR_BANK_FLEECA', 8)
    else
         TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas toute cette somme d\'argent !")
    end    
end) 

RegisterServerEvent("zBank:DeposerArgent")
AddEventHandler("zBank:DeposerArgent", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local xMoney = xPlayer.getMoney()
    
    if xMoney >= total then

    xPlayer.addAccountMoney('bank', total)
    xPlayer.removeMoney(total)
         TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque', 'FLEECA', "Vous avez déposer ~b~"..total.." $ ~s~en banque !", 'CHAR_BANK_FLEECA', 8)
    else
         TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas toute cette somme d\'argent !")
    end    
end)

RegisterServerEvent("zBank:actusold") 
AddEventHandler("zBank:actusold", function(action, amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local ArgentJoueur = xPlayer.getAccount('bank').money

    TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque', 'FLEECA', "Solde : ~b~".. ArgentJoueur .." $", 'CHAR_BANK_FLEECA', 8)

    TriggerClientEvent("zBank:actusold", source, ArgentJoueur)
end)

ESX.RegisterUsableItem('cartebancaire', function(source)

    TriggerClientEvent('atm:utiliser', source) 
    Citizen.Wait(5000000000) 
 end)   