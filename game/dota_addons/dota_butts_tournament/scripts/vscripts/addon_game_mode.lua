_G.ADDON_FOLDER = debug.getinfo(1,"S").source:sub(2,-37)

require("utils")
require("Shop")
require("Filters")



function Precache()

end

function Spawn()
	-- TODO: lessy messy
	GameRules:GetGameModeEntity():SetExecuteOrderFilter(function( self,event )
		for k,v in pairs(event) do
			-- print(k,v)
		end
		if 16==event.order_type and Shop:IsSpecialShopItem(event.entindex_ability) then
			print("try to buy secret item")
			return Shop:PayItem(event.issuer_player_id_const,event.entindex_ability)
		end
		return true
	end, Filters)
end

function Activate()
	GameRules:GetGameModeEntity():SetUseDefaultDOTARuneSpawnLogic(true)
	GameRules:GetGameModeEntity():SetFreeCourierModeEnabled(true)
	GameRules:GetGameModeEntity():SetTowerBackdoorProtectionEnabled(true)
end
