local vent = script.Parent
local DAMAGE_PER_HIT = 10
local Players = game:GetService("Players")

local function hurtPlayer(player) 
	if player then
		local character = player.Character
		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if humanoid then
			humanoid.Health = humanoid.Health - DAMAGE_PER_HIT
			return humanoid
		end
	end
	
end

vent.Touched:Connect(function(otherPart)
	hurtPlayer(Players:GetPlayerFromCharacter(otherPart.Parent))
end)