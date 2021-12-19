local mam --minutes after midnight
local timeShift = 0.05
local waitTime = 1 
local RunService = game:GetService("RunService")
local Weather = game.ReplicatedStorage.WeatherVariable
local timetoturnoff = 7 * 60 -- change the 7 to the hour after midnight the light should turn off
local timetoturnon = 18 * 60 -- change the 18 to the hour after midnight the light should turn on
local windConstant = 0.00000385802 -- Parabol constant for maximum of 2 and minimum of 0 for wind power
local cityLightFlag = false -- lock function so it doesn't execute every frame
local function adjustWind()
	Weather.WindUpdate.Value = false
	Weather.WindMultiplier.Value = windConstant*math.pow((game.Lighting:GetMinutesAfterMidnight()-720),2)
end
local function addTime()
	mam = game.Lighting:GetMinutesAfterMidnight() + timeShift
	game.Lighting:SetMinutesAfterMidnight(mam)
	mam = mam/60
	if(game.Lighting:GetMinutesAfterMidnight()%60<1) and Weather.WindUpdate.Value then
		adjustWind()
	end
	wait(waitTime)
end

local function cityLightOn(chance)
	cityLightFlag = true
	local cityLight = game.Workspace.CityLight:GetChildren()
	local rng = math.ceil(#cityLight*chance)
	local start = math.random(1,#cityLight-rng)
	for i = start, start+rng do
		cityLight[i].Material = "Neon"
		cityLight[i].Color = Color3.new(0.835294, 0.45098, 0.239216)
	end
end

local function cityLightOff()
	cityLightFlag = false
	local cityLight = game.Workspace.CityLight:GetChildren()
	for i = 1, #cityLight do
		cityLight[i].Material="Glass"
		cityLight[i].Color=Color3.new(0.780392, 0.831373, 0.894118)
	end
end

local function lightToggle()
	if game.Lighting:GetMinutesAfterMidnight() > timetoturnoff and 
		game.Lighting:GetMinutesAfterMidnight() < timetoturnoff+1
	then
		for _,part in pairs(game.Workspace.Light:GetDescendants()) do
			if part:GetAttribute("isLight") then
				part.Material = "Glass"
				part.Color = Color3.new(0.780392, 0.831373, 0.894118)
			end
			if part:isA("PointLight") then
				part.Enabled = false
			end
			if cityLightFlag then
				cityLightOff()
			end
		end
	end
	if game.Lighting:GetMinutesAfterMidnight() > timetoturnon and 
		game.Lighting:GetMinutesAfterMidnight() < timetoturnon+1
	then	
		for _,part in pairs(game.Workspace.Light:GetDescendants()) do
			if part:GetAttribute("isLight") then
				part.Material = "Neon"
				part.Color = Color3.new(0.835294, 0.45098, 0.239216)
			end
			if part:isA("PointLight") then
				part.Enabled = true
			end
			if not cityLightFlag then
				cityLightOn(0.5)
			end
		end
	end	
end



RunService.Heartbeat:Connect(function(step)
	addTime()
	lightToggle()
end)
