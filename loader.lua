-- Fsvx Hub - FIX VERSION

pcall(function()
    local gui = Instance.new("ScreenGui")
    gui.Name = "FsvxTest"
    gui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0,300,0,200)
    frame.Position = UDim2.new(0.5,-150,0.5,-100)
    frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
    frame.Active = true
    frame.Draggable = true

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,40)
    title.Text = "Fsvx Hub"
    title.TextColor3 = Color3.new(1,1,1)
    title.BackgroundTransparency = 1
    title.TextScaled = true

    local btn = Instance.new("TextButton", frame)
    btn.Position = UDim2.new(0.5,-100,0.5,-20)
    btn.Size = UDim2.new(0,200,0,40)
    btn.Text = "AUTO FISH : OFF"
    btn.TextScaled = true
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1)

    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on
        btn.Text = on and "AUTO FISH : ON" or "AUTO FISH : OFF"
    end)
end)

print("Fsvx FIX Loaded")
-- Fsvx Blatant Loader

local ScriptURL = "https://raw.githubusercontent.com/Bxkiller/Fsvx/main/Fsvx.lua"

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local plr = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FsvxBlatantLoader"
gui.Parent = plr:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 350, 0, 180)
frame.Position = UDim2.new(0.5, -175, -0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Corner
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,45)
title.Text = "FSVX LOADER"
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(255,70,70)
title.BackgroundTransparency = 1

-- Status
local status = Instance.new("TextLabel", frame)
status.Position = UDim2.new(0,0,0,60)
status.Size = UDim2.new(1,0,0,40)
status.Text = "Status : Initializing..."
status.Font = Enum.Font.Gotham
status.TextSize = 16
status.TextColor3 = Color3.fromRGB(200,200,200)
status.BackgroundTransparency = 1

-- Bar BG
local barBG = Instance.new("Frame", frame)
barBG.Position = UDim2.new(0.1,0,0.65,0)
barBG.Size = UDim2.new(0.8,0,0,18)
barBG.BackgroundColor3 = Color3.fromRGB(30,30,30)
barBG.BorderSizePixel = 0
Instance.new("UICorner", barBG).CornerRadius = UDim.new(1,0)

-- Bar
local bar = Instance.new("Frame", barBG)
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(255,70,70)
bar.BorderSizePixel = 0
Instance.new("UICorner", bar).CornerRadius = UDim.new(1,0)

-- Tween masuk
TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
    Position = UDim2.new(0.5,-175,0.4,0)
}):Play()

-- Loading steps
local function setProgress(text, percent)
    status.Text = text
    TweenService:Create(bar, TweenInfo.new(0.3), {
        Size = UDim2.new(percent,0,1,0)
    }):Play()
    task.wait(0.5)
end

setProgress("Status : Checking game...", 0.3)
setProgress("Status : Connecting to Fsvx...", 0.6)
setProgress("Status : Loading script...", 0.9)

-- Load main script
local success, err = pcall(function()
    loadstring(game:HttpGet(ScriptURL))()
end)

if success then
    setProgress("Status : Loaded Successfully!", 1)
else
    status.Text = "Status : Load Failed!"
    warn(err)
end

task.wait(0.8)
gui:Destroy()