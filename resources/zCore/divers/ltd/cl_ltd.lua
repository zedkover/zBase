local LTD = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "LTD", world = true},
    Data = { currentMenu = "Articles disponibles:"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if btn.name then
                TriggerServerEvent("ltd:buyitem", btn.item, 1, btn.price, btn.name)
            end
        end
    },

    Menu = {
        ["Articles disponibles:"] = {
            b = {
                {name = "Pain", price = 10, item = "bread", askX = true},
                {name = "Eau", price = 10, item = "water", askX = true},
                {name = "Carte Bancaire", price = 10, item = "cartebancaire", askX = true},
                {name = "Téléphone", price = 250, item = "phone", askX = true},
            }
        },
    }
}
-- Positions des frigos
local ltdpoz = {
    {x = -715.71, y = -909.18, z = 19.22},
    {x = 1707.31, y = 4928.2, z = 42.06}
}
-- Position des blips
local blipsltds = {
    {x = -716.56, y = -921.58, z = 19.01}
}

local blipsltdn = {
    {x = 1694.28, y = 4930.89, z = 42.08}
}


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for w in pairs(ltdpoz) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dest = vector3(ltdpoz[w].x, ltdpoz[w].y, ltdpoz[w].z)
            local dist = GetDistanceBetweenCoords(plyCoords, dest, true)

            if dist <= 1.7 then
                ESX.ShowHelpNotification('Appuyez ~INPUT_PICKUP~ pour accéder au ~b~frigo~s~.')
                if IsControlJustPressed(1, 51) then
                    CreateMenu(LTD)
		        end
            end
        end
    end
end)