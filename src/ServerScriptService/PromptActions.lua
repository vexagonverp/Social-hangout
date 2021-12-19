local PromptActions = {}

local ServerScriptService = game:GetService("ServerScriptService")
local GachaModule = require(ServerScriptService.GachaModule)

function PromptActions.promptTriggeredActions(promptObject, player)
	-- Locate model/folders related to the prompt object
	local ancestorModel = promptObject.Parent
	local valueFolder = ancestorModel:FindFirstChild("Values")
	local soundFolder = ancestorModel:FindFirstChild("Sounds")
	
	-- If model is a shop
	if ancestorModel:GetAttribute("isShop") then
		local playerCharacter = player.Character
		local humanoid = playerCharacter:FindFirstChild("Humanoid")
		local tool = ancestorModel:FindFirstChildWhichIsA("Tool")
		-- If player exist in workspace and not dead
		if humanoid and humanoid.Health>0 then
			local temp = tool:Clone()
			local toolHandle = temp:FindFirstChild("Handle")
			local backpack = player.Backpack
			if backpack:FindFirstChild(tool.Name) == nil and playerCharacter:FindFirstChild(tool.Name) == nil and player.leaderstats:FindFirstChild("Gold").Value >= ancestorModel:GetAttribute("priceShop")  then
				toolHandle.Anchored = false
				toolHandle.CanTouch = true
				temp.Parent = backpack
				player.leaderstats:FindFirstChild("Gold").Value -= ancestorModel:GetAttribute("priceShop")
			end
		end
	end
	if ancestorModel:GetAttribute("isGacha") then
		local playerCharacter = player.Character
		local ownedPet = player:WaitForChild("OwnedPet")
		local humanoid = playerCharacter:FindFirstChild("Humanoid")
		-- If player exist in workspace and not dead
		if humanoid and humanoid.Health>0 then
			if player.leaderstats:FindFirstChild("Gold").Value >= ancestorModel:GetAttribute("priceGacha")  then
				local pet = GachaModule.rollPet(ancestorModel:GetAttribute("bannerGacha"))
				if not ownedPet:FindFirstChild(pet.Name) then
					game.ReplicatedStorage.Events.PetSystem:FireClient(player,pet)
					pet:Clone().Parent = ownedPet
				else
					local banner = game.ReplicatedStorage.Rate:FindFirstChild(ancestorModel:GetAttribute("bannerGacha"))
					player.leaderstats:FindFirstChild("Diamond").Value+=math.floor((100-banner:FindFirstChild(pet.Parent.Name).Value)/10)
				end
				player.leaderstats:FindFirstChild("Gold").Value -= ancestorModel:GetAttribute("priceGacha")
			end
		end
	end
end

return PromptActions
