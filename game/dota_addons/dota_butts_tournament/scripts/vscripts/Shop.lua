require("shop/ButtCoin")

-- ButtCoin:SetTickTime(time)
-- ButtCoin:GetTickTime()
-- ButtCoin:SetPassiveCoinsEnabled(bool)
-- ButtCoin:GetPassiveCoinsEnabled()
-- ButtCoin:GetPlayerCoins(playerID)
-- ButtCoin:ModifyPlayerCoins(playerID, amt)

Shop = class({})

local shopItems = LoadKeyValues(ADDON_FOLDER.."scripts/npc/npc_items_custom.txt")

function Shop:BuyItem(playerID, itemname)
	local itemcost = GetItemCost(itemname)
	if ButtCoin:ModifyPlayerCoins(itemcost) then
		hero:AddItemByName(itemname)
	else
		HUDError(playerID,"Not enough coins to buy items")
	end
end