ESX = nil
local requestedtreasure = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_treasure:found')
AddEventHandler('esx_treasure:found', function(name)
	local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local identifier = xPlayer.getIdentifier()
  local playerName = xPlayer.getName()

  --Insert the player and the name of the found crate into the database
  --To make sure that the player can't open it again
  MySQL.Async.execute(
    'INSERT INTO treasure (identifier, treasurename) VALUES (@identifier, @name)',
    {
      ['@identifier'] = identifier,
      ['@name']   = name,
    }
  )

  --Delete any previously found crates
  for i=1, #requestedtreasure, 1 do
    requestedtreasure[i]=nil
  end

  --Set up the contents of the new crate
  for k,v in pairs(Config.Treasure) do
    if v.Name == name then
      table.insert(requestedtreasure, {
        name = v.Name,
        money = v.Money,
        items = v.Items,
        weapons = v.Weapons,
      })
    end
  end

  --Should only happen once but you never know :D
  for i=1, #requestedtreasure, 1 do
    --Give money
    if requestedtreasure[i].money ~= 0 then
      if Config.IsMoneyDirtyMoney then
        xPlayer.addAccountMoney('black_money', requestedtreasure[i].money)
      else
        xPlayer.addMoney(tonumber(requestedtreasure[i].money))
      end
    end
    --Give items
    for f,j in pairs(requestedtreasure[i].items) do
      xPlayer.addInventoryItem(j.Name, j.Amount)
    end
    --Give weapons
    for f,j in pairs(requestedtreasure[i].weapons) do
      xPlayer.addWeapon(j.Name,j.Ammo)
    end

    --Print in the console who opened what
    print('ESX Treasure: '..playerName..' just opened '..requestedtreasure[i].name)
  end

  --Trigger the checking function from the client in order to make the opened crate inaccessible to the player that opened it or for others
  if Config.OnePersonOpen then
    TriggerClientEvent('esx_treasure:checkcheck', -1) --Check for everybody
  else
    TriggerClientEvent('esx_treasure:checkcheck', source) --Check for source
  end
end)

ESX.RegisterServerCallback('esx_treasure:isTaken',function(source, cb, name)
	local xPlayer = ESX.GetPlayerFromId(source)
  local identifier = xPlayer.getIdentifier()
  local isTaken = 0

  --Search in the database if the player already opened the crate
  --This is called by the client for each crate
  if Config.OnePersonOpen then
    MySQL.Async.fetchAll(
    'SELECT treasurename FROM treasure WHERE treasurename = @name',
    {
      ['@identifier'] = identifier,
      ['@name'] = name
    },
    
    function(result)
      isTakenResult(result)
    end)
  else
    MySQL.Async.fetchAll(
    'SELECT treasurename FROM treasure WHERE identifier = @identifier AND treasurename = @name',
    {
      ['@identifier'] = identifier,
      ['@name'] = name
    },
    
    function(result)
      isTakenResult(result)
    end)
  end

  function isTakenResult(result)
      for i=1, #result, 1 do
        if name == result[i].treasurename then
          isTaken = 1
        end
      end
    cb(isTaken)
  end
end)