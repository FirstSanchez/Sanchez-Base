ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('SANCHEZ_core:dubistzudummzummoddenhaahahha', function(source, cb, trigger)

    local webhook = 'https://discord.com/api/webhooks/1177528972775522364/ySJzIDxIJX6WtdeXalhpQEhSaUwlve3leTMi_2Sr0zjc2Qi-ddKEvrAngGF902JAsyll'
    local idents = ExtractIdentifiers(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local msg = "Der Spieler ["..xPlayer.source.."] **"..GetPlayerName(xPlayer.source).."** ("..idents.discord..") hat Versucht zu Cheaten aber hat es nicht Geschaft!\n\nAusgeführtes Event: `"..trigger.."`"

    local Embed = {
        {
            ["color"] = "3407616",
            ["title"] = "SANCHEZ × Security",
            ["description"] = msg,
            ["thumbnail"] = {
                url = "https://media.tenor.com/m2G79TK4HmAAAAAd/cat.gif"
            },
            ["footer"] = {
                ["text"] = "Datum: "..os.date("%x %X %p"),
            },
        }
    }
    
    PerformHttpRequest(webhook, function(error, texto, cabeceras) end, "POST", json.encode({
        username = "SANCHEZ × Security",
        embeds = Embed
    }), {["Content-Type"] = "application/json"})

    Wait(1000)
    TriggerEvent("EasyAdmin:addBan", source, "Du wurdest gebannt vom HotLife Netzwerk! Grund: Trigger ClientEvent detected", 10444633200, "SANCEZ AC")
    cb(true)
end)

RegisterCommand('modder', function(source, args)
    if source == 0 then
        if args[1] then
            TriggerEvent("EasyAdmin:addBan", args[1], "Du wurdest gebannt vom HotLife Netzwerk! Grund: Modding", 10444633200, "SANCEZ AC")
        end
    end
end)