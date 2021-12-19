local PhysicsService = game:GetService("PhysicsService")

game.ReplicatedStorage.Events:WaitForChild("PropGrab").OnServerEvent:Connect(function(plr, target, dropping)
	
	if not target then return end
	
	
	if dropping then 
		
		
		target:SetNetworkOwner(nil)
		PhysicsService:SetPartCollisionGroup(target,"Default")
		
		for i, child in pairs(target:GetChildren()) do
			
			if child:IsA("BodyGyro") or child:IsA("BodyPosition") then
				
				child:Destroy()
			end
		end
		
		target:SetAttribute("canGrab","")
	
	
	elseif target:GetAttribute("canGrab") and target:GetAttribute("canGrab") == "" then
		
		
		local distance = (plr.Character.HumanoidRootPart.Position - target.Position).Magnitude
		
		if distance > 15 then return end
		
		target.CanCollide = false;
		target:SetAttribute("canGrab",plr.Name)
		PhysicsService:SetPartCollisionGroup(target,"Prop")
		
		if not target:FindFirstChild("BodyPosition") then
			
			local bp = Instance.new("BodyPosition", target)
			bp.D = 100
			bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		end
		
		if not target:FindFirstChild("BodyGyro") then
			
			local bg = Instance.new("BodyGyro", target)
			bg.D = 100
			bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		end
		
		
		target.Anchored = false
		
		target:SetNetworkOwner(plr)
		wait(0.1)
		target.CanCollide = true;
	end
end)