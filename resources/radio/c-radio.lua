Keys = {}
Keys.Register = function(Controls, ControlName, Description, Action)
    local _Keys = {
        CONTROLS = Controls
    }
    RegisterKeyMapping(string.format('radio-%s', ControlName), Description, "keyboard", Controls)
    RegisterCommand(string.format('radio-%s', ControlName), function(source, args)
        if (Action ~= nil) then
            Action();
        end
    end, false)
    return setmetatable(_Keys, Keys)
end

KeyboardInputRadio = function (entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, "", inputText, "", "", "", maxLength)
	blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(10)
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

function AddLongString(txt)
	local maxLen = 100
	for i = 0, string.len(txt), maxLen do
		local sub = string.sub(txt, i, math.min(i + maxLen, string.len(txt)))
		AddTextComponentString(sub)
	end
end

function ShowAboveRadarMessage(message, back)
	if back then ThefeedNextPostBackgroundColor(back) end
	SetNotificationTextEntry("jamyfafi")
	AddLongString(message)
	return DrawNotification(0, 1)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DisableControlAction(0, 199, true) 
    end
end)

local radioOpen = false
local Radio = {}
local notifRadio
local currentFreq
local talkActive = true 
local currentVolume = 10
local radioActif = falsef
local actifNotif

function toggleRadio()
    if radioActif then
        radioOpen = not radioOpen
        SendNUIMessage({
            type = 'showradio',
            toggle = radioOpen
        })
        SetNuiFocus(radioOpen, radioOpen)
    else
        ShowAboveRadarMessage('~r~Votre radio n\'est pas actif.')
    end
end

function closeRadio()
    radioOpen = false
    SendNUIMessage({
        type = 'showradio',
        toggle = false
    })
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
end

function drawCenterText(msg, time)
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(msg)
	DrawSubtitleTimed(time and math.ceil(time) or 0, true)
end

RegisterNetEvent('zRadio:setActive')
AddEventHandler('zRadio:setActive', function()
    radioActif = not radioActif
    if radioActif then
        actifNotif = ShowAboveRadarMessage('Vous avez ~b~activé~w~ votre radio.')
    else
        actifNotif = ShowAboveRadarMessage('Vous avez ~r~desactivé~w~ votre radio.')
    end
end)

function muteRadio()
    if radioActif then
        talkActive = not talkActive
        if talkActive then
            if toggleNotif then
                RemoveNotification(toggleNotif) 
            end
            SendNUIMessage({
                type = 'showMuteIcon',
                toggle = false
            })
            TriggerEvent('zRadio:talkRadio', true)
            toggleNotif = ShowAboveRadarMessage("Vous avez ~b~activé~s~ la radio.")
        else
            if toggleNotif then
                RemoveNotification(toggleNotif) 
            end
            SendNUIMessage({
                type = 'showMuteIcon',
                toggle = true
            })
            TriggerEvent('zRadio:talkRadio', false)
            toggleNotif = ShowAboveRadarMessage("Vous avez ~r~desactivé~s~ la radio.")
        end
    end
end

function Radio:Add(freq)
	exports["pma-voice"]:SetRadioChannel(freq)
end

function Radio:setActive(ac)
    exports["pma-voice"]:setTalkActive(ac)
end

function Radio:Remove()
	exports["pma-voice"]:SetRadioChannel(0)
end


Keys.Register('p', 'P', 'Ouvrir la Radio', function()
    toggleRadio()
end)

local toggleNotif
Keys.Register('k', 'k', 'Activer ou désactiver le mode muet.', function()
    if radioActif then
        talkActive = not talkActive
        if talkActive then
            if toggleNotif then
                RemoveNotification(toggleNotif) 
            end
            SendNUIMessage({
                type = 'showMuteIcon',
                toggle = false
            })
            TriggerEvent('zRadio:talkRadio', true)
            toggleNotif = ShowAboveRadarMessage("Vous avez ~b~activé~s~ la radio.")
        else
            if toggleNotif then
                RemoveNotification(toggleNotif) 
            end
            SendNUIMessage({
                type = 'showMuteIcon',
                toggle = true
            })
            TriggerEvent('zRadio:talkRadio', false)
            toggleNotif = ShowAboveRadarMessage("Vous avez ~r~desactivé~s~ la radio.")
        end
    end
end)

RegisterNetEvent('zRadio:setIndicatorMode')
AddEventHandler('zRadio:setIndicatorMode', function(mode)
    if mode == 0 then
        SendNUIMessage({
            type = 'hideIndicator'
        })
    else
        SendNUIMessage({
            type = 'indicatorMode',
            mode = mode
        })
    end
end)
 
RegisterNUICallback('requestFreq', function(data, cb)
    SetNuiFocus(false, false)
    local frequence = KeyboardInputRadio('Entrez la fréquence', 'Entrez la fréquence', '', 5)
    if frequence and frequence ~= '' then
        SendNUIMessage({
            type = 'setFrequence',
            data = frequence
        })
    end
    SetNuiFocus(true, true)
    cb('ok')
end)

RegisterNUICallback('closeRadio', function()
    closeRadio()
end)

RegisterNUICallback('enterFreq', function(data)
    if data.freq ~= '' then
        local freq = tonumber(data.freq)
        if notifRadio then
            RemoveNotification(notifRadio)
        end
        notifRadio = ShowAboveRadarMessage(string.format("Fréquence définie sur ~b~%sHz~w~ 📡", data.freq))
        ExecuteCommand('me active sa radio')
        exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
        SendNUIMessage({
            type = "showIconsRadioOn"
        })
        SendNUIMessage({
            type = 'showMuteIcon',
            toggle = true
        })
        Radio:Add(freq)
        currentFreq = freq
        talkActive = false
    else
        ShowAboveRadarMessage('~r~Vous devez d\'abord entrer une fréquence.')
    end
end)

RegisterNUICallback('muteRadio', function()
    muteRadio()
end)

RegisterNUICallback('offRadio', function()
    exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
    Radio:Remove()
    if notifRadio then
        RemoveNotification(notifRadio)
    end
    ShowAboveRadarMessage("Vous avez ~r~désactivé~s~ la radio.")
    talkActive = false
    currentFreq = nil
end)

RegisterNUICallback('volumeUp', function()
    if currentVolume < 10 then
        currentVolume = currentVolume + 1
        exports['pma-voice']:setRadioVolume(currentVolume /10)
    end
    drawCenterText("Volume de la radio à " .. currentVolume * 10 .. "%", 2000)
end)

RegisterNUICallback('volumeDown', function()
    if currentVolume > 0 then
        currentVolume = currentVolume - 1
        exports['pma-voice']:setRadioVolume(currentVolume / 10)
    end
    drawCenterText("Volume de la radio à " .. currentVolume * 10 .. "%", 2000)
end)