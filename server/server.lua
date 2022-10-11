local QBCore = exports['qb-core']:GetCoreObject()
local xSound = exports.xsound
local isPlaying = false

QBCore.Functions.CreateUseableItem("djdecks", function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent('rsg_mobiledj:client:placeDJEquipment', src)
	Player.Functions.RemoveItem('djdecks', 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['djdecks'], "remove")
end)

RegisterNetEvent('rsg_mobiledj:server:playMusic', function(song, entity, coords)
    local src = source
    xSound:PlayUrlPos(-1, tostring(entity), song, Config.DefaultVolume, coords)
    xSound:Distance(-1, tostring(entity), Config.radius)
    isPlaying = true
end)

RegisterNetEvent('rsg_mobiledj:server:pickedup', function(entity)
    local src = source
    xSound:Destroy(-1, tostring(entity))
end)

RegisterNetEvent('rsg_mobiledj:server:stopMusic', function(data)
    local src = source
    xSound:Destroy(-1, tostring(data.entity))
    TriggerClientEvent('rsg_mobiledj:client:playMusic', src)
end)

RegisterNetEvent('rsg_mobiledj:server:pauseMusic', function(data)
    local src = source
    xSound:Pause(-1, tostring(data.entity))
end)

RegisterNetEvent('rsg_mobiledj:server:resumeMusic', function(data)
    local src = source
    xSound:Resume(-1, tostring(data.entity))
end)

RegisterNetEvent('rsg_mobiledj:server:changeVolume', function(volume, entity)
    local src = source
    if not tonumber(volume) then return end
    xSound:setVolume(-1, tostring(entity), volume)
end)

RegisterServerEvent('rsg_mobiledj:server:pickeupdecks')
AddEventHandler('rsg_mobiledj:server:pickeupdecks', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.AddItem('djdecks', 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['djdecks'], "add")
end)