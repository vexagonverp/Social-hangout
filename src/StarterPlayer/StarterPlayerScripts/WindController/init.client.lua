local WIND_DIRECTION = Vector3.new(1,0,0)
local WIND_POWER = 1
local WIND_SPEED = WIND_POWER*20
local WindLines = require(script.WindLines)
local WindShake = require(script.WindShake)
local re = game.ReplicatedStorage.Events:WaitForChild("WeatherChange")
local windShakeAtribute = script.WindShake
windShakeAtribute:SetAttribute("WindPower",WIND_POWER)
windShakeAtribute:SetAttribute("WindSpeed",WIND_SPEED)
WindShake:Init()
WindLines:Init({
	Direction = WIND_DIRECTION;
	Speed = WIND_SPEED;
	Lifetime = (WIND_SPEED)/100+0.5;
	SpawnRate = WIND_SPEED;
})
re.OnClientEvent:Connect(function(multiplier)
	multiplier +=0.1
	print(multiplier)	
	local windSpeedUpdate = WIND_SPEED*multiplier;
	local windPowerUpdate = WIND_POWER*multiplier;
	windShakeAtribute:SetAttribute("WindPower",windPowerUpdate)
	windShakeAtribute:SetAttribute("WindSpeed",windSpeedUpdate)
	WindShake:Init()
	WindLines:Init({
		Direction = WIND_DIRECTION;
		Speed = windSpeedUpdate;
		Lifetime = (windSpeedUpdate)/100+0.5;
		SpawnRate = windSpeedUpdate;
	})
end)


