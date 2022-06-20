local PlayerData = {}
ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
    PlayerData = ESX.GetPlayerData() 
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job
	Citizen.Wait(5000)
end)

society = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Menu boss", world = true},
    Data = { currentMenu = "Boss", "Test" }, 
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            local player, distance = ESX.Game.GetClosestPlayer()
        if btn.name == "Employer" then
            grade() 
        elseif btn.name == "Action employer" then
            ActionE()
        end   

        if self.Data.currentMenu == "Employer" and btn.name ~= "Action employer" then 
            local result = KeyboardInput('Montant :', '', 10)
            ESX.TriggerServerCallback('esx_society:setJobSalary', function()
                Wait(50)
                grade() 
            end,  PlayerData.job.name, btn.value, result )
        
        end

        if btn.name == "Recruter" then 
            
            if distance ~= -1 and distance <= 3.0 then   
                print(PlayerData.job.name )
                TriggerServerEvent('zedkover:Boss_recruterplayer', GetPlayerServerId(player), PlayerData.job.name, 0)   
            end  
        elseif btn.name == "Virer" then  
            if distance ~= -1 and distance <= 3.0 then   
                print(PlayerData.job.name )
                TriggerServerEvent('zedkover:Boss_virerplayer', GetPlayerServerId(player))   
            end   
        elseif btn.name == "Promouvoir" then
            if distance ~= -1 and distance <= 3.0 then   
            print(PlayerData.job.grade )
            TriggerServerEvent('zedkover:Boss_promouvoirplayer', GetPlayerServerId(player)) 
            end
        elseif btn.name == "Destituer" then 
            if distance ~= -1 and distance <= 3.0 then   
            print(PlayerData.job.grade )
            TriggerServerEvent('zedkover:Boss_destituerplayer', GetPlayerServerId(player))
            end
        end 
 
        if self.Data.currentMenu == "Boss" and btn.name == "Argent" then 
            if btn.slidenum == 1 then 
                local result = KeyboardInput('Montant :', '', 10)
                    if result ~= nil then
                        TriggerServerEvent("zSociety:Dépot", PlayerData.job.name, result)
                        CloseMenu(true)
                    Wait(50)
                open() 
                end
            end 
            if btn.slidenum == 2 then 
                local result = KeyboardInput('Montant :', '', 10)
                if result ~= nil then
                TriggerServerEvent("zSociety:withdraw", PlayerData.job.name, result) 
                CloseMenu(true)
                Wait(50)
                open() 
                end 
            end
        end

    end, 
}, 
    Menu = {
        ["Boss"] = {
            b = {
            }
        }, 
        ["Employer"] = {
            b = {
            }
        }, 
        ["Action employer"] = {
            b = { 
            }
        }, 
	}
}  


function grade()
    society.Menu["Employer"].b = {} 
    table.insert(society.Menu["Employer"].b, {name = "Action employer", ask = ">", askX = true})    
    ESX.TriggerServerCallback('esx_society:getJob', function(job) 
        for i=1, #job.grades, 1 do
            local gradeLabel = (job.grades[i].label == '' and job.label or job.grades[i].label)
            table.insert(society.Menu["Employer"].b, {name = gradeLabel, price = ESX.Math.GroupDigits(job.grades[i].salary), value = job.grades[i].grade})    
        end 
        OpenMenu("Employer")
    end, PlayerData.job.name)
end

function ActionE()
    society.Menu["Action employer"].b = {} 
    table.insert(society.Menu["Action employer"].b, { name = "Recruter", ask = ">", askX = true})  
    table.insert(society.Menu["Action employer"].b, { name = "Virer", ask = ">", askX = true})  
    table.insert(society.Menu["Action employer"].b, { name = "Promouvoir", ask = ">", askX = true})  
    table.insert(society.Menu["Action employer"].b, { name = "Destituer", ask = ">", askX = true})  
    OpenMenu("Action employer")  
end

RegisterCommand('boss', function(source)
    if PlayerData.job.grade_name == "boss" then  
        open() 
    end
end, false)   

function open() 
    society.Menu["Boss"].b = {} 
    ESX.TriggerServerCallback('zSociety:getsocietymoney', function(zSocety)
        for k, v in pairs(zSocety) do 
            if v.account_name == "society_"..PlayerData.job.name.."" then
            table.insert(society.Menu["Boss"].b, { name = "Societé ~b~"..PlayerData.job.name.."", price  = v.money})  
            table.insert(society.Menu["Boss"].b, { name = "Argent", slidemax  = {" Déposer", "Retirer"}, geld  = v.money})   
            table.insert(society.Menu["Boss"].b, { name = "Employer", ask = ">", askX = true})   
            end
        end
        CreateMenu(society) 
    end)  
end