local re = game.ReplicatedStorage.Events:WaitForChild("PropGrab")


local mouse = game.Players.LocalPlayer:GetMouse()

local cam = workspace.CurrentCamera


local hrp = script.Parent:WaitForChild("HumanoidRootPart")


local target = nil

local rHeld = false


mouse.Button1Down:Connect(function()
	

	local mouseTarget = mouse.Target

	if mouseTarget and mouseTarget:GetAttribute("canGrab") then


		re:FireServer(mouseTarget)


		target = mouseTarget
	end
end)


mouse.Button1Up:Connect(function()


	re:FireServer(target, true)
end)


game:GetService("UserInputService").InputBegan:Connect(function(inp, processed)

	if not processed and inp.KeyCode == Enum.KeyCode.R and target then

		rHeld = true
	end
end)

game:GetService("UserInputService").InputEnded:Connect(function(inp)

	if inp.KeyCode == Enum.KeyCode.R then

		rHeld = false
	end
end)


game:GetService("RunService").Heartbeat:Connect(function()


	if target and target:GetAttribute("canGrab") == script.Parent.Name then
		local magnitudeSize = target.Size.Magnitude
		local pos = hrp.Position + (mouse.Hit.Position - hrp.Position).Unit * (3+math.ceil(magnitudeSize))
		
		target.BodyPosition.Position = pos

		target.BodyGyro.CFrame = target.CFrame


		if rHeld then
			local position = Vector2.new(mouse.X, mouse.Y)
			local size = Vector2.new(mouse.ViewSizeX, mouse.ViewSizeY)
			local normalizedPosition = position / size
			target.BodyGyro.CFrame = target.BodyGyro.CFrame * CFrame.Angles(normalizedPosition.X-0.5+0.1,normalizedPosition.Y-0.5+0.1, 0)
		end
	end
end)