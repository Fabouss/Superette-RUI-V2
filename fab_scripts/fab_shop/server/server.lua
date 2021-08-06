ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("Coucou:Paye")
AddEventHandler("Coucou:Paye", function(abcdef, name, label, price) 
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= price then
	    xPlayer.removeMoney(price)
    	xPlayer.addInventoryItem(name, 1) 
        TriggerClientEvent('esx:showNotification', source, "Vous avez acheté ~b~1x "..label.."~s~ avec ~g~"..price.."$~s~ !")
     else 
        TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez sur vous !")    
    end
end)