-- INFO you can change --
local speed = 50 -- how fast you want the player to sprint?
local norm_spd = 16 -- what do you want the normal speed to be?
local ke_y = Enum.KeyCode.LeftControl-- what key do you want it to work with?


------------------------------------------------ Don't edit under here - you may break something -- --
local fovMax = { FieldOfView = 70 + (speed/5) }
local fovMin = { FieldOfView = 70 }
local thing = game.Workspace.CurrentCamera
local tween = game.TweenService:Create(thing, TweenInfo.new(0.4, Enum.EasingStyle.Sine), fovMax)
local tween2 = game.TweenService:Create(thing, TweenInfo.new(0.4, Enum.EasingStyle.Sine), fovMin)
local UIS = game:GetService("UserInputService")

UIS.InputBegan:Connect(function(input, processed)
   if processed then return end
   if input.UserInputType == Enum.UserInputType.Keyboard then
   		if input.KeyCode == ke_y then
       		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
			tween:Play()
			-- tween starts 1 and stops 2
   		end
	end
end)

UIS.InputEnded:Connect(function(input) 
	if input.KeyCode == ke_y then
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = norm_spd
		tween2:Play()
		-- tween starts 2 and stops 1
	end
end)