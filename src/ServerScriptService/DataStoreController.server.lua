local dss = game:GetService("DataStoreService")
local playerDs = dss:GetDataStore("PlayerStat")

function saveData(player)
	pcall(function()
		local level = player.Stats.Level.Value
		local exp = player.Stats.Experience.Value
		local gold = player.leaderstats.Gold.Value
		local diamond = player.leaderstats.Diamond.Value
		local ownedPet = {}
		for i, pet in pairs(player.OwnedPet:GetChildren()) do
			table.insert(ownedPet, pet.Name)
		end
		playerDs:SetAsync(player.UserId .. "Stat", {level,exp,gold,diamond})
		playerDs:SetAsync(player.UserId .. "Pet", ownedPet)
	end)
end

function loadData(player)
	local statsFolder = Instance.new("Folder", player)
	statsFolder.Name = "Stats"
	local levelVal = Instance.new("IntValue", statsFolder)
	levelVal.Name = "Level"
	levelVal.Value = 1
	local expVal = Instance.new("IntValue", statsFolder)
	expVal.Name = "Experience"
	local leaderstats = Instance.new("Folder",player)
	leaderstats.Name = "leaderstats"
	local gold = Instance.new("IntValue",leaderstats)
	gold.Name = "Gold"
	gold.Value = 0
	local diamond = Instance.new("IntValue",leaderstats)
	diamond.Name = "Diamond"
	diamond.Value = 0
	local ownedPet = Instance.new("Folder", player)
	ownedPet.Name = "OwnedPet"
	pcall(function()
		local statsData = playerDs:GetAsync(player.UserId .. "Stat")
		local petsData = playerDs:GetAsync(player.UserId .. "Pet")
		if statsData then
			levelVal.Value = statsData[1]
			expVal.Value = statsData[2]
			gold.Value = statsData[3]
			diamond.Value = statsData[4]
		else
			levelVal.Value = 1
			expVal.Value = 0
			gold.Value = 1000
			diamond.Value = 100
		end
		if petsData then
			for i, petName in pairs(petsData) do
				for x, descendant in pairs(game.ReplicatedStorage:WaitForChild("Pet"):GetDescendants()) do
					if descendant.Name == petName then
						descendant:Clone().Parent = ownedPet
					end
				end
			end
		end
	end)
end

game.Players.PlayerRemoving:Connect(saveData)
game.Players.PlayerAdded:Connect(loadData)

function saveAll()
	for i, player in pairs(game.Players:GetPlayers()) do
		saveData(player)
	end
end

game:BindToClose(saveAll)
