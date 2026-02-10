-- Fsvx | Fish It (Visual Only)
-- by Bxkiller

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local LP = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")

-- Notifikasi
pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "Fsvx",
        Text = "Fsvx Main Loaded",
        Duration = 5
    })
end)

-- UI
local gui = Instance.new("ScreenGui")
gui.Name = "FsvxUI"
gui.Parent = game.CoreGui

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.fromScale(0.38, 0.52)
main.Position = UDim2.fromScale(0.31, 0.24)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.fromScale(1, 0.12)
title.Text = "Fsvx | Fish It"
title.TextScaled = true
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout")
layout.Parent = main
layout.Padding = UDim.new(0, 6)

-- Fungsi tombol
local function Button(text, callback)
    local b = Instance.new("TextButton")
    b.Parent = main
    b.Size = UDim2.fromScale(0.9, 0.1)
    b.Text = text
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.TextColor3 = Color3.new(1,1,1)
    b.MouseButton1Click:Connect(callback)
end

-- ================= FITUR =================

-- ESP Fish
Button("ESP Fish", function()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and string.find(v.Name:lower(), "fish") then
            if not v:FindFirstChild("FsvxESP") then
                local h = Instance.new("Highlight")
                h.Name = "FsvxESP"
                h.FillColor = Color3.fromRGB(0,255,255)
                h.OutlineColor = Color3.fromRGB(255,255,255)
                h.Parent = v
            end
        end
    end
end)

-- Box Size Fish
Button("Box Size Fish", function()
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

-- Redup Map (Toggle)
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

-- Teleport Lokal (Random)
Button("Teleport Lokal", function()
    local char = LP.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame =
            CFrame.new(math.random(-120,120), 10, math.random(-120,120))
    end
end)

-- Close UI
Button("Close UI", function()
    gui:Destroy()
end)