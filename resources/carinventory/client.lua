local GM = { State = { CinemaMode = 0 } }
local useMetric = GetConvarInt("sh_miles", 0) == 0

Citizen.CreateThread(function()
	local hudEnabled = false
	local PlayerPedId, GetVehiclePedIsIn, GetIsVehicleEngineRunning, SendNUIMessage, GetEntitySpeed, GetVehicleFuelLevel = PlayerPedId, GetVehiclePedIsIn, GetIsVehicleEngineRunning, SendNUIMessage, GetEntitySpeed, GetVehicleFuelLevel

	while true do
		local ped, waitTime = PlayerPedId(), 1000
		local veh = GetVehiclePedIsIn(ped)

		if veh ~= 0 and GetIsVehicleEngineRunning(veh) and GM.State.CinemaMode == 0 then
			hudEnabled = true
			waitTime = 100

			SendNUIMessage({
				showhud = hudEnabled,
				speed = math.ceil(GetEntitySpeed(veh) * (useMetric and 3.6 or 2.236936)),
				speedUnit = useMetric and "km/h" or "mph",
				fuel = GetVehicleFuelLevel(veh)
			})
		elseif hudEnabled then
			hudEnabled = false
			SendNUIMessage({ showhud = hudEnabled })
		end

		Citizen.Wait(waitTime)
	end
end)

AddEventHandler("pichot_data:varUpdated", function(varName, varValue, varOnValue)
	if not GM.State[varName] then return end

	if varOnValue then
		GM.State[varName] = GM.State[varName] or {}
		GM.State[varName][varOnValue] = varValue
	else
		GM.State[varName] = varValue
	end
end)