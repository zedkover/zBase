ESX = nil
local currentsho, currentactionmenu

function setupScaleform()
    local scaleform = RequestScaleformMovie("instructional_buttons")

    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    N_0xe83a3e3557a56640(GetControlInstructionalButton(2, 51, true))
    ButtonMessage("Tourner votre personnage à droite")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    N_0xe83a3e3557a56640(GetControlInstructionalButton(2, 44, true))
    ButtonMessage("Tourner votre personnage à droite")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end


shoplunettes = {   
	Base = {},
	Data = {currentMenu = "Action"},
    Events = {
		onSelected = function(self, _, zk, PMenu, Data, menuData, currentMenu, currentButton, currentBtn, currentSlt, result, slide)
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) 
			if self.Data.currentMenu == "Action" and zk.name ~= "Sauvegarder la tenue actuelle ...."  and zk.name ~= "Publier/liste des tenue" then 
				ESX.TriggerServerCallback('Checkmoney', function(cb)
					if cb then 
						TriggerEvent('skinchanger:getSkin', function(skin)
							save()
							TriggerServerEvent("zk:insertlunettes", zk.nom3, zk.nom, skin[zk.nom1], skin[zk.nom2], zk.nom1, zk.nom2) 
						end)
					end
				end, zk.price)
			elseif self.Data.currentMenu == "Publier/liste des tenue" and zk.name ~= "Publier de votre tenue actuelle" then 
				ESX.TriggerServerCallback('Checkmoney', function(cb)
					if cb then 
						save()
						TriggerServerEvent("zk:inserttenue", "zedkovertenue", zk.name, zk.skins) 
					end 
				end, zk.price)
			end 
			if zk.name == "Sauvegarder la tenue actuelle ...." then 
				ESX.TriggerServerCallback('Checkmoney', function(cb)
					if cb then 
						savetenue()
					end
				end, zk.price)
			elseif zk.name == "Publier/liste des tenue" then 
				shoplunettes.Menu["Publier/liste des tenue"].b = {} 
				table.insert(shoplunettes.Menu["Publier/liste des tenue"].b, {name = "Publier de votre tenue actuelle"})
				ESX.TriggerServerCallback('zk:getalltenues', function(Vetement)
					for k, v in pairs(Vetement) do  
						if v.type == "zedkoverpublic" then 
							table.insert(shoplunettes.Menu["Publier/liste des tenue"].b, {name = v.nom, price = 45, skins = json.decode(v.clothe)})
						end
					end
					OpenMenu('Publier/liste des tenue')
				end)
			elseif zk.name == "Publier de votre tenue actuelle" then 
				local result = KeyboardInput('Nom', '', 30)
				if result ~= nil then 
					TriggerEvent('skinchanger:getSkin', function(skin)
						TriggerServerEvent("zk:inserttenue", "zedkoverpublic", ""..result.."", skin) 
						ESX.ShowNotification('Vous avez (~b~Publier~s~) votre tenue [~y~'..result..'~s~] ')
					end)
				end
			end 
		end, 
		onOpened = function()
			SetEntityInvincible(GetPlayerPed(-1), true) 
			FreezeEntityPosition(GetPlayerPed(-1), true) 	
		end,    
		onExited = function(self, _, btn, PMenu, Data, menuData, currentMenu, currentButton, currentBtn, currentSlt, result, slide)
			SetEntityInvincible(GetPlayerPed(-1), false) 
			FreezeEntityPosition(GetPlayerPed(-1), false) 	
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		end,
		onButtonSelected = function(currentMenu, currentBtn, menuData, newButtons, self)
            if currentMenu == "Action" then 
                for k,v in pairs(shoplunettes.Menu["Action"].b) do 
                    if currentBtn - 1 == v.iterator then       
                        TriggerEvent('skinchanger:change',  newButtons.nom1, v.iterator)
                    end 
                end
            end
			if currentMenu == "Publier/liste des tenue" then 
				if newButtons.name == "Publier de votre tenue actuelle" then 
					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
						TriggerEvent('skinchanger:loadSkin', skin)
					end)
				else
				for k,v in pairs(shoplunettes.Menu["Publier/liste des tenue"].b) do 
					TriggerEvent('skinchanger:getSkin', function(skin)
						TriggerEvent('skinchanger:loadClothes', skin, { 
								["pants_2"] = newButtons.skins["pants_2"], 
								["pants_1"] = newButtons.skins["pants_1"], 
								["tshirt_2"] = newButtons.skins["tshirt_2"], 
								["tshirt_1"] = newButtons.skins["tshirt_1"], 
								["torso_1"] = newButtons.skins["torso_1"], 
								["torso_2"] = newButtons.skins["torso_2"],
								["shoes_1"] = newButtons.skins["shoes_1"],
								["shoes_2"] = newButtons.skins["shoes_2"]})
						end)
					end
				end
            end
        end,
        onSlide = function(menuData, btn, currentButton, currentSlt, slide, PMenu)
            local currentMenu = menuData.currentMenu
            local slide = btn.slidenum
            if currentMenu == "Action" and btn.name ~= "Sauvegarder la tenue actuelle ...." and btn.name ~= "Publier/liste des tenue" then 
                bags = slide - 1    
                TriggerEvent('skinchanger:change', btn.nom2, bags) 
            end
        end,
	}, 
	Menu = { 
		["Action"] = {
            Arrowsonly = " ",
			b = {}  
		},
		["Publier/liste des tenue"] = {
            Arrowsonly = " ",
			b = {}  
		},
	} 
}   
menuvetement = {   
	Base = {},
	Data = {currentMenu = "Action"},
    Events = {
		onSelected = function(self, _, zk, PMenu, Data, menuData, currentMenu, currentButton, currentBtn, currentSlt, result, slide)
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			if self.Data.currentMenu == "Action vetement" then 
				if zk.slidename == "Utiliser" then 
					TriggerEvent('skinchanger:getSkin', function(skin)
						local caca = json.decode(zk.value)
						local type  = caca[zk.infoData2] 
						local var = caca[zk.infoData3]
						if not on then
							save() 
							on = true
							changerdevetemnt(zk.infoData)
							TriggerEvent('skinchanger:loadClothes', skin, {[zk.infoData2] = type, [zk.infoData3] = var})  
						else
							on = false
							changerdevetemnt(zk.infoData)
							if zk.decals == nil then
								TriggerEvent('skinchanger:loadClothes', skin, {[zk.infoData2] = 0, [zk.infoData3] = 0}) 
							elseif zk.decals == "Torse" then 
								TriggerEvent('skinchanger:loadClothes', skin, {['torso_1'] = 15, ['torso_2'] = 0, ['arms'] = 15}) 	
							elseif zk.decals ~= nil and zk.decals ~= "Torse" then 
								TriggerEvent('skinchanger:loadClothes', skin, {[zk.infoData2] = zk.decals, [zk.infoData3] = 0})  
							end
						end
					end)
				elseif zk.slidename == "Rénommer" then 
					local result = KeyboardInput('Nom', zk.name, 20)
					if result ~= nil then 
						TriggerServerEvent('zk:changenom', zk.id, result)
						changeprinsmenu()
						ESX.ShowNotification('Vous avez changer le nom [~y~'..zk.name..'~s~] en [~b~'..result..'~s~]')
					end 
				elseif zk.slidename == "Effacer" then 
					TriggerServerEvent('zk:deleteitem', zk.id)
					changeprinsmenu()
				elseif zk.slidename == "Donner" then 
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer ~= -1 and closestDistance < 3 then
							TriggerServerEvent('zk:giveitem', zk.id, GetPlayerServerId(closestPlayer))
							changeprinsmenu()
						else
							ESX.ShowNotification('~r~Personne a proximté')
						end
				end
			elseif self.Data.currentMenu == "Action" and zk.ids == 456154 then 
				if zk.slidename == "Utiliser" then 
					TriggerEvent('skinchanger:getSkin', function(skin)
						TriggerEvent('skinchanger:loadClothes', skin, { 
								["pants_2"] = zk.skins["pants_2"], 
								["pants_1"] = zk.skins["pants_1"], 
								["tshirt_2"] = zk.skins["tshirt_2"], 
								["tshirt_1"] = zk.skins["tshirt_1"], 
								["torso_1"] = zk.skins["torso_1"], 
								["torso_2"] = zk.skins["torso_2"],
								["shoes_1"] = zk.skins["shoes_1"],
								["shoes_2"] = zk.skins["shoes_2"]})
						end)
					save()
					elseif zk.slidename == "Rénommer" then 
						local result = KeyboardInput('Nom', zk.name, 20)
						if result ~= nil then 
							TriggerServerEvent('zk:changenom', zk.id, result)
						end 
						changeprinsmenu()
						ESX.ShowNotification('Vous avez changer le nom [~y~'..zk.name..'~s~] en [~b~'..result..'~s~]')
					elseif zk.slidename == "Effacer" then 
						TriggerServerEvent('zk:deleteitem', zk.id)
						changeprinsmenu()
					elseif zk.slidename == "Donner" then 
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer ~= -1 and closestDistance < 3 then
							TriggerServerEvent('zk:giveitem', zk.id, GetPlayerServerId(closestPlayer))
							CloseMenu(true)
						else
							ESX.ShowNotification('~r~Personne a proximté')
						end
				end
			end 
			if zk.askX == true and zk.ids ~= 456154 then 
				menuvetement.Menu["Action vetement"].b = {} 
				ESX.TriggerServerCallback('zk:getzedkovermask', function(Vetement)
					for k, v in pairs(Vetement) do  
						if v.type == zk.infoData then  
							table.insert(menuvetement.Menu["Action vetement"].b, {name = v.nom, slidemax = {"Utiliser", "Donner", "Rénommer", "Effacer"}, id = v.id, menu = 1, value = v.clothe, infoData = zk.infoData, infoData2 = zk.infoData2, infoData3 = zk.infoData3, decals = zk.decals})
						end
					end
					OpenMenu('Action vetement')
				end)
			end 
		end, 
		onSlide = function(menuData, zk, currentButton, currentSlt, slide, PMenu)
            local currentMenu = menuData.currentMenu
            if currentMenu == "Action" and zk.ids ~= 456154 then 
				if zk.slidename ~= nil then  
					currentactionmenu = zk.slidename
					changeprinsmenu()
				end
            end
        end,
	}, 
	Menu = { 
		["Action"] = {
            Arrowsonly = " ",
			b = {} 
		},
		["Action vetement"] = {
            Arrowsonly = " ",
			b = {} 
		}
	} 
}   

function changerdevetemnt(info)
	if info == "zedkoversac" then 
		ESX.Streaming.RequestAnimDict("anim@heists@ornate_bank@grab_cash", function()
			TaskPlayAnim(PlayerPedId(), 'anim@heists@ornate_bank@grab_cash', 'intro', 8.0, -8, 1200, 49, 0, 0, 0, 0)
		end)
		Citizen.Wait(800)
	elseif info == "zedkovermasque" or info == "zedkoverchapeau" then 
		ESX.Streaming.RequestAnimDict("mp_masks@standard_car@ds@", function()
			TaskPlayAnim(PlayerPedId(), "mp_masks@standard_car@ds@", "put_on_mask", 8.0, 1.0, 500, 49, 0, 0, 0, 0 )
		end)
		Citizen.Wait(800)
	elseif info == "zedkoverpantalon" or info == "zedkoverchaussures" then 
		local lib, anim = 'clothingshoes', 'try_shoes_positive_a'
		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8, 1200, 49, 0, 0, 0, 0)
		end)
		Citizen.Wait(1000)
		ClearPedTasks(PlayerPedId())
	elseif info == "zedkoverlunettes" then 
		local lib, anim = 'clothingspecs', 'try_glasses_positive_a'
		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8, 1200, 49, 0, 0, 0, 0)
		end)
		Citizen.Wait(1000)
		ClearPedTasks(PlayerPedId())
	elseif info == "zedkoverCalques" then 
		local lib, anim = 'clothingspecs', 'try_glasses_positive_a'
		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8, 1200, 49, 0, 0, 0, 0)
		end)
		Citizen.Wait(1000)
		ClearPedTasks(PlayerPedId())
	elseif info == "zedkoverchaine" then 
		local lib, anim = 'clothingspecs', 'try_glasses_positive_a'
		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8, 1200, 49, 0, 0, 0, 0)
		end)
		Citizen.Wait(1000)
		ClearPedTasks(PlayerPedId())
	elseif info == "zedkoverchapeau" then 
		local lib, anim = 'missfbi4', 'takeoff_mask'
		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8, 1200, 49, 0, 0, 0, 0)
		end)
		Citizen.Wait(850)
		ClearPedTasks(PlayerPedId())
	end
end

function save()
	TriggerEvent('skinchanger:getSkin', function(skin)
		TriggerServerEvent('esx_skin:save', skin)
	end)
end

function savetenue()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local math = math.random(1, 9200)
		TriggerServerEvent("zk:inserttenue", "zedkovertenue", "Tenue N°"..math.."", skin) 
		ESX.ShowNotification('Vous avez acheter/(~b~engeristrer~s~) votre tenue [~y~'..math..'~s~] ')
	end)
end


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end    
    while true do 
       time = 500
	   posplayer = GetEntityCoords(GetPlayerPed(-1), false)
        for k, v in pairs(Shared.shops) do
            if (GetDistanceBetweenCoords(posplayer, v.pos, true) < 1.2) then
				currentshop = Shared.shops[k].shop
				ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~magasin de "..currentshop.."~w~.")
				if IsControlJustPressed(1,51) then 	
					save()
					shoplunettes.Menu["Action"].b = {} 
					if currentshop ~= "Main" then 
						TriggerEvent('skinchanger:getData', function(components, maxVals)
							for i=0, maxVals[Shared.info[currentshop].nom1], 1 do  
								if Shared.info[currentshop].slidemax == "Texture" then 
									table.insert(shoplunettes.Menu["Action"].b, {name = ""..currentshop.." N°" .. i , price = Shared.price[currentshop] , slidemax = GetNumberOfPedTextureVariations(PlayerPedId(),  Shared.info[currentshop].var, i) - 1, iterator = i, nom = ""..currentshop.." "..i.."", nom1 = Shared.info[currentshop].nom1, nom2 = Shared.info[currentshop].nom2, nom3 = Shared.info[currentshop].nom3 })
								elseif Shared.info[currentshop].slidemax == "Prop" then 
									table.insert(shoplunettes.Menu["Action"].b, {name = ""..currentshop.." N°" .. i , price = Shared.price[currentshop] , slidemax = GetNumberOfPedPropTextureVariations(PlayerPedId(),  Shared.info[currentshop].var, i) - 1, iterator = i, nom = ""..currentshop.." "..i.."", nom1 = Shared.info[currentshop].nom1, nom2 = Shared.info[currentshop].nom2, nom3 = Shared.info[currentshop].nom3 })
								elseif Shared.info[currentshop].slidemax ~= "Prop" or onfig.info[currentshop].slidemax ~= "Texture" then
									table.insert(shoplunettes.Menu["Action"].b, {name = ""..currentshop.." N°" .. i , price = Shared.price[currentshop] , slidemax = Shared.info[currentshop].slidemax, iterator = i, nom = ""..currentshop.." "..i.."", nom1 = Shared.info[currentshop].nom1, nom2 = Shared.info[currentshop].nom2, nom3 = Shared.info[currentshop].nom3 })
								end 
							end 
						end)	
					else
						table.insert(shoplunettes.Menu["Action"].b, {name = "Sauvegarder la tenue actuelle ....", price = 45, askX = true})
						table.insert(shoplunettes.Menu["Action"].b, {name = "Publier/liste des tenue", ask = "→", askX = true})
					end
					CreateMenu(shoplunettes)
				end
            end
			if (GetDistanceBetweenCoords(posplayer, v.pos, true) < 20) then
				time = 1
				if v.color == nil then 
					DrawMarker(25, v.pos, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.5, 0.5, 0.2, 52, 152, 219, 225, false, false, false, false)
				else
					DrawMarker(25, v.pos, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.5, 0.5, 0.2, v.color.r, v.color.g, v.color.b, 225, false, false, false, false) 
				end
			end
        end  
		Wait(time)
    end
end)

local blipsvtm = {
    {title = "Magasins de vêtements", colour = 81, id= 73, x = -1193.16, y = -767.98, z = 16.35},
    {title = "Magasins de vêtements", colour = 81, id= 73, x = -822.42, y = -1073.55, z = 10.35},
    {title = "Magasins de vêtements", colour = 81, id= 73, x = 75.34, y = -1393.00, z = 28.40},
    {title = "Magasins de vêtements", colour = 81, id= 73, x = -709.86, y = -153.1, z = 36.46},
    {title = "Magasins de vêtements", colour = 81, id= 73, x = -163.37, y = -302.73, z = 38.76},
    {title = "Magasins de vêtements", colour = 81, id= 73, x = 425.59, y = -806.15, z = 28.52},
    {title = "Magasins de vêtements", colour = 81, id= 73, x = -1450.42, y = -237.66, z = 48.85},
    {title = "Magasins de vêtements", colour = 81, id= 73, x = 4.87, y = 6512.46, z = 30.91},
    {title = "Magasins de vêtements", colour = 81, id= 73, x = 125.77, y = -223.9, z = 53.60},
    {title = "Magasins de vêtements", colour = 81, id= 73, x = 1693.92, y = 4822.82, z = 41.10},
    {title = "Magasins de vêtements", colour = 81, id= 73, x = 614.19, y = 2762.79, z = 41.12},
    {title = "Magasins de vêtements", colour = 81, id= 73, x = 1196.61, y = 2710.25, z = 37.26},
    {title = "Magasins de vêtements", colour = 81, id= 73, x = -3170.54, y = 1043.68, z = 19.90},
    {title = "Magasins de vêtements", colour = 81, id= 73, x = -1101.48, y = 2710.57, z = 18.16},
	{title = "Magasins de masques", colour = 2, id = 362, x = -1337.69, y = -1277.76, z = 3.90},
	{title = "Magasins de masques", colour = 2, id = 362, x = 1703.76, y = 3778.95, z = 33.80},
	{title = "Magasins de sacs", colour = 1, id = 501, x = 450.42, y = -739.23, z = 26.40},
}

Citizen.CreateThread(function()
    for _, infovtm in pairs(blipsvtm) do
        infovtm.blip = AddBlipForCoord(infovtm.x, infovtm.y, infovtm.z)
        SetBlipSprite(infovtm.blip, infovtm.id)
        SetBlipDisplay(infovtm.blip, 4)
        SetBlipScale(infovtm.blip, 0.745)
        SetBlipColour(infovtm.blip, infovtm.colour)
        SetBlipAsShortRange(infovtm.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(infovtm.title)
        EndTextCommandSetBlipName(infovtm.blip)
    end
end)