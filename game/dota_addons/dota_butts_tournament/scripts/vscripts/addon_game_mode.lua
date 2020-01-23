_G.ADDON_FOLDER = debug.getinfo(1,"S").source:sub(2,-37)

require("utils")
require("shop")



function Precache()

end

function Spawn()

end

function Activate()
	GameRules:GetGameModeEntity():SetUseDefaultDOTARuneSpawnLogic(true)
	GameRules:GetGameModeEntity():SetFreeCourierModeEnabled(true)
	GameRules:GetGameModeEntity():SetTowerBackdoorProtectionEnabled(true)
end
