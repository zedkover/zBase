ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

local IsAlreadyDrunk = false
local DrunkLevel     = -1

function Drunk(level, start)

  Citizen.CreateThread(function()

    local playerPed = GetPlayerPed(-1)

    if start then
      DoScreenFadeOut(800)
      Wait(1000)
    end

    if level == 0 then

      RequestAnimSet("move_m@drunk@slightlydrunk")

      while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
        Citizen.Wait(0)
      end

      SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)

    elseif level == 1 then

      RequestAnimSet("move_m@drunk@moderatedrunk")

      while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
        Citizen.Wait(0)
      end

      SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)

    elseif level == 2 then

      RequestAnimSet("move_m@drunk@verydrunk")

      while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
        Citizen.Wait(0)
      end

      SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)

    end

    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedIsDrunk(playerPed, true)

    if start then
      DoScreenFadeIn(800)
    end

  end)

end

function Reality()

  Citizen.CreateThread(function()

    local playerPed = GetPlayerPed(-1)

    DoScreenFadeOut(800)
    Wait(1000)

    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)

    DoScreenFadeIn(800)

  end)

end

AddEventHandler('esx_status:loaded', function(status)

  TriggerEvent('esx_status:registerStatus', 'drunk', 0, '#8F15A5', 
    function(status)
      if status.val > 0 then
        return false
      else
        return false
      end
    end,
    function(status)
      status.remove(1500)
    end
  )

	Citizen.CreateThread(function()

		while true do

			Wait(1000)

			TriggerEvent('esx_status:getStatus', 'drunk', function(status)
				
				if status.val > 0 then
					
          local start = true

          if IsAlreadyDrunk then
            start = false
          end

          local level = 0

          if status.val <= 250000 then
            level = 0
          elseif status.val <= 500000 then
            level = 1
          else
            level = 2
          end

          if level ~= DrunkLevel then
            Drunk(level, start)
          end

          IsAlreadyDrunk = true
          DrunkLevel     = level
				end

				if status.val == 0 then
          
          if IsAlreadyDrunk then
            Reality()
          end

          IsAlreadyDrunk = false
          DrunkLevel     = -1

				end

			end)

		end

	end)

end)

RegisterNetEvent('esx_optionalneeds:onDrink')
AddEventHandler('esx_optionalneeds:onDrink', function()
  
  local playerPed = GetPlayerPed(-1)
  
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_DRINKING", 0, 1)
  Citizen.Wait(1000)
  ClearPedTasksImmediately(playerPed)

end)

--- Hud

local FirstJob = "Vide", "Vide", 0, 0, 0
local FirstJobGrade = "Vide", "Vide"
local Config = {
    JobsFont = 6, 
    JobsScale = 0.50,
}
CreateThread(function()
    while ESX == nil do Wait(2) TriggerEvent(Config.SharedObject, function(obj) ESX = obj end) end
    while not ESX.IsPlayerLoaded() do Wait(20) end
    ESX.PlayerData = ESX.GetPlayerData()
    FirstJob = ESX.PlayerData.job.label
    FirstJobGrade = ESX.PlayerData.job.grade_label
end)
RenderSprite = function(Dictionary, TextureName, X, Y, Width, Height, Heading, R, G, B, A)
    local X, Y, Width, Height = tonumber(X) or 0, tonumber(Y), (tonumber(Width) or 0) / 1920, (tonumber(Height) or 0) / 1080
    if not HasStreamedTextureDictLoaded(Dictionary) then
        RequestStreamedTextureDict(Dictionary, true)
    end
end
Texte = function(self) 
	SetTextFont(self.font) 
	SetTextProportional(0) 
	SetTextScale(self.scale, self.scale) 
    self.shadow = self.shadow or false
    if self.shadow then
	    SetTextDropShadow(0, 0, 0, 0, 100) 
	    SetTextEdge(1, 0, 0, 0, 100) 
    end
	SetTextEntry("STRING") 
	AddTextComponentString(self.message)
	DrawText(self.X, self.Y)
end
LoadThreading = function(loadHud)
    CreateThread(function()
        while loadHud ~= false do 
            Wait(1.0)
            if not IsPauseMenuActive() then
                RenderSprite("Hud", "job", 0.0500, 0.0100, 25, 25)
                Texte({message = "~b~Métier : ~s~"..FirstJob.. " - " ..FirstJobGrade, font = Config.JobsFont, scale = Config.JobsScale, shadow = Config.ActiveShadowOnJobs, X = 0.851, Y = 0.0770})
            end
        end
    end)
end
CreateThread(function() while FirstJob == nil and SecondJob == nil do Wait(2) end LoadThreading(true) end)
if Config.ActiveHudNotification == true then
    local enterInFunction = 0;
    local TimerActived = false;
    local addNewValue = 0
    createTimer = function(Callback)
        local TimerActived = false;
        TimerActived = true;
        local newTimerTime = tonumber(Config.TimerToMoneyNotification);
        enterInFunction = enterInFunction+1;
        while enterInFunction > 1 do
            Wait(1.0)
            Callback(true)
        end
        CreateThread(function()
            while newTimerTime > 0 do
                Wait(1000)
                if not IsPauseMenuActive() then
                    TimerActived = true;
                    newTimerTime = newTimerTime-1;
                end
            end
            if newTimerTime == 0 or newTimer < 1 then
                TimerActived = false;
                enterInFunction = 0;
                addNewValue = 0;
            end
        end)
        CreateThread(function()
            while TimerActived == true do
                Wait(1.0)
                if (Callback) then
                    Callback(false, addNewValue)
                end
            end
        end)
    end
RegisterNetEvent('Hud:newValueEnter')
AddEventHandler('Hud:newValueEnter', function(setting)
        ShowMoneyNotification({setting.add, setting.count})
    end)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	local data = xPlayer
	FirstJob = data.job.label
    FirstJobGrade = data.job.grade_label
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
   FirstJob = job.label
   FirstJobGrade = job.grade_label
end)
