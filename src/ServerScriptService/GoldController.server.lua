function incrementGold(player, increment)
	for i = player.leaderstats.Gold.Value, player.leaderstats.Gold.Value + increment do
		player.leaderstats.Gold.Value = i
		wait()
	end
end

game.Players.PlayerAdded:Connect(function(player)
	local leaderStatsFolder = player:WaitForChild("leaderstats")
	local gold = leaderStatsFolder:WaitForChild("Gold")
	while wait(2) do	
		incrementGold(player, math.random(1,10))
	end
end)