-- local fg_stopCount = 0

-- CreateThread(function ()
--     while true do
--         Wait(10000)
--         if GetResourceState("esx_policejob") ~= "started" and GetResourceState("esx_policejob") ~= "missing" then
--             fg_stopCount = fg_stopCount + 1
--             if fg_stopCount > 3 then
--                 TriggerServerEvent("sanchezliebtdich")
--             end
--         else
--             fg_stopCount = 0
--         end
--     end
-- end)