RegisterNetEvent('carwash:removemoney')
AddEventHandler('carwash:removemoney', function(price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeMoney(price)
end)