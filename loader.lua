-- Fsvx Hub - Fish It (FULL AUTO)
-- Auto Scan Tool & Remote
-- by cludetype-cloud

if _G.FsvxFull then return end
_G.FsvxFull = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer

-- ================= STATES =================
local AutoFish = false
local Blatant = false
local ESPFish = false
local DimMap = false

-- ================= FOUND =================
local FoundTool
local FoundRemote

-- ================= AUTO SCAN =================
local function scanTool()
    local char = player.Character
    if not char then return end
    for _,v in pairs(char:GetChildren()) do
        if v:IsA("Tool") then
            FoundTool = v
            print("[Fsvx] Tool:", v.Name)
            return
        end
    end
end

local function scanRemote()
    for _,v in pairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            local n = v.Name:lower()
            if n:find("fish") or n:find("cast") or n:find("reel") or n:find("catch") then
                FoundRemote = v
                print("[Fsvx] Remote:", v:GetFullName())
                return
            end
        end
    end
end

task.spawn(function()
    while task.wait(2) do
        if not FoundTool then scanTool() end
        if not FoundRemote then scanRemote() end
    end
end)

player.CharacterAdded:Connect(function()
    task.wait(1)
    FoundTool = nil
    scanTool()
end)

-- ================= UI =================
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "FsvxHub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,420,0,420)
frame.Position = UDim2.new(0.5,-210,0.5,-210)
frame.BackgroundColor3 = Color3.fromRGB(18,18,18)
frame.Active = true
frame.Draggable = true
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "Fsvx Hub – Fish It"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true