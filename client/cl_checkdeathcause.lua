local locDeath= {
	-- regulars
	  ['press_e'] = 'Drücke ~INPUT_CONTEXT~ um zu schauen wegen was die Person Bewusstlos geworden ist.',
	  ['hardmeele'] = 'Wahrscheinlich wurde die Person von etas hartem an dem Kopf getroffen.',
	  ['bullet'] = 'Wahrscheinlich wurde die Person von einer Kugel getroffen.',
	  ['knifes'] = 'Wahrscheinlich wurde die Person mit einem Messer verletzt.',
	  ['bitten'] = 'Wahrscheinlich hat die Person einen Schaden von einem Tier erhalten.',
	  ['brokenlegs'] = 'Die Person hat sich beide Beine gebrochen.',
	  ['explosive'] = 'Wahrscheinlich ist die Person durch eine Explosion Bewusstlos geworden.',
	  ['gas'] = 'Wahrscheinlich ist die Person durch Gas Bewusstlos geworden.',
	  ['fireextinguisher'] = 'Wahrscheinlich ist die Person mit etwas hartem geschlagen worden.',
	  ['fire'] = 'Wahrscheinlich ist die Person durch ein Feuer Bewusstlos geworden.',
	  ['caraccident'] = 'Wahrscheinlich ist die Person durch einen Autounfall Bewusstlos geworden.',
	  ['drown'] = 'Wahrscheinlich ist die Person ertrunken.',
	  ['unknown'] = 'Ursache Unbekannt.',
  }
  
  function LocalesDeath(str, ...)  -- Translate string

	if locDeath[str] ~= nil then
		return  tostring(string.format(locDeath[str], ...):gsub("^%l", string.upper))
	else
		return 'Translation [' .. str .. '] does not exist'
	end

end

ESX               = nil
  
  CreateThread(function()
	  while ESX == nil do
			ESX = exports["es_extended"]:getSharedObject()
		  Wait(1)
	  end
		PlayerData = ESX.GetPlayerData()
  end)
  
  RegisterNetEvent('esx:playerLoaded')
  AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
  end)
  
  RegisterNetEvent('esx:setJob')
  AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
  end)
  
  local Melee = { -1569615261, 1737195953, 1317494643, -1786099057, 1141786504, -2067956739, -868994466 }
  local Knife = { -1716189206, 1223143800, -1955384325, -1833087301, 910830060, }
  local Bullet = { 453432689, 1593441988, 584646201, -1716589765, 324215364, 736523883, -270015777, -1074790547, -2084633992, -1357824103, -1660422300, 2144741730, 487013001, 2017895192, -494615257, -1654528753, 100416529, 205991906, 1119849093 }
  local Animal = { -100946242, 148160082 }
  local FallDamage = { -842959696 }
  local Explosion = { -1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745, -37975472, 539292904, 341774354, -1090665087 }
  local Gas = { -1600701090 }
  local Burn = { 615608432, 883325847, -544306709 }
  local Drown = { -10959621, 1936677264 }
  local Car = { 133987706, -1553120962 }
  
  function checkArray (array, val)
	  for name, value in ipairs(array) do
		  if value == val then
			  return true
		  end
	  end
  
	  return false
  end
  
  CreateThread(function()
	  Wait(1000)
		while true do
		  local sleep = 3000
  
		  if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
  
			  local player, distance = ESX.Game.GetClosestPlayer()
  
			  if distance ~= -1 and distance < 10.0 then
  
				  if distance ~= -1 and distance <= 2.0 then	
					  if IsPedDeadOrDying(GetPlayerPed(player)) then
						  Start(GetPlayerPed(player))
					  end
				  end
  
			  else
				  sleep = sleep / 100 * distance 
			  end
  
		  end
  
		  Wait(sleep)
  
	  end
  end)
  
  function Start(ped)
	  checking = true
  
	  while checking do
		  Wait(5)
  
		  local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(ped))
  
		  local x,y,z = table.unpack(GetEntityCoords(ped))
  
		  if distance < 2.0 and PlayerData.job.name == 'ambulance' then
			  DrawText3D(x,y,z, 'Drücke [~g~E~s~] um die Person zu untersuchen', 0.4)
			  
			  if IsControlPressed(0, 38) and PlayerData.job.name == 'ambulance' then
				  OpenDeathMenu(ped)
			  end
		  end
  
		  if distance > 7.5 or not IsPedDeadOrDying(ped) then
			  checking = false
		  end
  
	end
  
end
  
  function Notification(x,y,z)
	  local timestamp = GetGameTimer()
  
	  while (timestamp + 4500) > GetGameTimer() do
		  Wait(0)
		  DrawText3D(x, y, z, 'Der Schaden scheint hier aufzutreten', 0.4)
		  checking = false
	  end
  end
  
  function OpenDeathMenu(player)
  
	  loadAnimDict('amb@medic@standing@kneel@base')
	  loadAnimDict('anim@gangops@facility@servers@bodysearch@')
  
	  local elements   = {}
  
	  table.insert(elements, {label = 'Versuchen Sie, die Todesursache zu identifizieren', value = 'deathcause'})
	  table.insert(elements, {label = 'Versuchen Sie herauszufinden, wo der Schaden aufgetreten ist', value = 'damage'})
  
  
	  ESX.UI.Menu.Open(
		  'default', GetCurrentResourceName(), 'dead_citizen',
		  {
			  title    = 'Wähle die Aktion',
			  align    = 'top-right',
			  elements = elements,
		  },
	  function(data, menu)
		  local ac = data.current.value
  
		  if ac == 'damage' then
  
			  local bone
			  local success = GetPedLastDamageBone(player,bone)
  
			  local success,bone = GetPedLastDamageBone(player)
			  if success then
				  --print(bone)
				  local x,y,z = table.unpack(GetPedBoneCoords(player, bone))
					Notification(x,y,z)
				
			  else
				  Notify('Wo der Schaden aufgetreten ist, konnte nicht identifiziert werden')
			  end
		  end
  
		  if ac == 'deathcause' then
			  --gets deathcause
			  local d = GetPedCauseOfDeath(player)		
			  local playerPed = GetPlayerPed(-1)
  
			  --starts animation
  
			  TaskPlayAnim(GetPlayerPed(-1), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
			  TaskPlayAnim(GetPlayerPed(-1), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
  
			  Wait(5000)
  
			  --exits animation			
  
			  ClearPedTasksImmediately(playerPed)
  
			  if checkArray(Melee, d) then
				  Notify(LocalesDeath('hardmeele'))
			  elseif checkArray(Bullet, d) then
				  Notify(LocalesDeath('bullet'))
			  elseif checkArray(Knife, d) then
				  Notify(LocalesDeath('knifes'))
			  elseif checkArray(Animal, d) then
				  Notify(LocalesDeath('bitten'))
			  elseif checkArray(FallDamage, d) then
				  Notify(LocalesDeath('brokenlegs'))
			  elseif checkArray(Explosion, d) then
				  Notify(LocalesDeath('explosive'))
			  elseif checkArray(Gas, d) then
				  Notify(LocalesDeath('gas'))
			  elseif checkArray(Burn, d) then
				  Notify(LocalesDeath('fire'))
			  elseif checkArray(Drown, d) then
				  Notify(LocalesDeath('drown'))
			  elseif checkArray(Car, d) then
				  Notify(LocalesDeath('caraccident'))
			  else
				  Notify(LocalesDeath('unknown'))
			  end
		  end
  
  
	  end,
	  function(data, menu)
		menu.close()
	  end
	)
  end
  
  function loadAnimDict(dict)
	  while (not HasAnimDictLoaded(dict)) do
		  RequestAnimDict(dict)
		  
		  Wait(1)
	  end
  end
  
  function Notify(message)
	  ESX.ShowNotification(message)
  end
  
  function DrawText3D(x, y, z, text, scale)
	  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	  local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
   
	  SetTextScale(scale, scale)
	  SetTextFont(4)
	  SetTextProportional(1)
	  SetTextEntry("STRING")
	  SetTextCentre(1)
	  SetTextColour(255, 255, 255, 215)
   
	  AddTextComponentString(text)
	  DrawText(_x, _y)
   
  end
