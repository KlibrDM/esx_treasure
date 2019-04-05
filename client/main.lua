ESX = nil
local PlayerData              	= {}
local currentZone               = ''
local LastZone                  = ''
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local CurrentActionName         = ''
local alltreasures              = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
  TriggerEvent('esx_treasure:checkcheck')
end)

AddEventHandler('onResourceStart', function()
  TriggerEvent('esx_treasure:checkcheck')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('esx_treasure:checkcheck')
AddEventHandler('esx_treasure:checkcheck', function()
  checkIfTaken()
end)

function checkIfTaken()
  --Empty the old set of crates
  for i=1, #alltreasures, 1 do
    alltreasures[i]=nil
  end

  --Refresh the set of crates excluding the ones that were already taken
  for k,v in pairs(Config.Treasure) do
    Wait(500) --Fixes a bug for slower servers
    ESX.TriggerServerCallback('esx_treasure:isTaken', function(isTaken)
      if isTaken == 0 then
        table.insert(alltreasures, {
          name = v.Name,
          posx = v.Pos.x,
          posy = v.Pos.y,
          posz = v.Pos.z,
          type = v.Type,
          size = v.Size,
          color = v.Color,
        })
      end
    end, v.Name)
  end
end

AddEventHandler('esx_treasure:hasEnteredMarker', function(zone, name)
  if LastZone == 'containerzone' then
    CurrentAction     = 'open_container'
    CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to open container'
    CurrentActionData = {zone = zone}
    CurrentActionName = name
  end
end)

AddEventHandler('esx_treasure:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
  while true do
		Wait(0)
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil
      
    for i=1,#alltreasures,1 do
      if(GetDistanceBetweenCoords(coords, alltreasures[i].posx, alltreasures[i].posy, alltreasures[i].posz, true) < 3) then
        isInMarker  = true
        currentZone = 'containerzone'
        LastZone    = 'containerzone'
        currentName = alltreasures[i].name
      end
    end
        
    if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('esx_treasure:hasEnteredMarker', currentZone, currentName)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_treasure:hasExitedMarker', LastZone)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if CurrentAction ~= nil then
      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)
      if IsControlJustReleased(0, 38) then
        if CurrentAction == 'open_container' then
          TriggerServerEvent('esx_treasure:found', CurrentActionName)
        end
        CurrentAction = nil
      end
    end
  end
end)

-- Display markers
Citizen.CreateThread(function()
  while true do
    Wait(0)
    local coords = GetEntityCoords(GetPlayerPed(-1))
    for i=1,#alltreasures,1 do
			if (alltreasures[i].type ~= -1 and GetDistanceBetweenCoords(coords, alltreasures[i].posx, alltreasures[i].posy, alltreasures[i].posz, true) < Config.DrawDistance) then
				DrawMarker(alltreasures[i].type, alltreasures[i].posx, alltreasures[i].posy, alltreasures[i].posz, 0.0, 0.0, 0.0, 0, 0.0, 0.0, alltreasures[i].size.x, alltreasures[i].size.y, alltreasures[i].size.z, alltreasures[i].color.r, alltreasures[i].color.g, alltreasures[i].color.b, 100, false, true, 2, false, false, false, false)
      end
		end
  end
end)

-- Display container
Citizen.CreateThread(function()
  for k,v in pairs(Config.Treasure) do
    RequestModel(Config.ContainerModel)
    while not HasModelLoaded(Config.ContainerModel) do
      RequestModel(Config.ContainerModel)
      Wait(1)
    end
    crate = CreateObjectNoOffset(Config.ContainerModel, v.Pos.x, v.Pos.y, v.Pos.z, false, true, false)
  end
end)

-- Create Blips
Citizen.CreateThread(function()
  if Config.ShowBlips then
    for k,info in pairs(Config.Treasure) do
      info.blip = AddBlipForCoord(info.Pos.x, info.Pos.y, info.Pos.z)
      SetBlipSprite(info.blip, 501)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, 31)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString('Treasure')
      EndTextCommandSetBlipName(info.blip)
    end
  end
end)
