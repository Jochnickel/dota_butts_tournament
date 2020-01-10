GameEvents.Subscribe('dota_hud_error_message_player', (data)=>{
	GameEvents.SendEventClientSide("dota_hud_error_message", {
		splitscreenplayer: 0,
		reason: 80,
		message: data.message});
});