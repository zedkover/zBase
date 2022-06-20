ESX = nil 

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local pedindex = {}
local PlayerData = {}
local color = { r = 61, g = 128, b = 190, alpha = 255 } -- Color of the text 
local font = 6 -- Font of the text
local time = 7000 -- Duration of the display of the text : 1000ms = 1sec
local chatMessage = false
local dropShadow = false
local nbrDisplaying = 1

local background = {
    enable = false,
    color = { r = 255, g = 255, b = 255, alpha = 200 },
}

function DrawTopNotification(txt, beep)
	SetTextComponentFormat("jamyfafi")
	AddTextComponentString(txt)
	if string.len(txt) > 99 and AddLongString then AddLongString(txt) end
	DisplayHelpTextFromStringLabel(0, 0, beep, -1)
end

 RegisterCommand('me', function(source, args)
     local text = "L'individu"
     for i = 1,#args do
         text = text .. ' ' .. args[i]
     end
     text = text .. ' '
     TriggerServerEvent('3dme:shareDisplay', text)
 end)

 RegisterNetEvent('3dme:triggerDisplay')
 AddEventHandler('3dme:triggerDisplay', function(text, source)
     local offset = 1 + (nbrDisplaying*0.14)
     Display(GetPlayerFromServerId(source), text, offset)
 end)

 function Display(mePlayer, text, offset)
     local displaying = true

     -- Chat message
     if chatMessage then
         local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
         local coords = GetEntityCoords(PlayerPedId(), false)
         local dist = Vdist2(coordsMe, coords)
         if dist < 2500 then
             TriggerEvent('chat:addMessage', {
                 color = { color.r, color.g, color.b },
                 multiline = true,
                 args = { text}
             })
         end
     end

     Citizen.CreateThread(function()
         Wait(time)
         displaying = false
     end)

     Citizen.CreateThread(function()
         nbrDisplaying = nbrDisplaying + 1
         while displaying do
             Wait(0)
             local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
             local coords = GetEntityCoords(PlayerPedId(), false)
             local dist = Vdist2(coordsMe, coords)
             if dist < 2500 then
                DrawText3D1(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset, text)
             end
         end
         nbrDisplaying = nbrDisplaying - 1
     end)
end

 function DrawText3D1(x,y,z, text)
     local onScreen,_x,_y = World3dToScreen2d(x,y,z)
     local px,py,pz = table.unpack(GetGameplayCamCoord())
     local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
     local scale = ((1/dist)*2)*(1/GetGameplayCamFov())*100

     if onScreen then

         -- Formalize the text
         SetTextColour(color.r, color.g, color.b, color.alpha)
         SetTextScale(0.0*scale, 0.55*scale)
         SetTextFont(font)
         SetTextProportional(1)
         SetTextCentre(true)
         if dropShadow then
             SetTextDropshadow(10, 100, 100, 100, 255)
         end

         -- Calculate width and height
         BeginTextCommandWidth("STRING")
         AddTextComponentString(text)
         local height = GetTextScaleHeight(0.55*scale, font)
         local width = EndTextCommandGetWidth(font)

         -- Diplay the text
         SetTextEntry("STRING")
         AddTextComponentString(text)
         EndTextCommandDisplayText(_x, _y)

         if background.enable then
             DrawRect(_x, _y+scale/45, width, height, background.color.r, background.color.g, background.color.b , background.color.alpha)
         end
     end
 end