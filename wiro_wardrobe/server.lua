TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('wiro_wardrobe:ekle')
AddEventHandler('wiro_wardrobe:ekle', function(array)
    local _source = source
    xPlayer = ESX.GetPlayerFromId(_source)

	local result = MySQL.Sync.fetchAll('SELECT wardrobe FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})

    Citizen.Wait(250)

    local wardrobeTable = json.decode(result[1].wardrobe)


    table.insert(wardrobeTable, array)

    wardrobeTable = json.encode(wardrobeTable)

    MySQL.Async.insert("UPDATE users SET wardrobe = @tablo WHERE identifier = @identifier", { 
        ['@identifier'] = xPlayer.identifier,
        ['@tablo'] = wardrobeTable
    })

end)

RegisterServerEvent('wiro_wardrobe:sil')
AddEventHandler('wiro_wardrobe:sil', function(label)
    local _source = source
    xPlayer = ESX.GetPlayerFromId(_source)

	local result = MySQL.Sync.fetchAll('SELECT wardrobe FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})

    Citizen.Wait(250)

    local wardrobeTable = json.decode(result[1].wardrobe)

    for k,v in pairs(wardrobeTable) do
        if v.label == label then
            table.remove(wardrobeTable, k)
        end
    end

    wardrobeTable = json.encode(wardrobeTable)

    MySQL.Async.insert("UPDATE users SET wardrobe = @tablo WHERE identifier = @identifier", { 
        ['@identifier'] = xPlayer.identifier,
        ['@tablo'] = wardrobeTable
    })

end)


ESX.RegisterServerCallback('wiro_wardrobe:getWadrobe', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	local result = MySQL.Sync.fetchAll('SELECT wardrobe FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})

    local decoded = json.decode(result[1].wardrobe) 

    local data = {
		wardrobe = decoded,
	}

    cb(data)
end)

RegisterServerEvent('wiro_wardrobe:savegobrr')
AddEventHandler('wiro_wardrobe:savegobrr', function(skin)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.insert("UPDATE users SET skin = @sikin WHERE identifier = @identifier", { 
        ['@identifier'] = xPlayer.identifier,
        ['@sikin'] = json.encode(skin)
    })
end)