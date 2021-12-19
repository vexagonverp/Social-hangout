local GachaModule = {}

local rateFolder = game.ReplicatedStorage.Rate
local petFolder = game.ReplicatedStorage.Pet
function GachaModule.rollPet(rollRate)
	local probability = rateFolder:FindFirstChild(rollRate):GetChildren()
	local rate={}
	for i, rarity in pairs(probability) do
		rate[rarity.Name]=rarity.Value
	end
	
	local rng = math.random(1,100)
	local counter = 0
	for rariry,weight in pairs(rate) do
		counter = counter + weight
		if rng <= counter then
			local rarityTable = petFolder[rariry]
			local rarityPet = rarityTable:GetChildren()
			return rarityPet[math.random(1, #rarityPet)]
		end
	end
end

return GachaModule
