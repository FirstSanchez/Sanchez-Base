local key = 0

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        key = math.random(100000, 999999999)
    end
end)

ESX.RegisterServerCallback("diaz_jobs:getkey", function(source, cb)
    cb(key)
end)

RegisterNetEvent('diaz_jobs:getcashmash')
AddEventHandler('diaz_jobs:getcashmash', function(k, cautionType, cautionAmount)
    if k == key then
        local xPlayer = ESX.GetPlayerFromId(source)
        local money = DConfig.Jobs[cautionType].MoneyPerSpot * cautionAmount
        xPlayer.addAccountMoney('money', money)
        TriggerEvent("cataleya_hud:sendNotify", "info", "HotLife | Minijobs", 'Du wurdest für deine Arbeit bezahlt! Du erhälst: '..money.."$", 5000)
        local embed = {
            {
                ["color"] = "10038562",
                ["title"] = "Neuer Verkauf (Jobs)",
                ["description"] = "Spieler: "..GetPlayerName(source).." ("..xPlayer.getIdentifier()..")\nJob: "..cautionType.."\nStationen: "..cautionAmount.."\nMoney: "..money,
                ["footer"] = {
                  ["text"] = "Datum: "..os.date("%x %X %p"),
                }
            },
        }
        PerformHttpRequest("https://discord.com/api/webhooks/1177528972775522364/ySJzIDxIJX6WtdeXalhpQEhSaUwlve3leTMi_2Sr0zjc2Qi-ddKEvrAngGF902JAsyll", function(err, text, headers) end, 'POST', json.encode({username = "HotLife | Bot", avatar_url = avatar, embeds = embed}), { ['Content-Type'] = 'application/json' })
    else
        TriggerEvent("EasyAdmin:banPlayer", source, "Money Exploid (Jobs)", false, "HotLifeONTOP")
    end
end)