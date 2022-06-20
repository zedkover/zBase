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

f6resto = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Irish Pub", world = true },
    Data = { currentMenu = "Action", GetPlayerName() },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if zedkover.name == "Effectuer une annonce" then 
                local result = KeyboardInput('', '', 255)
                if result ~= nil then 
                    TriggerServerEvent('zedkover:annoncerestaurant', result)
                end
            elseif zedkover.name == "Supprimer l'objet" then
                ClearPedTasksImmediately()
                ClearPedTasks()
                ClearPedSecondaryTask()
                DeleteObject(Tray)
                DeleteObject(BeerBottle)
            elseif zedkover.name == "Effectuer une facture" then 
                CreateFacture("society_restaurant")
            end
        end,
    },
    Menu = {
        ["Action"] = {
            b = {
                {name = "Effectuer une facture", ask = ">", askX = true},
                {name = "Effectuer une annonce", ask = ">", askX = true},
                {name = "Supprimer l'objet", ask = ">", askX = true}
            }
        }
    }
}

stockresto = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Vestiare Restaurant", world = true },
    Data = { currentMenu = "Action", GetPlayerName() },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
                if self.Data.currentMenu == "Déposer un objet" then 
                    local result = KeyboardInput('Nombre', '', 10)
                    if result ~= nil then
                        TriggerServerEvent('zrestaurant:putStockItems', zedkover.value, result)
                        OpenMenu("Action")
                    end 
                elseif self.Data.currentMenu == "Retirer un objet" then 
                    local result = KeyboardInput('Nombre :', '', 10)
                    if result ~= nil then 
                        TriggerServerEvent('zrestaurant:getStockItem', zedkover.value, result)
                        OpenMenu("Action")
                    end  
                end

                if zedkover.name == "Déposer un objet" then 
                    stockresto.Menu["Déposer un objet"].b = {}
                    ESX.TriggerServerCallback('zrestaurant:getinventory', function(zedkover)
                        for i=1, #zedkover.items, 1 do
                            local item = zedkover.items[i]
                            if item.count > 0 then
                                table.insert(stockresto.Menu["Déposer un objet"].b,  {name = item.label .. ' x' .. item.count, askX = true, value = item.name})
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
                            TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.resto_tenue.male)
                        elseif skin.sex == 1 then
                            TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.resto_tenue.female)
                        end
                    end)
                elseif zedkover.name == "Retirer un objet" then 
                    stockresto.Menu["Retirer un objet"].b = {}
                    ESX.TriggerServerCallback('zrestaurant:getStockItems', function(items)  
                        for i=1, #items, 1 do 
                            if items[i].count > 0 then
                                table.insert(stockresto.Menu["Retirer un objet"].b, {name = 'x' .. items[i].count .. ' ' .. items[i].label, askX = true, value = items[i].name})
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

garageresto = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Garage", world = true },
    Data = { currentMenu = "Action", GetPlayerName() },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if self.Data.currentMenu == "Action" and zedkover.name ~= "Ranger le vehicule" then 
                TriggerEvent('esx:deleteVehicle')  
                ESX.Game.SpawnVehicle(zedkover.value, {x = Config.Spawngarageresto.x,y = Config.Spawngarageresto.y, z =  Config.Spawngarageresto.z + 1}, Config.Spawngarageresto.a, function(vehicle)
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

function opengarageresto()
    garageresto.Menu["Action"].b = {}
    for k, v in pairs(Config.carsresto) do
        table.insert(garageresto.Menu["Action"].b, {name = v.label, value = v.name})
    end
    table.insert(garageresto.Menu["Action"].b, {name = "Ranger le vehicule"})
    CreateMenu(garageresto)
end 

Citizen.CreateThread(function()

    RequestModel(GetHashKey("mp_m_waremech_01"))
    while not HasModelLoaded(GetHashKey("mp_m_waremech_01")) do 
        Wait(1) 
    end
    ped = CreatePed(4, "mp_m_waremech_01", Config.Pedgarageresto.x, Config.Pedgarageresto.y, Config.Pedgarageresto.z, false, true)
    FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
    SetEntityHeading(ped, Config.Pedgarageresto.a) 
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
            if PlayerData.job.name == "restaurant" then 
                time = 350
      
   
    


            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local diststockresto = Vdist(plyCoords, 829.20, -117.92, 80.43)
            local distgarageresto = Vdist(plyCoords, 826.22, -122.36, 80.38-0.93)
            local diststockageresto = Vdist(plyCoords, 822.59, -116.16, 80.43-0.93)

      
                if diststockageresto < 8 or diststockresto < 8 then
                    time = 0
                    DrawMarker(25, 822.59, -116.16, 80.43-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false) 
                    DrawMarker(25, 829.20, -117.92, 80.43-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false)  
                end

                if diststockresto <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~stock")
                    if IsControlJustPressed(1,51) then
                        CreateMenu(stockresto)
                    end
                elseif distgarageresto <= 1.5 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~garage")
                    if IsControlJustPressed(1,51) then
                        
                        opengarageresto()
                    end
                elseif diststockageresto <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~stockage")
                    if IsControlJustPressed(1,51) then
                        CreateMenu(stockageresto)
                    end
                end
        end
        Citizen.Wait(time)
    end
end)

function anim()
    if not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") then
        RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
        while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
            Citizen.Wait(1000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
        end
    end
    
    SetPedIsDrunk(GetPlayerPed(-1), true)
    ShakeGameplayCam("DRUNK_SHAKE", 1.0)
    SetPedConfigFlag(GetPlayerPed(-1), 100, true)
    SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@VERYDRUNK", 1.0)
end

RegisterNetEvent('zedkover:usebiere')
AddEventHandler('zedkover:usebiere', function()
    local playerPed = GetPlayerPed(-1)
	local PlayerCoords = GetEntityCoords(playerPed)
    anim()
end)

RegisterNetEvent('zedkover:usegin')
AddEventHandler('zedkover:usegin', function()
    local playerPed = GetPlayerPed(-1)
	local PlayerCoords = GetEntityCoords(playerPed)
    anim()
end)

RegisterNetEvent('zedkover:usewhisky')
AddEventHandler('zedkover:usewhisky', function()
	local playerPed = GetPlayerPed(-1)
	local PlayerCoords = GetEntityCoords(playerPed)
    anim()
end)

RegisterNetEvent('zedkover:usecalvados')
AddEventHandler('zedkover:usecalvados', function()
	local playerPed = GetPlayerPed(-1)
	local PlayerCoords = GetEntityCoords(playerPed)
	anim()
end)

RegisterNetEvent('zedkover:usevodka')
AddEventHandler('zedkover:usevodka', function()
	local playerPed = GetPlayerPed(-1)
	local PlayerCoords = GetEntityCoords(playerPed)
	anim()
end)

RegisterKeyMapping('resto', 'Menu Restaurant', 'keyboard', 'F6')

RegisterCommand('resto', function()
    if PlayerData.job.name == "restaurant" then 
        CreateMenu(f6resto)
    end    
end)

stockageresto = {

    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_green}, HeaderColor = {255, 255, 255}, Title = "Stockage Restaurant", world = true },
    Data = { currentMenu = "Liste des Objets" },
    Events = {

        onSelected = function(self, _, btn, CMenu, menuData, currentButton, currentSlt, result)
              if btn.name == "Vodka" then
                    TriggerServerEvent('zrestaurant:buy', 0, "vodka", "vodka")
              elseif btn.name == "Whisky" then
                    TriggerServerEvent('zrestaurant:buy', 0, "whisky", "whisky")
                elseif btn.name == "Gin" then
                    TriggerServerEvent('zrestaurant:buy', 0, "gin", "gin")
                elseif btn.name == "Bière" then
                    TriggerServerEvent('zrestaurant:buy', 0, "biere", "biere")
                elseif btn.name == "Calvados" then
                    TriggerServerEvent('zrestaurant:buy', 0, "calvados", "calvados")
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

local isInJob = false
local isInJobText = "Appuyez sur ~b~E~s~ pour prendre votre ~b~service~s~"
local SelectedDrink = "nil"
local BeerProp = "nil"

local Orders = {
    'Appuyez sur ~b~E~s~ pour servir de la ~b~Bière~s~',
    'Appuyez sur ~b~E~s~ pour servir du ~b~Gin~s~',
    'Appuyez sur ~b~E~s~ pour servir de la ~b~Vodka~s~',
    'Appuyez sur ~b~E~s~ pour servir du ~b~Calvados~s~',
    'Appuyez sur ~b~E~s~ pour servir du ~b~Whisky~s~',
}

local ChiwasRegalPrice = 258
local GilbeysCinPrice = 220
local AbsoluteVodkaPrice = 197
local CalvadosPrice = 173
local ROMPrice = 298

local FirstPedSelectedOrderPrice = nil

local Animations = {
    Sitting = "WORLD_HUMAN_SEAT_LEDGE",
    Sitting2 = "PROP_HUMAN_SEAT_BAR",
    Sitting3 = "WORLD_HUMAN_SEAT_LEDGE",
    Drinking = "PROP_HUMAN_SEAT_CHAIR_DRINK_BEER"
}

local CurrentFirstPedStageText = ""

local FirstCustomerPedCoords = { x = 851.48, y = -112.6, z = 78.77, h = 100.25} 
local FirstCustomerPedSlideCoords = { x = 844.47, y = -113.2, z = 79.77, h = 107.79}
local FirstCustomerPedHash = 'a_m_o_genstreet_01'

local FirstCustomerPedSitCoords = nil
local FirstPedSelectedOrder = "thinking"
local Chairs = {
    vector3(842.88, -110.29, 78.30),
    vector3(835.17, -104.98, 78.30),
    vector3(845.4, -116.94, 78.30),
}
local FirstCustomerPedSitHeading = nil

local CustomerInPub = false
local ServicesTaked = false

Citizen.CreateThread(function()
    while true do
        local player = PlayerPedId()
        local playerLoc = GetEntityCoords(player, false)
        if PlayerData.job and PlayerData.job.name == 'restaurant' and GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, vector3(826.29, -109.81, 79.77), true) < 2 then      
            sleep = 5
            if isInJob == false and IsControlJustReleased(0, 38) then 
                DisableControlAction(0, 69, true)
                isInJobText = "Appuyez sur ~r~E~s~ pour quitter votre ~r~service~s~"
                isInJob = true
            elseif isInJob == true and IsControlJustReleased(0, 38) then
                DisableControlAction(0, 69, false)
                isInJob = false
                DeleteEntity(FirstCustomerPed)
                OrdersTaked = false 
                FirstCustomerPedSitCoords = nil
                SelectedDrink = "nil"
                FirstPedSelectedOrder = "thinking"
                CurrentFirstPedStageText = ""
                FirstCustomerPedSitHeading = nil
                ServicesTaked = false
                isInJobText = "Appuyez sur ~b~E~s~ pour prendre votre ~b~service~s~"
            end
            DrawText3D(826.29, -109.81, 79.77, isInJobText)
        else           
            sleep = 1500
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local player = PlayerPedId()
        local playerLoc = GetEntityCoords(player)
        if isInJob == true then
            sleep = 5
            if GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, vector3(837.46, -117.06, 79.77), true) < 1.5 then
                DrawText3D(837.46, -117.06, 79.77, "Appuyez sur ~b~E~s~ pour prendre de la ~b~Bière~s~")
                if IsControlJustReleased(0, 38) then
                    SelectedDrink = 'Appuyez sur ~b~E~s~ pour servir de la ~b~Bière~s~'
                    BeerProp = 'prop_cs_beer_bot_03'
                    PlayPlayerTrayAnim()
                end
            elseif GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, vector3(835.75, -115.84, 79.77), true) < 1.5 then
                DrawText3D(835.75, -115.84, 79.77, "Appuyez sur ~b~E~s~ pour prendre du ~b~Gin~s~")
                if IsControlJustReleased(0, 38) then
                    SelectedDrink = 'Appuyez sur ~b~E~s~ pour servir du ~b~Gin~s~'
                    BeerProp = 'prop_sh_beer_pissh_01'
                    PlayPlayerTrayAnim()
                end
            elseif GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, vector3(833.75, -114.66, 79.77), true) < 1.5 then
                DrawText3D(833.75, -114.66, 79.77, "Appuyez sur ~b~E~s~ pour prendre de la ~b~Vodka~s~")
                if IsControlJustReleased(0, 38) then
                    SelectedDrink = 'Appuyez sur ~b~E~s~ pour servir de la ~b~Vodka~s~'
                    BeerProp = 'prop_cs_beer_bot_03'
                    PlayPlayerTrayAnim()
                end
            elseif GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, vector3(832.53, -113.93, 79.77), true) < 1.5 then
                DrawText3D(832.53, -113.93, 79.77, "Appuyez sur ~b~E~s~ pour prendre du ~b~Calvados~s~")
                if IsControlJustReleased(0, 38) then
                    SelectedDrink = 'Appuyez sur ~b~E~s~ pour servir du ~b~Calvados~s~'
                    BeerProp = 'prop_cs_beer_bot_01lod'
                    PlayPlayerTrayAnim()
                end
            elseif GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, vector3(831.0, -113.13, 79.77), true) < 1.5 then
                DrawText3D(831.0, -113.13, 79.77, "Appuyez sur ~b~E~s~ pour prendre du ~b~Whisky~s~") 
                if IsControlJustReleased(0, 38) then
                    SelectedDrink = 'Appuyez sur ~b~E~s~ pour servir du ~b~Whisky~s~'
                    BeerProp = 'prop_cs_whiskey_bottle'
                    PlayPlayerTrayAnim()
                end
            end
        else
            sleep = 3000
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        if isInJob == true then
            sleep = 6000
            if not DoesEntityExist(FirstCustomerPed) then
                CreateFirstCustomerPed() 
            end
        else
            sleep = 10000
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local player = PlayerPedId()
        local playerLoc = GetEntityCoords(player, false)
        local FirstCustomerPedLoc = GetEntityCoords(FirstCustomerPed, false)

        if GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, FirstCustomerPedLoc.x, 836.334, -110.189, 79.79, true) < 50 then
            isInJob = false
            DeleteEntity(FirstCustomerPed)
            Citizen.Wait(2000)

            OrdersTaked = false 
            FirstCustomerPedSitCoords = nil
            SelectedDrink = "nil"
            FirstPedSelectedOrder = "thinking"
            CurrentFirstPedStageText = ""
            FirstCustomerPedSitHeading = nil
            ServicesTaked = false
            FirstPedSelectedOrderPrice = nil
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if isInJob == true then
            sleep = 5
            local player = PlayerPedId()
            local playerLoc = GetEntityCoords(player, false)
            local FirstCustomerPedLoc = GetEntityCoords(FirstCustomerPed, false)
            if GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, FirstCustomerPedLoc.x, FirstCustomerPedLoc.y, FirstCustomerPedLoc.z, true) < 1.6 then
                DrawText3D(FirstCustomerPedLoc.x, FirstCustomerPedLoc.y, FirstCustomerPedLoc.z, CurrentFirstPedStageText)
            end
        else
            sleep = 2000
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do

        if isInJob == true then
            sleep = 5
            local player = PlayerPedId()
            local playerLoc = GetEntityCoords(player, false)
            local FirstCustomerPedLoc = GetEntityCoords(FirstCustomerPed, false)
            if GetDistanceBetweenCoords(FirstCustomerPedLoc.x, FirstCustomerPedLoc.y, FirstCustomerPedLoc.z, 844.47, -113.2, 79.77, 107.79, true) < 2 and GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, FirstCustomerPedLoc.x, FirstCustomerPedLoc.y, FirstCustomerPedLoc.z, true) < 1.6 then
                CurrentFirstPedStageText = "Appuyez sur ~b~E~s~ diriger le client vers une table"
                CustomerInPub = true
                if CustomerInPub == true and IsControlJustReleased(0, 38) then
                    SeatRandomForFirstPed()
                    CurrentFirstPedStageText = ""   
                    if FirstCustomerPedSitCoords == vector3(842.88, -110.29, 78.30) then
                        WaitTime = 2500
                        TaskPedSlideToCoord(FirstCustomerPed, 842.22, -110.9, 78.77, 49.75, 10.0)
                    elseif FirstCustomerPedSitCoords == vector3(835.17, -104.98, 78.30) then
                        TaskPedSlideToCoord(FirstCustomerPed, 834.59, -106.59, 78.77, 324.9, 10.0)
                        WaitTime = 8300
                    elseif FirstCustomerPedSitCoords == vector3(845.4, -116.94, 78.30) then
                        TaskPedSlideToCoord(FirstCustomerPed, 845.4, -116.94, 78.30, 324.9, 10.0)
                        WaitTime = 3000
                    end
                    Citizen.Wait(WaitTime)
                    CurrentFirstPedStageText = "Appuyez sur ~b~E~s~ prendre la commande du client"   
                    OrdersTaked = true  
                    PlaceFirstCustomer()  
                    WaitTime = 0
                end
            end
        else
            sleep = 2000
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        if isInJob == true then
            sleep = 5
            local player = PlayerPedId()
            local playerLoc = GetEntityCoords(player, false)
            local FirstCustomerPedLoc = GetEntityCoords(FirstCustomerPed, false)

            if GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, FirstCustomerPedLoc.x, FirstCustomerPedLoc.y, FirstCustomerPedLoc.z, true) < 1.6 and OrdersTaked == true and IsControlJustReleased(0, 38) then
                CreateRandomOrderForFirstPed()
                CurrentFirstPedStageText = FirstPedSelectedOrder
                ServicesTaked = true
                if GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, FirstCustomerPedLoc.x, FirstCustomerPedLoc.y, FirstCustomerPedLoc.z, true) < 1.6 and ServicesTaked == true and IsControlJustReleased(0, 38) and SelectedDrink == FirstPedSelectedOrder then
                    CustomerDrinkAnim()
                    ClearPedTasksImmediately(player)
                    DeleteObject(BeerBottle)
                    DeleteObject(Tray)
                    CurrentFirstPedStageText = ""
                    SelectedDrink = "nil"
                    Citizen.Wait(20000)
                    IsReadyForExit = true
                    TriggerServerEvent('zrestaurant:giveMoney', FirstPedSelectedOrderPrice)
                    FreezeEntityPosition(FirstCustomerPed, false)
                    if FirstCustomerPedSitCoords == vector3(842.88, -110.29, 78.30) then
                        ClearPedTasksImmediately(FirstCustomerPed)
                        SetEntityCoords(FirstCustomerPed, 842.43, -111.28, 78.77)
                        SetEntityHeading(FirstCustomerPed, 244.25)
                        Citizen.Wait(500)
                        TaskPedSlideToCoord(FirstCustomerPed, 849.52, -113.11, 79.45, 258.78, 10.0)

                    elseif FirstCustomerPedSitCoords == vector3(835.17, -104.98, 78.30) then
                        ClearPedTasksImmediately(FirstCustomerPed)
                        SetEntityCoords(FirstCustomerPed, 834.44, -107.1, 78.77)
                        SetEntityHeading(FirstCustomerPed, 242.25)
                        Citizen.Wait(500)
                        TaskPedSlideToCoord(FirstCustomerPed, 841.84, -111.41, 79.45, 249.03, 10.0)
                        Citizen.Wait(5000)
                        TaskPedSlideToCoord(FirstCustomerPed, 851.84, -113.23, 79.45, 249.03, 10.0)
                    elseif FirstCustomerPedSitCoords == vector3(845.4, -116.94, 78.30) then
                        ClearPedTasksImmediately(FirstCustomerPed)
                        SetEntityCoords(FirstCustomerPed, 844.98, -116.84, 78.77)
                        SetEntityHeading(FirstCustomerPed, 333.53)
                        Citizen.Wait(500)
                        TaskPedSlideToCoord(FirstCustomerPed, 849.25, -109.22, 79.57, 314.79, 10.0)
                    end
                    Citizen.Wait(10000)
                    DeleteEntity(FirstCustomerPed)
                    Citizen.Wait(2000)
                    OrdersTaked = false 
                    FirstCustomerPedSitCoords = nil
                    SelectedDrink = "nil"
                    FirstPedSelectedOrder = "thinking"
                    CurrentFirstPedStageText = ""
                    FirstCustomerPedSitHeading = nil
                    ServicesTaked = false
                    FirstPedSelectedOrderPrice = nil
                end
            end
        else
            sleep = 5000
        end
        Citizen.Wait(sleep)
    end
end)

function CreateFirstCustomerPed() 
	RequestModel(FirstCustomerPedHash)
    while not HasModelLoaded(FirstCustomerPedHash) do
	    Citizen.Wait(10)
    end
    FirstCustomerPed = CreatePed(1, FirstCustomerPedHash, FirstCustomerPedCoords.x, FirstCustomerPedCoords.y, FirstCustomerPedCoords.z, FirstCustomerPedCoords.h, false, false)
    SetEntityInvincible(FirstCustomerPed, true)
    SetBlockingOfNonTemporaryEvents(FirstCustomerPed, true)
    TaskPedSlideToCoord(FirstCustomerPed, FirstCustomerPedSlideCoords.x, FirstCustomerPedSlideCoords.y, FirstCustomerPedSlideCoords.z, FirstCustomerPedSlideCoords.h, 10.0)
end

function CreateRandomOrderForFirstPed()
    if FirstPedSelectedOrder == 'thinking' then
        local randomOrder = math.random(1, #Orders)
        selectedOrder = Orders[randomOrder]
        FirstPedSelectedOrder = selectedOrder
    end

    if FirstPedSelectedOrder == 'Appuyez sur ~b~E~s~ pour prendre de la ~b~Bière~s~' then
        FirstPedSelectedOrderPrice = ChiwasRegalPrice
    elseif FirstPedSelectedOrder ==  'Appuyez sur ~b~E~s~ pour prendre du ~b~Gin~s~' then
        FirstPedSelectedOrderPrice = GilbeysCinPrice
    elseif FirstPedSelectedOrder ==  'Appuyez sur ~b~E~s~ pour prendre de la ~b~Vodka~s~' then
        FirstPedSelectedOrderPrice = AbsoluteVodkaPrice
    elseif FirstPedSelectedOrder ==  'Appuyez sur ~b~E~s~ pour prendre du ~b~Calvados~s~' then
        FirstPedSelectedOrderPrice = CalvadosPrice
    elseif FirstPedSelectedOrder ==  'Appuyez sur ~b~E~s~ pour prendre du ~b~Whisky~s~' then   
        FirstPedSelectedOrderPrice = ROMPrice
    end
end

function SeatRandomForFirstPed()
    if FirstCustomerPedSitCoords == nil  then
        
        local randomChair = math.random(1, #Chairs)
        selectedSitCoords = Chairs[randomChair]
        FirstCustomerPedSitCoords = selectedSitCoords
    end
    if FirstCustomerPedSitCoords == vector3(842.88, -110.29, 78.30) then
        FirstCustomerPedSitHeading = 70.32
    elseif FirstCustomerPedSitCoords == vector3(835.17, -104.98, 78.30) then
        FirstCustomerPedSitHeading = 240.23
    elseif FirstCustomerPedSitCoords == vector3(845.4, -116.94, 78.30) then 
        FirstCustomerPedSitHeading = 148.63
    end
end

function PlaceFirstCustomer()
    SetEntityCoords(FirstCustomerPed, FirstCustomerPedSitCoords, false, false, false, false) 
    SetEntityHeading(FirstCustomerPed, FirstCustomerPedSitHeading)
    CustomerAnim()
    FreezeEntityPosition(FirstCustomerPed, true)
end

function CustomerAnim()
    TaskStartScenarioInPlace(FirstCustomerPed, Animations.Sitting3, 0, true) 
end
function CustomerDrinkAnim()
    ClearPedTasksImmediately(FirstCustomerPed)
    TaskStartScenarioInPlace(FirstCustomerPed, Animations.Drinking, 0, true) 
end

function PlayPlayerTrayAnim()
    local player = GetPlayerPed(-1)
    local AnimDict = "anim@heists@humane_labs@finale@keycards"

    RequestAnimDict(AnimDict)
    while not HasAnimDictLoaded(AnimDict) do
        Citizen.Wait(10)
    end

    if DoesEntityExist(Tray) and DoesEntityExist(BeerBottle) then
        DeleteObject(Tray)
        DeleteObject(BeerBottle)
    end

    TaskPlayAnim(player, AnimDict, "ped_a_enter_loop", 5.0, -1, -1, 50, 0, false, false, false)

    Tray = CreateObject(GetHashKey('prop_cs_silver_tray'), 842.88, -110.29, 78.30, true, true, true)
    AttachEntityToEntity(Tray, player, GetPedBoneIndex(player, 4137), 0.0, 0.0, 0.08, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, false)
    BeerBottle = CreateObject(GetHashKey(BeerProp), 842.88, -110.29, 78.30, true, true, true)
    if SelectedDrink == 'Appuyez sur ~b~E~s~ pour prendre du ~b~Gin~s~' then
        AttachEntityToEntity(BeerBottle, player, GetPedBoneIndex(player, 4137), 0.0, 0.0, 0.069, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, false)
    elseif SelectedDrink == 'Appuyez sur ~b~E~s~ pour prendre de la ~b~Bière~s~' or SelectedDrink == 'Appuyez sur ~b~E~s~ pour prendre de la ~b~Vodka~s~' or 
    SelectedDrink == 'Appuyez sur ~b~E~s~ pour prendre du ~b~Calvados~s~' or SelectedDrink == 'Appuyez sur ~b~E~s~ pour prendre du ~b~Whisky~s~' then
        AttachEntityToEntity(BeerBottle, player, GetPedBoneIndex(player, 4137), 0.0, 0.0, 0.205, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, false)
    end
end

local e = {}
e.Ped = 0

function LocalPlayer()
    return e
end

Citizen.CreateThread(function()
    e.ID = PlayerId()
    while true do
        e.Pos = GetEntityCoords(e.Ped)
        Citizen.Wait(0)
    end
end)
Citizen.CreateThread(function()
    while true do
        e.Ped = GetPlayerPed(-1)
        Citizen.Wait(1000)
    end
end)

function DrawText3D(GetEntityCoords, GetEntityHeading, GetEntityHealth, GetPedArmour, IsPedShooting, GetInteriorFromEntity)
    local GetPlayerPed = IsPedShooting or 7
    local IsPedInAnyVehicle, GetNameOfZone, IsPedArmed = table.unpack(GetGameplayCamCoords())
    IsPedShooting = GetDistanceBetweenCoords(IsPedInAnyVehicle, GetNameOfZone, IsPedArmed, GetEntityCoords, GetEntityHeading, GetEntityHealth, 1)
    local IsPedCuffed = GetDistanceBetweenCoords(LocalPlayer().Pos, GetEntityCoords, GetEntityHeading, GetEntityHealth, 1) - 1.65
    local GetVehiclePedIsUsing, GetPedConfigFlag = ((1 / IsPedShooting) * (GetPlayerPed * .7)) * (1 / GetGameplayCamFov()) * 100, 255;
    if IsPedCuffed < GetPlayerPed then
        GetPedConfigFlag = math.floor(255 * ((GetPlayerPed - IsPedCuffed) / GetPlayerPed))
    elseif IsPedCuffed >= GetPlayerPed then
        GetPedConfigFlag = 0
    end
    GetPedConfigFlag = GetInteriorFromEntity or GetPedConfigFlag
    SetTextFont(0)
    SetTextScale(.0 * GetVehiclePedIsUsing, .1 * GetVehiclePedIsUsing)
    SetTextColour(255, 255, 255, math.max(0, math.min(255, GetPedConfigFlag)))
    SetTextCentre(1)
    SetDrawOrigin(GetEntityCoords, GetEntityHeading, GetEntityHealth, 0)
    SetTextEntry("STRING")
    AddTextComponentString(GetPedArmour)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

function DrawJobText3D(GetEntityCoords, GetEntityHeading, GetEntityHealth, GetPedArmour, IsPedShooting, GetInteriorFromEntity)
    local GetPlayerPed = IsPedShooting or 7
    local IsPedInAnyVehicle, GetNameOfZone, IsPedArmed = table.unpack(GetGameplayCamCoords())
    IsPedShooting = GetDistanceBetweenCoords(IsPedInAnyVehicle, GetNameOfZone, IsPedArmed, GetEntityCoords, GetEntityHeading, GetEntityHealth, 1)
    local IsPedCuffed = GetDistanceBetweenCoords(LocalPlayer().Pos, GetEntityCoords, GetEntityHeading, GetEntityHealth, 1) - 1.65
    local GetVehiclePedIsUsing, GetPedConfigFlag = ((1 / IsPedShooting) * (GetPlayerPed * .7)) * (1 / GetGameplayCamFov()) * 100, 255;
    if IsPedCuffed < GetPlayerPed then
        GetPedConfigFlag = math.floor(255 * ((GetPlayerPed - IsPedCuffed) / GetPlayerPed))
    elseif IsPedCuffed >= GetPlayerPed then
        GetPedConfigFlag = 0
    end
    GetPedConfigFlag = GetInteriorFromEntity or GetPedConfigFlag
    SetTextFont(0)
    SetTextScale(.0 * GetVehiclePedIsUsing, .1 * GetVehiclePedIsUsing)
    SetTextColour(255, 255, 255, math.max(0, math.min(255, GetPedConfigFlag)))
    SetTextCentre(1)
    SetDrawOrigin(GetEntityCoords, GetEntityHeading, GetEntityHealth, 0)
    SetTextEntry("STRING")
    AddTextComponentString(GetPedArmour)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end
end) 