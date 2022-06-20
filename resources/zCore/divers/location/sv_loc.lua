RegisterServerEvent('location:buylocitem')
AddEventHandler('location:buylocitem', function(item, count, price, name)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xMoney = xPlayer.getMoney()
    
    
    if xMoney >= price then
        xPlayer.removeMoney(price)
        TriggerClientEvent('esx:showNotification', source, "Vous avez acheté: ~b~"..name)
        xPlayer.addInventoryItem(item, count)
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")
    end
end)