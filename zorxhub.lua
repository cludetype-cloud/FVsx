-- [[ ZORX HUB & i V1: CUSTOM LOGO EDITION ]] --
local player = game.Players.LocalPlayer
local TextChatService = game:GetService("TextChatService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local camera = workspace.CurrentCamera

-- Variables State
local flying = false
local aimlockOn = false
local lockTarget = nil
local invisSpeedActive = false
local vDir = 0
local flySpeed = 85
local bodyVel, bodyGyro
local superSpeedValue = 15 

-- ===== 1. STAFF SYSTEM =====
TextChatService.OnIncomingMessage = function(message)
    local properties = Instance.new("TextChatMessageProperties")
    if message.Text:sub(1, 7) == "[STAFF]" then
        properties.PrefixText = "[STAFF] " .. message.PrefixText
        properties.Text = message.Text:sub(8)
    end
    return properties
end

local function SendStaffChat()
    local staffTexts = {"Server monitoring active.", "Checking for unusual activity.", "Staff monitoring: Clear."}
    local msg = staffTexts[math.random(1, #staffTexts)]
    local channel = TextChatService:FindFirstChild("TextChannels") and TextChatService.TextChannels:FindFirstChild("RBXGeneral")
    if channel then channel:SendAsync("[STAFF]" .. msg) end
end

-- ===== 2. FIX INVISIBLE & SUPER SPEED =====
local function ToggleInvisSpeed()
    invisSpeedActive = not invisSpeedActive
    local char = player.Character
    if not char then return end
    if invisSpeedActive then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = 1 end
        end
    else
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                if v.Name ~= "HumanoidRootPart" then v.Transparency = 0 end
            end
        end
    end
end

RunService.Heartbeat:Connect(function()
    if invisSpeedActive and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hum = player.Character.Humanoid
        local root = player.Character.HumanoidRootPart
        if hum.MoveDirection.Magnitude > 0 then
            root.CFrame = root.CFrame + (hum.MoveDirection * superSpeedValue)
        end
    end
end)

-- ===== 3. CORE UTILS =====
local function makeDraggable(obj)
    local dragging, input, startPos, startInput
    obj.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true; startInput = i.Position; startPos = obj.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local delta = i.Position - startInput
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    obj.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
end

-- ===== 4. UI SETUP =====
local gui = Instance.new("ScreenGui", player.PlayerGui); gui.ResetOnSpawn = false

-- TOMBOL LOGO (PENGGANTI HURUF V)
local vBtn = Instance.new("ImageButton", gui)
vBtn.Name = "MainLogo"
vBtn.Size = UDim2.new(0, 70, 0, 70)
vBtn.Position = UDim2.new(0, 15, 0.5, -35)
vBtn.BackgroundTransparency = 1
-- GANTI ID DI BAWAH INI DENGAN ID FOTO KAMU
vBtn.Image = "rbxassetid://13111465762" 

local stroke = Instance.new("UIStroke", vBtn)
stroke.Color = Color3.fromRGB(0, 255, 150)
stroke.Thickness = 2
Instance.new("UICorner", vBtn).CornerRadius = UDim.new(1, 0)

local function createWindow(title, pos)
    local f = Instance.new("Frame", gui); f.Size = UDim2.new(0, 260, 0, 300); f.Position = pos
    f.BackgroundColor3 = Color3.fromRGB(15,15,15); f.Visible = false; Instance.new("UICorner", f); makeDraggable(f)
    local t = Instance.new("TextLabel", f); t.Size = UDim2.new(1,0,0,35); t.Text = title; t.TextColor3 = Color3.new(1,1,1); t.BackgroundColor3 = Color3.fromRGB(25,25,25)
    local s = Instance.new("ScrollingFrame", f); s.Size = UDim2.new(1,-10,1,-45); s.Position = UDim2.new(0,5,0,40); s.BackgroundTransparency = 1; s.CanvasSize = UDim2.new(0,0,2.2,0)
    Instance.new("UIListLayout", s).Padding = UDim.new(0,5)
    return f, s
end

local zorxFrame, zorxScroll = createWindow("ZORX HUB", UDim2.new(0.5, -270, 0.5, -150))
local iV1Frame, iV1Scroll = createWindow("i V1 - EMOTES", UDim2.new(0.5, 10, 0.5, -150))

local function addBtn(txt, parent, cb)
    local b = Instance.new("TextButton", parent); b.Size = UDim2.new(0.95,0,0,45); b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(30,30,30); b.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb); return b
end

addBtn("🚀 FLY MODE", zorxScroll, function()
    flying = not flying
    if flying then
        bodyVel = Instance.new("BodyVelocity", player.Character.HumanoidRootPart); bodyVel.MaxForce = Vector3.new(9e9,9e9,9e9)
        bodyGyro = Instance.new("BodyGyro", player.Character.HumanoidRootPart); bodyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9)
    else
        if bodyVel then bodyVel:Destroy() end; if bodyGyro then bodyGyro:Destroy() end
        player.Character.Humanoid.PlatformStand = false
    end
end)

addBtn("👻 INVIS SUPER SPEED", zorxScroll, function() ToggleInvisSpeed() end)
addBtn("🗑️ TONG SAMPAH OTO", zorxScroll, function() loadstring(game:HttpGet("https://raw.githubusercontent.com/yes1nt/yes/refs/heads/main/Trashcan%20Man", true))() end)

vBtn.MouseButton1Click:Connect(function() zorxFrame.Visible = not zorxFrame.Visible; iV1Frame.Visible = zorxFrame.Visible end)
