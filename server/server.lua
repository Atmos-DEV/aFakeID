ESX = nil

print("^0======================================================================^7")
print("^0[^4Author^0] ^7:^0 ^0Atmos-DEV^7")
print("^0======================================================================^7")

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_fakeid:SetFirstName')
AddEventHandler('esx_fakeid:SetFirstName', function(ID, firstName)
    local identifier = ESX.GetPlayerFromId(ID).identifier
	local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= 10000 then
        local firstname = xPlayer.getName()
        xPlayer.removeMoney(10000)
		SetFirstName(identifier, firstName)
        TriggerClientEvent('esx:showNotification', source, "Votre ~g~prénom~s~ a était changé !")
	elseif xPlayer.getAccount('bank').money >= 10000 then
		local newfirstname = xPlayer.getName()
		xPlayer.removeAccountMoney('bank', 10000)
		SetFirstName(identifier, firstName)
		TriggerClientEvent('esx:showNotification', source, "Votre ~g~prénom~s~ a était changé !")
	else
		TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
	end
end)

RegisterServerEvent('esx_fakeid:SetLastName')
AddEventHandler('esx_fakeid:SetLastName', function(ID, lastName)
    local identifier = ESX.GetPlayerFromId(ID).identifier
	local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= 20000 then
		local newlastname = xPlayer.getName()
        xPlayer.removeMoney(20000)
		SetLastName(identifier, lastName)
		TriggerClientEvent('esx:showNotification', source, "Votre ~g~nom~s~ a était changé !")
	elseif xPlayer.getAccount('bank').money >= 20000 then
		local newlastname = xPlayer.getName()
		xPlayer.removeAccountMoney('bank', 20000)
		SetLastName(identifier, lastName)
		TriggerClientEvent('esx:showNotification', source, "Votre ~g~nom~s~ a était changé !")
	else
		TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
	end
end)

function SetFirstName(identifier, firstName)
	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@firstname']		= firstName
	})
end

function SetLastName(identifier, lastName)
	MySQL.Async.execute('UPDATE `users` SET `lastname` = @lastname WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@lastname']		= lastName
	})
end