ESX = nil

local playergroup = nil
local cinema = false
local hasCinematic = false
local disableShuffle = true
local noclip, godmode, visible, gamerTags = false, false, false, {}
local skuskuMenu = {}
local PlayerData = {}
local refresh = false

crouched, handsup, pointing = false, false, false

Citizen.CreateThread(function()
    while true do
        if cinema then
            DisplayRadar(false)
            DrawRect(1.0, 1.0, 2.0, 0.25, 0, 0, 0, 255)
            DrawRect(1.0, 0.0, 2.0, 0.25, 0, 0, 0, 255)
        end
        Citizen.Wait(0)
    end
end)

RegisterKeyMapping("stream", "Filmer avec Rockstar Editor", "keyboard", "F3")

RegisterCommand("stream", function()
    if IsRecording() then return StopRecordingAndSaveClip() end
    StartRecording(1)
end)


local access = {
    "Masque",
    "Chapeau",
    "Montre",
    "Bracelet",
    "Chaine",
    "Lunette",
    "Boucles d'oreille"
}

local moteur = {
    "Démarrer",
    "Arrêter"
}

local carteid = {
    "Regarder",
    "Montrer"
}

local portes = {
    "Avant Droite",
    "Avant Gauche",
    "Arrière Droite",
    "Arrière Gauche",
    "Coffre",
    "Capot"
}

local fenetres = {
    "Avant Droite",
    "Avant Gauche",
    "Arrière Droite",
    "Arrière Gauche",
    "Fermer toutes les fenêtres"
}

local limitateur = {
    "35",
    "50",
    "80",
    "120",
    "130",
    "Par défault"
}

function ramasserbike()
	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, true)
	local bmxmodel = GetHashKey('bmx')
	local isVehicleBmx = IsVehicleModel(vehicle, bmxmodel)
	local fixtermodel = GetHashKey('fixter')
	local isVehicleFixter = IsVehicleModel(vehicle, fixtermodel)
    local scorchermodel = GetHashKey('scorcher')
	local isVehicleScorcher = IsVehicleModel(vehicle, scorchermodel)
    local tribikemodel = GetHashKey('tribike')
	local isVehicleTribike = IsVehicleModel(vehicle, tribikemodel)
	if isVehicleBmx then
        DeleteVehicle(vehicle)
        TriggerServerEvent('addbmx', "bmx")
        PlaySoundFrontend(-1, 'Bus_Schedule_Pickup', 'DLC_PRISON_BREAK_HEIST_SOUNDS', false)
    elseif isVehicleFixter then
        DeleteVehicle(vehicle)
        TriggerServerEvent('addbmx', "fixter")
        PlaySoundFrontend(-1, 'Bus_Schedule_Pickup', 'DLC_PRISON_BREAK_HEIST_SOUNDS', false)
    elseif isVehicleScorcher then
        DeleteVehicle(vehicle)
        TriggerServerEvent('addbmx', "scorcher")
        
        PlaySoundFrontend(-1, 'Bus_Schedule_Pickup', 'DLC_PRISON_BREAK_HEIST_SOUNDS', false)
    elseif isVehicleTribike then
        DeleteVehicle(vehicle)
        TriggerServerEvent('addbmx', "tribike")
        PlaySoundFrontend(-1, 'Bus_Schedule_Pickup', 'DLC_PRISON_BREAK_HEIST_SOUNDS', false)
    end
end

local validveh = {"Bmx","Fixter","Scorcher","Tribike"}

local MenuF5 = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Title = "Menu personnel", Color = {color_black}, HeaderColor = {80, 230, 80, 220}, world = true},
    Data = { currentMenu = "Voici votre menu personnel", " " },
    Events = {        
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            local slide = btn.slidenum
            local btn = btn.name
            local check = btn.unkCheckbox
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local pPed = GetPlayerPed(-1)
            local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            local PedCar = GetVehiclePedIsIn(pPed, false)
            local carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
            if btn == 'Facture' then
                ExecuteCommand('facture')
            end
            if btn == 'Gestion Véhicule' then
                OpenMenu('Intéraction avec le véhicule')
            end
            if slide == 1 and btn == "Carte d'identité" then
                ExecuteCommand('identity')
            end
            if slide == 2 and btn == "Carte d'identité" then
                ExecuteCommand('showidentity')
            end
            if slide == 1 and btn == 'Moteur' then 
                SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), true, false, true)
                SetVehicleUndriveable(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
            end
            if slide == 2 and btn == 'Moteur' then 
                SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), false, false, true)
                SetVehicleUndriveable(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
            end
            if btn == "Ramasser votre vélo" then 
                ramasserbike()
            end
            if slide == 1 and btn == 'Portes' then 
                avantdroite()
            end
            if slide == 2 and btn == 'Portes' then 
                avantgauche()
            end
            if slide == 3 and btn == 'Portes' then 
                arrieredroite()
            end
            if slide == 4 and btn == 'Portes' then 
                arrieregauche()
            end
            if slide == 5 and btn == 'Portes' then 
               coffre()
            end
            if slide == 6 and btn == 'Portes' then 
                capot()
             end
            if slide == 1 and btn == 'Fenêtres' then 
                TriggerEvent('zedkoverfenetre', 1)
            end

            if slide == 2 and btn == 'Fenêtres' then 
                TriggerEvent('zedkoverfenetre', 2)
            end
            if slide == 3 and btn == 'Fenêtres' then 
                TriggerEvent('zedkoverfenetre', 3)
            end
            if slide == 4 and btn == 'Fenêtres' then 
                TriggerEvent('zedkoverfenetre', 4)
            end
            if slide == 5 and btn == 'Fenêtres' then 
                TriggerEvent('zedkoverfenetre', 5)
            end
            if slide == 1 and btn == 'Limitateur de vitesse' then 
                SetEntityMaxSpeed(GetVehiclePedIsIn(pPed, false), 34.0/2.2369)
            end
            if slide == 2 and btn == 'Limitateur de vitesse' then 
                SetEntityMaxSpeed(GetVehiclePedIsIn(pPed, false), 49.0/2.2369)
            end
            if slide == 3 and btn == 'Limitateur de vitesse' then 
                SetEntityMaxSpeed(GetVehiclePedIsIn(pPed, false), 79.0/2.2369)
            end
            if slide == 4 and btn == 'Limitateur de vitesse' then 
                SetEntityMaxSpeed(GetVehiclePedIsIn(pPed, false), 119.0/2.2369)
            end
            if slide == 5 and btn == 'Limitateur de vitesse' then 
                SetEntityMaxSpeed(GetVehiclePedIsIn(pPed, false), 129.0/2.2369)
            end
            if slide == 6 and btn == 'Limitateur de vitesse' then 
                SetEntityMaxSpeed(GetVehiclePedIsIn(pPed, false), 1000.0/2.2369)
            end
            if btn == 'Divers' then
                OpenMenu('Intéraction divers')
            end
            if btn == 'Personnage' then
                OpenMenu('Menu action civil')
            end
            if btn == 'Tomber par terre' then 
                ExecuteCommand("ragdoll")
                CloseMenu(true)
            end
            if btn == 'Info Zone Laboratoire' then 
                ExecuteCommand("infozone")
            end
            if btn == "Activé la vente de drogue" then
                ExecuteCommand("drogue")
            end
            if btn == 'Afficher le mode cinématique' then 
                openCinematique()
            end
            if btn == 'Informations' then 
                OpenMenu('Informations serveur')
            end
            ExecuteCommand("players")
            if btn == 'Nombre de joueurs connectés' then 
                ESX.ShowNotification('Il y a ~b~'.. TouslesJoueursCO() ..' joueur(s) ~s~de connecté(s) sur le serveur')
            end
            if btn == 'Rockstar Editor' then 
                OpenMenu('Gestion du rockstar editor')
            end
            if btn == 'Sauvegarder' then 
                StopRecordingAndSaveClip()
            end
            if btn == 'Record' then 
                ESX.ShowNotification("Pour ~b~record~s~ avec ~b~Rockstar Editor~s~ appuyez sur votre touche ~b~F3~s~")
            end
            if btn == 'Ouvrir Rockstar Editor' then 
                NetworkSessionLeaveSinglePlayer()
                ActivateRockstarEditor()
            end
        end

    },
    
    Menu = {
        ["Voici votre menu personnel"] = {
            b = {
                {name = "Informations", ask = "→", askX = true},
                {name = "Personnage", ask = "→", askX = true},
                {name = "Facture", ask = "→", askX = true, canSee = function() return not (IsPedInAnyVehicle(GetPlayerPed(-1), false)) end,},
                {name = "Gestion Véhicule", ask = "→", askX = true, canSee = function() return (IsPedInAnyVehicle(GetPlayerPed(-1), false)) end,},
                {name = "Divers", ask = "→", askX = true},
            }
        },
        ["Intéraction avec le véhicule"] = {
            b = {
                {name = "Moteur", slidemax = moteur},
                {name = "Portes", slidemax = portes},
                {name = "Fenêtres", slidemax = fenetres},
                {name = "Limitateur de vitesse", slidemax = limitateur}
            }
        },

        ["Intéraction divers"] = {
            b = {
                {name = "Rockstar Editor", ask = "→", askX = true},
                {name = "Ramasser votre vélo", ask = "→", askX = true}
            }
        },

        ["Menu action civil"] = {
            b = {
                {name = "Carte d'identité", slidemax = carteid},
                {name = "Tomber par terre", ask = "→", askX = true},
                {name = "Info Zone Laboratoire", askX = true},
                {name = "Activé la vente de drogue", checkbox = false}
            }
        },
        ["Informations serveur"] = {
            b = {
                {name = "Nombre de joueurs connectés", ask = "→", askX = true},
                {name = "Connaitre votre ID :", ask = ""..GetPlayerServerId(PlayerId()), askX = true}
            }
        },

        ["Gestion du rockstar editor"] = {
            b = {
                {name = "Record", ask = "→", askX = true},
                {name = "Sauvegarder", ask = "→", askX = true},
                {name = "Ouvrir Rockstar Editor", ask = "→", askX = true}
            }
        },
    }
}

RegisterCommand('id', function(source, args)
	local plyData = ESX.GetPlayerData()
	if plyData and plyData.job and plyData.job.label and plyData.job.grade_label then
        ESX.ShowNotification("Votre Id est le numéro : ~b~" ..GetPlayerServerId(PlayerId()).. "")
	else 
        ESX.ShowNotification("Données introuvables.")
	end
end)

RegisterCommand('job', function(source, args)
	local plyData = ESX.GetPlayerData()
	if plyData and plyData.job and plyData.job.label and plyData.job.grade_label then
        ESX.ShowNotification("Job : ~b~"..plyData.job.label.."~s~\nGrade : ~b~"..plyData.job.grade_label.."")
	else 
        ESX.ShowNotification("Données introuvables.")
	end
end)

function openCinematique()
    hasCinematic = not hasCinematic
    if not hasCinematic then
        cinema = false
        TriggerServerEvent("getgps")
    elseif hasCinematic then
        cinema = true
    end
end

function avantdroite()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) then
       if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then 
          SetVehicleDoorShut(playerVeh, 1, false)
        else
          SetVehicleDoorOpen(playerVeh, 1, false)
          frontleft = true        
       end
    end
end

function avantgauche()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) then
       if GetVehicleDoorAngleRatio(playerVeh, 0) > 0.0 then 
          SetVehicleDoorShut(playerVeh, 0, false)
        else
          SetVehicleDoorOpen(playerVeh, 0, false)
          frontleft = true        
       end
    end
end

function arrieredroite()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) then
       if GetVehicleDoorAngleRatio(playerVeh, 3) > 0.0 then 
          SetVehicleDoorShut(playerVeh, 3, false)
        else
          SetVehicleDoorOpen(playerVeh, 3, false)
          frontleft = true        
       end
    end
end

function arrieregauche()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) then
       if GetVehicleDoorAngleRatio(playerVeh, 2) > 0.0 then 
          SetVehicleDoorShut(playerVeh, 2, false)
        else
          SetVehicleDoorOpen(playerVeh, 2, false)
          frontleft = true        
       end
    end
end

function coffre()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) then
       if GetVehicleDoorAngleRatio(playerVeh, 5) > 0.0 then 
          SetVehicleDoorShut(playerVeh, 5, false)
        else
          SetVehicleDoorOpen(playerVeh, 5, false)
          frontleft = true        
       end
    end
end

function capot()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) then
       if GetVehicleDoorAngleRatio(playerVeh, 4) > 0.0 then 
          SetVehicleDoorShut(playerVeh, 4, false)
        else
          SetVehicleDoorOpen(playerVeh, 4, false)
          frontleft = true        
       end
    end
end

AddEventHandler('zedkoverfenetre', function(data)
    local player = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(player, false) 
    if (IsPedSittingInAnyVehicle(player)) then
        if data == 1 then
            RollDownWindow(vehicle, 1)
        elseif data == 2 then
            RollDownWindow(vehicle, 0)
        elseif data == 3 then
            RollDownWindow(vehicle, 3)
        elseif data == 4 then
            RollDownWindow(vehicle, 2)
        elseif data == 5 then
            RollUpWindow(vehicle, 0)
            RollUpWindow(vehicle, 1)
            RollUpWindow(vehicle, 2)
            RollUpWindow(vehicle, 3)
        end
    else
    end
end)

function TouslesJoueursCO()
    local joueurs = 0
    for _, i in ipairs(GetActivePlayers()) do
        joueurs = joueurs + 1
    end
    return joueurs
end

function getCamDirection()
    local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(plyPed)
    local pitch = GetGameplayCamRelativePitch()
    local coords = vector3(-math.sin(heading * math.pi / 180.0), math.cos(heading * math.pi / 180.0), math.sin(pitch * math.pi / 180.0))
    local len = math.sqrt((coords.x * coords.x) + (coords.y * coords.y) + (coords.z * coords.z))

    if len ~= 0 then
        coords = coords / len
    end

    return coords
end

RegisterKeyMapping('openmenuf5', 'Menu Personnel', 'keyboard', 'F5')

RegisterCommand('openmenuf5', function()
    CreateMenu(MenuF5)
end)
