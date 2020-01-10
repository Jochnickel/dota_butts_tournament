ButtCoin = class({})

local passiveCoins = 0
local wallets = {}
local coinTickTime = 0.66
local passiveCoinsEnabled = false

function ButtCoin:SetTickTime(seconds)
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
	wallet[playerID] = wallet[playerID] or 0
	return math.max( 0, wallet[playerID] + passiveCoins )
end

function ButtCoin:ModifyPlayerCoins(playerID, plus_minus_Amount)
	if ButtCoin:GetPlayerCoins(playerID) + plus_minus_Amount < 0 then return false end
	wallet[playerID] = wallet[playerID] + plus_minus_Amount
	return true
end

local l1 = ListenToGameEvent("game_rules_state_change", function()
	passiveCoinsEnabled = passiveCoinsEnabled or Timers:CreateTimer(function()
		passiveCoins = passiveCoins + 1
		return coinTickTime
	end)
end, nil)