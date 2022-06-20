RegisterServerEvent('cayoperico:buy')
AddEventHandler('cayoperico:buy', function(count, price, name)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xMoney = xPlayer.getMoney()
    if xMoney >= 100 then
        xPlayer.removeMoney(100)
        TriggerClientEvent('esx:showNotification', source, "Vous avez acheté un ~b~billet d'avion.")
        TriggerClientEvent('tpisland', source)
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")
    end
end)