ESX = nil;
local sex = 0

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(a) ESX = a end)
        Citizen.Wait(0)
    end
end)

local controldisable = false

Citizen.CreateThread(function()
	while true do
         if controldisable then
   			DisableControlAction(0, 1,   true) -- LookLeftRight
   			DisableControlAction(0, 2,   true) -- LookUpDown
   			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
   			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
   			DisableControlAction(0, 30,  true) -- MoveLeftRight
   			DisableControlAction(0, 31,  true) -- MoveUpDown
   			DisableControlAction(0, 21,  true) -- disable sprint
   			DisableControlAction(0, 24,  true) -- disable attack
   			DisableControlAction(0, 25,  true) -- disable aim
   			DisableControlAction(0, 47,  true) -- disable weapon
   			DisableControlAction(0, 58,  true) -- disable weapon
   			DisableControlAction(0, 263, true) -- disable melee
   			DisableControlAction(0, 264, true) -- disable melee
   			DisableControlAction(0, 257, true) -- disable melee
   			DisableControlAction(0, 140, true) -- disable melee
   			DisableControlAction(0, 141, true) -- disable melee
   			DisableControlAction(0, 143, true) -- disable melee
 			DisableControlAction(0, 75,  true) -- disable exit vehicle
 			DisableControlAction(27, 75, true) -- disable exit vehicle
            DisableControlAction(0, 69, true)
            DisableControlAction(0, 92, true)
            DisableControlAction(0, 114, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 288, true)
            DisableControlAction(0, 289, true)
            DisableControlAction(0, 170, true)
            DisableControlAction(0, 166, true)
            DisableControlAction(0, 167, true)
            DisableControlAction(0, 168, true)
            DisableControlAction(0, 57, true)
            DisableControlAction(0, 37, true)
            DisableControlAction(0, 0, true)
            DisableControlAction(0, 26, true)
            DisableControlAction(0, 57, true)
 		end
 		Citizen.Wait(10)
 	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if onCreatorTick.FaceTurnEnabled then
            local ToucheGauche, ToucheDroite = IsDisabledControlPressed(1, 44), IsDisabledControlPressed(1, 51)

			DrawScaleformMovieFullscreen(setupScaleform(), 255, 255, 255, 255, 0)
			if ToucheGauche or ToucheDroite then
				local PlayerPed = PlayerPedId()
				SetEntityHeading(PlayerPed, ToucheGauche and GetEntityHeading(PlayerPed) - 2.0 or ToucheDroite and GetEntityHeading(PlayerPed) + 2.0)
			end
            if IsControlJustReleased(2, 205) or IsDisabledControlJustReleased(1, 205) then
                if not isTurnedLeft then
                    func_1513(PlayerPedId(), false)
                    isTurnedLeft = true
                else
                    func_1514(PlayerPedId(), true)
                    isTurnedLeft = false
                end
            end
            if IsControlJustReleased(1, 206) or
                IsDisabledControlJustReleased(1, 206) then
                if not isTurnedRight then
                    func_1514(PlayerPedId(), false)
                    isTurnedRight = true
                else
                    func_1513(PlayerPedId(), true)
                    isTurnedRight = false
                end
            end
        else
             DrawScaleformMovieFullscreen(false)
        end
        if onCreatorTick.LightRemote then end
        if onCreatorTick.Scaleform then OnRenderCreatorScaleform() end
    end
end)

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

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

function animationvetement()
    ClearPedTasks(PlayerPedId())
    TaskPlayAnim(GetPlayerPed(-1), "mp_character_creation@customise@male_a", "drop_loop", 3.0, -1.0, -1, 2, 0, 0, 0, 0)
end

local d = true;
local e = nil;
local f = false;

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(g)
    f = true
end)

function changeModel(skin)
	local model = GetHashKey(skin)
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetPedDefaultComponentVariation(PlayerPedId())
        SetModelAsNoLongerNeeded(model)
    end
end

AddEventHandler('playerSpawned', function()
    Citizen.CreateThread(function()
        while not f do Citizen.Wait(10) end
        if d then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(h, i)
                if h == nil then
                    changeModel('a_m_y_breakdance_01')
                    TriggerEvent('chat:clear')
                    TriggerEvent('spawnhandler:CharacterCreator')
                else
                    TriggerEvent('skinchanger:loadSkin', h)
                    NiceSpawn()
                end
            end)
            d = false
        end
    end)
end)

local h;

local j = {"Fatima", "Fatiha", "Kenza", "Mariam", "Paola", "Inès", "Myriam", "Jasmine", "Marla", "Léa", "Célia", "Alicia", "Solange", "Émilie", "Clara", "Clémence", "Camille", "Anais", "Emma", "Eva", "Marion", "Leonie", "Audrey", "Jasmine", "Giselle", "Amelia", "Isabella", "Zoe", "Ava", "Camilia", "Violet", "Sophie", "Evelyn", "Nicole", "Ashley", "Grace", "Briana", "Natalie", "Olivia", "Elizabeth", "Charlotte", "Emma", "Niko", "John"}

local k = {"Benjamin", "Daniel", "Joshua", "Noah", "Andrew", "Juan", "Alex", "Isaac", "Evan", "Ethan", "Vincent", "Angel", "Diego", "Adrian", "Gabriel", "Michael", "Santiago", "Kevin", "Louis", "Samuel", "Anthony", "Erwan", "Samuel", "Kevin", "Loic", "Sacha", "Etienne", "Elias", "Ayoub", "Hugo", "Lorenzo", "Gaspard", "Valentin", "Mathis", "Quentin", "Alexandre", "Kylian", "Ewan", "Luka", "Julian", "Thibault", "Tom", "Eliot", "Ilan"}

local l = {
    "Vert", "Emeraude", "Bleu clair", "Bleu marine", "Chatain", "Marron fonce","Noisette", "Gris fonce", "Gris clair"
}

local onBack = false
local onBackPerso = false

creator = {
    Base = {
        Header = {"commonmenu", "interaction_bgd"},
        Color = {color_black},
        HeaderColor = {0, 240, 150, 250},
        Title = 'Création de personnage',
        Blocked = true,
        world = true
    },
    Data = {currentMenu = "Création de personnage"},
    Events = {
        onBack = function()
            if onBackPerso then
                CreatorDeleteAssets()
                ClearPedTasks(PlayerPedId())
                TaskPlayAnim(GetPlayerPed(-1), "mp_character_creation@customise@male_a", "loop", 5.0, -1.0, -1, 2, 0, 0, 0, 0)
                AttachBoardToEntity(PlayerPedId(), "Nouveau personnage", math.random(10 * 1000000000, 10 * 1000000000), "LOS SANTOS POLICE DEPT", math.random(1, 99))
                onBackPerso = false
            end

            CreatorZoomOut(GetCreatorCam())
            if onBack then
                ClearPedTasks(PlayerPedId())
                TaskPlayAnim(GetPlayerPed(-1), "mp_character_creation@customise@male_a", "loop", 5.0, -1.0, -1, 2, 0, 0, 0, 0)
                onBack = false
            end
        end,
        onSelected = function(self, m, n, o, p, q, r, s, result, t)
            RequestStreamedTextureDict("pause_menu_pages_char_mom_dad", false)
            SetStreamedTextureDictAsNoLongerNeeded(
                "pause_menu_pages_char_mom_dad", false)
            SetStreamedTextureDictAsNoLongerNeeded(
                "pause_menu_pages_char_mom_dad", false)
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            RequestStreamedTextureDict("char_creator_portraits", false)
            RequestStreamedTextureDict("mpleaderboard", false)
            SetStreamedTextureDictAsNoLongerNeeded("char_creator_portraits",
                                                   false)
            local t = n.slidenum;
            local n = n.name;
            local u = n.unkCheckbox;
            local v, w = ESX.Game.GetClosestPlayer()
            local x = PlayerPedId()
            local y = p.currentMenu;
            local result = GetOnscreenKeyboardResult()

            if n == "Apparence" then
                OpenMenu('Apparence')
                CreatorZoomIn(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", true)
                onCreatorTick.FaceTurnEnabled = false
            elseif n == "Héritage" then
                CreatorZoomIn(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", true)
                OpenMenu("Héritage")
                onCreatorTick.FaceTurnEnabled = true
            elseif n == "Maquillage" then
                OpenMenu("Maquillage")
                CreatorZoomIn(GetCreatorCam())
                onCreatorTick.FaceTurnEnabled = true;
                UpdateCreatorTick("FaceTurnEnabled", true)
            elseif n == "Vêtement Ped" then
                OpenMenu("Vêtement Ped")
                CreatorZoomIn(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", true)
                onCreatorTick.FaceTurnEnabled = false           
            elseif n == "Personnage" then
                onBackPerso = true
                CreatorZoomOut(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", false)
                OpenMenu("Personnage")
            elseif n == "Trait du visage" then
                OpenMenu("Trait du visage")
                CreatorZoomIn(GetCreatorCam())
                onCreatorTick.FaceTurnEnabled = true;
                UpdateCreatorTick("FaceTurnEnabled", true)
            elseif n == "Vêtements" then
                onBack = true
                OpenMenu("Vêtements")
                ClearPedTasks(PlayerPedId())
                CreatorDeleteAssets()
                AttachBoardToEntity(PlayerPedId(), "Nouveau personnage", math.random(10 * 1000000000, 10 * 1000000000), "LOS SANTOS POLICE DEPT", math.random(1, 99))
                TaskPlayAnim(GetPlayerPed(-1), "mp_character_creation@customise@male_a", "drop_loop", 3.0, -1.0, -1, 2, 0, 0, 0, 0)
                CreatorZoomOut(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", false)
            elseif n == "~b~Valider & continuer" then
                UpdateCreatorTick("FaceTurnEnabled", false)
                CreatorZoomOut(GetCreatorCam())
                OpenMenu("Carte d'identité")
                onCreatorTick.FaceTurnEnabled = false
            elseif n == "Cheveux" then
                creator.Menu['Styles de cheveux'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.hair_1 do
                        table.insert(creator.Menu["Styles de cheveux"].b, {
                            name = "Cheveux N°" .. B,
                            advSlider = {0, 63, 0},
                            iterator = B
                        })
                    end
                end)
                CreatorZoomIn(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", true)
                OpenMenu('Styles de cheveux')
            elseif n == "Barbe" then
                creator.Menu['Styles de barbes'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.beard_1 do
                        table.insert(creator.Menu['Styles de barbes'].b, {
                            name = "Barbe N°" .. B,
                            opacity = 1,
                            advSlider = {0, 63, 0},
                            iterator = B
                        })
                    end
                end)
                CreatorZoomIn(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", true)
                OpenMenu('Styles de barbes')
            elseif n == "Sourcils" then
                creator.Menu['Styles de sourcils'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.eyebrows_1 do
                        table.insert(creator.Menu['Styles de sourcils'].b, {
                            name = "Sourcil N°" .. B,
                            opacity = 1,
                            advSlider = {0, 63, 0},
                            iterator = B
                        })
                    end
                end)
                CreatorZoomIn(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", true)
                OpenMenu("Styles de sourcils")
            elseif n == "Problème de peau" then
                creator.Menu['Styles de problèmes de peau'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.complexion_1 do
                        table.insert(
                            creator.Menu['Styles de problèmes de peau'].b, {
                                name = "Problème de peau N°" .. B,
                                opacity = 1,
                                iterator = B
                            })
                    end
                end)
                CreatorZoomIn(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", true)
                OpenMenu("Styles de problèmes de peau")
            elseif n == "Signe de viellisement" then
                creator.Menu['Viellisement'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.age_1 do
                        table.insert(creator.Menu['Viellisement'].b, {
                            name = "Viellisement N°" .. B,
                            opacity = 0.5,
                            iterator = B
                        })
                    end
                end)
                CreatorZoomIn(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", true)
                OpenMenu("Viellisement")
            elseif n == "Pilosité du torse" then
                creator.Menu['Poils du torse'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.chest_1 do
                        table.insert(creator.Menu['Poils du torse'].b, {
                            name = "Poils du torse N°" .. B,
                            advSlider = {0, 63, 0},
                            opacity = 1,
                            iterator = B
                        })
                    end
                end)
                CreatorZoomOut(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", false)
                OpenMenu("Poils du torse")
            elseif n == "Taches cutanées" then
                creator.Menu['Boutons'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.blemishes_1 do
                        table.insert(creator.Menu['Boutons'].b, {
                            name = "Boutons N°" .. B,
                            opacity = 1,
                            iterator = B
                        })
                    end
                end)
                CreatorZoomIn(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", true)
                OpenMenu("Boutons")
            elseif n == "Tâches de rousseurs" then
                creator.Menu['Peau'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.moles_1 do
                        table.insert(creator.Menu['Peau'].b, {
                            name = "Tâches sur le visage N°" .. B,
                            opacity = 1,
                            iterator = B
                        })
                    end
                end)
                CreatorZoomIn(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", true)
                OpenMenu("Peau")
            elseif n == "Aspect de la peau" then
                creator.Menu['Aspect'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.sun_1 do
                        table.insert(creator.Menu['Aspect'].b, {
                            name = "Aspect de la peau N°" .. B,
                            opacity = 1,
                            iterator = B
                        })
                    end
                end)
                CreatorZoomIn(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", true)
                OpenMenu("Aspect")
            elseif n == "Sous-haut" then
                onBack = true
                animationvetement()
                creator.Menu['Variations de sous-haut'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.tshirt_1 do
                        table.insert(creator.Menu['Variations de sous-haut'].b,
                                     {
                            name = "Sous haut N°" .. B,
                            advSlider = {0, 20, 0},
                            iterator = B
                        })
                    end
                end)
                CreatorZoomOut(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", false)
                OpenMenu("Variations de sous-haut")
            elseif n == "Haut" then
                onBack = true
                animationvetement()
                creator.Menu['Variations de haut'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.torso_1 do
                        table.insert(creator.Menu['Variations de haut'].b, {
                            name = "Haut N°" .. B,
                            advSlider = {0, 20, 0},
                            iterator = B
                        })
                    end
                end)
                CreatorZoomOut(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", false)
                OpenMenu("Variations de haut")
            elseif n == "Bas" then
                onBack = true
                animationvetement()
                creator.Menu['Variations de bas'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.pants_1 do
                        table.insert(creator.Menu['Variations de bas'].b, {
                            name = "Bas N°" .. B,
                            advSlider = {0, 20, 0},
                            iterator = B
                        })
                    end
                end)
                CreatorZoomOut(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", false)
                OpenMenu("Variations de bas")
            elseif n == "Chaussure" then
                onBack = true
                animationvetement()
                creator.Menu['Variations de chaussure'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.shoes_1 do
                        table.insert(creator.Menu['Variations de chaussure'].b,
                                     {
                            name = "Chaussure N°" .. B,
                            advSlider = {0, 20, 0},
                            iterator = B
                        })
                    end
                end)
                CreatorZoomOut(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", false)
                OpenMenu("Variations de chaussure")
            elseif n == "Chapeau" then
                creator.Menu['Variations de chapeau'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.helmet_1 do
                        table.insert(creator.Menu['Variations de chapeau'].b, {
                            name = "Chapeau N°" .. B,
                            advSlider = {0, 20, 0},
                            iterator = B
                        })
                    end
                end)
                CreatorZoomIn(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", true)
                OpenMenu("Variations de chapeau")
            elseif n == "Lunette" then
                creator.Menu['Variations de lunette'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.glasses_1 do
                        table.insert(creator.Menu['Variations de lunette'].b, {
                            name = "Lunette N°" .. B,
                            advSlider = {0, 20, 0},
                            iterator = B
                        })
                    end
                end)
                CreatorZoomIn(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", true)
                OpenMenu("Variations de lunette")
            elseif n == "Oreillette" then
                creator.Menu['Variations d\'oreillete'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.ears_1 do
                        table.insert(creator.Menu['Variations d\'oreillete'].b,
                                     {
                            name = "Oreillette N°" .. B,
                            advSlider = {0, 20, 0},
                            iterator = B
                        })
                    end
                end)
                CreatorZoomIn(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", true)
                OpenMenu("Variations d\'oreillete")
            elseif n == "Sac à dos" then
                onBack = true
                animationvetement()
                creator.Menu['Variations de sac à dos'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.bags_1 do
                        table.insert(creator.Menu['Variations de sac à dos'].b,
                                     {
                            name = "Sac à dos N°" .. B,
                            advSlider = {0, 20, 0},
                            iterator = B
                        })
                    end
                end)
                CreatorZoomOut(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", false)
                OpenMenu("Variations de sac à dos")
            elseif n == "Gant" then
                onBack = true
                animationvetement()
                creator.Menu['Variations de gant'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.arms do
                        table.insert(creator.Menu['Variations de gant'].b, {
                            name = "Gant N°" .. B,
                            advSlider = {0, 20, 0},
                            iterator = B
                        })
                    end
                end)
                CreatorZoomOut(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", false)
                OpenMenu("Variations de gant")
            elseif n == "Montre" then
                onBack = true
                animationvetement()
                creator.Menu['Variations de montre'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.watches_1 do
                        table.insert(creator.Menu['Variations de montre'].b, {
                            name = "Montre N°" .. B,
                            advSlider = {0, 20, 0},
                            iterator = B
                        })
                    end
                end)
                CreatorZoomOut(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", false)
                OpenMenu("Variations de montre")
            elseif n == "Chaîne" then
                onBack = true
                animationvetement()
                creator.Menu['Variations de chaîne'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.chain_1 do
                        table.insert(creator.Menu['Variations de chaîne'].b, {
                            name = "Chaine N°" .. B,
                            advSlider = {0, 20, 0},
                            iterator = B
                        })
                    end
                end)
                CreatorZoomOut(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", false)
                OpenMenu("Variations de chaîne")
            elseif n == "Bracelet" then
                onBack = true
                animationvetement()
                creator.Menu['Variations de bracelet'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.bracelets_1 do
                        table.insert(creator.Menu['Variations de bracelet'].b, {
                            name = "Bracelet N°" .. B,
                            advSlider = {0, 20, 0},
                            iterator = B
                        })
                    end
                end)
                CreatorZoomOut(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", false)
                OpenMenu("Variations de bracelet")
            elseif n == "Maquillage visage" then
                creator.Menu['Variations de maquillage'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.makeup_1 do
                        table.insert(creator.Menu['Variations de maquillage'].b,
                                     {
                            name = "Maquillage N°" .. B,
                            advSlider = {0, 20, 0},
                            opacity = 1,
                            iterator = B
                        })
                    end
                end)
                OpenMenu("Variations de maquillage")
            elseif n == "Rouge à lèvres" then
                creator.Menu['Variations de rouge à lèvres'].b = {}
                TriggerEvent('skinchanger:getData', function(z, A)
                    for B = 0, A.lipstick_1 do
                        table.insert(
                            creator.Menu['Variations de rouge à lèvres'].b, {
                                name = "Rouge à lèvres N°" .. B,
                                advSlider = {0, 20, 0},
                                opacity = 1,
                                iterator = B
                            })
                    end
                end)
                OpenMenu("Variations de rouge à lèvres")
            elseif n == "Prénom :" then
                if result ~= nil then
                    ResultPrenom = result
                end
            elseif n == "Nom :" then
                if result ~= nil then
                    ResultNom = result
                end
            elseif n == "Date de naissance :" then
                if result ~= nil then
                    datedenaissance = result
                end
            elseif n == "Lieu de naissance :" then
                if result ~= nil then
                    ResultLieuNaissance = result
                end
            elseif n == "Taille :" then
                if result ~= nil then
                    taille = result
                end
            elseif n == "Sexe (m/f) :" then
                if result ~= nil then
                    ResultSexe = result
                end
            elseif n == "Valider" then
                if ResultPrenom and ResultNom and datedenaissance and ResultLieuNaissance and taille and ResultSexe == result then
                    TriggerServerEvent('creator:saveidentite', ResultSexe, ResultPrenom, ResultNom, datedenaissance, taille)
                    TriggerEvent('skinchanger:getSkin', function(h)
                        e = h
                    end)
                    TriggerEvent('skinchanger:getSkin', function(h)
                        TriggerServerEvent('esx_skin:save', h)
                    end)
                    DestroyAllCams(true)
                    RenderScriptCams(false, false, 0, true, true)
                    CloseCreatorMenu()
                    TriggerServerEvent('zcreator:giveitembread')
                    TriggerServerEvent('zcreator:giveitemwater')
                    TriggerEvent('creator:launchCharMovie')
                else
                    ESX.ShowNotification("Vous n'avez pas ~r~remplie~s~ tout les champs")
                end
            end
        end,
        onButtonSelected = function(currentMenu, r, p, C, self)
            if currentMenu == "Styles de cheveux" then
                for D, E in pairs(creator.Menu["Styles de cheveux"].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'hair_1', E.iterator)
                    end
                end
            end
            if currentMenu == 'Styles de barbes' then
                for D, E in pairs(creator.Menu['Styles de barbes'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'beard_1', E.iterator)
                    end
                end
            end
            if currentMenu == 'Styles de sourcils' then
                for D, E in pairs(creator.Menu['Styles de sourcils'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'eyebrows_1',
                                     E.iterator)
                    end
                end
            end
            if currentMenu == 'Viellisement' then
                for D, E in pairs(creator.Menu['Viellisement'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'age_1', E.iterator)
                    end
                end
            end
            if currentMenu == 'Poils du torse' then
                for D, E in pairs(creator.Menu['Poils du torse'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'chest_1', E.iterator)
                    end
                end
            end
            if currentMenu == 'Boutons' then
                for D, E in pairs(creator.Menu['Boutons'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'blemishes_1',
                                     E.iterator)
                    end
                end
            end
            if currentMenu == 'Peau' then
                for D, E in pairs(creator.Menu['Peau'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'moles_1', E.iterator)
                    end
                end
            end
            if currentMenu == 'Aspect' then
                for D, E in pairs(creator.Menu['Aspect'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'sun_1', E.iterator)
                    end
                end
            end
            if currentMenu == 'Variations de sous-haut' then
                for D, E in pairs(creator.Menu['Variations de sous-haut'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'tshirt_1',
                                     E.iterator)
                    end
                    OnSelectedClothes()
                end
            end
            if currentMenu == 'Variations de haut' then
                for D, E in pairs(creator.Menu['Variations de haut'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'torso_1', E.iterator)
                    end
                    OnSelectedClothes()
                end
            end
            if currentMenu == 'Variations de bas' then
                for D, E in pairs(creator.Menu['Variations de bas'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'pants_1', E.iterator)
                    end
                    OnSelectedClothes()
                end
            end
            if currentMenu == 'Styles de problèmes de peau' then
                for D, E in
                    pairs(creator.Menu['Styles de problèmes de peau'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'complexion_1',
                                     E.iterator)
                    end
                end
            end
            if currentMenu == 'Variations de chaussure' then
                for D, E in pairs(creator.Menu['Variations de chaussure'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'shoes_1', E.iterator)
                    end
                    OnSelectedClothes()
                end
            end
            if currentMenu == 'Variations de chapeau' then
                for D, E in pairs(creator.Menu['Variations de chapeau'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'helmet_1',
                                     E.iterator)
                    end
                    OnSelectedClothes()
                end
            end
            if currentMenu == 'Variations de lunette' then
                for D, E in pairs(creator.Menu['Variations de lunette'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'glasses_1',
                                     E.iterator)
                    end
                    OnSelectedClothes()
                end
            end
            if currentMenu == 'Variations d\'oreillete' then
                for D, E in pairs(creator.Menu['Variations d\'oreillete'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'ears_1', E.iterator)
                    end
                    OnSelectedClothes()
                end
            end
            if currentMenu == 'Variations de sac à dos' then
                for D, E in pairs(creator.Menu['Variations de sac à dos'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'bags_1', E.iterator)
                    end
                    OnSelectedClothes()
                end
            end
            if currentMenu == 'Variations de gant' then
                for D, E in pairs(creator.Menu['Variations de gant'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'arms', E.iterator)
                    end
                    OnSelectedClothes()
                end
            end
            if currentMenu == 'Variations de montre' then
                for D, E in pairs(creator.Menu['Variations de montre'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'watches_1',
                                     E.iterator)
                    end
                    OnSelectedClothes()
                end
            end
            if currentMenu == 'Variations de chaîne' then
                for D, E in pairs(creator.Menu['Variations de chaîne'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'chain_1', E.iterator)
                    end
                    OnSelectedClothes()
                end
            end
            if currentMenu == 'Variations de bracelet' then
                for D, E in pairs(creator.Menu['Variations de bracelet'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'bracelets_1',
                                     E.iterator)
                    end
                    OnSelectedClothes()
                end
            end
            if currentMenu == 'Variations de maquillage' then
                for D, E in pairs(creator.Menu['Variations de maquillage'].b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'makeup_1',
                                     E.iterator)
                    end
                end
            end
            if currentMenu == 'Variations de rouge à lèvres' then
                for D, E in pairs(creator.Menu['Variations de rouge à lèvres']
                                      .b) do
                    if r - 1 == E.iterator then
                        TriggerEvent('skinchanger:change', 'lipstick_1',
                                     E.iterator)
                    end
                end
            end
        end,
        onSlide = function(p, n, q, s)
            local currentMenu = p.currentMenu, GetPlayerPed(-1)
            local t = n.slidenum;
            local F = n.opacity;
            local G = n.name;
            local H = n.parentSlider;
            local y = p.currentMenu, GetPlayerPed(-1), CreatorUpdateModelAnim()

            if y == "Personnage" then
                if perso then 
                    CreatorDeleteAssets()
                    SetEntityCoords(GetPlayerPed(-1), 402.85, -996.88, -100.00)
                    SetEntityHeading(GetPlayerPed(-1), 184.0)
                    TriggerEvent('skinchanger:change', 'sex', n.skin)
                    TaskPlayAnim(GetPlayerPed(-1), "mp_character_creation@customise@male_a", "drop_loop", 1.0, -1.0, -1, 2, 0, 0, 0, 0)
                else
                    TaskPlayAnim(GetPlayerPed(-1), "mp_character_creation@customise@male_a", "loop", 3.0, -1.0, -1, 2, 0, 0, 0, 0)
                    AttachBoardToEntity(PlayerPedId(), "Nouveau personnage", math.random(10 * 1000000000, 10 * 1000000000), "LOS SANTOS POLICE DEPT", math.random(1, 99))
                    sex = n.skin
                end
                perso = not perso
            end
            if G == "Visage" and t ~= -1 then
                eyecolor = t - 1;
                CreatorZoomIn(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", true)
                TriggerEvent('skinchanger:change', 'face_ped', eyecolor)
            end
            if G == "Haut du ped" and t ~= -1 then
                eyecolor = t - 1;
                CreatorZoomOut(GetCreatorCam())
                TriggerEvent('skinchanger:change', 'arms', eyecolor)
            end
            if G == "Bas du ped" and t ~= -1 then
                eyecolor = t - 1;
                CreatorZoomOut(GetCreatorCam())
                TriggerEvent('skinchanger:change', 'pants_1', eyecolor)
            end
            if G == "Couleurs des yeux" and t ~= -1 then
                CreatorZoomIn(GetCreatorCam())
                eyecolor = t - 1;
                TriggerEvent('skinchanger:change', 'eye_color', eyecolor)
            end
            if G == "Visage" and t ~= -1 then
                eyecolor = t - 1;
                CreatorZoomIn(GetCreatorCam())
                UpdateCreatorTick("FaceTurnEnabled", true)
                TriggerEvent('skinchanger:change', 'face_ped', eyecolor)
            end
            if G == "Haut du ped" and t ~= -1 then
                eyecolor = t - 1;
                TriggerEvent('skinchanger:change', 'arms', eyecolor)
            end
            if G == "Bas du ped" and t ~= -1 then
                eyecolor = t - 1;
                CreatorZoomOut(GetCreatorCam())
                TriggerEvent('skinchanger:change', 'pants_1', eyecolor)
            end
            if currentMenu == "Variations de maquillage" then
                TriggerEvent('skinchanger:change', 'makeup_2', F * 10)
            end
            if currentMenu == "Variations de rouge à lèvres" then
                TriggerEvent('skinchanger:change', 'lipstick_2', F * 10)
            end
            if currentMenu == "Styles de barbes" then
                TriggerEvent('skinchanger:change', 'beard_2', F * 10)
            end
            if currentMenu == "Styles de sourcils" then
                TriggerEvent('skinchanger:change', 'eyebrows_2', F * 10)
            end
            if currentMenu == "Styles de problèmes de peau" then
                TriggerEvent('skinchanger:change', 'complexion_2', F * 10)
            end
            if currentMenu == "Viellisement" then
                TriggerEvent('skinchanger:change', 'age_2', F * 10)
            end
            if currentMenu == "Poils du torse" then
                TriggerEvent('skinchanger:change', 'chest_2', F * 10)
            end
            if currentMenu == "Boutons" then
                TriggerEvent('skinchanger:change', 'blemishes_2', F * 10)
            end
            if currentMenu == "Peau" then
                TriggerEvent('skinchanger:change', 'moles_2', F * 10)
            end
            if currentMenu == "Aspect" then
                TriggerEvent('skinchanger:change', 'sun_2', F * 10)
            end
            if currentMenu == "Héritage" then
                j = creator.Menu["Héritage"].b[1].slidenum;
                k = creator.Menu["Héritage"].b[2].slidenum;
                ressemblance = creator.Menu["Héritage"].b[3].parentSlider;
                peau = creator.Menu["Héritage"].b[4].parentSlider;
                TriggerEvent('skinchanger:change', 'mom', j)
            end
            if currentMenu == "Héritage" then
                j = creator.Menu["Héritage"].b[1].slidenum;
                k = creator.Menu["Héritage"].b[2].slidenum;
                ressemblance = creator.Menu["Héritage"].b[3].parentSlider;
                peau = creator.Menu["Héritage"].b[4].parentSlider;
                TriggerEvent('skinchanger:change', 'dad', k)
            end
            if t == 1 and G == "Père" then
                creator.Menu["Héritage"].father = "male_0"
            end
            if t == 2 and G == "Père" then
                creator.Menu["Héritage"].father = "male_1"
            end
            if t == 3 and G == "Père" then
                creator.Menu["Héritage"].father = "male_2"
            end
            if t == 4 and G == "Père" then
                creator.Menu["Héritage"].father = "male_3"
            end
            if t == 5 and G == "Père" then
                creator.Menu["Héritage"].father = "male_4"
            end
            if t == 6 and G == "Père" then
                creator.Menu["Héritage"].father = "male_5"
            end
            if t == 7 and G == "Père" then
                creator.Menu["Héritage"].father = "male_6"
            end
            if t == 8 and G == "Père" then
                creator.Menu["Héritage"].father = "male_7"
            end
            if t == 9 and G == "Père" then
                creator.Menu["Héritage"].father = "male_8"
            end
            if t == 10 and G == "Père" then
                creator.Menu["Héritage"].father = "male_9"
            end
            if t == 11 and G == "Père" then
                creator.Menu["Héritage"].father = "male_10"
            end
            if t == 12 and G == "Père" then
                creator.Menu["Héritage"].father = "male_11"
            end
            if t == 13 and G == "Père" then
                creator.Menu["Héritage"].father = "male_12"
            end
            if t == 14 and G == "Père" then
                creator.Menu["Héritage"].father = "male_13"
            end
            if t == 15 and G == "Père" then
                creator.Menu["Héritage"].father = "male_14"
            end
            if t == 16 and G == "Père" then
                creator.Menu["Héritage"].father = "male_15"
            end
            if t == 17 and G == "Père" then
                creator.Menu["Héritage"].father = "male_16"
            end
            if t == 18 and G == "Père" then
                creator.Menu["Héritage"].father = "male_17"
            end
            if t == 19 and G == "Père" then
                creator.Menu["Héritage"].father = "male_18"
            end
            if t == 20 and G == "Père" then
                creator.Menu["Héritage"].father = "male_19"
            end
            if t == 21 and G == "Père" then
                creator.Menu["Héritage"].father = "male_20"
            end
            if t == 22 and G == "Père" then
                creator.Menu["Héritage"].father = "male_0"
            end
            if t == 23 and G == "Père" then
                creator.Menu["Héritage"].father = "male_1"
            end
            if t == 24 and G == "Père" then
                creator.Menu["Héritage"].father = "male_2"
            end
            if t == 25 and G == "Père" then
                creator.Menu["Héritage"].father = "male_3"
            end
            if t == 26 and G == "Père" then
                creator.Menu["Héritage"].father = "male_4"
            end
            if t == 27 and G == "Père" then
                creator.Menu["Héritage"].father = "male_5"
            end
            if t == 28 and G == "Père" then
                creator.Menu["Héritage"].father = "male_6"
            end
            if t == 29 and G == "Père" then
                creator.Menu["Héritage"].father = "male_7"
            end
            if t == 30 and G == "Père" then
                creator.Menu["Héritage"].father = "male_8"
            end
            if t == 31 and G == "Père" then
                creator.Menu["Héritage"].father = "male_9"
            end
            if t == 32 and G == "Père" then
                creator.Menu["Héritage"].father = "male_10"
            end
            if t == 33 and G == "Père" then
                creator.Menu["Héritage"].father = "male_11"
            end
            if t == 34 and G == "Père" then
                creator.Menu["Héritage"].father = "male_12"
            end
            if t == 35 and G == "Père" then
                creator.Menu["Héritage"].father = "male_13"
            end
            if t == 36 and G == "Père" then
                creator.Menu["Héritage"].father = "male_14"
            end
            if t == 37 and G == "Père" then
                creator.Menu["Héritage"].father = "male_15"
            end
            if t == 38 and G == "Père" then
                creator.Menu["Héritage"].father = "male_16"
            end
            if t == 39 and G == "Père" then
                creator.Menu["Héritage"].father = "male_17"
            end
            if t == 40 and G == "Père" then
                creator.Menu["Héritage"].father = "male_18"
            end
            if t == 41 and G == "Père" then
                creator.Menu["Héritage"].father = "male_19"
            end
            if t == 42 and G == "Père" then
                creator.Menu["Héritage"].father = "male_20"
            end
            if t == 43 and G == "Père" then
                creator.Menu["Héritage"].mother = "male_6"
            end
            if t == 44 and G == "Père" then
                creator.Menu["Héritage"].mother = "male_8"
            end

            if t == 1 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_0"
            end
            if t == 2 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_1"
            end
            if t == 3 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_2"
            end
            if t == 4 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_3"
            end
            if t == 5 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_4"
            end
            if t == 6 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_5"
            end
            if t == 7 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_6"
            end
            if t == 8 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_7"
            end
            if t == 9 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_8"
            end
            if t == 10 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_9"
            end
            if t == 11 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_10"
            end
            if t == 12 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_11"
            end
            if t == 13 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_12"
            end
            if t == 14 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_13"
            end
            if t == 15 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_14"
            end
            if t == 16 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_15"
            end
            if t == 17 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_16"
            end
            if t == 18 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_17"
            end
            if t == 19 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_18"
            end
            if t == 20 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_19"
            end
            if t == 21 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_20"
            end
            if t == 22 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_0"
            end
            if t == 23 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_1"
            end
            if t == 24 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_2"
            end
            if t == 25 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_3"
            end
            if t == 26 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_4"
            end
            if t == 27 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_5"
            end
            if t == 28 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_6"
            end
            if t == 29 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_7"
            end
            if t == 30 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_8"
            end
            if t == 31 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_9"
            end
            if t == 32 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_10"
            end
            if t == 33 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_11"
            end
            if t == 34 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_12"
            end
            if t == 35 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_13"
            end
            if t == 36 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_14"
            end
            if t == 37 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_15"
            end
            if t == 38 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_16"
            end
            if t == 39 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_17"
            end
            if t == 40 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_18"
            end
            if t == 41 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_19"
            end
            if t == 42 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_20"
            end
            
            if t == 43 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_6"
            end
            if t == 44 and G == "Mère" then
                creator.Menu["Héritage"].mother = "female_8"
            end
        end,
        onAdvSlide = function(self, I, r, J, K)
            local L, M, N, O = I.currentMenu, GetPlayerPed(-1), r.advSlider[3], r.advSlider[3] / 40 * 2 - 1;

            if I.currentMenu == "Vêtement Ped" and r.name == "Visage" then
                TriggerEvent('skinchanger:change', 'face_ped2', N)
            end
            if I.currentMenu == "Vêtement Ped" and r.name == "Haut du ped" then
                CreatorZoomOut(GetCreatorCam())
                TriggerEvent('skinchanger:change', 'arms_2', N)
            end
            if I.currentMenu == "Vêtement Ped" and r.name == "Bas du ped" then
                CreatorZoomOut(GetCreatorCam())
                TriggerEvent('skinchanger:change', 'pants_2', N)
            end

            if I.currentMenu == "Styles de cheveux" then
                for D, E in pairs(creator.Menu["Styles de cheveux"].b) do
                    if r.advSlider[3] == E.iterator then
                        TriggerEvent('skinchanger:change', 'hair_color_1',
                                     E.iterator)
                    end
                end
            end
            if I.currentMenu == "Styles de barbes" then
                for D, E in pairs(creator.Menu["Styles de barbes"].b) do
                    if r.advSlider[3] == E.iterator then
                        TriggerEvent('skinchanger:change', 'beard_3', E.iterator)
                    end
                end
            end
            if I.currentMenu == "Styles de sourcils" then
                for D, E in pairs(creator.Menu["Styles de sourcils"].b) do
                    if r.advSlider[3] == E.iterator then
                        TriggerEvent('skinchanger:change', 'eyebrows_3',
                                     E.iterator)
                    end
                end
            end
            if I.currentMenu == "Poils du torse" then
                for D, E in pairs(creator.Menu["Poils du torse"].b) do
                    if r.advSlider[3] == E.iterator then
                        TriggerEvent('skinchanger:change', 'chest_3', E.iterator)
                    end
                end
            end
            if I.currentMenu == "Variations de sous-haut" then
                for D, E in pairs(creator.Menu["Variations de sous-haut"].b) do
                    if r.advSlider[3] == E.iterator then
                        TriggerEvent('skinchanger:change', 'tshirt_2',
                                     E.iterator)
                    end
                end
            end
            if I.currentMenu == "Variations de haut" then
                for D, E in pairs(creator.Menu["Variations de haut"].b) do
                    if r.advSlider[3] == E.iterator then
                        TriggerEvent('skinchanger:change', 'torso_2', E.iterator)
                    end
                end
            end
            if I.currentMenu == "Variations de bas" then
                for D, E in pairs(creator.Menu["Variations de bas"].b) do
                    if r.advSlider[3] == E.iterator then
                        TriggerEvent('skinchanger:change', 'pants_2', E.iterator)
                    end
                end
            end
            if I.currentMenu == "Variations de chaussure" then
                for D, E in pairs(creator.Menu["Variations de chaussure"].b) do
                    if r.advSlider[3] == E.iterator then
                        TriggerEvent('skinchanger:change', 'shoes_2', E.iterator)
                    end
                end
            end
            if I.currentMenu == "Variations de chapeau" then
                for D, E in pairs(creator.Menu["Variations de chapeau"].b) do
                    if r.advSlider[3] == E.iterator then
                        TriggerEvent('skinchanger:change', 'helmet_2',
                                     E.iterator)
                    end
                end
            end
            if I.currentMenu == "Variations de lunette" then
                for D, E in pairs(creator.Menu["Variations de lunette"].b) do
                    if r.advSlider[3] == E.iterator then
                        TriggerEvent('skinchanger:change', 'glasses_2',
                                     E.iterator)
                    end
                end
            end
            if I.currentMenu == "Variations d\'oreillete" then
                for D, E in pairs(creator.Menu["Variations d\'oreillete"].b) do
                    if r.advSlider[3] == E.iterator then
                        TriggerEvent('skinchanger:change', 'ears_2', E.iterator)
                    end
                end
            end
            if I.currentMenu == "Variations de sac à dos" then
                for D, E in pairs(creator.Menu["Variations de sac à dos"].b) do
                    if r.advSlider[3] == E.iterator then
                        TriggerEvent('skinchanger:change', 'bags_2', E.iterator)
                    end
                end
            end
            if I.currentMenu == "Variations de gant" then
                for D, E in pairs(creator.Menu["Variations de gant"].b) do
                    if r.advSlider[3] == E.iterator then
                        TriggerEvent('skinchanger:change', 'arms_2', E.iterator)
                    end
                end
            end
            if I.currentMenu == "Variations de montre" then
                for D, E in pairs(creator.Menu["Variations de montre"].b) do
                    if r.advSlider[3] == E.iterator then
                        TriggerEvent('skinchanger:change', 'watches_2',
                                     E.iterator)
                    end
                end
            end
            if I.currentMenu == "Variations de chaîne" then
                for D, E in pairs(creator.Menu["Variations de chaîne"].b) do
                    if r.advSlider[3] == E.iterator then
                        TriggerEvent('skinchanger:change', 'chain_2', E.iterator)
                    end
                end
            end
            if I.currentMenu == "Variations de bracelet" then
                for D, E in pairs(creator.Menu["Variations de bracelet"].b) do
                    if r.advSlider[3] == E.iterator then
                        TriggerEvent('skinchanger:change', 'bracelets_2',
                                     E.iterator)
                    end
                end
            end
            if I.currentMenu == "Variations de maquillage" then
                for D, E in pairs(creator.Menu["Variations de maquillage"].b) do
                    if r.advSlider[3] == E.iterator then
                        TriggerEvent('skinchanger:change', 'makeup_3',
                                     E.iterator)
                    end
                end
            end
            if I.currentMenu == "Variations de rouge à lèvres" then
                for D, E in pairs(creator.Menu["Variations de rouge à lèvres"]
                                      .b) do
                    if r.advSlider[3] == E.iterator then
                        TriggerEvent('skinchanger:change', 'lipstick_3',
                                     E.iterator)
                    end
                end
            end
            if I.currentMenu == "Trait du visage" and r.name == "Largeur du nez" then
                TriggerEvent('skinchanger:change', 'nose_1', N)
            end
            if I.currentMenu == "Trait du visage" and r.name == "Hauteur du nez" then
                TriggerEvent('skinchanger:change', 'nose_2', N)
            end
            if I.currentMenu == "Trait du visage" and r.name ==
                "Longueur du nez" then
                TriggerEvent('skinchanger:change', 'nose_3', N)
            end
            if I.currentMenu == "Trait du visage" and r.name ==
                "Abaissement du nez" then
                TriggerEvent('skinchanger:change', 'nose_4', N)
            end
            if I.currentMenu == "Trait du visage" and r.name ==
                "Abaissement pic du nez" then
                TriggerEvent('skinchanger:change', 'nose_5', N)
            end
            if I.currentMenu == "Trait du visage" and r.name == "Torsion du nez" then
                TriggerEvent('skinchanger:change', 'nose_6', N)
            end
            if I.currentMenu == "Trait du visage" and r.name ==
                "Hauteur des sourcils" then
                TriggerEvent('skinchanger:change', 'eyebrows_5', N)
            end
            if I.currentMenu == "Trait du visage" and r.name ==
                "Profondeur des sourcils" then
                TriggerEvent('skinchanger:change', 'eyebrows_6', N)
            end
            if I.currentMenu == "Trait du visage" and r.name ==
                "Hauteur des pommettes" then
                TriggerEvent('skinchanger:change', 'cheeks_1', N)
            end
            if I.currentMenu == "Trait du visage" and r.name ==
                "Largeur des pommettes" then
                TriggerEvent('skinchanger:change', 'cheeks_2', N)
            end
            if I.currentMenu == "Trait du visage" and r.name ==
                "Largeur des joues" then
                TriggerEvent('skinchanger:change', 'cheeks_3', N)
            end
            if I.currentMenu == "Trait du visage" and r.name ==
                "Ouverture des yeux" then
                TriggerEvent('skinchanger:change', 'eye_open', N)
            end
            if I.currentMenu == "Trait du visage" and r.name ==
                "Épaisseur des lèvres" then
                TriggerEvent('skinchanger:change', 'lips_thick', N)
            end
            if I.currentMenu == "Trait du visage" and r.name ==
                "Largeur de la mâchoire" then
                TriggerEvent('skinchanger:change', 'jaw_1', N)
            end
            if I.currentMenu == "Trait du visage" and r.name ==
                "Longueur du dos de la mâchoire" then
                TriggerEvent('skinchanger:change', 'jaw_2', N)
            end
            if I.currentMenu == "Trait du visage" and r.name ==
                "Abaissement du menton" then
                TriggerEvent('skinchanger:change', 'chin_height', N)
            end
            if I.currentMenu == "Trait du visage" and r.name ==
                "Longueur de l'os du menton" then
                TriggerEvent('skinchanger:change', 'chin_lenght', N)
            end
            if I.currentMenu == "Trait du visage" and r.name ==
                "Largeur du menton" then
                TriggerEvent('skinchanger:change', 'chin_width', N)
            end
            if I.currentMenu == "Trait du visage" and r.name == "Trou du menton" then
                TriggerEvent('skinchanger:change', 'chin_hole', N)
            end
            if I.currentMenu == "Trait du visage" and r.name ==
                "Épaisseur du cou" then
                TriggerEvent('skinchanger:change', 'neck_thick', N)
            end
        end,

        onSlider = function(self, r, P, Q)
            if self.Data.currentMenu == "Héritage" then
                j = creator.Menu["Héritage"].b[1].slidenum;
                k = creator.Menu["Héritage"].b[2].slidenum;
                ressemblance = creator.Menu["Héritage"].b[3].parentSlider;
                peau = creator.Menu["Héritage"].b[4].parentSlider;
                TriggerEvent('skinchanger:change', 'skin', peau)
            end
            if self.Data.currentMenu == "Héritage" then
                j = creator.Menu["Héritage"].b[1].slidenum;
                k = creator.Menu["Héritage"].b[2].slidenum;
                ressemblance = creator.Menu["Héritage"].b[3].parentSlider;
                peau = creator.Menu["Héritage"].b[4].parentSlider;
                TriggerEvent('skinchanger:change', 'face', ressemblance)
            end
        end
    },
    Menu = {
        ["Création de personnage"] = {
            b = {
                {name = "Personnage", askX = true},
                {name = "Héritage", askX = true , canSee = function() return sex < 2 end},
                {name = "Apparence", askX = true, canSee = function() return sex < 2 end},
                {name = "Maquillage", askX = true , canSee = function() return sex < 2 end},
                {name = "Trait du visage", askX = true, canSee = function() return sex < 2 end},
                {name = "Vêtement Ped", askX = true, canSee = function() return sex >= 2 end},
                {name = "Vêtements", askX = true, canSee = function() return sex < 2 end},
                {name = "~b~Valider & continuer", askX = true}
            }
        },
        ["Héritage"] = {
            extra = true,
            charCreator = true,
            father = 'male_0',
            mother = 'female_0',
            b = {
                {name = "Mère", slidemax = j}, 
                {name = "Père", slidemax = k},
                {name = "Ressemblance", parentSlider = .25},
                {name = "Peau", parentSlider = .75}
            }
        },
        ["Apparence"] = {
            b = {
                {name = "Cheveux", askX = true},
                {name = "Sourcils", askX = true}, 
                {name = "Barbe", askX = true},
                {name = "Problème de peau", askX = true},
                {name = "Signe de viellisement", askX = true},
                {name = "Pilosité du torse", askX = true},
                {name = "Taches cutanées", askX = true},
                {name = "Aspect de la peau", askX = true},
                {name = "Tâches de rousseurs", askX = true},
                {name = "Couleurs des yeux", slidemax = l}
            }
        },
        ["Maquillage"] = {
            b = {
                {name = "Maquillage visage", askX = true},
                {name = "Rouge à lèvres", askX = true}
            }
        },
        ["Trait du visage"] = {
            extra = true,
            b = {
                {name = "Largeur du nez", advSlider = {0, 10, 0}},
                {name = "Hauteur du nez", advSlider = {0, 10, 0}},
                {name = "Longueur du nez", advSlider = {0, 10, 0}},
                {name = "Abaissement du nez", advSlider = {0, 10, 0}},
                {name = "Abaissement pic du nez", advSlider = {0, 10, 0}},
                {name = "Torsion du nez", advSlider = {0, 10, 0}},
                {name = "Hauteur des sourcils", advSlider = {0, 10, 0}},
                {name = "Profondeur des sourcils", advSlider = {0, 10, 0}},
                {name = "Hauteur des pommettes", advSlider = {0, 10, 0}},
                {name = "Largeur des pommettes", advSlider = {0, 10, 0}},
                {name = "Largeur des joues", advSlider = {0, 10, 0}},
                {name = "Ouverture des yeux", advSlider = {0, 10, 0}},
                {name = "Épaisseur des lèvres", advSlider = {0, 10, 0}},
                {name = "Largeur de la mâchoire", advSlider = {0, 10, 0}},
                {name = "Longueur du dos de la mâchoire",advSlider = {0, 10, 0}
                }, {name = "Abaissement du menton", advSlider = {0, 10, 0}},
                {name = "Longueur de l'os du menton", advSlider = {0, 10, 0}},
                {name = "Largeur du menton", advSlider = {0, 10, 0}},
                {name = "Trou du menton", advSlider = {0, 10, 0}},
                {name = "Épaisseur du cou", advSlider = {0, 10, 0}}
            }
        },
        ["Vêtements"] = {
            b = {
                {name = "Sous-haut", askX = true}, {name = "Haut", askX = true},
                {name = "Bas", askX = true}, {name = "Chaussure", askX = true},
                {name = "Chapeau", askX = true},
                {name = "Lunette", askX = true},
                {name = "Oreillette", askX = true},
                {name = "Sac à dos", askX = true},
                {name = "Gant", askX = true}, {name = "Montre", askX = true},
                {name = "Chaîne", askX = true},
                {name = "Bracelet", askX = true}
            }
        },
        ["Carte d'identité"] = {
            b = {
                {name = "Prénom :", ask = '', askX = false},
                {name = "Nom :", ask = '', askX = false},
                {name = "Date de naissance :", ask = '', askX = false},
                {name = "Lieu de naissance :", ask = '', askX = false},
                {name = "Taille :", ask = '', askX = false},
                {name = "Sexe (m/f) :", ask = '', askX = false},
                {name = "Valider", colorFree = {45, 119, 205, 165}, askX = true}
            }
        },
        ["Vêtement Ped"] = {
            extra = true,
            b = {
                {name = "Visage", slidemax = 1, advSlider = {0, 2, 0}},
                {name = "Haut du ped", slidemax = 1, advSlider = {0, 2, 0}},
                {name = "Bas du ped", slidemax = 1, advSlider = {0, 2, 0}}
            }
        },
        ["Personnage"] = {
            useFilter = true,
            b = {
                {name = "Homme", skin = 0},
                {name = "Femme", skin = 1},
                {name = "g_m_importexport_01", skin = 2},
                {name = "g_m_m_armboss_01", skin = 3},
                {name = "g_m_m_armgoon_01", skin = 4},
                {name = "g_m_m_armlieut_01", skin = 5},
                {name = "g_m_m_chemwork_01", skin = 6},
                {name = "g_m_m_chiboss_01", skin = 7},
                {name = "g_m_m_chicold_01", skin = 8},
                {name = "g_m_m_chigoon_01", skin = 9},
                {name = "g_m_m_chigoon_02", skin = 10},
                {name = "g_m_m_korboss_01", skin = 11},
                {name = "g_m_m_mexboss_01", skin = 12},
                {name = "g_m_m_mexboss_02", skin = 13},
                {name = "g_m_y_armgoon_02", skin = 14},
                {name = "g_m_y_azteca_01", skin = 15},
                {name = "g_m_y_ballaeast_01", skin = 16},
                {name = "g_m_y_ballaorig_01", skin = 17},
                {name = "g_m_y_ballasout_01", skin = 18},
                {name = "g_m_y_famca_01", skin = 19},
                {name = "g_m_y_famdnf_01", skin = 20},
                {name = "g_m_y_famfor_01", skin = 21},
                {name = "ig_lamardavis", skin = 22},
                {name = "cs_lamardavis", skin = 23},
                {name = "g_m_y_korean_01", skin = 24},
                {name = "g_m_y_korean_02", skin = 25},
                {name = "g_m_y_korlieut_01", skin = 26},
                {name = "g_m_y_lost_01", skin = 27},
                {name = "g_m_y_lost_02", skin = 28},
                {name = "g_m_y_lost_03", skin = 29},
                {name = "g_m_y_mexgang_01", skin = 30},
                {name = "g_m_y_mexgoon_01", skin = 31},
                {name = "g_m_y_mexgoon_02", skin = 32},
                {name = "g_m_y_mexgoon_03", skin = 33},
                {name = "g_m_y_pologoon_01", skin = 34},
                {name = "g_m_y_pologoon_02", skin = 35},
                {name = "g_m_y_salvaboss_01", skin = 36},
                {name = "g_m_y_salvagoon_01", skin = 37},
                {name = "g_m_y_salvagoon_02", skin = 38},
                {name = "g_m_y_salvagoon_03", skin = 39},
                {name = "g_m_y_strpunk_01", skin = 40},
                {name = "g_m_y_strpunk_02", skin = 41},
                {name = "g_f_importexport_01", skin = 42},
                {name = "g_f_y_ballas_01", skin = 43},
                {name = "g_f_y_families_01", skin = 44},
                {name = "g_f_y_lost_01", skin = 45},
                {name = "g_f_y_vagos_01", skin = 46},
                {name = "mp_f_bennymech_01", skin = 47},
                {name = "mp_f_boatstaff_01", skin = 48},
                {name = "mp_f_cardesign_01", skin = 49},
                {name = "mp_f_chbar_01", skin = 50},
                {name = "mp_f_counterfeit_01", skin = 51},
                {name = "mp_f_forgery_01", skin = 52},
                {name = "mp_f_helistaff_01", skin = 53},
                {name = "mp_f_weed_01", skin = 54},
                {name = "mp_g_m_pros_01", skin = 55},
                {name = "mp_m_boatstaff_01", skin = 56},
                {name = "mp_m_counterfeit_01", skin = 57},
                {name = "mp_m_exarmy_01", skin = 58},
                {name = "mp_m_forgery_01", skin = 59},
                {name = "mp_m_g_vagfun_01", skin = 60},
                {name = "mp_m_waremech_01", skin = 61},
                {name = "mp_m_weapexp_01", skin = 62},
                {name = "mp_m_weapwork_01", skin = 63},
                {name = "mp_m_weed_01", skin = 64},
                {name = "s_f_m_fembarber", skin = 65},
                {name = "s_f_m_maid_01", skin = 66},
                {name = "s_f_m_sweatshop_01", skin = 67},
                {name = "s_f_y_airhostess_01", skin = 68},
                {name = "s_f_y_bartender_01", skin = 69},
                {name = "s_f_y_clubbar_01", skin = 70},
                {name = "s_f_y_hooker_01", skin = 71},
                {name = "s_f_y_hooker_02", skin = 72},
                {name = "s_f_y_hooker_03", skin = 73},
                {name = "s_f_y_migrant_01", skin = 74},
                {name = "s_f_y_movprem_01", skin = 75},
                {name = "s_f_y_scrubs_01", skin = 76},
                {name = "s_f_y_shop_low", skin = 77},
                {name = "s_f_y_shop_mid", skin = 78},
                {name = "s_f_y_stripper_01", skin = 79},
                {name = "s_f_y_stripper_02", skin = 80},
                {name = "s_f_y_sweatshop_01", skin = 81},
                {name = "s_f_y_casino_01", skin = 82},
                {name = "s_m_m_ammucountry", skin = 83},
                {name = "s_m_m_autoshop_01", skin = 84},
                {name = "s_m_m_autoshop_02", skin = 85},
                {name = "s_m_m_bouncer_01", skin = 86},
                {name = "s_m_m_ccrew_01", skin = 87},
                {name = "s_m_m_cntrybar_01", skin = 88},
                {name = "s_m_m_docscork_01", skin = 89},
                {name = "s_m_m_doctor_01", skin = 90},
                {name = "s_m_m_fiboffice_01", skin = 91},
                {name = "s_m_m_fiboffice_02", skin = 92},
                {name = "s_m_m_gaffer_01", skin = 93},
                {name = "s_m_m_gardener_01", skin = 94},
                {name = "s_m_m_gentransport", skin = 95},
                {name = "s_m_m_hairdress_01", skin = 96},
                {name = "s_m_m_highsec_01", skin = 97},
                {name = "s_m_m_highsec_02", skin = 98},
                {name = "s_m_m_janitor", skin = 99},
                {name = "s_m_m_lathandy_01", skin = 100},
                {name = "s_m_m_lifeinvad_01", skin = 101},
                {name = "s_m_m_linecook", skin = 101},
                {name = "s_m_m_lsmetro_01", skin = 102},
                {name = "s_m_m_mariachi_01", skin = 104},
                {name = "s_m_m_migrant_01", skin = 105},
                {name = "s_m_m_movprem_01", skin = 106},
                {name = "s_m_m_paramedic_01", skin = 107},
                {name = "s_m_m_postal_01", skin = 108},
                {name = "s_m_m_postal_02", skin = 109},
                {name = "s_m_m_scientist_01", skin = 110},
                {name = "s_m_m_strpreach_01", skin = 111},
                {name = "s_m_m_strvend_01", skin = 112},
                {name = "s_m_m_trucker_01", skin = 113},
                {name = "s_m_m_ups_01", skin = 114},
                {name = "s_m_m_ups_02", skin = 115},
                {name = "s_m_o_busker_01", skin = 116},
                {name = "s_m_y_airworker", skin = 117},
                {name = "s_m_y_ammucity_01", skin = 118},
                {name = "s_m_y_armymech_01", skin = 119},
                {name = "s_m_y_autopsy_01", skin = 120},
                {name = "s_m_y_barman_01", skin = 121},
                {name = "s_m_y_busboy_01", skin = 122},
                {name = "s_m_y_chef_01", skin = 123},
                {name = "s_m_y_clown_01", skin = 124},
                {name = "s_m_y_clubbar_01", skin = 125},
                {name = "s_m_y_construct_01", skin = 126},
                {name = "s_m_y_construct_02", skin = 127},
                {name = "s_m_y_dealer_01", skin = 128},
                {name = "s_m_y_devinsec_01", skin = 129},
                {name = "s_m_y_docscork_01", skin = 130},
                {name = "s_m_y_doorman_01", skin = 131},
                {name = "s_m_y_dwservice_01", skin = 132},
                {name = "s_m_y_dwservice_02", skin = 133},
                {name = "s_m_y_garbage", skin = 134},
                {name = "s_m_y_grip_01", skin = 135},
                {name = "s_m_y_mime", skin = 136},
                {name = "s_m_y_prismuscl_01", skin = 137},
                {name = "s_m_y_prisoner_01", skin = 138},
                {name = "s_m_y_robber_01", skin = 139},
                {name = "s_m_y_shop_mask", skin = 140},
                {name = "s_m_y_strvend_01", skin = 141},
                {name = "s_m_y_valet_01", skin = 142},
                {name = "s_m_y_waiter_01", skin = 143},
                {name = "s_m_y_waretech_01", skin = 144},
                {name = "s_m_y_winclean_01", skin = 145},
                {name = "s_m_y_xmech_02", skin = 146},
                {name = "ig_abigail", skin = 147},
                {name = "ig_ashley", skin = 148},
                {name = "ig_avon", skin = 149},
                {name = "ig_bankman", skin = 150},
                {name = "ig_barry", skin = 151},
                {name = "ig_benny", skin = 152},
                {name = "ig_bestmen", skin = 153},
                {name = "ig_beverly", skin = 154},
                {name = "ig_bride", skin = 155},
                {name = "ig_car3guy1", skin = 156},
                {name = "ig_car3guy2", skin = 157},
                {name = "ig_chengsr", skin = 158},
                {name = "ig_clay", skin = 159},
                {name = "ig_claypain", skin = 160},
                {name = "ig_cletus", skin = 161},
                {name = "ig_dale", skin = 162}, {name = "ig_dix", skin = 163},
                {name = "ig_djblamadon", skin = 164},
                {name = "ig_djblamrupert", skin = 165},
                {name = "ig_djblamryans", skin = 166},
                {name = "ig_djdixmanager", skin = 167},
                {name = "ig_djgeneric_01", skin = 168},
                {name = "ig_djsolfotios", skin = 169},
                {name = "ig_djsoljakob", skin = 170},
                {name = "ig_djsolmanager", skin = 171},
                {name = "ig_djsolmike", skin = 172},
                {name = "ig_djsolrobt", skin = 173},
                {name = "ig_djtalaurelia", skin = 174},
                {name = "ig_djtalignazio", skin = 175},
                {name = "ig_dreyfuss", skin = 176},
                {name = "ig_englishdave", skin = 177},
                {name = "ig_fbisuit_01", skin = 178},
                {name = "ig_g", skin = 179}, {name = "ig_groom", skin = 180},
                {name = "ig_hao", skin = 181}, {name = "ig_janet", skin = 182},
                {name = "ig_jewelass", skin = 183},
                {name = "ig_jimmyboston", skin = 184},
                {name = "ig_jimmyboston_02", skin = 185},
                {name = "ig_joeminuteman", skin = 186},
                {name = "ig_josef", skin = 187}, {name = "ig_josh", skin = 188},
                {name = "ig_kerrymcintosh", skin = 189},
                {name = "ig_kerrymcintosh_02", skin = 190},
                {name = "ig_lacey_jones_02", skin = 191},
                {name = "ig_lazlow_2", skin = 192},
                {name = "ig_lestercrest_2", skin = 193},
                {name = "ig_lifeinvad_01", skin = 194},
                {name = "ig_lifeinvad_02", skin = 195},
                {name = "ig_magenta", skin = 196},
                {name = "ig_malc", skin = 197},
                {name = "ig_manuel", skin = 198},
                {name = "ig_marnie", skin = 199},
                {name = "ig_maryann", skin = 200},
                {name = "ig_maude", skin = 201},
                {name = "ig_money", skin = 202},
                {name = "ig_mrs_thornhill", skin = 203},
                {name = "ig_mrsphillips", skin = 204},
                {name = "ig_natalia", skin = 205},
                {name = "ig_nigel", skin = 206},
                {name = "ig_old_man1a", skin = 207},
                {name = "ig_old_man2", skin = 208},
                {name = "ig_oneil", skin = 209},
                {name = "ig_ortega", skin = 210},
                {name = "ig_paige", skin = 211},
                {name = "ig_paper", skin = 212},
                {name = "ig_popov", skin = 213},
                {name = "ig_priest", skin = 214},
                {name = "csb_ramp_gang", skin = 215},
                {name = "ig_ramp_hic", skin = 216},
                {name = "ig_ramp_hipster", skin = 217},
                {name = "ig_ramp_mex", skin = 218},
                {name = "ig_rashcosvki", skin = 219},
                {name = "ig_roccopelosi", skin = 220},
                {name = "ig_russiandrunk", skin = 221},
                {name = "ig_sacha", skin = 222},
                {name = "ig_screen_writer", skin = 223},
                {name = "ig_sol", skin = 224}, {name = "ig_talcc", skin = 225},
                {name = "ig_talina", skin = 226},
                {name = "ig_talmm", skin = 227},
                {name = "ig_tanisha", skin = 228},
                {name = "ig_terry", skin = 229},
                {name = "ig_tomepsilon", skin = 230},
                {name = "ig_tonya", skin = 231},
                {name = "ig_tonyprince", skin = 232},
                {name = "ig_tylerdix", skin = 233},
                {name = "ig_tylerdix_02", skin = 234},
                {name = "ig_vagspeak", skin = 235},
                {name = "ig_zimbor", skin = 236},
                {name = "u_f_m_miranda", skin = 237},
                {name = "u_f_m_miranda_02", skin = 238},
                {name = "u_f_m_promourn_01", skin = 239},
                {name = "u_f_o_moviestar", skin = 240},
                {name = "u_f_o_prolhost_01", skin = 241},
                {name = "u_f_y_bikerchic", skin = 242},
                {name = "u_f_y_comjane", skin = 243},
                {name = "u_f_y_danceburl_01", skin = 244},
                {name = "u_f_y_dancelthr_01", skin = 245},
                {name = "u_f_y_dancerave_01", skin = 246},
                {name = "u_f_y_hotposh_01", skin = 247},
                {name = "u_f_y_jewelass_01", skin = 248},
                {name = "u_f_y_mistress", skin = 249},
                {name = "u_f_y_poppymich", skin = 250},
                {name = "u_f_y_poppymich_02", skin = 251},
                {name = "u_f_y_princess", skin = 252},
                {name = "u_f_y_spyactress", skin = 253},
                {name = "u_m_m_aldinapoli", skin = 254},
                {name = "u_m_m_bankman", skin = 255},
                {name = "u_m_m_bikehire_01", skin = 256},
                {name = "u_m_m_doa_01", skin = 257},
                {name = "u_m_m_edtoh", skin = 258},
                {name = "u_m_m_fibarchitect", skin = 259},
                {name = "u_m_m_filmdirector", skin = 260},
                {name = "u_m_m_glenstank_01", skin = 261},
                {name = "u_m_m_griff_01", skin = 262},
                {name = "u_m_m_jesus_01", skin = 263},
                {name = "u_m_m_jewelsec_01", skin = 264},
                {name = "u_m_m_jewelthief", skin = 265},
                {name = "u_m_m_markfost", skin = 266},
                {name = "u_m_m_partytarget", skin = 267},
                {name = "u_m_m_promourn_01", skin = 268},
                {name = "u_m_m_rivalpap", skin = 269},
                {name = "u_m_m_spyactor", skin = 270},
                {name = "u_m_m_willyfist", skin = 271},
                {name = "u_m_o_finguru_01", skin = 272},
                {name = "u_m_o_taphillbilly", skin = 273},
                {name = "u_m_o_tramp_01", skin = 274},
                {name = "u_m_y_abner", skin = 275},
                {name = "u_m_y_antonb", skin = 276},
                {name = "u_m_y_baygor", skin = 277},
                {name = "u_m_y_burgerdrug_01", skin = 278},
                {name = "u_m_y_chip", skin = 279},
                {name = "u_m_y_cyclist_01", skin = 280},
                {name = "u_m_y_babyd", skin = 281},
                {name = "u_m_y_danceburl_01", skin = 282},
                {name = "u_m_y_dancelthr_01", skin = 283},
                {name = "u_m_y_dancerave_01", skin = 284},
                {name = "u_m_y_fibmugger_01", skin = 285},
                {name = "u_m_y_guido_01", skin = 286},
                {name = "u_m_y_gunvend_01", skin = 287},
                {name = "u_m_y_hippie_01", skin = 288},
                {name = "u_m_y_imporage", skin = 289},
                {name = "u_m_y_justin", skin = 290},
                {name = "u_m_y_mani", skin = 291},
                {name = "u_m_y_militarybum", skin = 292},
                {name = "u_m_y_paparazzi", skin = 293},
                {name = "u_m_y_party_01", skin = 294},
                {name = "u_m_y_prisoner_01", skin = 295},
                {name = "u_m_y_sbike", skin = 296},
                {name = "u_m_y_smugmech_01", skin = 297},
                {name = "u_m_y_staggrm_01", skin = 298},
                {name = "u_m_y_tattoo_01", skin = 299},
                {name = "csb_grove_str_dlr", skin = 300},
                {name = "csb_hugh", skin = 301},
                {name = "csb_imran", skin = 302},
                {name = "csb_jackhowitzer", skin = 303},
                {name = "csb_janitor", skin = 304},
                {name = "csb_mrs_r", skin = 305},
                {name = "csb_oscar", skin = 306},
                {name = "csb_porndudes", skin = 307},
                {name = "csb_undercover", skin = 308},
                {name = "a_f_m_beach_01", skin = 309},
                {name = "a_f_m_bevhills_01", skin = 310},
                {name = "a_f_m_bevhills_02", skin = 311},
                {name = "a_f_m_business_02", skin = 312},
                {name = "a_f_m_downtown_01", skin = 313},
                {name = "a_f_m_eastsa_01", skin = 314},
                {name = "a_f_m_eastsa_02", skin = 315},
                {name = "a_f_m_fatbla_01", skin = 316},
                {name = "a_f_m_fatcult_01", skin = 317},
                {name = "a_f_m_fatwhite_01", skin = 318},
                {name = "a_f_m_ktown_01", skin = 319},
                {name = "a_f_m_ktown_02", skin = 320},
                {name = "a_f_m_prolhost_01", skin = 321},
                {name = "a_f_m_salton_01", skin = 322},
                {name = "a_f_m_skidrow_01", skin = 323},
                {name = "a_f_m_soucent_01", skin = 324},
                {name = "a_f_m_soucent_02", skin = 325},
                {name = "a_f_m_soucentmc_01", skin = 326},
                {name = "a_f_m_tourist_01", skin = 327},
                {name = "a_f_m_tramp_01", skin = 328},
                {name = "a_f_m_trampbeac_01", skin = 329},
                {name = "a_f_o_genstreet_01", skin = 330},
                {name = "a_f_o_indian_01", skin = 331},
                {name = "a_f_o_ktown_01", skin = 332},
                {name = "a_f_o_salton_01", skin = 333},
                {name = "a_f_o_soucent_01", skin = 334},
                {name = "a_f_o_soucent_02", skin = 335},
                {name = "a_f_y_beach_01", skin = 336},
                {name = "a_f_y_bevhills_01", skin = 337},
                {name = "a_f_y_bevhills_02", skin = 338},
                {name = "a_f_y_bevhills_03", skin = 339},
                {name = "a_f_y_bevhills_04", skin = 340},
                {name = "a_f_y_business_01", skin = 341},
                {name = "a_f_y_business_02", skin = 342},
                {name = "a_f_y_business_03", skin = 343},
                {name = "a_f_y_business_04", skin = 344},
                {name = "a_f_y_clubcust_01", skin = 345},
                {name = "a_f_y_clubcust_02", skin = 346},
                {name = "a_f_y_clubcust_03", skin = 347},
                {name = "a_f_y_eastsa_01", skin = 348},
                {name = "a_f_y_eastsa_02", skin = 349},
                {name = "a_f_y_eastsa_03", skin = 350},
                {name = "a_f_y_epsilon_01", skin = 351},
                {name = "a_f_y_femaleagent", skin = 352},
                {name = "a_f_y_fitness_01", skin = 353},
                {name = "a_f_y_fitness_02", skin = 354},
                {name = "a_f_y_genhot_01", skin = 355},
                {name = "a_f_y_golfer_01", skin = 356},
                {name = "a_f_y_hiker_01", skin = 357},
                {name = "a_f_y_hippie_01", skin = 358}
            }
        },
        ["Styles de cheveux"] = {extra = true, b = {}},
        ["Styles de barbes"] = {extra = true, b = {}},
        ["Styles de sourcils"] = {extra = true, b = {}},
        ["Styles de problèmes de peau"] = {extra = true, b = {}},
        ["Viellisement"] = {extra = true, b = {}},
        ["Poils du torse"] = {b = {}},
        ["Boutons"] = {extra = true, b = {}},
        ["Peau"] = {extra = true, b = {}},
        ["Aspect"] = {extra = true, b = {}},
        ["Variations de sous-haut"] = {extra = true, b = {}},
        ["Variations de haut"] = {extra = true, b = {}},
        ["Variations de bas"] = {extra = true, b = {}},
        ["Variations de chaussure"] = {extra = true, b = {}},
        ["Variations de chapeau"] = {extra = true, b = {}},
        ["Variations de lunette"] = {extra = true, b = {}},
        ["Variations d\'oreillete"] = {extra = true, b = {}},
        ["Variations de sac à dos"] = {extra = true, b = {}},
        ["Variations de gant"] = {extra = true, b = {}},
        ["Variations de montre"] = {extra = true, b = {}},
        ["Variations de chaîne"] = {extra = true, b = {}},
        ["Variations de bracelet"] = {extra = true, b = {}},
        ["Variations de maquillage"] = {extra = true, b = {}},
        ["Variations de rouge à lèvres"] = {extra = true, b = {}}
    }
}

function CreateNamedRenderTargetForModel(R, S)
    local T = 0;
    if not IsNamedRendertargetRegistered(R) then
        RegisterNamedRendertarget(R, 0)
    end
    if not IsNamedRendertargetLinked(S) then LinkNamedRendertarget(S) end
    if IsNamedRendertargetRegistered(R) then
        T = GetNamedRendertargetRenderId(R)
    end
    return T
end
function GetScaleformMenuInfo(U)
    PushScaleformMovieFunction(U, "GET_CURRENT_SCREEN_ID")
    local V = EndScaleformMovieMethodReturn()
    while not GetScaleformMovieFunctionReturnBool(V) do Citizen.Wait(0) end
    local W = GetScaleformMovieFunctionReturnInt(V)
    PushScaleformMovieFunction(U, "GET_CURRENT_SELECTION")
    V = EndScaleformMovieMethodReturn()
    while not GetScaleformMovieFunctionReturnBool(V) do Citizen.Wait(0) end
    local X = GetScaleformMovieFunctionReturnInt(V)
    return W, X
end
function SetScaleformParams(U, Y)
    Y = Y or {}
    for D, E in pairs(Y) do
        PushScaleformMovieFunction(U, E.name)
        if E.param then
            for m, Z in pairs(E.param) do
                if math.type(Z) == "integer" then
                    PushScaleformMovieFunctionParameterInt(Z)
                elseif type(Z) == "boolean" then
                    PushScaleformMovieFunctionParameterBool(Z)
                elseif math.type(Z) == "float" then
                    PushScaleformMovieFunctionParameterFloat(Z)
                elseif type(Z) == "string" then
                    PushScaleformMovieFunctionParameterString(Z)
                end
            end
        end
        if E.func then E.func() end
        PopScaleformMovieFunctionVoid()
    end
end
function createScaleform(R, Y)
    if not R or string.len(R) <= 0 then return end
    local U = RequestScaleformMovie(R)
    while not HasScaleformMovieLoaded(U) do Citizen.Wait(0) end
    SetScaleformParams(U, Y)
    return U
end
AddEventHandler("creator:launchCharMovie", function()
    local function _(U)
        local T = RequestScaleformMovie(U)
        if T ~= 0 then
            while not HasScaleformMovieLoaded(T) do Citizen.Wait(0) end
        end
        return T
    end
    local function a0(U, a1, ...)
        local a2;
        local a3 = {...}
        BeginScaleformMovieMethod(U, a1)
        for D, E in ipairs(a3) do
            a2 = type(E)
            if a2 == 'string' then
                PushScaleformMovieMethodParameterString(E)
            elseif a2 == 'number' then
                if string.match(tostring(E), "%.") then
                    PushScaleformMovieFunctionParameterFloat(E)
                else
                    PushScaleformMovieFunctionParameterInt(E)
                end
            elseif a2 == 'boolean' then
                PushScaleformMovieMethodParameterBool(E)
            end
        end
        EndScaleformMovieMethod()
    end
    local a4 = vector3(399.9, -998.7, -100.0)
    local a5 = GetInteriorAtCoordsWithType(a4, "v_mugshot")
    local a6 = 2086940140;
    local a7 = "mp_character_creation@lineup@male_a"
    local T;
    local a8;
    local a9 = vector3(409.02, -1000.8, -98.859)
    local aa;
    local ab;
    local ac = GetHashKey("prop_police_id_text")
    local ad;
    local ae;
    local af;
    local ag = N_0xa67c35c56eb1bd9d;
    local ah = N_0x0d6ca79eeebd8ca3;
    local ai = N_0x3dec726c25a11bac;
    local aj = N_0xd801cc02177fa3f1;
    
    local function ak()
        ReleaseNamedRendertarget("ID_Text")
        SetScaleformMovieAsNoLongerNeeded(aa)
        CreatorDeleteAssets()
        DestroyCam(ae, 1)
        DestroyCam(af, 1)
        ReleaseNamedScriptAudioBank("DLC_GTAO/MUGSHOT_ROOM")
        ReleaseNamedScriptAudioBank("Mugshot_Character_Creator")
        RemoveAnimDict(a7)
        ClearPedTasksImmediately(PlayerPedId())
        StopPlayerSwitch()
        -- UnpinInterior("v_mugshot")
        T = false
    end

    AddEventHandler('onResourceStop', function(al)
        if al == GetCurrentResourceName() then ak() end
    end)

    local function at(au)
        a0(ad, 'OPEN_SHUTTER', 250)
        if au then
            a0(ad, 'SHOW_PHOTO_FRAME', false)
            a0(ad, 'SHOW_PHOTO_BORDER', true, -0.7, 0.5, 0.5, 162, 120)
        else
            a0(ad, 'SHOW_REMAINING_PHOTOS', true)
            a0(ad, 'SET_REMAINING_PHOTOS', 0, 1)
            a0(ad, 'SHOW_PHOTO_FRAME', true)
            a0(ad, 'SHOW_PHOTO_BORDER', false)
        end
    end
    local function av()
        local ar = PlayerPedId()
        a0(ad, 'CLOSE_SHUTTER', 250)
        if RequestScriptAudioBank("Mugshot_Character_Creator", false, -1) then
            PlaySound(-1, "Take_Picture", "MUGSHOT_CHARACTER_CREATION_SOUNDS", 0, 0, 1)
        end
        at(true)
    end

    local function ax(ae, ay, az, aA, aB)
        N_0xf55e4046f6f831dc(ae, ay)
        N_0xe111a7c0d200cbc5(ae, az)
        SetCamDofFnumberOfLens(ae, aA)
        SetCamDofMaxNearInFocusDistanceBlendLevel(ae, aB)
    end
    Citizen.CreateThread(function()
        LoadInterior(a5)
        DoScreenFadeOut(0)
        ae = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
        SetCamCoord(ae, 416.4084, -998.3806, -99.24789)
        SetCamRot(ae, 0.878834, -0.022102, 90.0173, 2)
        SetCamFov(ae, 36.97171)
        ShakeCam(ae, "HAND_SHAKE", 0.1)
        ax(ae, 7.2, 1.0, 0.5, 1.0)
        Wait(5000)
        at(false)
        SetCamActive(ae, true)
        af = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
        SetCamCoord(af, 412.0216, -997.9448, -98.8)
        SetCamRot(af, 0.865862, -0.01934, 91.04581, 2)
        SetCamFov(af, 35.2015)
        while DoesCamExist(ae) do
            if not IsCamInterpolating(ae) and not IsCamInterpolating(af) then
                RenderScriptCams(true, false, 3000, 1, 0, 0)
            end
            Wait(0)
        end
    end)
    Citizen.CreateThread(function()
        Wait(500)
        if IsScreenFadedOut() or IsScreenFadingOut() then
            DoScreenFadeIn(500)
        end
    end)

    Citizen.CreateThread(function()
        local ar = PlayerPedId()
        SetEntityCoords(a4)
        SetPlayerVisibleLocally(PlayerId(), false)
        FreezeEntityPosition(ar, true)
        RequestAnimDict(a7)
        RequestScriptAudioBank("DLC_GTAO/MUGSHOT_ROOM", false, -1)
        RequestScriptAudioBank("Mugshot_Character_Creator", false, -1)
        while not IsInteriorReady(a5) do Wait(1) end
        while not HasAnimDictLoaded(a7) do Wait(1) end
        AttachBoardToEntity(PlayerPedId(), "Nouveau personnage", math.random(10 * 1000000000, 10 * 1000000000), "LOS SANTOS POLICE DEPT", math.random(1, 99))
        SetEntityCoords(ar, a9)
        ClearPedWetness(ar)
        ClearPedBloodDamage(ar)
        ClearPlayerWantedLevel(PlayerId())
        SetCurrentPedWeapon(ar, GetHashKey("weapon_unarmed"), 1)
        FreezeEntityPosition(ar, false)
        ClearPedTasksImmediately(ar)
        controldisable = false
        SetEntityCoords(GetPlayerPed(-1), 409.36, -1000.83, -100.00)
        SetEntityHeading(GetPlayerPed(-1), 350)
        startAnim("mp_character_creation@lineup@male_a", "intro")
        Wait(6200)
        ClearPedTasksImmediately(ar)
        SetEntityCoords(GetPlayerPed(-1), 408.87, -997.88, -100.00)
        SetEntityHeading(GetPlayerPed(-1), 268.72219848633)
        startAnim("mp_character_creation@lineup@male_a", "outro")
        if RequestScriptAudioBank("DLC_GTAO/MUGSHOT_ROOM", false, -1) then
            PlaySoundFrontend(-1, "Lights_On", "GTAO_MUGSHOT_ROOM_SOUNDS", true)
        end
        PlaySound(-1, "Zoom_In", "MUGSHOT_CHARACTER_CREATION_SOUNDS", 0, 0, 1)
        if DoesCamExist(af) then
            StopCamShaking(af)
            SetCamActiveWithInterp(af, ae, 300, 1, 1)
        end
        Wait(4650)
        av()
        Wait(1500)
        at(false)
        SetCamActiveWithInterp(ae, af, 300, 1, 1)
        PlaySound(-1, "Zoom_Out", "MUGSHOT_CHARACTER_CREATION_SOUNDS", 0, 0, 1)
        Wait(2555)
        ak()
        DoScreenFadeOut(2500)
        Wait(2500)
        cutsceneavion()
        RenderScriptCams(false, false, 0, false, false)
        Wait(2500)
        DoScreenFadeIn(2500)
    end)

    Citizen.CreateThread(function()
        ad = _("digital_camera")
        T = CreateNamedRenderTargetForModel("ID_Text", ac)
        a0(ad, 'OPEN_SHUTTER', 250)
        while T do
            SetTextRenderId(T)
            Set_2dLayer(4)
            Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
            DrawScaleformMovie(aa, 0.405, 0.37, 0.81, 0.74, 255, 255, 255, 255,
                               0)
            Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
            SetTextRenderId(GetDefaultScriptRendertargetRenderId())
            Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
            DrawScaleformMovieFullscreen(ad, 255, 255, 255, 255, 0)
            Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
            Wait(0)
        end
    end)
end)

function AnimationIntro()
    FreezeEntityPosition(PlayerPedId(), false)
    AttachBoardToEntity(PlayerPedId(), "Nouveau personnage", math.random(10 * 1000000000, 10 * 1000000000), "LOS SANTOS POLICE DEPT", math.random(1, 99))
    RequestAnimDict("mp_character_creation@customise@male_a")
    Citizen.Wait(100)
    TaskPlayAnim(PlayerPedId(), "mp_character_creation@customise@male_a", "intro", 8.0, -8.0, -1, 0, 0.0, false, false, false)
    Citizen.Wait(4685)
    TaskPlayAnim(GetPlayerPed(-1), "mp_character_creation@customise@male_a", "loop", 1.0, -1.0,-1, 2, 0, 0, 0,0)
    Citizen.Wait(2250)
end

RegisterNetEvent('spawnhandler:CharacterCreator')
AddEventHandler('spawnhandler:CharacterCreator', function()
    Citizen.CreateThread(function()
        TriggerEvent("localInstance", "login")
        controldisable = true
        FreezeEntityPosition(PlayerPedId(), false)
        SetEntityCoords(GetPlayerPed(-1), 399.9, -998.7, -100.0)
        DoScreenFadeOut(1000)
        Wait(1000)
        DisplayRadar(false)
        SetEntityCoords(GetPlayerPed(-1), 406.03, -997.09, -100.00)
        SetEntityHeading(GetPlayerPed(-1), 93.19)
        Citizen.Wait(500)
        AnimationIntro()
        Citizen.Wait(1500)
        FreezeEntityPosition(PlayerId(), true)
        ClearPlayerWantedLevel(PlayerId())
        RemoveLoadingPrompt()
        local aD = GetInteriorAtCoordsWithType(vector3(399.9, -998.7, -100.0), "v_mugshot")
        LoadInterior(aD)
        SetOverrideWeather("EXTRASUNNY")
        SetWeatherTypePersist("EXTRASUNNY")
        while not IsInteriorReady(aD) do Citizen.Wait(0) end
    end)
    DoScreenFadeIn(1000)
    CreatorLoadContent()
end)

function CreateText(text, font, rgba, scale, x, y)
    SetTextFont(font)
    SetTextScale(0.0, scale)
    SetTextColour(rgba[1], rgba[2], rgba[3], rgba[4])
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function startAnim(lib, anim)
    ESX.Streaming.RequestAnimDict(lib, function()
        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
    end)
end

function NiceSpawn()

    local player = GetPlayerPed(-1)
    local xPlayer = GetPlayerServerId(player)

    TriggerEvent("localInstance", "login")
    TriggerServerEvent("Pasdesave")
    SetPlayerInvincible(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(),-811.71, 175.18, 76.74, 0.0, 0.0, 0.0, true)
    SetEntityHeading(PlayerPedId(), 108.38)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, -813.91, 174.02, 76.74 )
	SetCamRot(cam, 5.0, 0.0, 294.160)
    SetCamFov(cam, 30.0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    DisplayRadar(false)
    PrepareMusicEvent("FM_INTRO_START")
        while true do
            Citizen.Wait(1)
                TriggerMusicEvent("FM_INTRO_START")
                startAnim("amb@world_human_hang_out_street@male_c@idle_a", "idle_b")
                DrawNiceText(.5, .1, 1.0, "Appuyez sur ~b~ENTRER~w~ pour valider votre entrée.", 4, 0)
                Controls = true
                if IsControlJustPressed(1, 18) then
                    DoScreenFadeOut(1000)
                    Citizen.Wait(1000)
                    DestroyCam(Camera)
                    ClearFocus()    
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent("getgps")
                    TriggerServerEvent("ouilasave")
                    ESX.TriggerServerCallback('GetEntityPosition', function()end)
                    RenderScriptCams(0, 0, 3000, 1, 1, 0)
                    SetPlayerInvincible(PlayerPedId(), false)
                    Wait(2000)
                    DoScreenFadeIn(2000)
                    Wait(1000)
                    Controls = false
                    TriggerEvent("exitInstance")
                    ESX.ShowNotification("Vous avez été ~b~replacé~s~ à votre dernière ~b~position~s~")
                    PrepareMusicEvent("FM_SUDDEN_DEATH_STOP_MUSIC")
                    TriggerMusicEvent("FM_SUDDEN_DEATH_STOP_MUSIC")
                    Wait(20)
            return
        end
    end
end

RegisterNetEvent('GetEntityPosition')
AddEventHandler('GetEntityPosition', function(position, vie)
    if position then
        pos = position
    end
    SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, true)
    Wait(500)
end)

function DrawNiceText(x, y, sc, text, font, ap, wp)
    SetTextFont(font)
    SetTextScale(sc, sc)
    SetTextColour(255, 255, 255, 255)
    SetTextJustification(ap or 1)
    SetTextEntry("STRING")
    if wp then
        SetTextWrap(x, x + .1)
    end
    AddTextComponentString(text)
    DrawText(x, y)
end