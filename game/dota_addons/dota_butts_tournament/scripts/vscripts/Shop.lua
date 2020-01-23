require("shop/ButtCoin")

-- ButtCoin:SetTickTime(time)
-- ButtCoin:GetTickTime()
-- ButtCoin:SetPassiveCoinsEnabled(bool)
-- ButtCoin:GetPassiveCoinsEnabled()
-- ButtCoin:GetPlayerCoins(playerID)
-- ButtCoin:ModifyPlayerCoins(playerID, amt)

Shop = class({})

local sideShopItems = LoadKeyValues(ADDON_FOLDER.."scripts/npc/npc_items_custom.txt")
for k,v in pairs(sideShopItems) do if not v.SideShop then sideShopItems[k] = nil end end

local nameByID = {}
local idByName = {}
for itemname,v in pairs(sideShopItems) do
	if v.ID then
		nameByID[v.ID] = itemname
		idByName[itemname] = v.ID
	end
end

function Shop:PayItem(unit, itemname_or_ID)
	if "number"==type(itemname_or_ID) then itemname_or_ID = nameByID[itemname_or_ID] end
	local playerID = unit:GetPlayerOwnerID()

	if not sideShopItems[itemname_or_ID] then
		HUDError("PayItem: This shouldnt happen", playerID)
		return false
	end

	if not Shop:UnitIsInRange(unit) then
		HUDError("Shop Not In Range", playerID)
		return false
	end
	
	local itemcost = GetItemCost(itemname_or_ID)

	if ButtCoin:ModifyPlayerCoins(playerID, -itemcost) then
		return true
	else
		HUDError("Not Enough Coins To Buy Item", playerID)
		return false
	end

	return false

end

function Shop:IsSpecialShopItem(itemname_or_ID)
	if "number"==type(itemname_or_ID) then itemname_or_ID = nameByID[itemname_or_ID] end
	return nil~=sideShopItems[itemname_or_ID]
end

function Shop:UnitIsInRange(unit)
	DOTA_SHOP_CUSTOM2 = DOTA_SHOP_CUSTOM2 or DOTA_SHOP_CUSTOM -- update proof
	return unit:IsInRangeOfShop(DOTA_SHOP_CUSTOM, true) or unit:IsInRangeOfShop(DOTA_SHOP_CUSTOM2, true)
end
