
RegisterNetEvent("11_giveIdentityCL")
RegisterNetEvent("11_refreshIdentityCL")
RegisterNetEvent('11_refreshLicensesCL')
RegisterNetEvent('skinchanger:modelLoaded')

function DrawAdvancedText2(text, font, rgba, scale, x, y)
    SetTextFont(font)
    SetTextScale(0.0, scale)
    SetTextColour(rgba[1], rgba[2], rgba[3], rgba[4])
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

local containerX,containerY = .72,.25
local hText,pText = .6,.5
local boxX, boxY = (containerX+.0288), (containerY+.26)

local licenses = {
    ["car"] = {200, 0, false},
    ["motor"] = {200, 0, false},
    ["boat"] = {0, 200, true},
    ["heavycar"] = {200, 0, false},
    ["ppa"] = {200, 0, false},
}
local playerIdentity = {}

AddEventHandler('onResourceStart', function(resourceName)
    TriggerServerEvent('11_refreshIdentity')
    TriggerServerEvent('11_refreshLicenses')
end)
  
  
AddEventHandler('skinchanger:modelLoaded', function()
    TriggerServerEvent('11_refreshIdentity')
    TriggerServerEvent('11_refreshLicenses')
end)

AddEventHandler("11_giveIdentityCL", function(playerIdentity, licenses)
	identity(playerIdentity, licenses)
end)
AddEventHandler("11_refreshIdentityCL", function(data)
	playerIdentity = data
end)
AddEventHandler("11_refreshLicensesCL", function(data)
    local data = json.decode(data[1].licenses)
    for k, v in pairs(data) do 
        checkLicenses(k, v)
    end 
end)

RegisterCommand('refreshidentity', function()
    TriggerServerEvent('11_refreshIdentity')
end)
RegisterCommand('refreshlicenses', function()
    TriggerServerEvent('11_refreshLicenses')
end)
RegisterCommand('identity', function()
    identity(playerIdentity, licenses)
end)
RegisterCommand('showidentity', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent("11_giveIdentity", GetPlayerServerId(closestPlayer), playerIdentity, licenses)
    else
        ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
    end
end) 
 
function checkLicenses(v, bool)
    if bool then 
        licenses[v] = {0, 200, true}
    else
        licenses[v] = {200, 0, false}
    end 
end

function identity(playerIdentity, licenses)
    Citizen.CreateThread( function()
        local currentOpacity, endMovement = 0, 255 
        while endMovement > 10 do 
            Wait(0)
            RequestStreamedTextureDict("personage") 
            SetStreamedTextureDictAsNoLongerNeeded("personage") 
            RequestStreamedTextureDict("commonmenu") 
            SetStreamedTextureDictAsNoLongerNeeded("commonmenu")   
            if currentOpacity < 255 and endMovement > 200 then 
                currentOpacity = currentOpacity + 3
            end
            endMovement = endMovement - .3
            if endMovement < 20 then 
                currentOpacity = currentOpacity - 3
            end 
            DrawRect(containerX+.10, containerY+.40, .35, .30 , 0, 0, 0, currentOpacity-80)
            DrawAdvancedText2("Identité", 4, {255, 255, 255, currentOpacity}, hText, containerX-.05, containerY+.280)
            DrawAdvancedText2("~b~Nom:~s~ "..playerIdentity[1].lastname, 4, {255, 255, 255, currentOpacity}, pText, containerX-.05, containerY+.330)
            DrawAdvancedText2("~b~Prénom:~s~ "..playerIdentity[1].firstname, 4, {255, 255, 255, currentOpacity}, pText, containerX-.05, containerY+.370)
            DrawAdvancedText2("~b~Date de naissance:~s~ "..playerIdentity[1].dateofbirth, 4, {255, 255, 255, currentOpacity}, pText, containerX-.05, containerY+.410)
            DrawAdvancedText2("~b~Taille:~s~ "..playerIdentity[1].height, 4, {255, 255, 255, currentOpacity}, pText, containerX-.05, containerY+.450)
            DrawAdvancedText2("~b~Sexe:~s~ "..playerIdentity[1].sex, 4, {255, 255, 255, currentOpacity}, pText, containerX-.05, containerY+.490)
            DrawAdvancedText2("Permis", 4, {255, 255, 255, currentOpacity}, hText, containerX+.158, containerY+.280)
            DrawRect(boxX+.1, boxY+.12, .02, .035, licenses["car"][1], licenses["car"][2], 0, currentOpacity)
            DrawSprite("personage", "transport_car_icon", boxX+.1, boxY+.12, .02, .034, 0.0, 255, 255, 255, currentOpacity)
            DrawRect(boxX+.135, boxY+.12, .02, .035, licenses["motor"][1], licenses["motor"][2], 0, currentOpacity)
            DrawSprite("personage", "transport_bike_icon", boxX+.135, boxY+.12, .02, .034, 0.0, 255, 255, 255, currentOpacity)
            DrawRect(boxX+.17, boxY+.12, .02, .035, licenses["heavycar"][1], licenses["heavycar"][2], 0, currentOpacity)
            DrawSprite("personage", "vehicle_card_icons_braking", boxX+.17, boxY+.12, .02, .034, 0.0, 255, 255, 255, currentOpacity)
            DrawRect(boxX+.205, boxY+.12, .02, .035, licenses["ppa"][1], licenses["ppa"][2], 0, currentOpacity)
            DrawSprite("personage", "leaderboard_kills_icon", boxX+.205, boxY+.12, .02, .034, 0.0, 255, 255, 255, currentOpacity)
        end 
    end)
end

function DroitMiranda()
    CreateThread( function()
        local currentOpacity, endMovement = 0, 255 
        while endMovement > 10 do 
            Wait(0)
            if currentOpacity < 255 and endMovement > 200 then 
                currentOpacity = currentOpacity + 3
            end
            endMovement = endMovement - .1
            if endMovement < 20 then 
                currentOpacity = currentOpacity - 3
            end 
            DrawRect(0.69, 0.30, 0.43, 0.31, 0, 0, 0, currentOpacity-80)
            CreateText("~b~Droit Miranda", 4, {255, 255, 255, currentOpacity}, 0.7, 0.48, 0.155)
            CreateText("Vous avez le droit de garder le silence. Si vous renoncez à ce droit,", 4, {255, 255, 255, currentOpacity}, pText, 0.48, 0.20)
            CreateText("tout ce que vous direz pourra être et sera utilisé contre vous devant une cour de justice.", 4, {255, 255, 255, currentOpacity}, pText, 0.48, 0.23)
            CreateText("Vous avez le droit à un avocat et d’avoir un avocat présent lors de l’interrogatoire.", 4, {255, 255, 255, currentOpacity}, pText, 0.48, 0.26)
            CreateText("Si vous n’en avez pas les moyens, un avocat vous sera fourni gratuitement.", 4, {255, 255, 255, currentOpacity}, pText, 0.48, 0.29)
            CreateText("Durant chaque interrogatoire, vous pourrez décider à n’importe quel moment d’exercer", 4, {255, 255, 255, currentOpacity}, pText, 0.48, 0.32)
            CreateText("ces droits, de ne répondre à aucune question ou de ne faire aucune déposition.", 4, {255, 255, 255, currentOpacity}, pText, 0.48, 0.35)
            CreateText("Vous avez également le droit à une assistance médicale si nécessaire.", 4, {255, 255, 255, currentOpacity}, pText, 0.48, 0.38)
        end 
    end)
end

RegisterCommand("miranda", function()
    CreateThread(function()
        if PlayerData.job.name == "police" then 
            DroitMiranda()
        end
    end)
end)