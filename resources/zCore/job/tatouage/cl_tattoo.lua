ESX = nil
local PlayerData = {}
local currentsex = nil

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)


local currentTattoos = {}
local currentmenudisplay
local target

AddEventHandler('skinchanger:modelLoaded', function()
    ESX.TriggerServerCallback('zTattoo:requestPlayerTattoos', function(tattooList)
        if json.encode(tattooList) ~= "[]" then 
    
            for k,v in pairs(tattooList) do
                SetPedDecoration(PlayerPedId(), v.collection, v.texture)
            end
			currentTattoos = tattooList
		end
	end)
end)

stocktatto = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Stock Blazing Tattoo", world = true},
    Data = {currentMenu = "Action"},
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
                if self.Data.currentMenu == "Déposer un objet" then 
                    local result = KeyboardInput('Nombre', '', 10)
                    if result ~= nil then
                        TriggerServerEvent('zTattoo:putStockItemstattoo', zedkover.value, result)
                        OpenMenu("Action")
                    end 
                elseif self.Data.currentMenu == "Retirer un objet" then 
                    local result = KeyboardInput('Nombre :', '', 10)
                    if result ~= nil then 
                        TriggerServerEvent('zTattoo:getStockItemtattoo', zedkover.value, result)
                        OpenMenu("Action")
                    end  
                end

                if zedkover.name == "Déposer un objet" then 
                    stocktatto.Menu["Déposer un objet"].b = {}
                    ESX.TriggerServerCallback('zTattoo:getinventorytattoo', function(zedkover)
                        for i=1, #zedkover.items, 1 do
                            local item = zedkover.items[i]
                            if item.count > 0 then
                                table.insert(stocktatto.Menu["Déposer un objet"].b,  {name = item.label .. ' x' .. item.count, askX = true, value = item.name})
                            end
                        end
                        OpenMenu("Déposer un objet")
                    end)
                elseif zedkover.name == "Retirer un objet" then 
                    stocktatto.Menu["Retirer un objet"].b = {}
                    ESX.TriggerServerCallback('zTattoo:getStockItemstattoo', function(items)  
                        for i=1, #items, 1 do 
                            if items[i].count > 0 then
                                table.insert(stocktatto.Menu["Retirer un objet"].b, {name = 'x' .. items[i].count .. ' ' .. items[i].label, askX = true, value = items[i].name})
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

Menu = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Blazing Tattoo", world = true},
    Data = {currentMenu = "Action"},
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if zedkover.id == 33 then 
                OpenMenu(zedkover.name)
            elseif zedkover.name == "Effectuer une annonce" then 
                local result = KeyboardInput('', '', 255)
                if result ~= nil then 
                    TriggerServerEvent('zTattoo:annoncetattoo', result)
                end
            elseif zedkover.name == "Effectuer une facture" then 
                CreateFacture("society_tattoo")
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

TattooMenu = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Blazing Tattoo", world = true},
    Data = { currentMenu = "Action" },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if self.Data.currentMenu == "Action" and zedkover.name ~= "Allonger" and zedkover.name ~= "Sex" then 

                TattooMenu.Menu["Changement tattoo"].b = {}
                for k, v in pairs(Config.AllTattooList) do 
                    if v.Zone == zedkover.value then 
                        if currentsex == "homme" then 
                            if GetLabelText(v.Name) ~= "NULL" then 
                                tattooname = GetLabelText(v.Name)
                            else
                                tattooname = v.Name
                            end 
                            table.insert(TattooMenu.Menu["Changement tattoo"].b, {name = tattooname, value = v.HashNameMale, col = v.Collection, prefix = v.Name, iterator = k})
                        else
                            if GetLabelText(v.Name) ~= "NULL" then 
                                tattooname = GetLabelText(v.Name)
                            else
                                tattooname = v.Name
                            end 
                            table.insert(TattooMenu.Menu["Changement tattoo"].b, {name = tattooname, value = v.HashNameFemale, col = v.Collection, prefix = v.Name, iterator = k})
                        end
                    end 
                end 
                OpenMenu('Changement tattoo')
    


            elseif self.Data.currentMenu == "Changement tattoo" and currentmenudisplay ~= "catalogue" then 
                TriggerServerEvent('zTattoo:changeclothe', target, "achetertattoo", zedkover.col, zedkover.value)  
                RequestAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
        
                while not HasAnimDictLoaded('anim@amb@clubhouse@tutorial@bkr_tut_ig3@') do
                  Citizen.Wait(0)
                end
                local ped = GetPlayerPed(-1)
                FreezeEntityPosition(ped, true)
                local x,y,z = table.unpack(GetEntityCoords(ped))
                local prop_name = "v_ilev_ta_tatgun"
                Jointsupp = CreateObject(GetHashKey(prop_name), x, y, z,  true,  true, true)
                AttachEntityToEntity(Jointsupp, ped, GetPedBoneIndex(ped, 28422), -0.0, 0.03, 0, 0, -270.0, -20.0, true, true, false, true, 1, true)
                TaskPlayAnim(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)
                Wait(15000)
                DeleteObject(Jointsupp)
                DetachEntity(Jointsupp, 1, true)
                ClearPedTasksImmediately(ped)
                ClearPedSecondaryTask(ped)
                FreezeEntityPosition(ped, false)
            end 
            if zedkover.name == "Allonger" and zedkover.slidenum == 1 then
                TriggerServerEvent('zTattoo:changeclothe', target, "dos")
            elseif  zedkover.name == "Allonger" and zedkover.slidenum == 2 then
                TriggerServerEvent('zTattoo:changeclothe', target, "ventre")
            elseif zedkover.name == "Sex" and zedkover.slidenum == 1 then 
                currentsex = "homme"
            elseif zedkover.name == "Sex" and zedkover.slidenum == 2 then 
                currentsex = "femme"
            end 
        end,
        onButtonSelected = function(currentMenu, currentBtn, zedkover, menuData, newButtons, self)
            if currentMenu == "Changement tattoo" then  
                if currentmenudisplay ~= "catalogue" then 
                    TriggerServerEvent('zTattoo:changetattoo', target, menuData.col, menuData.value)   
                else
                    ClearPedDecorations(ped)
                    SetPedDecoration(ped, menuData.col, menuData.value)
                end
                    
            end
        end,
        onOpened = function()
            if currentmenudisplay ~= "catalogue" then 
                TriggerServerEvent('zTattoo:changeclothe', target, "changeclothe")
            end
        end,
        onExited = function()
            if currentmenudisplay ~= "catalogue" then 
            TriggerServerEvent('zTattoo:changeclothe', target, "getclothes")
            else
                stepout()
                Wait(2000)
                DeletePed(ped)
            end
        end, 

    },
    Menu = {
        ["Action"] = {b = {}},
        ["Changement tattoo"] = {useFilter = true,b = {}},
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
            time = 500
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            if PlayerData.job.name == "tattoo" then 
                local menutattoo = Vdist(plyCoords, 324.46, 180.22, 103.58-0.93)
                local menumenu = Vdist(plyCoords, 319.68, 180.78, 103.58-0.93)
                local menustocktatto = Vdist(plyCoords, 322.04, 185.55, 103.58-0.93)
                if menutattoo < 20 then 
                    time = 0
                    DrawMarker(25, 324.46, 180.22, 103.58-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 255, 0, 0, 120, false, false, false, false) 
                    DrawMarker(25, 319.68, 180.78, 103.58-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false) 
                    DrawMarker(25, 322.04, 185.55, 103.58-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false)
                end      
                if menutattoo <= 1 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour ~b~tatouer une personne")
                    if IsControlJustPressed(1,51) then
                        currentmenudisplay = "menu"
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            target = GetPlayerServerId(closestPlayer) 
                            TattooMenu.Menu["Action"].b = {}  
                            table.insert(TattooMenu.Menu["Action"].b, {name = "Allonger", slidemax = {" Sur le dos", " Sur le ventre"}})
                            table.insert(TattooMenu.Menu["Action"].b, {name = "Sex", slidemax = {"Homme", "Femme"}}) 
                            for k, v in pairs(Config.TattooCats) do
                                table.insert(TattooMenu.Menu["Action"].b, {name = v[2], value = v[1]})
                            end
                            CreateMenu(TattooMenu)
                        else
                            ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
                        end    
                    end
                elseif menumenu <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~menu")
                    if IsControlJustPressed(1,51) then
                        CreateMenu(Menu) 
                    end
                elseif menustocktatto <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~stock Blazing Tattoo")
                    if IsControlJustPressed(1,51) then
                        CreateMenu(stocktatto) 
                    end
                end      
            end
        Citizen.Wait(time)
    end
end)

function startAnims(lib, anim)
	local lib, anim = lib,anim
	ESX.Streaming.RequestAnimDict(lib)
	TaskPlayAnim(GetPlayerPed(-1), lib, anim, 8.0, 8.0, -1, 1, 1, 0, 0, 0)
end

RegisterNetEvent('zTattoo:changeclothecl') 
AddEventHandler('zTattoo:changeclothecl', function(result, z, q)
    if result == "changeclothe" then 
        SetEntityCoords(PlayerPedId(), 325.6615, 180.567, 103.2109)
        SetEntityHeading(PlayerPedId(), 150.13)
        Wait(100)
        FreezeEntityPosition(PlayerPedId(), true)

       
        Wait(2000)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        TriggerEvent('skinchanger:getSkin', function(skin)
            if skin.sex == 0 then
                TriggerEvent('skinchanger:loadSkin', {
                    sex      = 0,
                    tshirt_1 = 15,
                    tshirt_2 = 0,
                    arms     = 15,
                    torso_1  = 91,
                    torso_2  = 0,
                    pants_1  = 14,
                    pants_2  = 0
                })
            else
                TriggerEvent('skinchanger:loadSkin', {
                    sex      = 1,
                    tshirt_1 = 16,
                    tshirt_2 = 0,
                    arms     = 15,
                    torso_1  = 15,
                    torso_2  = 0,
                    pants_1  = 62,
                    pants_2  = 0
                })
            end
        end)
    elseif result == "getclothes" then 
        FreezeEntityPosition(PlayerPedId(), false) 
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
        ClearPedTasksImmediately(PlayerPedId())
        ClearPedSecondaryTask(PlayerPedId())
        ClearPedDecorations(PlayerPedId())
        for k,v in pairs(currentTattoos) do
            SetPedDecoration(PlayerPedId(), v.collection, v.texture)
        end
        SetEntityCoords(PlayerPedId(), 324.3824, 178.6813, 103.5707)
        SetEntityHeading(PlayerPedId(), 325.12)
    elseif result == "achetertattoo" then
        ESX.TriggerServerCallback('zTattoo:purchaseTattoo', function(cb)
            if cb then
                table.insert(currentTattoos, {collection = z, texture = q})
            end
        end, currentTattoos, {collection = z, texture = q})
    elseif result == "dos" then 
        startAnims("switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_girl")
    elseif result == "ventre" then 
        startAnims("missfbi3_sniping", "prone_dave")
    end
end)

RegisterNetEvent('zTattoo:changetattoocl') 
AddEventHandler('zTattoo:changetattoocl', function(cr, pr)
    for k,v in pairs(currentTattoos) do
        SetPedDecoration(PlayerPedId(), v.collection, v.texture)
    end
    ClearPedDecorations(PlayerPedId())
    SetPedDecoration(PlayerPedId(), cr, pr)
end)

function pedclothe()
    SetPedComponentVariation(ped, 11, 14, 2, 2) 
    SetPedComponentVariation(ped, 4, 1, 0, 2) 
    SetPedComponentVariation(ped, 3, 4, 0, 2)
    SetPedComponentVariation(ped, 6, 1, 0, 2)
    SetPedComponentVariation(ped, 8, 16, 9, 2) 
end

function pednoclothe()
    SetPedComponentVariation(ped, 11, 124, 2, 2) 
    SetPedComponentVariation(ped, 4, 14, 0, 2) 
    SetPedComponentVariation(ped, 3, 15, 0, 2)
    SetPedComponentVariation(ped, 6, 34, 0, 2)
    SetPedComponentVariation(ped, 8, 16, 9, 2) 
end