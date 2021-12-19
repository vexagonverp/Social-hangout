local re = game.ReplicatedStorage.Events:WaitForChild("PetSystem")

local hatched = script.Parent.PetHatchedFrame
local inv = script.Parent.PetInventoryFrame
hatched.Visible, inv.Visible = false, false


local ownedPets = game.Players.LocalPlayer:WaitForChild("OwnedPet")


function updateInventory()
	
	for i, child in pairs(inv.PetScroller:GetChildren()) do
		
		if child:IsA("ImageButton") then child:Destroy() end
	end
	
	local pets = ownedPets:GetChildren()
	
	for i, pet in pairs(pets) do
		
		local newButton = script.PetButton:Clone()
		
		newButton.PetName.Text = pet.Name
		
		for x, descendant in pairs(game.ReplicatedStorage:WaitForChild("Pet"):GetDescendants()) do
			if descendant.Name == pet.Name then
				newButton.PetRarity.Text = descendant.Parent.Name
			end
		end
		
		local cam = Instance.new("Camera", newButton.PetImage)
		newButton.PetImage.CurrentCamera = cam

		local vpfPet = pet:Clone()
		vpfPet.Parent = newButton.PetImage
		if vpfPet:WaitForChild("Hitbox",100) or vpfPet.PrimaryPart then
			local petHitBox = vpfPet:WaitForChild("Hitbox")
			cam.CFrame = CFrame.new(petHitBox.Position + petHitBox.CFrame.LookVector * 3 + Vector3.new(-2, -1, -1), petHitBox.Position)
		end
		
		newButton.Parent = inv.PetScroller
		
		inv.PetScroller.CanvasSize = UDim2.new(0, 0, 0, inv.PetScroller.UIGridLayout.AbsoluteContentSize.Y)
		
		
		newButton.MouseButton1Click:Connect(function()
			
			re:FireServer(pet)
		end)
	end
end


script.Parent.InventoryButton.MouseButton1Click:Connect(function()
	
	inv.Visible = not inv.Visible
end)

inv.CloseButton.MouseButton1Click:Connect(function()
	
	inv.Visible = not inv.Visible
end)


updateInventory()

ownedPets.DescendantAdded:Connect(updateInventory)
ownedPets.DescendantRemoving:Connect(updateInventory)



re.OnClientEvent:Connect(function(pet)
	
	hatched.PetImage:ClearAllChildren()
	
	local cam = Instance.new("Camera", hatched.PetImage)
	hatched.PetImage.CurrentCamera = cam
	
	local vpfPet = pet:Clone()
	vpfPet.Parent = hatched.PetImage
	
	cam.CFrame = CFrame.new(vpfPet.PrimaryPart.Position + vpfPet.PrimaryPart.CFrame.LookVector * 3 + Vector3.new(0, -1, -1), vpfPet.PrimaryPart.Position)
	
	
	hatched.PetName.Text = pet.Name
	
	for x, descendant in pairs(game.ReplicatedStorage:WaitForChild("Pet"):GetDescendants()) do
		if descendant.Name == pet.Name then
			hatched.PetRarity.Text = descendant.Parent.Name
		end
	end
	
	
	hatched.Visible = true
	
	hatched.ClaimButton.MouseButton1Click:Wait()
	
	hatched.Visible = false
end)