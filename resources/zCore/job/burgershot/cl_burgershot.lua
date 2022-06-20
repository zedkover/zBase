ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(a)
            ESX = a 
        end)
    end 
end)

local PlayerData = {}
local target = nil

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

recettemenu = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255, 255}, world = true, arrowsonly = true, Title = '            Manuel Recette' },
    Data = { currentMenu = "liste des recettes"}, 
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
        if self.Data.currentMenu == "liste des recettes" then
            recettemenu.Menu["Liste des ingrédients"].b = {}
            table.insert(recettemenu.Menu["Liste des ingrédients"].b, {name = "Recette : ~b~"..btn.name.."", ask = "", askX = true})
            table.insert(recettemenu.Menu["Liste des ingrédients"].b, {name = "Fromage : ~b~"..btn.fromage.."", ask = "", askX = true})
            table.insert(recettemenu.Menu["Liste des ingrédients"].b, {name = "Steak-haché : ~b~"..btn.steak.."", ask = "", askX = true})
            table.insert(recettemenu.Menu["Liste des ingrédients"].b, {name = "Poisson-pané : ~b~"..btn.poissonpane.."", ask = "", askX = true})
            table.insert(recettemenu.Menu["Liste des ingrédients"].b, {name = "Poulet-pané : ~b~"..btn.poissonpane.."", ask = "", askX = true})
            table.insert(recettemenu.Menu["Liste des ingrédients"].b, {name = "Cornichon : ~b~"..btn.cornichon.."", ask = "", askX = true})
            table.insert(recettemenu.Menu["Liste des ingrédients"].b, {name = "Tomate : ~b~"..btn.tomate.."", ask = "", askX = true})
            OpenMenu("Liste des ingrédients")
        end
    end, 
}, 
    Menu = {
        ["liste des recettes"] = {
            b = {
                {name = "Hamburger", item = "hamburger", fromage = 1, steak = 1, cornichon = 3, tomate = 1, poissonpane = 0,  pouletpane = 0},
                {name = "Cheese-burger", item = "cheeseburger", fromage = 2, steak = 1, cornichon = 2, tomate = 1, poissonpane = 0,  pouletpane = 0},
                {name = "Fish-burger", item = "fishburger", fromage = 1, steak = 0, cornichon = 0, tomate = 2, poissonpane = 1, pouletpane = 0},
                {name = "Chicken-burger", item = "chickenburger", fromage = 2, steak = 0, cornichon = 2, tomate = 3, poissonpane = 0,  pouletpane = 1},
            }
        },
        ["Liste des ingrédients"] = {
            b = {
            }
        }
    }
} 

cuisinemenu = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255, 255}, world = true, arrowsonly = true, Title = 'Cuisine' },
    Data = { currentMenu = "Action" },
    Events = {

    onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentSlt, result)
            
            if self.Data.currentMenu == 'Action' then 
                TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BBQ", 0, true)
                createProgressBar("Cuisson en cours..", 0, 255, 255, 200, 20000)
                Citizen.Wait(20000)
                ClearPedTasksImmediately(PlayerPedId())
                TriggerServerEvent("zburrgershot:cuisine", zedkover.item, zedkover.fromage, zedkover.steak, zedkover.cornichon, zedkover.tomate, zedkover.poissonpane, zedkover.pouletpane)
            end

        end 

            
            

    },

    Menu = {
        ["Action"] = {
            b = {
            {name = "Cuisiner un ~b~hamburger", item = "hamburger", fromage = 0, steak = 1, cornichon = 3, tomate = 1, poissonpane = 0,  pouletpane = 0},
            {name = "Cuisiner un ~b~Cheese-burger", item = "cheeseburger", fromage = 2, steak = 1, cornichon = 2, tomate = 1, poissonpane = 0,  pouletpane = 0},
            {name = "Cuisiner un ~b~Fish-burger", item = "fishburger", fromage = 1, steak = 0, cornichon = 0, tomate = 2, poissonpane = 1, pouletpane = 0},
            {name = "Cuisiner un ~b~Chicken-burger", item = "chickenburger", fromage = 2, steak = 0, cornichon = 2, tomate = 3, poissonpane = 0,  pouletpane = 1},
            
            }
        },
    }
}

f6burgershot = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "BurgerShot", world = true },
    Data = { currentMenu = "Action", GetPlayerName() },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if zedkover.name == "Effectuer une annonce" then 
                local result = KeyboardInput('', '', 255)
                if result ~= nil then 
                    TriggerServerEvent('zedkover:annonceburgershot', result)
                end
            elseif zedkover.name == "Effectuer une facture" then 
                CreateFacture("society_burgershot")
            elseif zedkover.name == "Nouvelle commande" then
                OpenMenu('Enregistrer une nouvelle commande')
            elseif zedkover.name == "Nom du client" then
                local result = GetOnscreenKeyboardResult()
                print(result)
                  if result ~= nil then  
                  client = result 
              end
              elseif zedkover.name == "Contenu de la commande" then
                local result = GetOnscreenKeyboardResult()
                print(result)
                if result ~= nil then  
                  burger = result 
                end
            elseif zedkover.name == "~b~Enregistrer la commande" then
                TriggerServerEvent('zburgershot:Commande', burger, client)
     
               elseif zedkover.name == "Liste des commandes" then
                 f6burgershot.Menu["Voici la liste des commandes"].b = {}
                 ESX.TriggerServerCallback('zburgershot:getcommande', function(zedkover)
                   for k, v in pairs(zedkover) do
                     table.insert(f6burgershot.Menu["Voici la liste des commandes"].b, {name = "Commande : ~b~".. v.name, ask = ">>", askX = true, names = v.name, id = v.id, burger = v.burger, arrowsonly = true})
                     OpenMenu('Voici la liste des commandes')	
                   end
                 end)
                 elseif zedkover.name == "~r~Supprimer la commande" then
                     print(zedkover.ids)
                     local id = zedkover.ids
                     TriggerServerEvent('zburgershot:delete', id)
                     ESX.ShowNotification('Commande supprimer : ~b~' .. id )
                     OpenMenu('Action')
                 end
             end,
                 onSlide = function(menuData, zedkover, currentButton, currentSlt, newButtons, slide, PMenu)
                         local currentMenu = menuData.currentMenu
                         local slide = zedkover.slidenum
                         if currentMenu == "Voici la liste des commandes" then 
                             f6burgershot.Menu["Résumé de la commande"].b = {}
                           table.insert(f6burgershot.Menu["Résumé de la commande"].b, {name = "Commande n° ~b~" .. zedkover.id, ask = ">", askX = true, arrowsonly = true})
                           table.insert(f6burgershot.Menu["Résumé de la commande"].b, {name = "Nom du client : ~b~" .. zedkover.names, ask = ">", askX = true, arrowsonly = true})
                           table.insert(f6burgershot.Menu["Résumé de la commande"].b, {name = "Contenu de la commande ~b~ : " .. zedkover.burger, ask = ">", askX = true, arrowsonly = true})
                           table.insert(f6burgershot.Menu["Résumé de la commande"].b, {name = "~r~Supprimer la commande", ids = zedkover.id, ask = ">", askX = true, arrowsonly = true})
                            OpenMenu('Résumé de la commande')
                         end
                     end
                 
    },
    Menu = {
        ["Action"] = {
            b = {
                {name = "Effectuer une facture", ask = ">", askX = true},
                {name = "Effectuer une annonce", ask = ">", askX = true},
                {name = "Nouvelle commande", ask = ">", askX = true},
                {name = "Liste des commandes", ask = ">", askX = true}
            }
        },
        ["Enregistrer une nouvelle commande"] = {
            b = {
            {name = "Nom du client", ask = ""},
            {name = "Contenu de la commande", ask = ""},
            {name = "~b~Enregistrer la commande", ask = ">", askX = true},
            }
        },
        ["Voici la liste des commandes"] = {
            b = {}
        },
        ["Résumé de la commande"] = {
            b = {}
        },
    }
}

stockburgershot = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Vestiare BurgerShot", world = true },
    Data = { currentMenu = "Action", GetPlayerName() },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
                if self.Data.currentMenu == "Déposer un objet" then 
                    local result = KeyboardInput('Nombre', '', 10)
                    if result ~= nil then
                        TriggerServerEvent('zburgershot:putStockItems', zedkover.value, result)
                        OpenMenu("Action")
                    end 
                elseif self.Data.currentMenu == "Retirer un objet" then 
                    local result = KeyboardInput('Nombre :', '', 10)
                    if result ~= nil then 
                        TriggerServerEvent('zburgershot:getStockItem', zedkover.value, result)
                        OpenMenu("Action")
                    end  
                end
                if zedkover.name == "Déposer un objet" then 
                    stockburgershot.Menu["Déposer un objet"].b = {}
                    ESX.TriggerServerCallback('zburgershot:getinventory', function(zedkover)
                        for i=1, #zedkover.items, 1 do
                            local item = zedkover.items[i]
                            if item.count > 0 then
                                table.insert(stockburgershot.Menu["Déposer un objet"].b,  {name = item.label .. ' x' .. item.count, askX = true, value = item.name})
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
                            TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.burgershot_tenue.male)
                        elseif skin.sex == 1 then
                            TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.burgershot_tenue.female)
                        end
                    end)
                elseif zedkover.name == "Retirer un objet" then 
                    stockburgershot.Menu["Retirer un objet"].b = {}
                    ESX.TriggerServerCallback('zburgershot:getStockItems', function(items)  
                        for i=1, #items, 1 do 
                            if items[i].count > 0 then
                                table.insert(stockburgershot.Menu["Retirer un objet"].b, {name = 'x' .. items[i].count .. ' ' .. items[i].label, askX = true, value = items[i].name})
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

garageburgershot = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Garage", world = true },
    Data = { currentMenu = "Action", GetPlayerName() },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if self.Data.currentMenu == "Action" and zedkover.name ~= "Ranger le vehicule" then 
                TriggerEvent('esx:deleteVehicle')  
                ESX.Game.SpawnVehicle(zedkover.value, {x = Config.Spawngarageburgershot.x,y = Config.Spawngarageburgershot.y, z =  Config.Spawngarageburgershot.z + 1}, Config.Spawngarageburgershot.a, function(vehicle)
                    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)    
                    local plate = GetVehicleNumberPlateText(vehicle)
                    TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate)        
				end)  
            end 
            if zedkover.name == "Ranger le vehicule" then 
                TriggerEvent('esx:deleteVehicle')  
            end 
        end,
    },
    Menu = {
        ["Action"] = {
            b = {
                {name = "Ranger le vehicule", ask = ">", askX = true, id = 33},
            }
        },
        ["Ranger le vehicule"] = { b = {} },
    }
}

function opengarageburgershot()
    garageburgershot.Menu["Action"].b = {}
    for k, v in pairs(Config.carsburgershot) do
        table.insert(garageburgershot.Menu["Action"].b, {name = v.label, value = v.name})
    end
    table.insert(garageburgershot.Menu["Action"].b, {name = "Ranger le vehicule"})
    CreateMenu(garageburgershot)
end 

Citizen.CreateThread(function()
    RequestModel(GetHashKey("mp_m_waremech_01"))
    while not HasModelLoaded(GetHashKey("mp_m_waremech_01")) do 
        Wait(1) 
    end
    ped = CreatePed(4, "mp_m_waremech_01", Config.Pedgarageburgershot.x, Config.Pedgarageburgershot.y, Config.Pedgarageburgershot.z, false, true)
    FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
    SetEntityHeading(ped, Config.Pedgarageburgershot.a) 
    SetBlockingOfNonTemporaryEvents(ped, true)
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
            if PlayerData.job.name == "burgershot" then 
                time = 350
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local diststockburgershot = Vdist(plyCoords, -1204.325, -891.9033, 13.98022-0.93)
            local distgarageburgershot = Vdist(plyCoords, -1175.842, -899.5912, 13.69373-0.93)
            local distcuisinemenu = Vdist(plyCoords, -1202.031, -896.8747, 13.98022-0.93)
            local distrecettemenu = Vdist(plyCoords, -1197.785, -901.7407, 13.98022-0.93)
                if distcuisinemenu < 30 or diststockburgershot < 30 or distrecettemenu < 30 then
                    time = 0
                    DrawMarker(25, -1202.031, -896.8747, 13.98022-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false) 
                    DrawMarker(25, -1204.325, -891.9033, 13.98022-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false)  
                    DrawMarker(25, -1197.785, -901.7407, 13.98022-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false)  

                end
                if diststockburgershot <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~stock")
                    if IsControlJustPressed(1,51) then
                        CreateMenu(stockburgershot)
                    end
                elseif distgarageburgershot <= 1.5 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~garage")
                    if IsControlJustPressed(1,51) then
                        
                        opengarageburgershot()
                    end
                elseif distcuisinemenu <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~stockage")
                    if IsControlJustPressed(1,51) then
                        CreateMenu(cuisinemenu)
                    end
                elseif distrecettemenu <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder à la ~b~recette")
                    if IsControlJustPressed(1,51) then
                        CreateMenu(recettemenu)
                    end
                end
        end
        Citizen.Wait(time)
    end
end)


RegisterKeyMapping('burgershot', 'Menu BurgerShot', 'keyboard', 'F6')

RegisterCommand('burgershot', function()
    if PlayerData.job.name == "burgershot" then 
        CreateMenu(f6burgershot)
    end    
end)