ammunationls = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Armurerie", world = true},
    Data = { currentMenu = "Types Armes", GetPlayerName() },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if zedkover.name == "Arme Blanche" then 
                OpenMenu('Arme blanche')
            elseif zedkover.name == "Arme de poing" then
                OpenMenu('Arme de poing')
            elseif zedkover.name == "Munition" then
                OpenMenu('Munition')
            elseif zedkover.name == "Batte de Baseball" then
                TriggerServerEvent("zAmmu:BuyBat")
            elseif zedkover.name == "Couteau" then
                TriggerServerEvent("zAmmu:BuyCouteau")
            elseif zedkover.name == "Cran d'arret" then
                TriggerServerEvent("zAmmu:BuyCranArret")
            elseif zedkover.name == ".45" then
                TriggerServerEvent("zAmmu:45")
            elseif zedkover.name == "9mm" then
                TriggerServerEvent("zAmmu:9mm")
            elseif zedkover.name == "Machette" then
                TriggerServerEvent("zAmmu:BuyMachette")
            elseif zedkover.name == "Pétoire" then
                TriggerServerEvent("zAmmu:BuyPetoire")
            end
        end,
    },
    Menu = {
        ["Types Armes"] = {
            b = {
                {name = "Arme Blanche", askX = true},
                {name = "Arme de poing", askX = true},
                {name = "Munition", askX = true},
            }
        },
        ["Arme blanche"] = {
            b = {
                {name = "Batte de Baseball", ask = "~b~800$", askX = true},
                {name = "Couteau", ask = "~b~650$", askX = true},
                {name = "Cran d'arret", ask = "~b~700$", askX = true},
                {name = "Machette", ask = "~b~600$", askX = true},
            }
        },
        ["Munition"] = {
            b = {
                {name = ".45", ask = "~b~5$", askX = true},
                {name = "9mm", ask = "~b~15$", askX = true},
            }
        },
        ["Arme de poing"] = {
            b = {
                {name = "Pétoire", ask = "~b~10000$", askX = true},
            }
        }
    }
}

Citizen.CreateThread(function()
    while true do
        time = 200
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local distamu= Vdist(plyCoords, 22.44396, -1106.914, 29.7854-0.93)
            if distamu <= 2 then 
                time = 0
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accèder à ~b~l'armurerie~s~.")
                if IsControlJustPressed(1,51) then
                    CreateMenu(ammunationls)
                end
        end
        Citizen.Wait(time)
    end
end)