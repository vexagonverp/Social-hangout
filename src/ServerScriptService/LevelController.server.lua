function incrementExp(player, increment)
	for i = player.Stats.Experience.Value, player.Stats.Experience.Value + increment do
		player.Stats.Experience.Value = i
		wait()
	end
end

game.Players.PlayerAdded:Connect(function(player)
	local statsFolder = player:WaitForChild("Stats")
	local levelVal = statsFolder:WaitForChild("Level")
	local expVal = statsFolder:WaitForChild("Experience")
	expVal:GetPropertyChangedSignal("Value"):Connect(function()	
		local neededExp = math.floor(levelVal.Value ^ 1.5 + 0.5) * 500	
		if expVal.Value >= neededExp then		
			levelVal.Value += 1
		end
	end)
	
	while wait(2) do	
		incrementExp(player, math.random(1,30))
	end
end)