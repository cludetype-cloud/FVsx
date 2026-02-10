-- FVsx Fish It Loader
-- made by cludetype-cloud

-- cegah double load
if _G.FVsxLoaded then return end
_G.FVsxLoaded = true

-- UI
local gui = Instance.new("ScreenGui")
gui.Name = "FVsxUI"
gui.Parent = game.CoreGui

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "FVsx – Fish It"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

local status = Instance.new("TextLabel", frame)
status.Position = UDim2.new(0, 0, 0, 50)
status.Size = UDim2.new(1, 0, 0, 40)
status.BackgroundTransparency = 1
status.Text = "Script berhasil dijalankan"
status.TextColor3 = Color3.fromRGB(0, 255, 120)
status.TextScaled = true
status.Font = Enum.Font.Gotham

local close = Instance.new("TextButton", frame)
close.Position = UDim2.new(0.5, -50, 1, -45)
close.Size = UDim2.new(0, 100, 0, 30)
close.Text = "Close"
close.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.Font = Enum.Font.GothamBold
close.TextScaled = true

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

print("FVsx Fish It Loader Loaded")