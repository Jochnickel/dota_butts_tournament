ButtCoin = class({})

local passiveCoins = 0
local wallet = {}
local coinTickTime = 0.66
local passiveCoinsEnabled = false

function ButtCoin:SetTickTime(seconds)
	if "number"~=type(seconds) then error("ButtCoin:SetTickTime(seconds), 1st argument must be number",2) end
	coinTickTime = seconds
end

function ButtCoin:GetTickTime()
	return coinTickTime
end

function ButtCoin:SetPassiveCoinsEnabled(enable)
	passiveCoinsEnabled = enable
end

function ButtCoin:GetPassiveCoinsEnabled()
	return not not passiveCoinsEnabled
end

function ButtCoin:GetPlayerCoins(playerID)
	if "number"~=type(playerID) then error("ButtCoin:GetPlayerCoins(playerID), 1st argument must be number",2) end
	wallet[playerID] = wallet[playerID] or 0
	return math.max( 0, wallet[playerID] + passiveCoins )
end

function ButtCoin:ModifyPlayerCoins(playerID, plus_minus_Amount)
	if "number"~=type(playerID) then error("ButtCoin:ModifyPlayerCoins(playerID, plus_minus_Amount), 1st argument must be number",2) end
	if "number"~=type(plus_minus_Amount) then error("ButtCoin:ModifyPlayerCoins(playerID, plus_minus_Amount), 2nd argument must be number",2) end
	print("ButtCoin",ButtCoin:GetPlayerCoins(playerID))
	if ButtCoin:GetPlayerCoins(playerID) + plus_minus_Amount < 0 then return false end
	wallet[playerID] = wallet[playerID] + plus_minus_Amount
	return true
end

local l1 = ListenToGameEvent("game_rules_state_change", function()
	if (GameRules:State_Get()~=DOTA_GAMERULES_STATE_GAME_IN_PROGRESS) then return end
	passiveCoinsEnabled = passiveCoinsEnabled or Timers:CreateTimer(function()
		passiveCoins = passiveCoins + 1
		return coinTickTime
	end)
end, nil)