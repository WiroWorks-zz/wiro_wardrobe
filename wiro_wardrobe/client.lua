local suits
local first = true

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function SetDisplay(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        status = bool,
        type = "ui",
    })
end

RegisterNetEvent('wiro_wardrobe:display')
AddEventHandler('wiro_wardrobe:display', function()
    local suit
    if first then
        ESX.TriggerServerCallback('wiro_wardrobe:getWadrobe', function(data)
            suit = data.wardrobe
        end)
        Citizen.Wait(250)
        suits = suit
    end
    SetDisplay(true)
    if first then
        for k,v in pairs(suits) do
            SendNUIMessage({
                type = "ilkekle",
                label = v.label,
                color = v.color,
                ikon = v.ikon,
            })
        end
        first = false
    end
end)
--[[
RegisterCommand("wiroward", function(source)
    local suit
    if first then
        ESX.TriggerServerCallback('wiro_wardrobe:getWadrobe', function(data)
            suit = data.wardrobe
        end)
        Citizen.Wait(250)
        suits = suit
    end
    SetDisplay(true)
    if first then
        for k,v in pairs(suits) do
            SendNUIMessage({
                type = "ilkekle",
                label = v.label,
                color = v.color,
                ikon = v.ikon,
            })
        end
        first = false
    end
end)
]]
RegisterNUICallback('exit', function()
    SetDisplay(false)
end)

RegisterNUICallback('ekle', function(data)
    TriggerEvent('skinchanger:getSkin', function(skin)
		lastSkin = skin
	end)
    --local anlik = 
    TriggerServerEvent('wiro_wardrobe:ekle', {label = data.label,ikon = data.ikon,color = data.color,skin = lastSkin})
    table.insert(suits, {label = data.label,ikon = data.ikon,color = data.color,skin = lastSkin})
end)

RegisterNUICallback('giyin', function(data)
    for k,v in pairs(suits) do
        if v.label == data.label then
            SetDisplay(false)
            giyinAnim()
            TriggerEvent('skinchanger:loadSkin', v.skin)
        end
    end
    TriggerEvent('skinchanger:getSkin', function(skin)
		TriggerServerEvent('wiro_wardrobe:savegobrr', skin)
	end)
end)

RegisterNUICallback('sil', function(data)
    TriggerServerEvent('wiro_wardrobe:sil', data.label)
    for k,v in pairs(suits) do
        if v.label == data.label then
            table.remove(suits, k)
            break
        end
    end
end)

function giyinAnim()
    ESX.Streaming.RequestAnimDict("nmt_3_rcm-10", function()
        TaskPlayAnim(PlayerPedId(), "nmt_3_rcm-10", "cs_nigel_dual-10", 1.5, -1.0, 1000, 51, 1, false, false, false)
    end)
    Citizen.Wait(1000)
    ESX.Streaming.RequestAnimDict("clothingtie", function()
        TaskPlayAnim(PlayerPedId(), "clothingtie", "try_tie_negative_a", 1.5, -1.0, 1000, 51, 1, false, false, false)
    end)
    Citizen.Wait(1000)
    ESX.Streaming.RequestAnimDict("re@construction", function()
        TaskPlayAnim(PlayerPedId(), "re@construction", "out_of_breath", 1.5, -1.0, 1000, 51, 1, false, false, false)
    end)
    Citizen.Wait(1000)
    ESX.Streaming.RequestAnimDict("random@domestic", function()
        TaskPlayAnim(PlayerPedId(), "random@domestic", "pickup_low", 1.5, -1.0, 1000, 51, 1, false, false, false)
    end)
    Citizen.Wait(1000)
end