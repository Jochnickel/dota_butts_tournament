_G.ADDON_FOLDER = debug.getinfo(1,"S").source:sub(2,-37)
_G.DOTA_SHOP_CUSTOM = _G.DOTA_SHOP_SIDE -- can get deleted after map update
_G.DOTA_SHOP_CUSTOM2 = _G.DOTA_SHOP_SIDE2 -- can get deleted after map update

require("utils")
require("Shop")
require("Filters")



function Precache()

end

function Spawn()
	-- TODO: lessy messy, Filters.lua
	GameRules:GetGameModeEntity():SetExecuteOrderFilter(function( self,event )
		if 16==event.order_type and Shop:IsSpecialShopItem(event.entindex_ability) then
			print("try to buy secret item")
			return Shop:PayItem(EntIndexToHScript(event.units["0"]),event.entindex_ability)
		end
		return true
	end, Filters)
end

function Activate()
	GameRules:GetGameModeEntity():SetUseDefaultDOTARuneSpawnLogic(true)
	GameRules:GetGameModeEntity():SetFreeCourierModeEnabled(true)
	GameRules:GetGameModeEntity():SetTowerBackdoorProtectionEnabled(true)
end
