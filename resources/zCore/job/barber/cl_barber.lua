ESX = nil
local PlayerData = {}
local target = nil


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

stockbarber = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Stock Herr Kutz", world = true},
    Data = {currentMenu = "Action"},
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
                if self.Data.currentMenu == "Déposer un objet" then 
                    local result = KeyboardInput('Nombre', '', 10)
                    if result ~= nil then
                        TriggerServerEvent('zBarber:putStockItems', zedkover.value, result)
                        OpenMenu("Action")
                    end 
                elseif self.Data.currentMenu == "Retirer un objet" then 
                    local result = KeyboardInput('Nombre :', '', 10)
                    if result ~= nil then 
                        TriggerServerEvent('zBarber:getStockItem', zedkover.value, result)
                        OpenMenu("Action")
                    end  
                end

                if zedkover.name == "Déposer un objet" then 
                    stockbarber.Menu["Déposer un objet"].b = {}
                    ESX.TriggerServerCallback('zBarber:getinventory', function(zedkover)
                        for i=1, #zedkover.items, 1 do
                            local item = zedkover.items[i]
                            if item.count > 0 then
                                table.insert(stockbarber.Menu["Déposer un objet"].b,  {name = item.label .. ' x' .. item.count, askX = true, value = item.name})
                            end
                        end
                        OpenMenu("Déposer un objet")
                    end)
                elseif zedkover.name == "Retirer un objet" then 
                    stockbarber.Menu["Retirer un objet"].b = {}
                    ESX.TriggerServerCallback('zBarber:getStockItems', function(items)  
                        for i=1, #items, 1 do 
                            if items[i].count > 0 then
                                table.insert(stockbarber.Menu["Retirer un objet"].b, {name = 'x' .. items[i].count .. ' ' .. items[i].label, askX = true, value = items[i].name})
                            end
                        end
                    OpenMenu('Retirer un objet')
                    end)
                end

       
        end,
        onOpened = function()
        end,
    },
    Menu = {
        ["Action"] = {
            b = {
                {name = "Déposer un objet", ask = ">", askX = true, id = 33},
                {name = "Retirer un objet", ask = ">", askX = true, id = 33},
            }
        },
        ["Déposer un objet"] = { b = {} },
        ["Retirer un objet"] = { b = {} },
    }
}

menubarber = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Herr Kutz", world = true},
    Data = {currentMenu = "Action"},
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if zedkover.name == "Effectuer une annonce" then 
                local result = KeyboardInput('', '', 255)
                if result ~= nil then 
                    TriggerServerEvent('zBarber:annoncebarber', result)
                end
            elseif zedkover.name == "Effectuer une facture" then 
                CreateFacture("society_barber")
            end 
        end,
    },
    Menu = {
        ["Action"] = {
            b = {
                {name = "Effectuer une facture", askX = true},
                {name = "Effectuer une annonce", askX = true}
            }
        }
    }
}

local BarberNoPed = {
    Base = {Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}}, 
    Data = { currentMenu = "Coiffeurs" },
    Events = {
        onExited = function(self, _, zedkover, CMenu, menuData, currentButton, currentBtn, currentSlt, result, slide, onSlide) 
			ClearPedTasks(PlayerPedId())
            TriggerEvent('skinchanger:modelLoaded')
        end,
        onOpened = function()
        end, 
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)

            if zedkover.id == 33 then 
                OpenMenu(zedkover.name)
            end 

            if  zedkover.name == "Selection" and zedkover.slidenum == 2 then
                TriggerServerEvent('annulertarget', target)
                CloseMenu(true)
            elseif zedkover.name == "Selection" and zedkover.slidenum == 1 then
                SetEntityCoords(PlayerPedId(), 138.12, -1708.47, 28.30)
                SetEntityHeading(PlayerPedId(), 210.8189697)

                local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
                local prop_name = "prop_cs_scissors"
                ciseau = CreateObject(GetHashKey(prop_name), x, y, z,  true,  true, true)
                AttachEntityToEntity(ciseau, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), -0.0, 0.03, 0, 0, -270.0, -20.0, true, true, false, true, 1, true)
                startAnims("misshair_shop@barbers", "keeper_idle_b")
                    Wait(10500)
                    DeleteObject(ciseau)
                DetachEntity(ciseau, 1, true)
                ClearPedTasksImmediately(GetPlayerPed(-1))
                ClearPedSecondaryTask(GetPlayerPed(-1))


                TriggerServerEvent('saveskintarget', target)
                ESX.ShowNotification("~r~Coiffeurs~s~\nVous avez changer la coupe de votre client.")
                CloseMenu(true)
            end
        end,
        onSlide = function(menuData, zedkover, currentButton, currentSlt, slide, PMenu)
            local slide = zedkover.slidenum

            if zedkover.name == "Coupes" and slide ~= -1 then
                coupe = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'hair_1', coupe)
            elseif zedkover.name == "Teinture" and slide ~= -1 then
                teinture1 = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'hair_color_1', teinture1)
            elseif zedkover.name == "Teinture 2" and slide ~= -1 then
                teinture2 = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'hair_color_2', teinture2)
            elseif zedkover.name == "Barbes" and slide ~= -1 then
                barbe = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'beard_1', barbe)
            elseif zedkover.name == "Taille" and slide ~= -1 then
                tbarbe = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'beard_2', tbarbe)
            elseif zedkover.name == "Teinture Barbe" and slide ~= -1 then
                teinture1b = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'beard_3', teinture1b)
            elseif zedkover.name == "Sourcil" and slide ~= -1 then
                sourciltype = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'eyebrows_1', sourciltype)
            elseif zedkover.name == "Taille  " and slide ~= -1 then
                taillesourcilss = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'eyebrows_2', taillesourcilss)
            elseif zedkover.name == "Teinture Sourcil" and slide ~= -1 then
                couleursourcil = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'eyebrows_3', couleursourcil)
            elseif zedkover.name == "Maquillage " and slide ~= -1 then
                maquillage = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'makeup_1', maquillage)
            elseif zedkover.name == "Taille " and slide ~= -1 then
                tmaquillage = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'makeup_2', tmaquillage)
            elseif zedkover.name == "Couleur" and slide ~= -1 then
                cmaquillage = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'makeup_3', cmaquillage)
            end
        end
    },

    Menu = {
        ["Coiffeurs"] = {
            b = {
                {name = "Cheveux", ask = ">", askX = true, id = 33},
                {name = "Barbe", ask = ">", askX = true, id = 33},
                {name = "Sourcils", ask = ">", askX = true, id = 33},
                {name = "Maquillage", ask = ">", askX = true, id = 33},
                {name = "Selection", slidemax = {"~b~Valider", "~r~Annuler"}, askX = true, id = 33},
            }
        },
        ["Cheveux"] = {
            b = {
                {name = "Coupes", slidemax = 102},
                {name = "Teinture", slidemax = 63},
                {name = "Teinture 2", slidemax = 63},
            }
        },
        ["Barbe"] = {
            b = {
                {name = "Barbes", slidemax = 28},
                {name = "Taille", slidemax = 10},
                {name = "Teinture Barbe", slidemax = 63},
            }
        },
        ["Sourcils"] = {
            b = {
                {name = "Sourcil", slidemax = 28},
                {name = "Taille  ", slidemax = 10},
                {name = "Teinture Sourcil", slidemax = 63},
            }
        },
        ["Maquillage"] = {
            b = {
                {name = "Maquillage ", slidemax = 71},
                {name = "Taille ", slidemax = 10},
                {name = "Couleur", slidemax = 63},
            }
        },
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
            if PlayerData.job.name == "barber" then 
                time = 350
      
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local distcoiffure = Vdist(plyCoords, 138.20, -1708.28, 29.30-0.93)
            local distmenu = Vdist(plyCoords, 134.69, -1707.85, 29.30-0.93)
            local diststockbarber = Vdist(plyCoords, 141.44, -1705.89, 29.30-0.93)
                if distcoiffure < 20 or distmenu < 20 or diststockbarber < 20 then
                    time = 0 
                    DrawMarker(25, 138.20, -1708.28, 29.30-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 255, 0, 0, 120, false, false, false, false) 
                    DrawMarker(25, 134.69, -1707.85, 29.30-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false) 
                    DrawMarker(25, 141.44, -1705.89, 29.30-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false) 
                end
                if distcoiffure <= 1 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~r~Coiffeur~w~")
                    if IsControlJustPressed(1,51) then
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestDistance ~= -1 and closestDistance <= 3 then
                                TriggerServerEvent('sitchairtarget', GetPlayerServerId(closestPlayer))
                                DoScreenFadeIn(2200) DoScreenFadeOut(1250) 
                                Citizen.Wait(2200)
                                CreateMenu(BarberNoPed)
                                SetEntityCoords(PlayerPedId(), 138.12, -1708.47, 28.30)
                                SetEntityHeading(PlayerPedId(), 210.8189697)
                                DoScreenFadeIn(2000) DoScreenFadeOut(1550)  DoScreenFadeIn(1000)     
                                target = GetPlayerServerId(closestPlayer)
                            else
                                ESX.ShowNotification('~r~Personne a proximité')
                            end
                        end)
                    end
                elseif distmenu <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~menu")
                    if IsControlJustPressed(1,51) then
                        CreateMenu(menubarber)
                    end
                elseif diststockbarber <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~stock Herr Kutz")
                    if IsControlJustPressed(1,51) then
                        CreateMenu(stockbarber)
                    end
                end
        end
        Citizen.Wait(time)
    end
end)

RegisterCommand('sit', function()
    SetEntityCoords(PlayerPedId(), 137.77-0.03, -1710.74-0.58, 28.30-0.20)
    SetEntityHeading(PlayerPedId(), 236.5154)
end)

RegisterNetEvent('sitchairtargetcl') 
AddEventHandler('sitchairtargetcl', function(source)
    DoScreenFadeIn(2000) DoScreenFadeOut(1250) 
    Citizen.Wait(2000)
    SetEntityCoords(PlayerPedId(), 138.15, -1709.05, 28.10)
    SetEntityHeading(PlayerPedId(), 236.5154)
    DoScreenFadeIn(2000) DoScreenFadeOut(1550)  DoScreenFadeIn(1000)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_SEAT_CHAIR_MP_PLAYER', 0, false)
end)



RegisterNetEvent('skinchanger:changetargetcl') 
AddEventHandler('skinchanger:changetargetcl', function(type, var)
    TriggerEvent('skinchanger:change', type, var)
end)

RegisterNetEvent('annulertargetcl') 
AddEventHandler('annulertargetcl', function(source)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    ClearPedSecondaryTask(GetPlayerPed(-1))
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end)

RegisterNetEvent('saveskintargetcl') 
AddEventHandler('saveskintargetcl', function(source)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    ClearPedSecondaryTask(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerServerEvent('esx_skin:save', skin)
    end)
end)


function startAnims(lib, anim)
	local lib, anim = lib,anim
	ESX.Streaming.RequestAnimDict(lib)
	TaskPlayAnim(GetPlayerPed(-1), lib, anim, 8.0, 8.0, -1, 1, 1, 0, 0, 0)
end