ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societybikermoney = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

local open = false 
local mainMenu = RageUI.CreateMenu('Superette', '~o~Choisi ton produit')
local bouffe = RageUI.CreateSubMenu(mainMenu, "Nourriture", "~o~Choisi ton produit")
local soif = RageUI.CreateSubMenu(mainMenu, "Boissons", "~o~Choisi ton produit")
local alcool = RageUI.CreateSubMenu(mainMenu, "Alcool", "~o~Choisi ton produit")
local autre = RageUI.CreateSubMenu(mainMenu, "Autre", "~o~Choisi ton produit")
mainMenu:SetRectangleBanner(60,0,0)
bouffe:SetRectangleBanner(60,0,0)
soif:SetRectangleBanner(60,0,0)
alcool:SetRectangleBanner(60,0,0)
autre:SetRectangleBanner(60,0,0)
mainMenu.Display.Header = true 
mainMenu.Closed = function()
  open = false
end


function Superette()
    if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while open do 
                RageUI.IsVisible(mainMenu,function()
                    RageUI.Button('Nourriture', nil, {RightLabel = "→"}, true, {onSelected = function() end}, bouffe);
                    RageUI.Button('Boissons', nil, {RightLabel = "→"}, true, {onSelected = function() end}, soif);
                    RageUI.Button('Alcool', nil, {RightLabel = "→"}, true, {onSelected = function() end}, alcool);
                    RageUI.Button('Autres', nil, {RightLabel = "→"}, true, {onSelected = function() end}, autre);
                end)		
                RageUI.IsVisible(bouffe,function()
                    for k, v in pairs(Configuration.Categories.bouffe) do 
                        RageUI.Button(v.label, "~g~"..ESX.Math.GroupDigits(v.price).."$", {}, true, {
                            onSelected = function()
                                TriggerServerEvent('Coucou:Paye', lastPos, v.name, v.label, v.price)
                            end, 
                        })
                    end
                end)
                RageUI.IsVisible(soif,function()
                    for k, v in pairs(Configuration.Categories.soif) do 
                        RageUI.Button(v.label, "~g~"..ESX.Math.GroupDigits(v.price).."$", {}, true, {
                            onSelected = function()
                                TriggerServerEvent('Coucou:Paye', lastPos, v.name, v.label, v.price)
                            end, 
                        })
                    end
                end)
                RageUI.IsVisible(alcool,function()
                    for k, v in pairs(Configuration.Categories.alcool) do 
                        RageUI.Button(v.label, "~g~"..ESX.Math.GroupDigits(v.price).."$", {}, true, {
                            onSelected = function()
                                TriggerServerEvent('Coucou:Paye', lastPos, v.name, v.label, v.price)
                            end, 
                        })
                    end
                end)
                RageUI.IsVisible(autre,function()	
                    for k, v in pairs(Configuration.Categories.autre) do 
                        RageUI.Button(v.label, "~g~"..ESX.Math.GroupDigits(v.price).."$", {}, true, {
                            onSelected = function()
                                TriggerServerEvent('Coucou:Paye', lastPos, v.name, v.label, v.price)
                            end, 
                        })
                    end
                end)
                wait = 0
                Citizen.Wait(wait)
            end
        end)
    end
end

local position = {
    {x = 25.73, y = -1345.49, z = 29.751}
}

Citizen.CreateThread(function()
    while true do
      local wait = 750
        for k in pairs(position) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist2 <= 1.5 then
               wait = 0
                Visual.Subtitle("Appuyez sur E pour accéder à la superette", 1)
                if IsControlJustPressed(1,51) then
                Superette()
            end
        end
    end
    Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
	for k, v in pairs(position) do
		local blip = AddBlipForCoord(v.x, v.y, v.z)

		SetBlipSprite(blip, 52)
		SetBlipScale (blip, 0.7)
		SetBlipColour(blip, 2)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Magasin')
		EndTextCommandSetBlipName(blip)
	end
end)