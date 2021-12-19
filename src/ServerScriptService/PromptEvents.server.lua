local ProximityPromptService = game:GetService("ProximityPromptService")
local ServerScriptService = game:GetService("ServerScriptService")
local PromptActions = require(ServerScriptService.PromptActions)

-- Detect when prompt is triggered
local function onPromptTriggered(promptObject, player)
	PromptActions.promptTriggeredActions(promptObject, player)
end

-- Detect when prompt hold begins
local function onPromptHoldBegan(promptObject, player)
	--PromptActions.promptHoldBeganActions(promptObject, player)
end

-- Detect when prompt hold ends
local function onPromptHoldEnded(promptObject, player)
	--PromptActions.promptHoldEndedActions(promptObject, player)
end

-- Connect prompt events to handling functions
ProximityPromptService.PromptTriggered:Connect(onPromptTriggered)
ProximityPromptService.PromptButtonHoldBegan:Connect(onPromptHoldBegan)
ProximityPromptService.PromptButtonHoldEnded:Connect(onPromptHoldEnded)