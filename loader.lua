-- Fsvx | Fish It (Visual Only)
-- by Bxkiller

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local LP = Players.LocalPlayer

-- Notification
pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "Fsvx",
        Text = "Fsvx Loaded (Visual Only)",
        Duration = 5
    })
end)

-- UI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "FsvxUI"

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.38, 0.5)
main.Position = UDim2.fromScale(0.31, 0.25)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.fromScale(1, 0.12)
title.Text = "Fsvx | Fish It"
title.TextScaled = true
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", main)
layout.Padding = UDim.new(0, 6)

-- Button maker
local function Button(text, callback)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.fromScale(0.9, 0.1)
    b.Text = text
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.TextColor3 = Color3.new(1,1,1)
    b.MouseButton1Click:Connect(callback)
end

-- === FEATURES ===

-- ESP Fish
Button("ESP Fish", function()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and string.find(v.Name:lower(), "fish") then
            if not v:FindFirstChild("FsvxESP") then
                local h = Instance.new("Highlight", v)
                h.Name = "FsvxESP"
                h.FillColor = Color3.fromRGB(0,255,255)
                h.OutlineColor = Color3.fromRGB(255,255,255)
            end
        end
    end
end)

-- Box Size Fish
Button("Box Fish Size", function()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and string.find(v.Name:lower(), "fish") then
            for _,p in pairs(v:GetChildren()) do
                if p:IsA("BasePart") then
                    p.Size = p.Size * 1.2
                end
            end
        end
    end
end)

-- Redup Map
local dim = false
Button("Redup Map (Toggle)", function()
    dim = not dim
    if dim then
        Lighting.Brightness = 0.5
        Lighting.Ambient = Color3.fromRGB(80,80,80)
    else
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.fromRGB(255,255,255)
    end
end)

-- Teleport Lokal
Button("Teleport Random", function()
    local char = LP.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame =
            CFrame.new(math.random(-100,100), 10, math.random(-100,100))
    end
end)

-- Close
Button("Close UI", function()
    gui:Destroy()
end)