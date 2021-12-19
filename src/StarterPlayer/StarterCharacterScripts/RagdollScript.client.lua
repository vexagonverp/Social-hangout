local humanoid = script.Parent:WaitForChild('Humanoid')

local function ragdoll()
	for index,part in pairs(script.Parent:GetDescendants()) do
		if part.Name == ("UpperTorso")then
			local force = Instance.new("BodyVelocity")
			force.Velocity = Vector3.new(nil,math.random(50,100),nil)
			force.Parent = part
			wait(0.3)
			force:Destroy()
		end
		if part:IsA("Motor6D") and part.Name ~= "Neck" then
			local socket = Instance.new("BallSocketConstraint")
			local attachPart0 = Instance.new("Attachment")
			local attachPart1 = Instance.new("Attachment")
			attachPart0.Parent = part.Part0
			attachPart1.Parent = part.Part1
			socket.Parent = part.Parent
			socket.Attachment0 = attachPart0
			socket.Attachment1 = attachPart1
			attachPart0.CFrame = part.C0
			attachPart1.CFrame = part.C1
			socket.LimitsEnabled = true
			socket.TwistLimitsEnabled = true
			part:Destroy()
		end		
	end
end

humanoid.Died:Connect(ragdoll)