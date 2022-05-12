local vehiclesKHM = {}

Citizen.CreateThread(function()
    local loadFile = LoadResourceFile(GetCurrentResourceName(), "vehicles.json")
    vehiclesKHM = json.decode(loadFile)

end)


RegisterServerEvent("prot-hud:server:vehiclesKHM")
AddEventHandler("prot-hud:server:vehiclesKHM", function(plate,kmh)
    if plate and kmh and type(vehiclesKHM) == 'table' then
        vehiclesKHM[plate] = kmh
        SaveResourceFile(GetCurrentResourceName(), "vehicles.json", json.encode(vehiclesKHM), -1)
        TriggerClientEvent("prot-hud:client:vehiclesKHM", -1, plate,kmh)
    end
end)

RegisterServerEvent("prot-hud:server:requestTable")
AddEventHandler("prot-hud:server:requestTable", function()
    TriggerClientEvent("prot-hud:client:vehiclesKHMTable", source, vehiclesKHM)
end)