-- [[ ZORX HUB & i V1: STAFF EDITION + GLOBAL KILL SOUND + NEW EMOTES ]] --
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

-- ===== 1. GLOBAL KILL SOUND SYSTEM (ID: 9087024260) =====
local KILL_SOUND_ID = "rbxassetid://9087024260"

local function PlayKillEffect()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local sound = Instance.new("Sound")
        sound.Name = "ZorxBroadcast"
        sound.SoundId = KILL_SOUND_ID
        sound.Volume = 10 
        sound.EmitterSize = 100
        sound.MaxDistance = 2500 
        sound.RollOffMaxDistance = 2500
        sound.Parent = char.HumanoidRootPart
        sound:Play()
        task.delay(5, function() if sound then sound:Destroy() end end)
    end
end

local function monitorPlayer(p)
    p.CharacterAdded:Connect(function(char)
        char:WaitForChild("Humanoid").Died:Connect(function()
            if aimlockOn and lockTarget and lockTarget.Parent == char then
                PlayKillEffect()
            end
        end)
    end)
end

for _, p in pairs(game.Players:GetPlayers()) do if p ~= player then monitorPlayer(p) end end
game.Players.PlayerAdded:Connect(monitorPlayer)

-- ===== 2. STAFF SYSTEM =====
TextChatService.OnIncomingMessage = function(message)
    local properties = Instance.new("TextChatMessageProperties")
    if message.Text:sub(1, 7) == "[STAFF]" then
        properties.PrefixText = "[STAFF] " .. message.PrefixText
        properties.Text = message.Text:sub(8)
    end
    return properties
end

local function SendStaffChat()
    local staffTexts = {"Server monitoring active.", "Checking for unusual activity.", "Staff status: Clear."}
    local msg = staffTexts[math.random(1, #staffTexts)]
    local channel = TextChatService:FindFirstChild("TextChannels") and TextChatService.TextChannels:FindFirstChild("RBXGeneral")
    if channel then channel:SendAsync("[STAFF]" .. msg) end
end

-- ===== 3. INVISIBLE & SUPER SPEED =====
local function ToggleInvisSpeed()
    invisSpeedActive = not invisSpeedActive
    local char = player.Character
    if not char then return end
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then
            part.Transparency = invisSpeedActive and 1 or (part.Name == "HumanoidRootPart" and 1 or 0)
        end
    end
end

RunService.Heartbeat:Connect(function()
    if invisSpeedActive and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hum = player.Character:FindFirstChild("Humanoid")
        if hum and hum.MoveDirection.Magnitude > 0 then
            player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame + (hum.MoveDirection * superSpeedValue)
        end
    end
end)

-- ===== 4. CORE UTILS =====
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

local function getClosest()
    local dist = math.huge
    local target = nil
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
            local pos, onScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            if onScreen then
                local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)).Magnitude
                if mag < dist then dist = mag; target = v.Character.HumanoidRootPart end
            end
        end
    end
    return target
end

-- ===== 5. UI SETUP =====
local gui = Instance.new("ScreenGui", player.PlayerGui); gui.ResetOnSpawn = false
local vBtn = Instance.new("TextButton", gui)
vBtn.Size = UDim2.new(0, 50, 0, 50); vBtn.Position = UDim2.new(0, 15, 0.5, 0); vBtn.Text = "V"
vBtn.BackgroundColor3 = Color3.fromRGB(30,30,30); vBtn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", vBtn).CornerRadius = UDim.new(1,0)

local aimlockBtn = Instance.new("TextButton", gui)
aimlockBtn.Size = UDim2.new(0, 100, 0, 45); aimlockBtn.Position = UDim2.new(0.5, -50, 0.8, 0)
aimlockBtn.Text = "AIM: OFF"; aimlockBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50); aimlockBtn.TextColor3 = Color3.new(1,1,1)
aimlockBtn.Visible = false; Instance.new("UICorner", aimlockBtn); makeDraggable(aimlockBtn)

local function createWindow(title, pos)
    local f = Instance.new("Frame", gui); f.Size = UDim2.new(0, 260, 0, 320); f.Position = pos
    f.BackgroundColor3 = Color3.fromRGB(15,15,15); f.Visible = false; Instance.new("UICorner", f); makeDraggable(f)
    local t = Instance.new("TextLabel", f); t.Size = UDim2.new(1,0,0,35); t.Text = title; t.TextColor3 = Color3.new(1,1,1); t.BackgroundColor3 = Color3.fromRGB(25,25,25)
    local s = Instance.new("ScrollingFrame", f); s.Size = UDim2.new(1,-10,1,-45); s.Position = UDim2.new(0,5,0,40); s.BackgroundTransparency = 1; s.CanvasSize = UDim2.new(0,0,2.5,0)
    Instance.new("UIListLayout", s).Padding = UDim.new(0,5)
    return f, s
end

local zorxFrame, zorxScroll = createWindow("ZORX HUB", UDim2.new(0.5, -270, 0.5, -150))
local iV1Frame, iV1Scroll = createWindow("i V1 - EMOTES", UDim2.new(0.5, 10, 0.5, -150))

local function addBtn(txt, parent, cb)
    local b = Instance.new("TextButton", parent); b.Size = UDim2.new(0.95,0,0,40); b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(30,30,30); b.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb); return b
end

-- ===== 6. FEATURES BUTTONS =====
local upBtn = Instance.new("TextButton", gui); upBtn.Size = UDim2.new(0,65,0,65); upBtn.Position = UDim2.new(1,-85, 0.4, 0); upBtn.Text = "UP"; upBtn.Visible = false; Instance.new("UICorner", upBtn)
local downBtn = Instance.new("TextButton", gui); downBtn.Size = UDim2.new(0,65,0,65); downBtn.Position = UDim2.new(1,-85, 0.55, 0); downBtn.Text = "DOWN"; downBtn.Visible = false; Instance.new("UICorner", downBtn)

-- ZORX HUB Category
addBtn("🚀 FLY MODE", zorxScroll, function()
    flying = not flying
    upBtn.Visible = flying; downBtn.Visible = flying
    if flying then
        bodyVel = Instance.new("BodyVelocity", player.Character.HumanoidRootPart); bodyVel.MaxForce = Vector3.new(9e9,9e9,9e9)
        bodyGyro = Instance.new("BodyGyro", player.Character.HumanoidRootPart); bodyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9); bodyGyro.P = 10000
    else
        if bodyVel then bodyVel:Destroy() end; if bodyGyro then bodyGyro:Destroy() end
        player.Character.Humanoid.PlatformStand = false
    end
end)

addBtn("🎯 SETUP AIMLOCK", zorxScroll, function() aimlockBtn.Visible = not aimlockBtn.Visible end)
addBtn("📢 SEND STAFF MSG", zorxScroll, function() SendStaffChat() end)
addBtn("👻 INVIS SUPER SPEED", zorxScroll, function() ToggleInvisSpeed() end)
addBtn("🔊 TEST GLOBAL SOUND", zorxScroll, function() PlayKillEffect() end)
addBtn("🗑️ TONG SAMPAH OTO", zorxScroll, function() loadstring(game:HttpGet("https://raw.githubusercontent.com/yes1nt/yes/refs/heads/main/Trashcan%20Man", true))() end)

-- EMOTES Category
local function playAnim(id)
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. id
    local load = player.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(anim)
    load:Play()
end

addBtn("🕷️ Spider Emote", iV1Scroll, function() loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))() end)
addBtn("💃 Needy Shake", iV1Scroll, function() playAnim("18043914845") end)
addBtn("🕺 Trip Out", iV1Scroll, function() playAnim("11352467571") end)

-- ===== 7. ENGINE =====
vBtn.MouseButton1Click:Connect(function() zorxFrame.Visible = not zorxFrame.Visible; iV1Frame.Visible = zorxFrame.Visible end)
aimlockBtn.MouseButton1Click:Connect(function()
    aimlockOn = not aimlockOn
    aimlockBtn.Text = aimlockOn and "AIM: ON" or "AIM: OFF"
    aimlockBtn.BackgroundColor3 = aimlockOn and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    if not aimlockOn then lockTarget = nil end
end)

upBtn.MouseButton1Down:Connect(function() vDir = 75 end); upBtn.MouseButton1Up:Connect(function() vDir = 0 end)
downBtn.MouseButton1Down:Connect(function() vDir = -75 end); downBtn.MouseButton1Up:Connect(function() vDir = 0 end)

RunService.RenderStepped:Connect(function()
    local char = player.Character
    if flying and char and char:FindFirstChild("HumanoidRootPart") then
        bodyVel.Parent = char.HumanoidRootPart; bodyGyro.Parent = char.HumanoidRootPart
        bodyGyro.CFrame = camera.CFrame
        bodyVel.Velocity = Vector3.new(char.Humanoid.MoveDirection.X * flySpeed, vDir, char.Humanoid.MoveDirection.Z * flySpeed)
        char.Humanoid.PlatformStand = true
    end
    if aimlockOn then
        if not lockTarget or not lockTarget.Parent or lockTarget.Parent:FindFirstChild("Humanoid") == nil or lockTarget.Parent.Humanoid.Health <= 0 then 
            lockTarget = getClosest() 
        end
        if lockTarget then camera.CFrame = CFrame.new(camera.CFrame.Position, lockTarget.Position) end
    end
end)
