local goldInt=game.Players.LocalPlayer.leaderstats.Gold
local diamondInt=game.Players.LocalPlayer.leaderstats.Diamond
if goldInt then
	script.Parent.Gold.GoldCount.Text = goldInt.Value
end

if diamondInt then
	script.Parent.Diamond.DiamondCount.Text = diamondInt.Value
end

goldInt.Changed:Connect(function(NewValue)
	script.Parent.Gold.GoldCount.Text = NewValue
end)

diamondInt.Changed:Connect(function(NewValue)
	script.Parent.Diamond.DiamondCount.Text = NewValue
end)
