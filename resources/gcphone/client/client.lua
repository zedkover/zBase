local KeyOpenClose = 32 -- G
local KeyTakeCall = 38 -- E
local menuIsOpen = false
local contacts = {}
local messages = {}
local myPhoneNumber = ''
local isDead = false
local USE_RTC = false
local useMouse = false
local ignoreFocus = false
local takePhoto = false
local hasFocus = false

local UseMumble = true
local UseTokovoip = false

local PhoneInCall = {}
local currentPlaySound = false
local soundDistanceMax = 4.0

-- Configuration
local KeyToucheCloseEvent = {
  { code = 172, event = 'ArrowUp' },
  { code = 173, event = 'ArrowDown' },
  { code = 174, event = 'ArrowLeft' },
  { code = 175, event = 'ArrowRight' },
  { code = 176, event = 'Enter' },
  { code = 177, event = 'Backspace' },
}

local GUI = {}
GUI.Time = 0

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)

-- esx_addons_gcphone
RegisterNetEvent('esx_addons_gcphone:call')
AddEventHandler('esx_addons_gcphone:call', function(data)
  local playerPed = GetPlayerPed(-1)
  local coords = GetEntityCoords(playerPed)
  local message = data.message
  local number = data.number
  if message == nil then
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 200)
    while (UpdateOnscreenKeyboard() == 0) do
      DisableAllControlActions(0);
      Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
      message = GetOnscreenKeyboardResult()
    end
  end
  if message ~= nil and message ~= "" then
    TriggerServerEvent('esx_addons_gcphone:startCall', number, message, {
      x = coords.x,
      y = coords.y,
      z = coords.z
    })
  end
end)

-- Check si le joueurs poséde un téléphone
-- Callback true or false
function hasPhone (cb)
  if (ESX == nil) then return cb(0) end
  ESX.TriggerServerCallback('gcphone:getItemAmount', function(qtty)
    cb(qtty > 0)
  end, 'phone')
end

function ShowNoPhoneWarning () 
  if (ESX == nil) then return end
  ESX.ShowNotification("Vous n'avez pas de ~r~téléphone~s~")
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if takePhoto ~= true then
      if menuIsOpen == true then
        for _, value in ipairs(KeyToucheCloseEvent) do
          if IsControlJustPressed(1, value.code) then
            SendNUIMessage({keyUp = value.event})
          end
        end
        if useMouse == true and hasFocus == ignoreFocus then
          local nuiFocus = not hasFocus
          SetNuiFocus(nuiFocus, nuiFocus)
          hasFocus = nuiFocus
        elseif useMouse == false and hasFocus == true then
          SetNuiFocus(false, false)
          hasFocus = false
        end
      else
        if hasFocus == true then
          SetNuiFocus(false, false)
          hasFocus = false
        end
      end
    end
  end
end)

RegisterKeyMapping('openphone', 'Ouvrir son téléphone', 'keyboard', 'Z')

local bind = true

RegisterCommand('openphone', function()
  if bind then
    hasPhone(function (hasPhone)
      if hasPhone == true then
        TooglePhone()
      else
        ShowNoPhoneWarning()
      end
    end)
  end
end)

-- Active ou Deactive une application (appName => config.json)
RegisterNetEvent('gcPhone:setEnableApp')
AddEventHandler('gcPhone:setEnableApp', function(appName, enable)
  SendNUIMessage({event = 'setEnableApp', appName = appName, enable = enable })
end)

-- Gestion des appels fixe
function startFixeCall (fixeNumber)
  local number = ''
  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 10)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
    number =  GetOnscreenKeyboardResult()
  end
  if number ~= '' then
    TriggerEvent('gcphone:autoCall', number, {
      useNumber = fixeNumber
    })
    PhonePlayCall(true)
  end
end

function TakeAppel (infoCall)
  TriggerEvent('gcphone:autoAcceptCall', infoCall)
end

RegisterNetEvent("gcPhone:notifyFixePhoneChange")
AddEventHandler("gcPhone:notifyFixePhoneChange", function(_PhoneInCall)
  PhoneInCall = _PhoneInCall
end)
 
Citizen.CreateThread(function ()
  local mod = 0
  while true do 
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local inRangeToActivePhone = false
    local inRangedist = 0
    for i, _ in pairs(PhoneInCall) do 
        local dist = GetDistanceBetweenCoords(
          PhoneInCall[i].coords.x, PhoneInCall[i].coords.y, PhoneInCall[i].coords.z,
          coords.x, coords.y, coords.z, 1)
        if (dist <= soundDistanceMax) then
          DrawMarker(1, PhoneInCall[i].coords.x, PhoneInCall[i].coords.y, PhoneInCall[i].coords.z,
              0,0,0, 0,0,0, 0.1,0.1,0.1, 0,255,0,255, 0,0,0,0,0,0,0)
          inRangeToActivePhone = true
          inRangedist = dist
          if (dist <= 1.5) then 
            SetTextComponentFormat('STRING')
            AddTextComponentString('~INPUT_PICKUP~ Décrocher')
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if IsControlJustPressed(1, KeyTakeCall) then
              PhonePlayCall(true)
              TakeAppel(PhoneInCall[i])
              PhoneInCall = {}
              StopSoundJS('ring2.ogg')
            end
          end
          break
        end
    end
    if inRangeToActivePhone == false then
      --showFixePhoneHelper(coords)
    end
    if inRangeToActivePhone == true and currentPlaySound == false then
      PlaySoundJS('ring2.ogg', 0.2 + (inRangedist - soundDistanceMax) / -soundDistanceMax * 0.8 )
      currentPlaySound = true
    elseif inRangeToActivePhone == true then
      mod = mod + 1
      if (mod == 15) then
        mod = 0
        SetSoundVolumeJS('ring2.ogg', 0.2 + (inRangedist - soundDistanceMax) / -soundDistanceMax * 0.8 )
      end
    elseif inRangeToActivePhone == false and currentPlaySound == true then
      currentPlaySound = false
      StopSoundJS('ring2.ogg')
    end
    Citizen.Wait(0)
  end
end)

function PlaySoundJS (sound, volume)
  SendNUIMessage({event = 'playSound', sound = sound, volume = volume})
end

function SetSoundVolumeJS (sound, volume)
  SendNUIMessage({event = 'setSoundVolume', sound = sound, volume = volume})
end

function StopSoundJS (sound)
  SendNUIMessage({event = 'stopSound', sound = sound})
end

RegisterNetEvent('gcPhone:forceOpenPhone')
AddEventHandler('gcPhone:forceOpenPhone', function(_myPhoneNumber)
  if menuIsOpen == false then
    TooglePhone()
  end
end)
 
-- Events
RegisterNetEvent('gcPhone:myPhoneNumber')
AddEventHandler('gcPhone:myPhoneNumber', function(_myPhoneNumber)
  myPhoneNumber = _myPhoneNumber
  SendNUIMessage({event = 'updateMyPhoneNumber', myPhoneNumber = myPhoneNumber})
end)

RegisterNetEvent('gcPhone:contactList')
AddEventHandler('gcPhone:contactList', function(_contacts)
  SendNUIMessage({event = 'updateContacts', contacts = _contacts})
  contacts = _contacts
end)

RegisterNetEvent('gcPhone:allMessage')
AddEventHandler('gcPhone:allMessage', function(allmessages)
  SendNUIMessage({event = 'updateMessages', messages = allmessages})
  messages = allmessages
end)

RegisterNetEvent('gcPhone:getBourse')
AddEventHandler('gcPhone:getBourse', function(bourse)
  SendNUIMessage({event = 'updateBourse', bourse = bourse})
end)

RegisterNetEvent('gcPhone:receiveMessage')
AddEventHandler('gcPhone:receiveMessage', function(message)
  SendNUIMessage({event = 'newMessage', message = message})
  table.insert(messages, message)
  if message.owner == 0 then
    DrawNotification(false, false)
    PlaySound(-1, 'Menu_Accept', 'Phone_SoundSet_Default', 0, 0, 1)
    Citizen.Wait(300)
    PlaySound(-1, 'Menu_Accept', 'Phone_SoundSet_Default', 0, 0, 1)
    Citizen.Wait(300)
    PlaySound(-1, 'Menu_Accept', 'Phone_SoundSet_Default', 0, 0, 1)
  end
end)


-- Function client | Contacts
function addContact(display, num) 
    TriggerServerEvent('gcPhone:addContact', display, num)
end

function deleteContact(num) 
    TriggerServerEvent('gcPhone:deleteContact', num)
end

-- Function client | Messages
function sendMessage(num, message)
  TriggerServerEvent('gcPhone:sendMessage', num, message)
end

function deleteMessage(msgId)
  TriggerServerEvent('gcPhone:deleteMessage', msgId)
  for k, v in ipairs(messages) do 
    if v.id == msgId then
      table.remove(messages, k)
      SendNUIMessage({event = 'updateMessages', messages = messages})
      return
    end
  end
end

function deleteMessageContact(num)
  TriggerServerEvent('gcPhone:deleteMessageNumber', num)
end

function deleteAllMessage()
  TriggerServerEvent('gcPhone:deleteAllMessage')
end

function setReadMessageNumber(num)
  TriggerServerEvent('gcPhone:setReadMessageNumber', num)
  for k, v in ipairs(messages) do 
    if v.transmitter == num then
      v.isRead = 1
    end
  end
end

function requestAllMessages()
  TriggerServerEvent('gcPhone:requestAllMessages')
end

function requestAllContact()
  TriggerServerEvent('gcPhone:requestAllContact')
end

-- Function client | Appels
local aminCall = false
local inCall = false

RegisterNetEvent('gcPhone:waitingCall')
AddEventHandler('gcPhone:waitingCall', function(infoCall, initiator)
  SendNUIMessage({event = 'waitingCall', infoCall = infoCall, initiator = initiator})
  if initiator == true then
    PhonePlayCall()
    if menuIsOpen == false then
      TooglePhone()
    end
  end
end)

RegisterNetEvent('gcPhone:acceptCall')
AddEventHandler('gcPhone:acceptCall', function(infoCall, initiator)
  if inCall == false and USE_RTC == false then
    inCall = true
      if UseMumble then 
          exports["pma-voice"]:SetCallChannel(infoCall.id + 1)
      elseif UseTokovoip then 
        exports.tokovoip_script:addPlayerToCall(infoCall.id + 1)
        TokoVoipID = infoCall.id + 120
      end
  end
  if menuIsOpen == false then 
    if UseMumble then 
      exports["pma-voice"]:removePlayerFromCall()
    else
      
    end
    TooglePhone()
  end
  PhonePlayCall()
  SendNUIMessage({event = 'acceptCall', infoCall = infoCall, initiator = initiator})
end)

RegisterNetEvent('gcPhone:rejectCall')
AddEventHandler('gcPhone:rejectCall', function(infoCall)
  if inCall == true then
    inCall = false
    if UseMumble then 
        exports["pma-voice"]:removePlayerFromCall()
        exports["pma-voice"]:SetCallChannel(0)
    elseif UseTokovoip then 
      Citizen.InvokeNative(0xE036A705F989E049)
      exports.tokovoip_script:removePlayerFromCall(TokoVoipID)
      TokoVoipID = nil
    end
  end

  if UseMumble then 
    exports["pma-voice"]:removePlayerFromCall()
  else

  end
  PhonePlayText()
  SendNUIMessage({event = 'rejectCall', infoCall = infoCall})
end)

RegisterNetEvent('gcPhone:historiqueCall')
AddEventHandler('gcPhone:historiqueCall', function(historique)
  SendNUIMessage({event = 'historiqueCall', historique = historique})
end)

function startCall (phone_number, rtcOffer, extraData)
  TriggerServerEvent('gcPhone:startCall', phone_number, rtcOffer, extraData)
end

function acceptCall (infoCall, rtcAnswer)
  TriggerServerEvent('gcPhone:acceptCall', infoCall, rtcAnswer)
end

function rejectCall(infoCall)
    if UseMumble then 
      exports["pma-voice"]:removePlayerFromCall()
    else

    end
  TriggerServerEvent('gcPhone:rejectCall', infoCall)
end

function ignoreCall(infoCall)
    if UseMumble then 
      exports["pma-voice"]:removePlayerFromCall()
    else

    end
  TriggerServerEvent('gcPhone:ignoreCall', infoCall)
end

function requestHistoriqueCall() 
  TriggerServerEvent('gcPhone:getHistoriqueCall')
end

function appelsDeleteHistorique (num)
  TriggerServerEvent('gcPhone:appelsDeleteHistorique', num)
end

function appelsDeleteAllHistorique ()
  TriggerServerEvent('gcPhone:appelsDeleteAllHistorique')
end
  
-- Event NUI - Appels
RegisterNUICallback('startCall', function (data, cb)
  startCall(data.numero, data.rtcOffer, data.extraData)
  cb()
end)

RegisterNUICallback('acceptCall', function (data, cb)
  acceptCall(data.infoCall, data.rtcAnswer)
  cb()
end)

RegisterNUICallback('rejectCall', function (data, cb)
    if UseMumble then 
      exports["pma-voice"]:removePlayerFromCall()
    else

    end
  rejectCall(data.infoCall)
  cb()
end)

RegisterNUICallback('ignoreCall', function (data, cb)
    if UseMumble then 
      exports["pma-voice"]:removePlayerFromCall()
    else

    end
  ignoreCall(data.infoCall)
  cb()
end)

RegisterNUICallback('notififyUseRTC', function (use, cb)
  USE_RTC = use
  if USE_RTC == true and inCall == true then
    inCall = false
    if UseMumble then 
      Citizen.InvokeNative(0xE036A705F989E049)
      exports["pma-voice"]:SetCallChannel(infoCall.id + 1)
    elseif UseTokovoip then 
      Citizen.InvokeNative(0xE036A705F989E049)
      exports.tokovoip_script:removePlayerFromCall(TokoVoipID)
      TokoVoipID = nil
    end
  end
  cb()
end)

RegisterNUICallback('onCandidates', function (data, cb)
  TriggerServerEvent('gcPhone:candidates', data.id, data.candidates)
  cb()
end)

RegisterNetEvent('gcPhone:candidates')
AddEventHandler('gcPhone:candidates', function(candidates)
  SendNUIMessage({event = 'candidatesAvailable', candidates = candidates})
end)

RegisterNetEvent('gcphone:autoCall')
AddEventHandler('gcphone:autoCall', function(number, extraData)
  if number ~= nil then
    SendNUIMessage({event = "autoStartCall", number = number, extraData = extraData})
  end
end)

RegisterNetEvent('gcphone:autoCallNumber')
AddEventHandler('gcphone:autoCallNumber', function(data)
  TriggerEvent('gcphone:autoCall', data.number)
end)

RegisterNetEvent('gcphone:autoAcceptCall')
AddEventHandler('gcphone:autoAcceptCall', function(infoCall)
  SendNUIMessage({event = "autoAcceptCall", infoCall = infoCall})
end)

-- Gestion des evenements NUI
RegisterNUICallback('log', function(data, cb)
  print(data)
  cb()
end)

RegisterNUICallback('focus', function(data, cb)
  cb()
end)

RegisterNUICallback('blur', function(data, cb)
  cb()
end)

RegisterNUICallback('reponseText', function(data, cb)
  local limit = data.limit or 255
  local text = data.text or ''
  
  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", text, "", "", "", limit)
  while (UpdateOnscreenKeyboard() == 0) do
      DisableAllControlActions(0);
      Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
      text = GetOnscreenKeyboardResult()
  end
  cb(json.encode({text = text}))
end)

-- Event - Messages
RegisterNUICallback('getMessages', function(data, cb)
  cb(json.encode(messages))
end)

RegisterNUICallback('sendMessage', function(data, cb)
  if data.message == '%pos%' then
    local myPos = GetEntityCoords(PlayerPedId())
    data.message = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
  end
  TriggerServerEvent('gcPhone:sendMessage', data.phoneNumber, data.message)
end)

RegisterNUICallback('deleteMessage', function(data, cb)
  deleteMessage(data.id)
  cb()
end)

RegisterNUICallback('deleteMessageNumber', function (data, cb)
  deleteMessageContact(data.number)
  cb()
end)

RegisterNUICallback('deleteAllMessage', function (data, cb)
  deleteAllMessage()
  cb()
end)

RegisterNUICallback('setReadMessageNumber', function (data, cb)
  setReadMessageNumber(data.number)
  cb()
end)

-- Event - Contacts
RegisterNUICallback('addContact', function(data, cb) 
  TriggerServerEvent('gcPhone:addContact', data.display, data.phoneNumber)
end)

RegisterNUICallback('updateContact', function(data, cb)
  TriggerServerEvent('gcPhone:updateContact', data.id, data.display, data.phoneNumber)
end)

RegisterNUICallback('deleteContact', function(data, cb)
  TriggerServerEvent('gcPhone:deleteContact', data.id)
end)

RegisterNUICallback('getContacts', function(data, cb)
  cb(json.encode(contacts))
end)

RegisterNUICallback('setGPS', function(data, cb)
  SetNewWaypoint(tonumber(data.x), tonumber(data.y))
  cb()
end)

-- Add security for event (leuit#0100)
RegisterNUICallback('callEvent', function(data, cb)
  local eventName = data.eventName or ''
  if string.match(eventName, 'gcphone') then
    if data.data ~= nil then 
      TriggerEvent(data.eventName, data.data)
    else
      TriggerEvent(data.eventName)
    end
  else
    print('Event not allowed')
  end
  cb()
end)

RegisterNUICallback('useMouse', function(um, cb)
  useMouse = um
end)

RegisterNUICallback('deleteALL', function(data, cb)
  TriggerServerEvent('gcPhone:deleteALL')
  cb()
end)

function TooglePhone() 
  menuIsOpen = not menuIsOpen
  SendNUIMessage({show = menuIsOpen})
  if menuIsOpen == true then 
    PhonePlayIn()
  else
    PhonePlayOut()
  end
end

RegisterNetEvent("phone:blockcontrols")
AddEventHandler("phone:blockcontrols",function(state)
  if state then
    stateOpen = false
  else
    stateOpen = true
  end

  while stateOpen do 
      Wait(0)
      DisableControlAction(0, 0, true)
      DisableControlAction(0, 1, true)
      DisableControlAction(0, 2, true)
      DisableControlAction(0, 6, true)
      DisableControlAction(0, 288, true)
      DisableControlAction(0, 318, true)
      DisableControlAction(0, 168, true)
      DisableControlAction(0, 327, true)
      DisableControlAction(0, 166, true)
      DisableControlAction(0, 289, true)
      DisableControlAction(0, 305, true)
      DisableControlAction(0, 331, true)
      DisableControlAction(0, 330, true)
      DisableControlAction(0, 329, true)
      DisableControlAction(0, 132, true)
      DisableControlAction(0, 246, true)
      DisableControlAction(0, 36, true)
      DisableControlAction(0, 18, true)
      DisableControlAction(0, 106, true)
      DisableControlAction(0, 122, true)
      DisableControlAction(0, 135, true)
      DisableControlAction(0, 218, true)
      DisableControlAction(0, 200, true)
      DisableControlAction(0, 219, true)
      DisableControlAction(0, 220, true)
      DisableControlAction(0, 221, true)
      DisableControlAction(0, 202, true)
      DisableControlAction(0, 199, true)
      DisableControlAction(0, 177, true)
      DisableControlAction(0, 19, true) -- INPUT_CHARACTER_WHEEL
      DisableControlAction(0, 22, true) -- INPUT_JUMP
      DisableControlAction(0, 23, true) -- INPUT_ENTER
      DisableControlAction(0, 24, true) -- INPUT_ATTACK
      DisableControlAction(0, 25, true) -- INPUT_AIM
      DisableControlAction(0, 26, true) -- INPUT_LOOK_BEHIND
      DisableControlAction(0, 38, true) -- INPUT KEY
      DisableControlAction(0, 44, true) -- INPUT_COVER
      DisableControlAction(0, 45, true) -- INPUT_RELOAD
      DisableControlAction(0, 50, true) -- INPUT_ACCURATE_AIM
      DisableControlAction(0, 51, true) -- CONTEXT KEY
      DisableControlAction(0, 58, true) -- INPUT_THROW_GRENADE
      DisableControlAction(0, 59, true) -- INPUT_VEH_MOVE_LR
      DisableControlAction(0, 60, true) -- INPUT_VEH_MOVE_UD
      DisableControlAction(0, 61, true) -- INPUT_VEH_MOVE_UP_ONLY
      DisableControlAction(0, 62, true) -- INPUT_VEH_MOVE_DOWN_ONLY
      DisableControlAction(0, 63, true) -- INPUT_VEH_MOVE_LEFT_ONLY
      DisableControlAction(0, 64, true) -- INPUT_VEH_MOVE_RIGHT_ONLY
      DisableControlAction(0, 65, true) -- INPUT_VEH_SPECIAL
      DisableControlAction(0, 66, true) -- INPUT_VEH_GUN_LR
      DisableControlAction(0, 67, true) -- INPUT_VEH_GUN_UD
      DisableControlAction(0, 68, true) -- INPUT_VEH_AIM
      DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
      DisableControlAction(0, 70, true) -- INPUT_VEH_ATTACK2
      DisableControlAction(0, 71, true) -- INPUT_VEH_ACCELERATE
      DisableControlAction(0, 72, true) -- INPUT_VEH_BRAKE
      DisableControlAction(0, 73, true) -- INPUT_VEH_DUCK
      DisableControlAction(0, 74, true) -- INPUT_VEH_HEADLIGHT
      DisableControlAction(0, 75, true) -- INPUT_VEH_EXIT
      DisableControlAction(0, 76, true) -- INPUT_VEH_HANDBRAKE
      DisableControlAction(0, 86, true) -- INPUT_VEH_HORN
      DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
      DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
      DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
      DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
      DisableControlAction(0, 261, true) -- INPUT_PREV_WEAPON
      DisableControlAction(0, 262, true) -- INPUT_NEXT_WEAPON
      DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
      DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
      DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
      DisableControlAction(0, 143, true) -- INPUT_MELEE_BLOCK
      DisableControlAction(0, 144, true) -- PARACHUTE DEPLOY
      DisableControlAction(0, 145, true) -- PARACHUTE DETACH
      DisableControlAction(0, 156, true) -- INPUT_MAP
      DisableControlAction(0, 157, true) -- INPUT_SELECT_WEAPON_UNARMED
      DisableControlAction(0, 158, true) -- INPUT_SELECT_WEAPON_MELEE
      DisableControlAction(0, 159, true) -- INPUT_SELECT_WEAPON_HANDGUN
      DisableControlAction(0, 160, true) -- INPUT_SELECT_WEAPON_SHOTGUN
      DisableControlAction(0, 161, true) -- INPUT_SELECT_WEAPON_SMG
      DisableControlAction(0, 162, true) -- INPUT_SELECT_WEAPON_AUTO_RIFLE
      DisableControlAction(0, 243, true) -- INPUT_ENTER_CHEAT_CODE
      DisableControlAction(0, 257, true) -- INPUT_ATTACK2
      DisableControlAction(0, 183, true) -- GCPHONE
      DisableControlAction(0, 244, true) -- GCPHONE
      DisableControlAction(0, 163, true) -- INPUT_SELECT_WEAPON_SNIPER
      DisableControlAction(0, 164, true) -- INPUT_SELECT_WEAPON_HEAVY
      DisableControlAction(0, 165, true) -- INPUT_SELECT_WEAPON_SPECIAL
      DisableControlAction(0, 32, true) 
      DisableControlAction(0, 20, true)  
      DisableControlAction(0, 87, true)  
      DisableControlAction(0, 301, true)  
      DisableControlAction(0, 323, true)  
      DisableControlAction(0, 182, true)  
      DisableControlAction(0, 303, true)  
      DisableControlAction(0, 302, true)  
      DisableControlAction(0, 34, true)  
      DisableControlAction(0, 30, true)  
      DisableControlAction(0, 33, true)  
	    DisableControlAction(0, 31, true)  
	    DisableControlAction(0, 138, true)  
      DisableControlAction(0, 120, true)  
      DisableControlAction(0, 131, true)  
      DisableControlAction(0, 186, true)  
      DisableControlAction(0, 252, true)  
      DisableControlAction(0, 337, true)  
      DisableControlAction(0, 345, true)  
      DisableControlAction(0, 354, true)  
      DisableControlAction(0, 357, true)  
      DisableControlAction(0, 77, true)  
      DisableControlAction(0, 82, true)  
      DisableControlAction(0, 29, true)  
      DisableControlAction(0, 311, true)  
    end
end)

local a = false;
local d = false;
local e = {1, 2, 3, 4, 5, 6, 18, 24, 25, 37, 68, 69, 70, 91, 92, 142, 182, 199, 200, 245, 257}
function SetCanMooveInInv(f)
    if SetNuiFocusKeepInput then
        SetNuiFocusKeepInput(f)
    end
    a = f;
    if not d and f then
        d = true;
        Citizen.CreateThread(function()
            while a do
                Wait(0)
                for g, h in pairs(e) do
                    DisableControlAction(0, h, true)
                end
            end
            d = false
        end)
    end
end

function TooglePhone() 
  menuIsOpen = not menuIsOpen
  SendNUIMessage({show = menuIsOpen})
  if menuIsOpen == true then
    TriggerEvent("phone:blockcontrols",stateOpen) 
    PhonePlayIn()
    SetNuiFocus(true, true)
    SetCanMooveInInv(true)
  else
    TriggerEvent("phone:blockcontrols",stateOpen) 
    PhonePlayOut()
    SetNuiFocus(false, false)
    SetCanMooveInInv(false)
  end
end

RegisterNUICallback('faketakePhoto', function(data, cb)
  TriggerEvent("phone:blockcontrols",stateOpen)
  SetCanMooveInInv(false)
  menuIsOpen = false
  SendNUIMessage({show = false})
  SetNuiFocus(false, false)
  cb()
  TriggerEvent('camera:open')
end)

RegisterNUICallback('closePhone', function(data, cb)
  if UseMumble then 
    exports["pma-voice"]:removePlayerFromCall()
  else

  end
  TriggerEvent("phone:blockcontrols",stateOpen) 
  SetCanMooveInInv(false)
  menuIsOpen = false
  SendNUIMessage({show = false})
  SetNuiFocus(false, false)
  PhonePlayOut()
  cb()
end)

-- GESTION APPEL
RegisterNUICallback('appelsDeleteHistorique', function (data, cb)
  appelsDeleteHistorique(data.numero)
  cb()
end)

RegisterNUICallback('appelsDeleteAllHistorique', function (data, cb)
  appelsDeleteAllHistorique(data.infoCall)
  cb()
end)

-- GESTION VIA WEBRTC
AddEventHandler('onClientResourceStart', function(res)
  DoScreenFadeIn(300)
  if res == "gcphone" then
      TriggerServerEvent('gcPhone:allUpdate')
  end
end)

RegisterNUICallback('setIgnoreFocus', function (data, cb)
  ignoreFocus = data.ignoreFocus
  cb()
end)

local hideHelp = false
local a = {"phone_cam1", "phone_cam2", "phone_cam3", "phone_cam4", "phone_cam5", "phone_cam6", "phone_cam7",
           "phone_cam8", "phone_cam9", "phone_cam10", "phone_cam11", "phone_cam12", "phone_cam13"}
local b = 0;
RegisterNUICallback('takePhoto', function(data, cb)
    CreateMobilePhone(1)
    CellCamActivate(true, true)
    takePhoto = true
    Citizen.Wait(0)
    if hasFocus == true then
        SetNuiFocus(false, false)
        SetKeepInputMode(false)
        hasFocus = false
    end
    while takePhoto do
        Citizen.Wait(0)
        SetNuiFocus(false, false)
        SetKeepInputMode(false)

        if not hideHelp then
			ESX.ShowHelpNotification("~INPUT_FRONTEND_UP~ Caméra frontale.\n~INPUT_CELLPHONE_SELECT~ Prendre une photo.\n~INPUT_FRONTEND_LEFT~ ~INPUT_FRONTEND_RIGHT~ Changer les filtres.")
        end

        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(19)
        HideHudAndRadarThisFrame()

        local e, f = IsControlJustPressed(0, 189), IsControlJustPressed(0, 190)
        if e or f then
            b = e and (b > 0 and b - 1 or b) or (b < #a and b + 1 or b)
            if b <= 0 then
                ClearTimecycleModifier()
            else
                SetTimecycleModifier(a[b])
            end
        end

        if IsControlJustPressed(0, 183) then
            hideHelp = not hideHelp
        end

        if IsControlJustPressed(1, 27) then -- Toogle Mode
            frontCam = not frontCam
            CellFrontCamActivate(frontCam)
        elseif IsControlJustPressed(1, 177) then -- CANCEL
            DestroyMobilePhone()
            CellCamActivate(false, false)
            cb(json.encode({
                url = nil
            }))
            takePhoto = false
            break
        elseif IsControlJustPressed(1, 176) then -- TAKE.. PIC
            hideHelp = true
            TakePhoto()
            if WasPhotoTaken() then
                SavePhoto(-1)
                ClearPhoto()
                PlaySoundFrontend(-1, "Camera_Shoot", "Phone_Soundset_Franklin", 0)
            end
            Citizen.Wait(1000)
            PhonePlayAnim('text', false, true)
            ClearTimecycleModifier()
            takePhoto = false
        end
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(19)
        HideHudAndRadarThisFrame()
    end
    Citizen.Wait(1000)
    PhonePlayAnim('text', false, true)
end)

phone = false;
phoneId = 0;
RegisterNetEvent('camera:open')
AddEventHandler('camera:open', function()
    CreateMobilePhone(1)
    CellCamActivate(true, true)
    phone = true;
    PhonePlayOut()
end)
frontCam = false;
local c = false;
function CellFrontCamActivate(d)
    return Citizen.InvokeNative(0x2491A93618B7D838, d)
end
Citizen.CreateThread(function()
    DestroyMobilePhone()
    while true do
        local attente = 500 
        if phone == true then 
          attente = 1
          if IsControlJustPressed(1, 177) and phone == true then
              ClearTimecycleModifier()
              DestroyMobilePhone()
              phone = false;
              c = false;
              CellCamActivate(false, false)
              if firstTime == true then
                  firstTime = false;
                  Citizen.Wait(2500)
                  displayDoneMission = true
              end
          end
          if IsControlJustPressed(1, 27) and phone == true then
              frontCam = not frontCam;
              CellFrontCamActivate(frontCam)
          end
        end
        if phone == true then
          attente = 1
            if IsControlJustPressed(1, 215) then
              PlaySoundFrontend(-1, "Camera_Shoot", "Phone_Soundset_Franklin", 0)
            end
            local e, f = IsControlJustPressed(0, 189), IsControlJustPressed(0, 190)
            if e or f then
                b = e and (b > 0 and b - 1 or b) or (b < #a and b + 1 or b)
                if b <= 0 then
                    ClearTimecycleModifier()
                else
                    SetTimecycleModifier(a[b])
                end
            end
            if not c then
                ESX.ShowHelpNotification("~INPUT_FRONTEND_UP~ Caméra frontale.\n~INPUT_CELLPHONE_SELECT~ Prendre une photo.\n~INPUT_FRONTEND_LEFT~ ~INPUT_FRONTEND_RIGHT~ Changer les filtres.")
            end
            if IsControlJustPressed(0, 183) then
                c = not c
            end
            HideHudComponentThisFrame(7)
            HideHudComponentThisFrame(8)
            HideHudComponentThisFrame(9)
            HideHudComponentThisFrame(6)
            HideHudComponentThisFrame(19)
            HideHudAndRadarThisFrame()
        end
        ren = GetMobilePhoneRenderId()
        SetTextRenderId(ren)
        SetTextRenderId(1)
        Wait(attente)
    end
end)

