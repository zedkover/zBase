local locmenu = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Location", world = true},
    Data = { currentMenu = "Location:"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if btn.name then
                TriggerServerEvent("location:buylocitem", btn.item, 1, btn.price, btn.name)
            end
        end
    },

    Menu = {
        ["Location:"] = {
            b = {
                {name = "BMX", price = 80, item = "bmx", askX = true},
                {name = "Scorcher", price = 90, item = "scorcher", askX = true},
                {name = "Fixter", price = 100, item = "fixter", askX = true},
                {name = "Tribike", price = 110, item = "tribike", askX = true},
            }
        },
    }
}
-- Positions de la location
local locpos = {
    {x = -505.2923, y = -670.5231, z = 33.08789}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for w in pairs(locpos) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dest = vector3(locpos[w].x, locpos[w].y, locpos[w].z)
            local dist = GetDistanceBetweenCoords(plyCoords, dest, true)
            if dist <= 1.7 then
                ESX.ShowHelpNotification('Appuyez ~INPUT_PICKUP~ pour parler à ~b~Bob~s~.')
                if IsControlJustPressed(1, 51) then
                    CreateMenu(locmenu)
		        end
            end
        end
    end
end)