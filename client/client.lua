ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(5000)
    end
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("ig_dale")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    local ped = CreatePed("PED_TYPE_CIVFEMALE", "ig_dale", 1740.9288330078, 3329.2836914062, 40.223487854004, 101.89, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)
-----------------------------------------------------------------------------------------
function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, "", inputText, "", "", "", maxLength)
	blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
		blockinput = false
        return result
    else
        Citizen.Wait(500)
		blockinput = false
        return nil
    end
end

-- Menus
local AtmosMenu = {
    Base = { Title = "Faux Papiers", HeaderColor = {255, 0, 0} },
    Data = { currentMenu = "Options :" },
    Events = {
        onSelected = function(self, _, btn, JMenu, menuData, currentButton, currentSlt, result)
            if btn.name == "Changer de Prénom" then
                EditFirstName()
            end
            if btn.name == "Changer de Nom" then
                EditLastName()
            end
        end
        
    },

    Menu = {
        ["Options :"] = {
            b = {
                {name = "Changer de Prénom", ask = "10 000$ →→→", askX = true},
                {name = "Changer de Nom", ask = "25 000$ →→→", askX = true},
            }
        },
    }
}

-- Ouverture du Menu

local position = {
    {x = 1740.1452636719, y = 3329.0390625, z = 41.223461151123   }                 
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(position) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
            if dist <= 0.5 then
            ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour changer d'indentité")
            if IsControlJustPressed(1,51) then
                    CreateMenu(AtmosMenu)
            end
        end 
    end
    
    end
end
end)

-----------------------------------------------------

function EditFirstName()
	local firstName = KeyboardInput("fakeid_VORNAMEN", 'Quel est ton nouveau prénom?', "", 15)

	if firstName ~= nil then
		firstName = tostring(firstName)
		
		if type(firstName) == 'string' then
			TriggerServerEvent('esx_fakeid:SetFirstName', GetPlayerServerId(PlayerId()), firstName)
		end
	end
end

function EditLastName()
	local lastName = KeyboardInput("fakeid_NACHNAMEN", 'Quel est votre nouveau nom de famille?', "", 15)

	if lastName ~= nil then
		lastName = tostring(lastName)
		
		if type(lastName) == 'string' then
			TriggerServerEvent('esx_fakeid:SetLastName', GetPlayerServerId(PlayerId()), lastName)
		end
	end
end 


