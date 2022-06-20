-- VARIABLES

local open = false
local disablecontrol = false
local threadCreated = false
local controlDisabled = {1, 2, 3, 4, 5, 6, 18, 24, 25, 37, 69, 70, 111, 117, 118, 182, 199, 200, 257}
local tenue,chaussures,masque,torse,pantalon,tshirt,lunettes,modifitems,chapeau,sac,chaine,calque = {},{},{},{},{},{},{},{},{},{},{},{}

local fastWeapons = {
	[1] = nil,
	[2] = nil,
	[3] = nil
}

Inv = {}
KEEP_FOCUS = false
isInInventory = false
ESX = nil
currentMenu = 'item'

-- FUNCTION 

function SetKeepInputMode(bool)
    if SetNuiFocusKeepInput then
        SetNuiFocusKeepInput(bool)
    end

    KEEP_FOCUS = bool

    if not threadCreated and bool then
        threadCreated = true

        Citizen.CreateThread(function()
            while KEEP_FOCUS do
                Wait(0)

                for _,v in pairs(controlDisabled) do
                    DisableControlAction(0, v, true)
                end
            end

            threadCreated = false
        end)
    end
end

function Inv:LoadPlayerInventory(result)

    if result == 'item' then 
        ESX.TriggerServerCallback("esx_inventoryhud:getPlayerInventory", function(data)
            items = {}
            fastItems = {}
			inventory = data.inventory
			accounts = data.accounts
			money = data.money
			weapons = data.weapons
			weight = data.weight
            maxWeight = data.maxWeight

            SendNUIMessage(
                {
                    action = "setItems",
                    text = "<div id=\"weightValue\"><p>" ..weight.. " / " ..maxWeight.. "KG</p></span>"
                }
            )
            
			if Shared.IncludeCash and money ~= nil and money > 0 then
				moneyData = {
					label = "Argent",
					name = "cash",
					type = "item_money",
					count = money,
					usable = false,
					rare = false,
					weight = 0,
					canRemove = true
				}
				table.insert(items, moneyData)
			end

            if Shared.IncludeAccounts and accounts ~= nil then
                for key, value in pairs(accounts) do
                    if not Inv:ShouldSkipAccount(accounts[key].name) then
                        local canDrop = accounts[key].name ~= "bank"

                        if accounts[key].money > 0 then
                            accountData = {
                                label = "Argent non déclaré",
                                count = accounts[key].money,
                                type = "item_account",
                                name = accounts[key].name,
                                usable = false,
                                rare = false,
                                weight = 0,
                                canRemove = canDrop
                            }
                            table.insert(items, accountData)
                        end
                    end
                end
            end

            if inventory ~= nil then
                for key, value in pairs(inventory) do
                    if inventory[key].count <= 0 then
                        inventory[key] = nil
                    else
                        local infast = false
                        if json.encode(fastWeapons) ~= "[]" then
                            for fast, bind in pairs(fastWeapons) do
                                if inventory[key].name == bind then
                                    table.insert(fastItems, {
                                        label = inventory[key].label,
                                        count = inventory[key].count,
                                        limit = -1,
                                        type = inventory[key].type,
                                        name = inventory[key].name,
                                        usable = true,
                                        rare = false,
                                        canRemove = true,
                                        slot = fast
                                    })
                                    infast = true
                                end
                            end
                        end
                        if not infast then
                        inventory[key].type = "item_standard"
                        table.insert(items, inventory[key])
                        end
                    end
                end
            end

         
        SendNUIMessage({ action = "setItems", itemList = items, fastItems = fastItems, text = texts, crMenu = currentMenu})
        end, GetPlayerServerId(PlayerId()))

    elseif result == 'clothe' then 
        items = {}

        ESX.TriggerServerCallback('zk:getzedkovermask', function(Vetement)
            tenue, chaussures, masque, pantalon, torse, tshirt, lunettes, chapeau, sac,chaine,calque = {}, {}, {}, {}, {}, {}, {}, {}, {},{},{}
            for k, v in pairs(Vetement) do  
                if v.type == "zedkovertenue" then 
                    table.insert(tenue, {name = v.nom, skins = json.decode(v.clothe), id = v.id})
                end
                if v.type == "zedkoverchaussures" then 
                    table.insert(chaussures, {name = v.nom, skins = json.decode(v.clothe), id = v.id, data = "shoes_1", data2 = "shoes_2", decals = 34})
                end 
                if v.type == "zedkovermasque" then 
                    table.insert(masque, {name = v.nom, skins = json.decode(v.clothe), id = v.id, data = "mask_1", data2 = "mask_2"})
                end 
                if v.type == "zedkoverpantalon" then 
                    table.insert(pantalon, {name = v.nom, skins = json.decode(v.clothe), id = v.id, data = "pants_1", data2 = "pants_2", decals = 14})
                end 
                if v.type == "zedkovertshirt" then 
                    table.insert(tshirt, {name = v.nom, skins = json.decode(v.clothe), id = v.id, data = "tshirt_1", data2 = "tshirt_2"})
                end 
                if v.type == "zedkovergant" then 
                    table.insert(lunettes, {name = v.nom, skins = json.decode(v.clothe), id = v.id, data = "arms", data2 = "arms_2"})
                end 
                if v.type == "zedkoverlunettes" then 
                    table.insert(lunettes, {name = v.nom, skins = json.decode(v.clothe), id = v.id, data = "glasses_1", data2 = "glasses_2"})
                end 
                if v.type == "zedkoverchapeau" then 
                    table.insert(chapeau, {name = v.nom, skins = json.decode(v.clothe), id = v.id, data = "helmet_1", data2 = "helmet_2"})
                end 
                if v.type == "zedkoversac" then 
                    table.insert(sac, {name = v.nom, skins = json.decode(v.clothe), id = v.id, data = "bags_1", data2 = "bags_1"})
                end 
                if v.type == "zedkoverchaine" then 
                    table.insert(chaine, {name = v.nom, skins = json.decode(v.clothe), id = v.id, data = "chain_1", data2 = "chain_2"})
                end 
                if v.type == "zedkoverCalques" then 
                    table.insert(calque, {name = v.nom, skins = json.decode(v.clothe), id = v.id, data = "decals_1", data2 = "decals_2"})
                end 
                if v.type == "zedkovertorse" then 
                    table.insert(torse, {name = v.nom, skins = json.decode(v.clothe), id = v.id, data = "torso_1", data2 = "torso_2"})
                end 
            end 
    

        Wait(50)

            for k, v in pairs(tenue) do
                tenueData = {
                    label = v.name,
                    name = "tenue",
                    type = "item_tenue",
                    skins = v.skins,
                    count = "",
                    usable = true,
                    rename = true,
                    rare = false,
                    information = true, 
                    id = v.id, 
                    weight = -1,
                    canRemove = true
                }
                table.insert(items, tenueData)
            end

            for k, v in pairs(chaussures) do
                chaussuresData = {
                    label = v.name,
                    name = "shoes",
                    type = "item_chaussures",
                    skins = v.skins,
                    info = v.data,
                    info2 = v.data2,
                    count = "",
                    usable = true,
                    information = true, 
                    id = v.id, 
                    decals = v.decals,
                    rename = true,
                    rare = false,
                    weight = -1,
                    canRemove = true
                }
                table.insert(items, chaussuresData)
            end

            for k, v in pairs(masque) do
                masqueData = {
                    label = v.name,
                    name = "mask",
                    type = "item_chaussures",
                    skins = v.skins,
                    info = v.data,
                    info2 = v.data2,
                    id = v.id, 
                    count = "",
                    information = true, 
                    usable = true,
                    rename = true,
                    rare = false,
                    weight = -1,
                    canRemove = true
                }
                table.insert(items, masqueData)
            end

            for k, v in pairs(pantalon) do
                pantalonData = {
                    label = v.name,
                    name = "jean",
                    type = "item_chaussures",
                    skins = v.skins,
                    info = v.data,
                    info2 = v.data2,
                    decals = v.decals,
                    id = v.id, 
                    count = "",
                    information = true, 
                    usable = true,
                    rename = true,
                    rare = false,
                    weight = -1,
                    canRemove = true
                }
                table.insert(items, pantalonData)
            end

            for k, v in pairs(tshirt) do
                tshirtData = {
                    label = v.name,
                    name = "shirt",
                    type = "item_chaussures",
                    skins = v.skins,
                    info = v.data,
                    info2 = v.data2,
                    id = v.id, 
                    count = "",
                    information = true, 
                    usable = true,
                    rename = true,
                    rare = false,
                    weight = -1,
                    canRemove = true
                }
                table.insert(items, tshirtData)
            end

            for k, v in pairs(torse) do
                torseData = {
                    label = v.name,
                    name = "shirt",
                    type = "item_torse",
                    skins = v.skins,
                    info = v.data,
                    info2 = v.data2,
                    id = v.id, 
                    count = "",
                    information = true, 
                    usable = true,
                    rename = true,
                    rare = false,
                    weight = -1,
                    canRemove = true
                }
                table.insert(items, torseData)
            end

            for k, v in pairs(lunettes) do
                lunettesData = {
                    label = v.name,
                    name = "tie",
                    type = "item_chaussures",
                    skins = v.skins,
                    info = v.data,
                    info2 = v.data2,
                    id = v.id, 
                    count = "",
                    usable = true,
                    information = true, 
                    rename = true,
                    rare = false,
                    weight = -1,
                    canRemove = true
                }
                table.insert(items, lunettesData)
            end

            for k, v in pairs(chapeau) do
                chapeauData = {
                    label = v.name,
                    name = "hat",
                    type = "item_chapeau",
                    skins = v.skins,
                    info = v.data,
                    info2 = v.data2,
                    id = v.id, 
                    decals = 11,
                    count = "",
                    usable = true,
                    information = true, 
                    rename = true,
                    rare = false,
                    weight = -1,
                    canRemove = true
                }
                table.insert(items, chapeauData)
            end
            
            for k, v in pairs(sac) do
                sacData = {
                    label = v.name,
                    name = "bag",
                    type = "item_sac",
                    skins = v.skins,
                    info = v.data,
                    info2 = v.data2,
                    id = v.id, 
                    count = "",
                    usable = true,
                    information = true, 
                    rename = true,
                    rare = false,
                    weight = -1,
                    canRemove = true
                }
                table.insert(items, sacData)
            end
    
                
            for k, v in pairs(chaine) do
                chaineData = {
                    label = v.name,
                    name = "tie",
                    type = "item_chaine",
                    skins = v.skins,
                    info = v.data,
                    info2 = v.data2,
                    id = v.id, 
                    count = "",
                    usable = true,
                    information = true, 
                    rename = true,
                    rare = false,
                    weight = -1,
                    canRemove = true
                }
                table.insert(items, chaineData)
            end
    
            for k, v in pairs(calque) do
                calqueData = {
                    label = v.name,
                    name = "tie",
                    type = "item_calque",
                    skins = v.skins,
                    info = v.data,
                    info2 = v.data2,
                    id = v.id, 
                    count = "",
                    usable = true,
                    information = true, 
                    rename = true,
                    rare = false,
                    weight = -1,
                    canRemove = true
                }
                table.insert(items, calqueData)
            end

        SendNUIMessage({ action = "setItems", itemList = items, fastItems = fastItems, text = texts, crMenu = currentMenu})
        Wait(250)
    end)
    end
end


function Inv:ShouldCloseInventory(itemName)
    for index, value in ipairs(Shared.CloseUiItems) do
        if value == itemName then
            return true
        end
    end

    return false
end

function Inv:ShouldSkipAccount(accountName)
    for index, value in ipairs(Shared.ExcludeAccountsList) do
        if value == accountName then
            return true
        end
    end

    return false
end

function Inv:SaveSkin()
	TriggerEvent('skinchanger:getSkin', function(skin)
		TriggerServerEvent('esx_skin:save', skin)
	end)
end

function Inv:ActiveHud()
    SendNUIMessage({showUi = true})

    if IsPedSwimmingUnderWater(PlayerPedId()) then
        isUnderwater = true
        SendNUIMessage({showOxygen = true})
    elseif not IsPedSwimmingUnderWater(PlayerPedId()) then
        isUnderwater = false
        SendNUIMessage({showOxygen = false})
    end

    TriggerEvent('esx_status:getStatus', 'hunger',function(status) hunger = status.val / 10000 end)
    TriggerEvent('esx_status:getStatus', 'thirst', function(status) thirst = status.val / 10000 end)
    TriggerEvent('esx_status:getStatus', 'stress',function(status) stress = status.val / 10000 end)

    SendNUIMessage({
        action = "update_hud",
        hp = GetEntityHealth(PlayerPedId()) - 100,
        armor = GetPedArmour(PlayerPedId()),
        hunger = hunger,
        thirst = thirst,
        stress = stress,
        oxygen = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10
    })
end

function Inv:OpenInventory()
    Inv:LoadPlayerInventory(currentMenu)
    Inv:ActiveHud()
    isInInventory = true
    open = true
    SendNUIMessage({action = "display", type = "normal"})
    SetNuiFocus(true, true)
    SetKeepInputMode(true)
    disablecontrol = true
    TriggerScreenblurFadeIn(0)
    DisplayRadar(false)
end

function Inv:CloseInventory()
    isInInventory = false
    open = false
    SendNUIMessage({action = "hide"})
    SetNuiFocus(false, false)
    SetKeepInputMode(false)
    disablecontrol = false
    SendNUIMessage({showUi = false})
    TriggerScreenblurFadeOut(0)
    DisplayRadar(true)
end
-- THREAD

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        Citizen.Wait(750)
        HideHudComponentThisFrame(19)
        HideHudComponentThisFrame(20)
        BlockWeaponWheelThisFrame()
        SetPedCanSwitchWeapon(PlayerPedId(), false)

        if not isInInventory then 
            SendNUIMessage({showUi = false})
        end 
    end
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj)
            ESX = obj
        end)
    Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
	while true do
		if disablecontrol then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 69, true) -- Attack
			DisableControlAction(0, 70, true) -- Attack
			DisableControlAction(0, 92, true) -- Attack
			DisableControlAction(0, 114, true) -- Attack
			DisableControlAction(0, 121, true) -- Attack
            DisableControlAction(0, 140, true) -- Attack
            DisableControlAction(0, 141, true) -- Attack
            DisableControlAction(0, 142, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack
            DisableControlAction(0, 263, true) -- Attack
            DisableControlAction(0, 264, true) -- Attack
            DisableControlAction(0, 331, true) -- Attack

            DisableControlAction(0, 157, true) -- Weapon 1
            DisableControlAction(0, 158, true) -- Weapon 2
            DisableControlAction(0, 160, true) -- Weapon 3
		end
		Wait(0)
	end
end)

-- COMMAND

RegisterCommand('invbug', function()
    if invbug then 
        SetNuiFocus(false, false)
        SetKeepInputMode(false)
    else
        SetNuiFocus(true, true)
        SetKeepInputMode(true)
    end
    invbug = not invbug
end)

RegisterCommand("nohud",function()  
    SendNUIMessage({showUi = false})
end)

RegisterKeyMapping('openinv', 'Ouverture inventaire', 'keyboard', 'TAB')

RegisterKeyMapping('keybind1', 'Slot d\'arme 1', 'keyboard', '1')
RegisterKeyMapping('keybind2', 'Slot d\'arme 2', 'keyboard', '2')
RegisterKeyMapping('keybind3', 'Slot d\'arme 3', 'keyboard', '3')


RegisterCommand('openinv', function()
    if not isInInventory then
		DisplayRadar(false)
        Inv:OpenInventory()
    elseif isInInventory then 
        Inv:CloseInventory()
    end
end)

RegisterCommand('keybind1', function()
    if fastWeapons[1] ~= nil then
        if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey(fastWeapons[1]) then
            SetCurrentPedWeapon(GetPlayerPed(-1), "WEAPON_UNARMED",true)
        else
            SetCurrentPedWeapon(GetPlayerPed(-1), fastWeapons[1],true)
            ESX.ShowNotification('Vous avez équipé votre ~b~'..ESX.GetWeaponLabel(fastWeapons[1])..'')
        end
    end
end)

RegisterCommand('keybind2', function()
    if fastWeapons[2] ~= nil then
        if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey(fastWeapons[2]) then
            SetCurrentPedWeapon(GetPlayerPed(-1), "WEAPON_UNARMED",true)
        else
            SetCurrentPedWeapon(GetPlayerPed(-1), fastWeapons[2],true)
            ESX.ShowNotification('Vous avez équipé votre ~b~'..ESX.GetWeaponLabel(fastWeapons[2])..'')
        end
    end
end)

RegisterCommand('keybind3', function()
    if fastWeapons[3] ~= nil then
        if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey(fastWeapons[3]) then
            SetCurrentPedWeapon(GetPlayerPed(-1), "WEAPON_UNARMED",true)
        else
            SetCurrentPedWeapon(GetPlayerPed(-1), fastWeapons[3],true)
            ESX.ShowNotification('Vous avez équipé votre ~b~'..ESX.GetWeaponLabel(fastWeapons[3])..'')
        end
    end
end)
-- NUICALLBAKC

RegisterNUICallback('escape', function(data, cb)
    Inv:CloseInventory()
    SetKeepInputMode(false)
end)

RegisterNUICallback("NUIFocusOff",function()
    Inv:CloseInventory()
    SetKeepInputMode(false)
end)

RegisterNUICallback("GetNearPlayers", function(data, cb)
    local targetT = GetNearbyPlayer(false, true)

    if not targetT then return end

    if targetT then

        Inv:CloseInventory()
        
        local count = tonumber(data.number)

        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            ESX.Streaming.RequestAnimDict("mp_common", function()
                TaskPlayAnim(PlayerPedId(), "mp_common", "givetake2_a", 2.0, -2.0, 2500, 49, 0, false, false, false)
            end)
            GiveWeaponToPed(GetPlayerPed(-1), "weapon_unarmed", 1, false, true)
        end

        if data.item.type == "item_standard" then
            ESX.Streaming.RequestAnimDict("mp_common", function()
                TaskPlayAnim(PlayerPedId(), "mp_common", "givetake2_a", 2.0, -2.0, 2500, 49, 0, false, false, false)
            end)
            GiveWeaponToPed(GetPlayerPed(-1), "weapon_unarmed", 1, false, true)
        end

        if data.item.type == "item_money" then 
            GiveWeaponToPed(GetPlayerPed(-1), "weapon_unarmed", 1, false, true)
            ESX.Streaming.RequestAnimDict("mp_common", function()
                TaskPlayAnim(PlayerPedId(), "mp_common", "givetake2_a", 2.0, -2.0, 2500, 49, 0, false, false, false)
            end)
            TriggerServerEvent("esx_inventoryhud:tradePlayerItem", GetPlayerServerId(PlayerId()), GetPlayerServerId(targetT), data.item.type, data.item.name, count)
        end

        if data.item.type == "item_tenue" or data.item.type == "item_torse" or data.item.type == "item_chaussures" or data.item.type == "item_lunettes" or data.item.type == "item_tshirt" or data.item.type == "item_calque" or data.item.type == "item_chaine" or data.item.type == "item_masque" or data.item.type == "item_pantalon" or data.item.type == "item_chapeau" or data.item.type == "item_sac" or data.item.type == "item_gant" or data.item.type == "item_montre" or data.item.type == "item_bracelet" or data.item.type == "item_oreille" then
            TriggerServerEvent(Shared.prefix.."giveitem", data.item.id, GetPlayerServerId(targetT))
            ESX.Streaming.RequestAnimDict("mp_common", function()
                TaskPlayAnim(PlayerPedId(), "mp_common", "givetake2_a", 2.0, -2.0, 2500, 49, 0, false, false, false)
            end)
            Wait(250)
            Inv:LoadPlayerInventory(currentMenu)
            ESX.ShowNotification('Vous venez de donner votre ~b~'..data.item.label)
        else
            TriggerServerEvent("esx:giveInventoryItem", GetPlayerServerId(targetT), data.item.type, data.item.name, count)
            ESX.Streaming.RequestAnimDict("mp_common", function()
                TaskPlayAnim(PlayerPedId(), "mp_common", "givetake2_a", 2.0, -2.0, 2500, 49, 0, false, false, false)
            end)
            Wait(250)
            Inv:LoadPlayerInventory(currentMenu)
        end
    end

    cb("ok")
end)

RegisterNUICallback("dsqds", function(data, cb)
    if currentMenu ~= data.type then 
        currentMenu = data.type
        Inv:LoadPlayerInventory(data.type)
    end
end)

RegisterNUICallback("RenameItem", function(data, cb)
    if data.item.type ~= "item_weapon" then
        if data.item.type ~= "item_money" then
            if data.item.type ~= "item_standard" then
        
            Inv:CloseInventory()
            local result = KeyboardInput('', data.item.label, 30)
            if result ~= nil then 
                if data.item.type ~= "item_standard" then 
                    TriggerServerEvent('zk:changenom', data.item.id, result)
                elseif data.item.type == "item_standard" then 
                    TriggerServerEvent('zk:changenom', data.item.name, result)
                end
                ESX.ShowNotification('Vous avez ~b~changé~s~ le nom de votre vêtement ~b~'..data.item.label..'~s~ en ~b~'..result..'~s~')
            end
        end 
    end
    else
        Inv:CloseInventory()
        local result = KeyboardInput(data.item.label,"", 30)
        if result ~= nil then 
            for k, v in pairs(ESX.GetPlayerData().loadout) do 
                if data.item.name == v.name then
                    print(v.name)
                end 
            end 
        end 
    end
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
	AddTextEntry("FMMC_KEY_TIP1", TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

RegisterNUICallback("UseItem", function(data, cb)
  
    if data.item.type == "item_standard" then 
        TriggerServerEvent("esx:useItem", data.item.name)
    elseif data.item.type == "item_tenue" then 
        TriggerEvent('skinchanger:getSkin', function(skin)
            if tenue then 
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
                            tshirt_1 = 34,
                            tshirt_2 = 0,
                            arms     = 15,
                            torso_1  = 101,
                            torso_2  = 1,
                            pants_1  = 16,
                            pants_2  = 0
                        })
                    end
                end)
            else
                TriggerEvent('skinchanger:loadClothes', skin, { 
                    ["pants_1"] = data.item.skins["pants_1"], 
                    ["tshirt_2"] = data.item.skins["tshirt_2"], 
                    ["tshirt_1"] = data.item.skins["tshirt_1"], 
                    ["torso_1"] = data.item.skins["torso_1"], 
                    ["torso_2"] = data.item.skins["torso_2"],
                    ["arms"] = data.item.skins["arms"],
                    ["arms_2"] = data.item.skins["arms_2"],
                    ["decals_1"] = data.item.skins["decals_1"],
                    ["decals_2"] = data.item.skins["decals_2"],
                    ["shoes_1"] = data.item.skins["shoes_1"],
                    ["shoes_2"] = data.item.skins["shoes_2"]})
            end
            tenue = not tenue
            save()
            end)
        elseif data.item.type == "item_chaussures" or data.item.type == "item_torse" or data.item.type == "item_calque" or data.item.type == "item_chaine" or data.item.type == "item_masque" or data.item.type == "item_pantalon" or data.item.type == "item_chapeau" or data.item.type == "item_sac" then 
            local info = data.item.skins
            local type  = info[data.item.info] 
            local var = info[data.item.info2] 
            TriggerEvent('skinchanger:getSkin', function(skin)
                if used then 
                    if data.item.decals ~= nil then 
                        TriggerEvent('skinchanger:loadClothes', skin, {[data.item.info] = data.item.decals, [data.item.info2] = 0})
                    else
                        TriggerEvent('skinchanger:loadClothes', skin, {[data.item.info] = 0, [data.item.info2] = 0})
                    end
                else
                    ESX.ShowNotification("Vous venez d'equipé le ~b~"..data.item.label)
                    TriggerEvent('skinchanger:loadClothes', skin, {[data.item.info] = type, [data.item.info2] = var})
                end  
                save()
                used = not used
            end)
    end 
    if Inv:ShouldCloseInventory(data.item.name) then
        Inv:CloseInventory()
    else
        Citizen.Wait(250)
        if data.item.type == "item_chaussures" or data.item.type == "item_torse" or data.item.type == "item_calque" or data.item.type == "item_chaine" or data.item.type == "item_masque" or data.item.type == "item_pantalon" or data.item.type == "item_chapeau" or data.item.type == "item_sac" then 
            Inv:LoadPlayerInventory(currentMenu)
        end
    end
    cb("ok")
end)

RegisterNUICallback("DropItem", function(data, cb)
        local playerPed = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(playerPed) then
        return
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
		if data.item.type == "item_money" then
			TriggerServerEvent("esx:removeInventoryItem", "item_account", "money", data.number, GetEntityCoords(playerPed))
            TaskPlayAnim(GetPlayerPed(-1), "random@domestic", "pickup_low" , 8.0, -8.0, 1780, 35, 0.0, false, false, false)
            GiveWeaponToPed(GetPlayerPed(-1), "weapon_unarmed", 1, false, true)
		else
			TriggerServerEvent("esx:removeInventoryItem", data.item.type, data.item.name, data.number, GetEntityCoords(playerPed))
			TaskPlayAnim(GetPlayerPed(-1), "random@domestic", "pickup_low" , 8.0, -8.0, 1780, 35, 0.0, false, false, false)
            GiveWeaponToPed(GetPlayerPed(-1), "weapon_unarmed", 1, false, true)
        end
        
    end

    if currentMenu ~= 'clothe' then 
        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("esx:removeInventoryItem", data.item.type, data.item.name, data.number)
        end
    else
        TriggerServerEvent('zk:deleteitem', data.item.id) 
    end

    Wait(250)
    Inv:LoadPlayerInventory(currentMenu)

    cb("ok")
end)

RegisterNUICallback("PutIntoFast", function(data, cb)
	if data.item.slot ~= nil then
		fastWeapons[data.item.slot] = nil
	end
	fastWeapons[data.slot] = data.item.name
	TriggerServerEvent("esx_inventoryhud:changeFastItem",data.slot,data.item.name)
	Inv:LoadPlayerInventory(currentMenu)
	cb("ok")
end)

RegisterNUICallback("TakeFromFast", function(data, cb)
	fastWeapons[data.item.slot] = nil
	TriggerServerEvent("esx_inventoryhud:changeFastItem",0,data.item.name)
	Inv:LoadPlayerInventory(currentMenu)
	cb("ok")
end)
