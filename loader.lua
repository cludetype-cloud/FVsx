-- FVsx Atomic Fish It
-- made by cludetype-cloud

if _G.FVsxAtomic then return end
_G.FVsxAtomic = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local autoFish = false

-- UI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "FVsxAtomicUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 180)
frame.Position = UDim2.new(0.5, -160, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "FVsx Atomic – Fish It"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local status = Instance.new("TextLabel", frame)
status.Position = UDim2.new(0,0,0,45)
status.Size = UDim2.new(1,0,0,30)
status.BackgroundTransparency = 1
status.Text = "Status: OFF"
status.TextColor3 = Color3.fromRGB(255,80,80)
status.Font = Enum.Font.Gotham
status.TextScaled = true

local toggle = Instance.new("TextButton", frame)
toggle.Position = UDim2.new(0.5,-100,0,90)
toggle.Size = UDim2.new(0,200,0,40)
toggle.Text = "AUTO FISH : OFF"
toggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
toggle.TextColor3 = Color3.fromRGB(255,255,255)
toggle.Font = Enum.Font.GothamBold
toggle.TextScaled = true

local close = Instance.new("TextButton", frame)
close.Position = UDim2.new(0.5,-60,1,-40)
close.Size = UDim2.new(0,120,0,30)
close.Text = "CLOSE"
close.BackgroundColor3 = Color3.fromRGB(60,60,60)
close.TextColor3 = Color3.fromRGB(255,255,255)
close.Font = Enum.Font.GothamBold
close.TextScaled = true

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

toggle.MouseButton1Click:Connect(function()
    autoFish = not autoFish
    if autoFish then
        toggle.Text = "AUTO FISH : ON"
        status.Text = "Status: ON"
        status.TextColor3 = Color3.fromRGB(0,255,120)
    else
        toggle.Text = "AUTO FISH : OFF"
        status.Text = "Status: OFF"
        status.TextColor3 = Color3.fromRGB(255,80,80)
    end
end)

-- AUTO FISH LOOP (basic template)
RunService.Heartbeat:Connect(function()
    if autoFish then
        -- TEMPLATE LOGIC (akan kita upgrade)
        -- contoh: klik / tool activate
        pcall(function()
            local char = player.Character
            if char then
                local tool = char:FindFirstChildOfClass("Tool")
                if tool then
                    tool:Activate()
                end
            end
        end)
    end
end)

print("FVsx Atomic Fish It Loaded")