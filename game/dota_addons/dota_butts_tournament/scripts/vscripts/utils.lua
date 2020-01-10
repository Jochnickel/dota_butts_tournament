require("utils/thinker")

function HUDError(message, playerID)
	if ("number"==type(playerID)) and playerID>=0 then
		CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "dota_hud_error_message_player", {splitscreenplayer= 0, reason= 80, message= message})
	else
		if "number"~=type(playerID) then message = "All Players: "..message end
		CustomGameEventManager:Send_ServerToAllClients("dota_hud_error_message_player", {splitscreenplayer= 0, reason= 80, message= message})
	end
end
