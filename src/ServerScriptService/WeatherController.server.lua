local re = game.ReplicatedStorage.Events:WaitForChild("WeatherChange")
local boolWeather=game.ReplicatedStorage.WeatherVariable.WindUpdate

boolWeather.Changed:Connect(function(weather)
	if not weather then
		game.ReplicatedStorage.Events.WeatherChange:FireAllClients(game.ReplicatedStorage.WeatherVariable.WindMultiplier.Value)
		wait(0.3)
		boolWeather.Value = true 
	end
end)