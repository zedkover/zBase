f6unicorn = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Unicorn", world = true},
    Data = { currentMenu = "Action", GetPlayerName() },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if zedkover.name == "Effectuer une annonce" then 
                local result = KeyboardInput('', '', 255)
                if result ~= nil then 
                    TriggerServerEvent('zedkover:annonceunicorn', result)
                end
            elseif zedkover.name == "Effectuer une facture" then 
                CreateFacture("society_unicorn")
            end
        end,
    },
    Menu = {
        ["Action"] = {
            b = {
                {name = "Effectuer une annonce", ask = ">", askX = true},
                {name = "Effectuer une facture", ask = ">", askX = true},
            }
        }
    }
}

RegisterKeyMapping('unicorn', 'Menu Unicorn', 'keyboard', 'F6')

RegisterCommand('unicorn', function()
    if ESX.GetPlayerData().job.name == "unicorn" then 
        CreateMenu(f6unicorn)
    end    
end)

stockunicorn = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Vestiare Unicorn", world = true },
    Data = { currentMenu = "Action", GetPlayerName() },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
                if self.Data.currentMenu == "Déposer un objet" then 
                    local result = KeyboardInput('Nombre', '', 10)
                    if result ~= nil then
                        TriggerServerEvent('zUnicorn:putStockItems', zedkover.value, result)
                        OpenMenu("Action")
                    end 
                elseif self.Data.currentMenu == "Retirer un objet" then 
                    local result = KeyboardInput('Nombre :', '', 10)
                    if result ~= nil then 
                        TriggerServerEvent('zUnicorn:getStockItem', zedkover.value, result)
                        OpenMenu("Action")
                    end  
                end

                if zedkover.name == "Déposer un objet" then 
                    stockunicorn.Menu["Déposer un objet"].b = {}
                    ESX.TriggerServerCallback('zUnicorn:getinventory', function(zedkover)
                        for i=1, #zedkover.items, 1 do
                            local item = zedkover.items[i]
                            if item.count > 0 then
                                table.insert(stockunicorn.Menu["Déposer un objet"].b,  {name = item.label .. ' x' .. item.count, askX = true, value = item.name})
                            end
                        end
                        OpenMenu("Déposer un objet")
                    end)
                elseif zedkover.name == "Reprendre vos affaires" then
                        NotificationClear('~r~Vous êtes plus en tenue')
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                            TriggerEvent('skinchanger:loadSkin', skin)
                        end)
                        SetPedArmour(playerPed, 0)	   
                elseif zedkover.name == "Vestiaires" then
                    OpenMenu("Vestiaires")
                elseif zedkover.name == "Tenue Serveur" then
                    NotificationClear('~b~Vous êtes en tenue')
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        if skin.sex == 0 then
                            TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.unicorn_tenue.male)
                        elseif skin.sex == 1 then
                            TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.unicorn_tenue.female)
                        end
                    end)
                elseif zedkover.name == "Retirer un objet" then 
                    stockunicorn.Menu["Retirer un objet"].b = {}
                    ESX.TriggerServerCallback('zUnicorn:getStockItems', function(items)  
                        for i=1, #items, 1 do 
                            if items[i].count > 0 then
                                table.insert(stockunicorn.Menu["Retirer un objet"].b, {name = 'x' .. items[i].count .. ' ' .. items[i].label, askX = true, value = items[i].name})
                            end
                        end
                    OpenMenu('Retirer un objet')
                    end)
                end

       
        end,
    },
    Menu = {
        ["Action"] = {
            b = {
                {name = "Déposer un objet", ask = ">", askX = true, id = 33},
                {name = "Retirer un objet", ask = ">", askX = true, id = 33},
                {name = "Vestiaires", ask = ">", askX = true, id = 33}
            }
        },
        ["Vestiaires"] = {
            b = {
                {name = "Tenue Serveur", ask = ">", askX = true},
                {name = "Reprendre vos affaires", ask = ">", askX = true}
            }
        },
        ["Déposer un objet"] = { b = {} },
        ["Retirer un objet"] = { b = {} },
    }
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()  
    while true do
        time = 200
            if PlayerData.job.name == "unicorn" then 
                time = 350
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local diststockunicorn = Vdist(plyCoords, 106.4835, -1299.705, 28.75757-0.93)
            local diststockageunicorn = Vdist(plyCoords, 129.3758, -1281.059, 29.26306-0.93)
                if diststockageunicorn < 8 or diststockunicorn < 8 then
                    time = 0
                    DrawMarker(25, 129.3758, -1281.059, 29.26306-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false) 
                    DrawMarker(25, 106.4835, -1299.705, 28.75757-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false)  
                end
                if diststockunicorn <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~stock")
                    if IsControlJustPressed(1,51) then
                        CreateMenu(stockunicorn)
                    end
                elseif diststockageunicorn <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~stockage")
                    if IsControlJustPressed(1,51) then
                        CreateMenu(stockageunicorn)
                    end
                end
        end
        Citizen.Wait(time)
    end
end)

stockageunicorn = {

    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_green}, HeaderColor = {255, 255, 255}, Title = "Stockage Unicorn", world = true },
    Data = { currentMenu = "Liste des Objets" },
    Events = {

        onSelected = function(self, _, btn, CMenu, menuData, currentButton, currentSlt, result)
              if btn.name == "Vodka" then
                    TriggerServerEvent('zUnicorn:buy', 0, "vodka", "vodka")
              elseif btn.name == "Whisky" then
                    TriggerServerEvent('zUnicorn:buy', 0, "whisky", "whisky")
                elseif btn.name == "Gin" then
                    TriggerServerEvent('zUnicorn:buy', 0, "gin", "gin")
                elseif btn.name == "Bière" then
                    TriggerServerEvent('zUnicorn:buy', 0, "biere", "biere")
                elseif btn.name == "Calvados" then
                    TriggerServerEvent('zUnicorn:buy', 0, "calvados", "calvados")
              end
        end,
    },

    Menu = {
        ["Liste des Objets"] = {
            b = {
                {name = "Vodka", ask = ">", askX = true},
                {name = "Whisky", ask = ">", askX = true},
                {name = "Gin", ask = ">", askX = true},
                {name = "Bière", ask = ">", askX = true},
                {name = "Calvados", ask = ">", askX = true}
            }
        },
    }
}