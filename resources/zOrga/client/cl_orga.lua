Orga = {}
Orga.TblGrades = {
    { name = "Chef", ask = "1", askX = true }
}

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

Orga.Name = {}
Orga.Data = {}
Orga.Perms = {}
Orga.PlyData = nil
Orga.RanksData = nil
Orga.PlayerOrga = nil
Orga.PlayerOrgaId = nil

function Orga:GetOrgaFromPlayer()
    ESX.TriggerServerCallback("zOrga:getPlyOrga", function(result)
        if not result then 
            Orga.Name = nil 
            Orga.PlayerOrga = nil
            Orga.PlayerOrgaId = nil
        else
            Orga.Name = result.name
            Orga.PlayerOrga = result.name
            Orga.PlayerOrgaId = result.id
        end
    end)
    Wait(250)

    return Orga.Name
end

function Orga:GetPerms()
    if not Orga:GetOrgaFromPlayer() then return end
    if Orga.RanksData then Orga.RanksData = nil end

    Orga.PlyData = Orga:GetOrgaFromPlayerData()
    while not Orga.PlyData do 
        Wait(50)
    end

    ESX.TriggerServerCallback("zOrga:getOrgaRanks", function(cb)
        Orga.RanksData = cb
    end, Orga.PlyData.id_grade)
    while not Orga.RanksData do
        Wait(50)
    end

    local v = Orga.RanksData
    Orga.Perms = {
        recruit = ConvertToBool(v.recruit),
        fire = ConvertToBool(v.fire),
        attribute_property = ConvertToBool(v.attribute_property),
        give_access_property = ConvertToBool(v.give_access_property),
        access_property = ConvertToBool(v.access_property),
        see_chest = ConvertToBool(v.see_chest),
        deposit = ConvertToBool(v.deposit),
        remove = ConvertToBool(v.remove),
        access_garage = ConvertToBool(v.access_garage),
        take_car = ConvertToBool(v.take_car),
        park_car = ConvertToBool(v.park_car)
    }  
end

function Orga:GetOrgaFromPlayerData()
    ESX.TriggerServerCallback("zOrga:getPlyOrgaData", function(result)
        if not result then Orga.Data = {} end 
        Orga.Data = result
    end)
    Wait(250)
    
    return Orga.Data
end

function ConvertToBool(number)
    local number = tonumber(number)
    if number == 1 then return true else return false end
end

function ConvertToNum(bool)
    if bool then return 1 else return 0 end
end

-- Fonctions globales
function Orga:GetData()
    ESX.TriggerServerCallback("zOrga:getOrgaData", function(result)
        if not result then Orga.Data = {} end 
        Orga.Data = result
    end, Orga:GetOrgaFromPlayer())
    Wait(250)
    
    return Orga.Data
end

function Orga:GetPlyList()
    ESX.TriggerServerCallback("zOrga:getOrgaPlyList", function(result)
        if not result then Orga.PlyList = {} end
        Orga.PlyList = result
    end, Orga:GetOrgaFromPlayer())
    Wait(250)

    return Orga.PlyList
end

-- Fonctions de menus
Orga.Menus = {}
Menus = {}

-- R??cup??ration des infos de l'organisation via l'identifier
local function GetOrgaInfos()
    Orga.PlyData = Orga:GetOrgaFromPlayerData()
    local tblInfos = {}
    while not Orga.PlyData do 
        Wait(50)
    end

    -- On insert des valeures
    tblInfos = {
        { name = "Nom : ", ask = Orga:GetOrgaFromPlayer(), askX = Orga.PlyData.rang ~= 1 },
        { name = "Devise : ", Description = Orga.PlyData.devise },
    }

    -- Si le joueur est le chef
    if Orga.PlyData.rang == 1 then
        tblInfos[#tblInfos+1] = { name = "~r~Supprimer l'organisation" }
    end

    -- On retourne la table apr??s les modifications
    return tblInfos
end

-- R??cup??ration de la liste des joueurs
local function GetPlyList()
    Orga.Data = Orga:GetPlyList()
    local tblMembres = {}
    while not Orga.Data do
        Wait(50)
    end

    -- Insertions des membres dans la table
    if Orga.Perms.recruit then
        tblMembres[#tblMembres+1] = { name = "~b~Recruter quelqu'un" }
    end

    for k, v in pairs(Orga.Data) do
        tblMembres[#tblMembres+1] = { name = v.label, identifier = v.identifier, ask = v.name, askX = true }
    end

    -- On retourne la table apr??s les modificiations
    return tblMembres
end

-- R??cup??ration de la liste des rangs
local function GetRanks()
    -- On r??cup??re les infos de l'organisation
    Orga.Data = Orga:GetData()
    local tblRangs = {}
    while not Orga.Data do
        Wait(50)
    end

    local desc = Orga.EditRank and "Appuyez sur ~b~ENTRER ~s~pour attribuer ce grade au joueur" or "Appuyez sur ~b~ENTRER ~s~pour modifier le grade"

    -- Insertions des rangs dans la table
    for k, v in pairs(Orga.Data) do
        tblRangs[#tblRangs+1] = { name = v.name, ask = v.rang, askX = true, id_grade = v.id_grade, Description = desc }
    end

    -- On retourne la table apr??s les modifications
    return tblRangs    
end

local function GetPermsRank()
    local tblPerm = {}
    if Orga.RanksData then Orga.RanksData = nil end
    ESX.TriggerServerCallback("zOrga:getOrgaRanks", function(cb)
        Orga.RanksData = cb
    end, Orga.SelectedGrade)

    while not Orga.RanksData do
        Wait(50)
    end

    local v = Orga.RanksData

    local tblPerm = {
        { name = "Grade selectionn?? : ~b~" .. Orga.SelectedGradeName, Description = "Appuyez sur ~b~ENTRER ~s~pour modifier le ~b~nom~s~ du grade.", action = "changeGradeName" },
        { name = "" },
        { name = "Recruter des membres",                        curPerm = 'recruit',                checkbox = ConvertToBool(v.recruit) },
        { name = "Virer des membres",                           curPerm = 'fire',                   checkbox = ConvertToBool(v.fire) },
        { name = "Attribuer une propri??t?? ?? l'organisation",    curPerm = 'attribute_property',     checkbox = ConvertToBool(v.attribute_property) },
        { name = "Donner l'acc??s ?? une propri??t??",              curPerm = 'give_access_property',   checkbox = ConvertToBool(v.give_access_property) },
        { name = "Acc??der aux propri??t??s",                      curPerm = 'access_property',        checkbox = ConvertToBool(v.access_property) },
        { name = "Acc??s au coffre",                              curPerm = 'see_chest',              checkbox = ConvertToBool(v.see_chest) },
        { name = "Acc??der aux garages",                         curPerm = 'access_garage',          checkbox = ConvertToBool(v.access_garage) },
        { name = "Prendre une voiture",                         curPerm = 'take_car',               checkbox = ConvertToBool(v.take_car) },
        { name = "Ranger une voiture",                          curPerm = 'park_car',               checkbox = ConvertToBool(v.park_car) }
    }

    return tblPerm
end

-- Ouverture du menu quand on selectionne un joueur
local function SelectPlayer()
    -- On v??rifie si un joueur est bien selectionn??
    if not Orga.SelectedPlayer then ESX.ShowNotification("~r~Erreur\n~s~Joueur introuv??, veuillez r????ssayer.") return {} end

    -- valeurs locales
    Orga.PlyData = Orga:GetOrgaFromPlayerData()
    while not Orga.PlyData do
        Wait(50)
    end

    -- Insertions des rangs dans la table
    local tblGestionJ = {
        { name = "Modifier le rang" },
        { name = "Virer " .. Orga.SelectedPlayer.Name, action = "virer" }
    }

    if Orga.PlyData.rang == 1 then
        tblGestionJ[#tblGestionJ+1] = { name = "~r~Attribuer l'organisation" }
    end

    -- On retourne la table apr??s les modifications
    return tblGestionJ    
end

-- Menu cr??ation d'organisation
menuCreateOrga = {
    Base = { Title = "Cr??ation d'organisation", Header = {"commonmenu", "interaction_bgd"} },
    Data = { currentMenu = "Gestion organisation" },
    Events = {
        onSelected = function(self, menuData, btnData, currentSlt, allButtons)
            -- Valeurs
            local slide = btnData.slidenum
            local btn = btnData.name
            local result = GetOnscreenKeyboardResult()

            -- Gestion des boutons (onclick)
            if btn == "Nom de l'organisation" then
                -- On r??cup??re le r??sultat du ask
                if result == "" or result == " " then return end

                -- On sauvegarde la valeur dans une valeure globale
                Orga.Name = result
            elseif btn == "Devise" then
                -- On demande une entr??e de texte 
                AskEntry(function(msg)
                    if not msg then return end 

                    if string.sub(msg, string.len(msg), string.len(msg)) ~= "." then
                        -- Si la devise ne finit pas par un point, on en rajoute un
                        Orga.Devise = msg .. "."
                    else
                        Orga.Devise = msg
                    end

                    -- On change la descrption du currentButton
                    btnData.Description = Orga.Devise
                end, "Ins??rez votre ~b~devise~s~.")

            elseif btn == "~b~Ajouter un grade" then
                -- On demande une entr??e de texte
                AskEntry(function(msg)
                    if not msg then return end

                    -- On r??cup??re la derni??re ID
                    local newID = tonumber(Orga.TblGrades[#Orga.TblGrades].ask) + 1

                    -- On ajoute notre nouveau grade ?? la liste existante
                    Orga.TblGrades[#Orga.TblGrades+1] = { name = msg, ask = newID, askX = true }

                    -- On refresh le menu
                    CloseMenu(true)
                    CreateMenu(menuCreateOrga)
                    OpenMenu("grades")
                end, "Ins??rez le nom du nouveau ~b~grade~s~.")

            elseif btn == "~b~Valider" then
                -- On v??rifie si les valeurs sont bien rentr??es
                if not Orga.Name then return ESX.ShowNotification("~r~Aucun nom renseign??.") end 
                if not Orga.Devise then return ESX.ShowNotification("~r~Aucune devise renseign??e.") end

                -- On demande une entr??e de texte
                AskEntry(function(msg)
                    -- On demande au joueur de r????crire le nom de l'orga pour valider
                    if not msg or msg ~= Orga.Name then return ESX.ShowNotification("~r~Nom incorrect.") end 

                    -- On envoi les donn??es au serveur pour ins??rez dans la bdd
                    TriggerServerEvent("zOrga:saveCrew", Orga.Name, Orga.Devise, Orga.TblGrades)
                    CloseMenu(true)
                end, "Pour confirmer, ??crivez le nom de l'orga '~b~" .. Orga.Name .. "~s~'")
            end
        end,
    },
    Menu = {
        ["Gestion organisation"] = {
            -- Cr??ation des boutons du menu de cr??ation de grade
            b = {
                { name = "Nom de l'organisation", ask = "" },
                { name = "Devise", Description = "" },
                { name = "Grades", ask = ">", askX = true },
                { name = "~b~Valider" }
            }
        },
        ["grades"] = {
            -- Cr??ation des boutons du menu "Grades"
            b = function()
                -- On d??finit tblGrades2 pour y faire des modifications
                local tblGrades2 = {}
                tblGrades1 = json.encode(Orga.TblGrades)
                tblGrades2 = json.decode(tblGrades1)
                Wait(50)

                -- On ajoute un bouton apr??s la liste des grades
                tblGrades2[#tblGrades2+1] = { name = "~b~Ajouter un grade" }
                Wait(50)
                return tblGrades2
            end,
        }
    }
}

menuOrga = {
    Base = { Title = "Gestion d'organisation", Header = {"commonmenu", "interaction_bgd"} },
    Data = { currentMenu = "Gestion d'organisation" },
    Events = {
        onBack = function()
            if Orga.EditRank then Orga.EditRank = false end
        end,
        onOpened = function()
            if Orga.RanksData then Orga.RanksData = nil end

            Orga.PlyData = Orga:GetOrgaFromPlayerData()
            while not Orga.PlyData do 
                Wait(50)
            end

            ESX.TriggerServerCallback("zOrga:getOrgaRanks", function(cb)
                Orga.RanksData = cb
            end, Orga.PlyData.id_grade)
            while not Orga.RanksData do
                Wait(50)
            end
        
            local v = Orga.RanksData
            Orga.Perms = {
                recruit = ConvertToBool(v.recruit),
                fire = ConvertToBool(v.fire),
                attribute_property = ConvertToBool(v.attribute_property),
                give_access_property = ConvertToBool(v.give_access_property),
                access_property = ConvertToBool(v.access_property),
                see_chest = ConvertToBool(v.see_chest),
                deposit = ConvertToBool(v.deposit),
                remove = ConvertToBool(v.remove),
                access_garage = ConvertToBool(v.access_garage),
                take_car = ConvertToBool(v.take_car),
                park_car = ConvertToBool(v.park_car)
            }        
        end,
        onSelected = function(self, menuData, btnData, currentSlt, allButtons)
            local slide = btnData.slidenum
            local btn = btnData.name
            local result = GetOnscreenKeyboardResult()

            if self.Data.currentMenu == "liste des rangs" and Orga.PlyData.rang == 1 then
                if not Orga.EditRank then
                    Orga.SelectedGrade = btnData.id_grade
                    Orga.SelectedGradeName = btn
                    OpenMenu("Permissions du rang")
                else
                    TriggerServerEvent("zOrga:updatePlayerGrade", btnData.id_grade, btn, Orga.SelectedPlayer.Identifier, Orga.SelectedPlayer.Name)
                    CloseMenu(true)
                end
            end

            if self.Data.currentMenu == "Permissions du rang" then
                if btnData.curPerm then
                    TriggerServerEvent("zOrga:updatePerm", btnData.curPerm, Orga.SelectedGrade, ConvertToNum(btnData.checkbox))
                elseif btnData.action and btnData.action == "changeGradeName" then
                    AskEntry(function(msg)
                        if not msg or msg == "" then return ESX.ShowNotification("~r~Nom invalide") end

                        TriggerServerEvent("zOrga:updateGrade", Orga.SelectedGrade, msg)
                        btnData.name = "Grade selectionn?? : ~b~" .. msg
                        Orga.SelectedGradeName = msg
                    end, "Ins??rez le ~b~nouveau nom ~s~du grade.")
                end
            end

            if btn == "Nom : " and Orga.PlyData.rang == 1 then
                if not result or result == "" then return ESX.ShowNotification('~r~Nom invalide') end 

                TriggerServerEvent("zOrga:updateOrgaName", Orga:GetOrgaFromPlayer(), result)
            elseif btn == "Devise : " and Orga.PlyData.rang == 1 then
                AskEntry(function(msg)
                    if not msg or msg == "" then return ESX.ShowNotification("~r~Devise invalide") end

                    if string.sub(msg, string.len(msg), string.len(msg)) ~= "." then
                        -- Si la devise ne finit pas par un point, on en rajoute un
                        Orga.Devise = msg .. "."
                    else
                        Orga.Devise = msg
                    end

                    TriggerServerEvent("zOrga:updateOrgaDevise", Orga:GetOrgaFromPlayer(), Orga.Devise)
                    btnData.Description = Orga.Devise
                end, "Ins??rez la nouvelle ~b~devise~s~.")
            elseif btn == "~r~Supprimer l'organisation" then
                AskEntry(function(msg)
                    if not msg or msg == "" then return ESX.ShowNotification("~r~Message invalide") end
                    if not msg == Orga:GetOrgaFromPlayer() then return ESX.ShowNotification("~r~Message invalide") end

                    TriggerServerEvent("zOrga:deleteOrga", Orga:GetOrgaFromPlayer())
                    CloseMenu(true)
                end, "Tapez '~b~" .. Orga:GetOrgaFromPlayer() .. "~s~' pour confirmer.")
            elseif btn == "~b~Recruter quelqu'un" then
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer and closestPlayer ~= -1 and closestDistance <= 2.5 then 
                    TriggerServerEvent("zOrga:recruitPlayer", GetPlayerServerId(closestPlayer), Orga.PlyData.id_orga)
                else
                    ESX.ShowNotification("~r~Aucun joueur ?? proximit??.")
                end
            end

            if self.Data.currentMenu == "liste des membres" then
                if btn ~= "~b~Recruter quelqu'un" and Orga.PlyData.rang == 1 then
                    Orga.SelectedPlayer = { Identifier = btnData.identifier, Name = btnData.name }
                    OpenMenu("Gestion joueur")
                end
            end 
            if self.Data.currentMenu == "Gestion joueur" then
                if btn == "Modifier le rang" then
                    Orga.EditRank = true
                    OpenMenu("liste des rangs")
                elseif btnData.action and btnData.action == "virer" then
                    TriggerServerEvent("zOrga:firePlyOrga", Orga.SelectedPlayer.Identifier)
                    ESX.ShowNotification("~r~Vous avez vir?? " .. Orga.SelectedPlayer.Name .. ".")
                    CloseMenu(true)
                elseif btn == "~r~Attribuer l'organisation" then
                    -- On r??cup??re les infos de l'organisation
                    Orga.Data = Orga:GetData()
                    while not Orga.Data do
                        Wait(50)
                    end

                    -- On trigger l'event
                    TriggerServerEvent("zOrga:attributePlyOrga", Orga.SelectedPlayer.Identifier, Orga.Data[#Orga.Data])
                    ESX.ShowNotification("Vous avez attribu?? l'organisation ?? ~b~" .. Orga.SelectedPlayer.Name)
                    CloseMenu(true)
                end
            end
        end,
    },
    Menu = {
        ["Gestion d'organisation"] = {
            b = {
                { name = "Informations", ask = ">", askX = true },  
                { name = "Liste des membres", ask = ">", askX = true },
                { name = "Liste des rangs", ask = ">", askX = true }
            }
        },
        ["informations"] = {
            b = GetOrgaInfos
        },
        ["liste des membres"] = {
            b = GetPlyList
        },
        ["liste des rangs"] = {
            b = GetRanks
        },
        ["Gestion joueur"] = {
            b = SelectPlayer
        },
        ["Permissions du rang"] = {
            b = GetPermsRank
        }
    }
}

-- Commande ouverture menu
RegisterCommand("orga", function()
    if Orga:GetOrgaFromPlayer() then
        -- Si le joueur a une orga, on ouvre gestion d'orga
        menuOrga.Base.Title = Orga:GetOrgaFromPlayer()
        CreateMenu(menuOrga)
    else
        -- Sinon on ouvre la cr??ation d'orga
        CreateMenu(menuCreateOrga)
    end
end)

Citizen.CreateThread(function()
    Wait(10000)
    while true do 
        Orga:GetOrgaFromPlayer()
        Wait(5 * 60 * 1000)
    end 
end)