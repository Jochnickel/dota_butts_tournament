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

function Shop:PayItem(playerID, itemname_or_ID)
	if "number"==type(itemname_or_ID) then itemname_or_ID = nameByID[itemname_or_ID] end
	if not sideShopItems[itemname_or_ID] then return false end

	if SideShop_not_in_range then return false end -- TODO
	
	local itemcost = GetItemCost(itemname_or_ID)
	if ButtCoin:ModifyPlayerCoins(playerID,-itemcost) then
		return true
	else
		print(playerID,"Not enough coins to buy items")
		HUDError(playerID,"Not enough coins to buy items")
	end
	return false
end

function Shop:IsSpecialShopItem(itemname_or_ID)
	if "number"==type(itemname_or_ID) then itemname_or_ID = nameByID[itemname_or_ID] end
	return nil~=sideShopItems[itemname_or_ID]
end



-- GameRules:GetGameModeEntity():SetExecuteOrderFilter( InternalFilters.ExecuteOrderFilter, contxt )

-- unit:IsInRangeOfShop(int nShopType, bool bPhysical) 

-- print(shop:GetShopType())