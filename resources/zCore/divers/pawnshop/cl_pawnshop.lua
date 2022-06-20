local pawnshop = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Banque", world = true},
    Data = { currentMenu = "Articles disponibles:"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if btn.name then
                TriggerServerEvent("pawnshop:buyitem", btn.item, 1, btn.price, btn.name)
            end
        end
    },

    Menu = {
        ["Articles disponibles:"] = {
            b = {
                {name = "Canne à Pêche", price = 150, item = "canneapeche", askX = true},
                {name = "Radio", price = 50, item = "radio", askX = true},
            }
        },
    }
}

Citizen.CreateThread(function()
    while true do
        time = 200
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local distpawnshop = Vdist(plyCoords, -1459.332, -413.5912, 35.73328)
            if distpawnshop <= 4 then 
                time = 0
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au ~b~PawnShop~s~.")
                if IsControlJustPressed(1,51) then
                    CreateMenu(pawnshop)
                end
        end
        Citizen.Wait(time)
    end
end)