ESX             = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_skin:save')
AddEventHandler('esx_skin:save', function(skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	if not ESX.GetConfig().OxInventory then
		local defaultMaxWeight = ESX.GetConfig().MaxWeight
		-- local backpackModifier = Config.BackpackWeight[skin.bags_1]

		if backpackModifier then
			xPlayer.setMaxWeight(defaultMaxWeight + backpackModifier)
		else
			xPlayer.setMaxWeight(defaultMaxWeight)
		end
	end

	MySQL.update('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
		['@skin'] = json.encode(skin),
		['@identifier'] = xPlayer.identifier
	})
end)

RegisterServerEvent('esx_skin:responseSaveSkin')
AddEventHandler('esx_skin:responseSaveSkin', function(skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getGroup() == 'admin' then
		local file = io.open('resources/[esx]/esx_skin/skins.txt', "a")

		file:write(json.encode(skin) .. "\n\n")
		file:flush()
		file:close()
	else
		print(('esx_skin: %s attempted saving skin to file'):format(xPlayer.getIdentifier()))
	end
end)

ESX.RegisterServerCallback('esx_skin:getPlayerSkin', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.query('SELECT skin FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		local user, skin = users[1]

		local jobSkin = {
			skin_male   = xPlayer.job.skin_male,
			skin_female = xPlayer.job.skin_female
		}

		if user.skin then
			skin = json.decode(user.skin)
		end

		cb(skin, jobSkin)
	end)
end)

--------------------- SKIN COMMAND ---------------------
RegisterCommand('skin', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    local AdminGroups = {'pl', 'management', 'manager'}
    local xTarget = tonumber(args[1])
    if xPlayer ~= nil then
        local xGroup = xPlayer.getGroup()
        for num, key in ipairs(AdminGroups) do
            if xGroup == key then
                if xTarget == nil then
                    TriggerClientEvent('esx_skin:openSaveableMenu', source)
                elseif xTarget > 0 then
                    TriggerClientEvent('esx_skin:openSaveableMenu', xTarget)
                end
                break
            end
        end
    else
        if xTarget ~= nil then
            if xTarget > 0 then
                TriggerClientEvent('esx_skin:openSaveableMenu', xTarget)
            end
        end
    end
end, false)
--------------------- SKIN COMMAND ---------------------