local Tool = script.Parent
local Handle = Tool:WaitForChild("Handle")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local MouseEvent = Tool:WaitForChild("MouseEvent")

local Mouse = nil
local ExpectingInput = 0
local Camera = workspace.CurrentCamera
local FirePointObject = Handle:WaitForChild("GunFirePoint")
local IsMouseDown = false

function UpdateMouseIcon()
	if Mouse and not Tool.Parent:IsA("Backpack") then
		Mouse.Icon = "rbxasset://textures/GunCursor.png"
	end
end

function OnEquipped(playerMouse)
	Mouse = playerMouse
	ExpectingInput = true
	IsMouseDown = false
	UpdateMouseIcon()
end

function OnUnequipped()
	ExpectingInput = false
	IsMouseDown = false
	UpdateMouseIcon()
end

Tool.Equipped:Connect(OnEquipped)
Tool.Unequipped:Connect(OnUnequipped)

UserInputService.InputBegan:Connect(function (input, gameHandledEvent)
	if gameHandledEvent or game.Players.LocalPlayer.Character.Humanoid.Health == ExpectingInput then
		--The ExpectingInput value is used to prevent the gun from firing when it shouldn't on the clientside.
		--This will still be checked on the server.
		return
	end
	
	if input.UserInputType == Enum.UserInputType.MouseButton1 and Mouse ~= nil then
		IsMouseDown = true
	end
end)

UserInputService.InputEnded:Connect(function (input, gameHandledEvent)
	if gameHandledEvent or not ExpectingInput then
		--The ExpectingInput value is used to prevent the gun from firing when it shouldn't on the clientside.
		--This will still be checked on the server.
		return
	end
	
	if input.UserInputType == Enum.UserInputType.MouseButton1 and Mouse ~= nil then
		IsMouseDown = false
	end
end)

game:GetService("RunService").Stepped:Connect(function ()
	if IsMouseDown then
		MouseEvent:FireServer(Mouse.Hit.Position)
	end
end)