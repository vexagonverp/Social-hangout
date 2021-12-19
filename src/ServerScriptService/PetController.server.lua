
game.Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(char)
		char.ChildAdded:Connect(function(child)
			if child.Name == "EquippedPet" then
				local bp = Instance.new("BodyPosition", child.PrimaryPart)
				local bg = Instance.new("BodyGyro", child.PrimaryPart)
				bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
				local hrp = char.HumanoidRootPart
				while child.Parent == char do
					wait()
					bp.Position = hrp.Position - (hrp.CFrame.RightVector * 5)
					bg.CFrame = CFrame.new(hrp.Position, hrp.CFrame.LookVector * 10000)
				end
			end
		end)
	end)
end)

game.ReplicatedStorage.Events.PetSystem.OnServerEvent:Connect(function(plr, petToEquip)
	if plr.Character and petToEquip.Parent == plr.OwnedPet then

		local createNewPet = true

		if plr.Character:FindFirstChild("EquippedPet") then

			if plr.Character.EquippedPet.Name == petToEquip.Name then

				createNewPet = false
			end

			plr.Character.EquippedPet:Destroy()
		end

		if createNewPet then

			local newPet = petToEquip:Clone()
			newPet.Name = "EquippedPet"

			newPet.PrimaryPart.CFrame = plr.Character.HumanoidRootPart.CFrame

			newPet.Parent = plr.Character
		end
	end
end)


