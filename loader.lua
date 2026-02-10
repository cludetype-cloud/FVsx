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