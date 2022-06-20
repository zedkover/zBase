ESX = nil

f6immo = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Dynasty 8", world = true},
    Data = { currentMenu = "Action", GetPlayerName() },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if zedkover.name == "Effectuer une annonce" then 
                local result = KeyboardInput('', '', 255)
                if result ~= nil then 
                    TriggerServerEvent('zedkover:annonceimmo', result)
                end
            elseif zedkover.name == "Gestion Clients" then
                CloseMenu()
                ExecuteCommand('propertyclients')
            elseif zedkover.name == "Créer une propriété" then
                CloseMenu()
                ExecuteCommand('propertycreator')
            elseif zedkover.name == "Effectuer une facture" then 
                CreateFacture("society_realestateagent")
            end
        end,
    },
    Menu = {
        ["Action"] = {
            b = {
                {name = "Effectuer une annonce", ask = ">", askX = true},
                {name = "Effectuer une facture", ask = ">", askX = true},
                {name = "Créer une propriété", ask = ">", askX = true},
                {name = "Gestion Clients", ask = ">", askX = true},
            }
        }
    }
}

RegisterKeyMapping('immo', 'Menu Agent Immobilier', 'keyboard', 'F6')

RegisterCommand('immo', function()
    if ESX.GetPlayerData().job.name == "realestateagent" then 
        CreateMenu(f6immo)
    end    
end)