-- [[ ZORX HUB FINAL - GLOBAL SOUND FIX 100% ]] --
local player = game.Players.LocalPlayer
local TextChatService = game:GetService("TextChatService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local camera = workspace.CurrentCamera

-- Variables
local flying = false
local aimlockOn = false
local lockTarget = nil
local invisSpeedActive = false
local vDir = 0
local flySpeed = 85
local superSpeedValue = 15 

-- ===== 1. GLOBAL KILL SOUND (FIX FE BYPASS) =====
local KILL_SOUND_ID = "rbxassetid://9087024260"

local function PlayKillEffect()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        -- Gunakan folder SoundService sebagai cadangan & HumanoidRootPart sebagai Sumber Utama
        -- Agar didengar orang lain, suara harus diletakkan di objek yang sudah ada sejak spawn
        local sound = char.HumanoidRootPart:FindFirstChild("ZorxKillSound")
        if not sound then
            sound = Instance.new("Sound")
            sound.Name = "ZorxKillSound"
            sound.Parent = char.HumanoidRootPart
        end
        
        sound.SoundId = KILL_SOUND_ID
        sound.Volume = 10 -- Volume mentok
        sound.Pitch = 1.0
        sound.EmitterSize = 100
        sound.MaxDistance = 2500 -- Sangat Jauh
        sound.RollOffMaxDistance = 2500
        
        -- Paksa Play (Stop dulu jika sedang bunyi)
        sound:Stop()
        sound:Play()
        
        -- Tambahan trik: Mainkan juga di SoundService (Hanya untuk local tapi memperkuat audio)
        game:GetService("SoundService"):PlayLocalSound(sound)
    end
end

-- Deteksi Otomatis (Work untuk semua Hero/Player)
local function monitorPlayer(p)
    p.CharacterAdded:Connect(function(char)
        char:WaitForChild("Humanoid").Died:Connect(function()
            local myChar = player.Character
            if myChar and myChar:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("HumanoidRootPart") then
                local dist = (myChar.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
                -- Bunyi jika musuh yang kita lock mati ATAU musuh mati di dekat kita
                if (aimlockOn and lockTarget and lockTarget.Parent == char) or (dist < 60) then
                    PlayKillEffect()
                end
            end
        end)
    end)
end

for _, p in pairs(game.Players:GetPlayers()) do if p ~= player then monitorPlayer(p) end end
game.Players.PlayerAdded:Connect(monitorPlayer)

-- ===== 2. STAFF & UI SYSTEM (DISEDERHANAKAN) =====
local function SendStaffChat()
    local channel = TextChatService:FindFirstChild("TextChannels") and TextChatService.TextChannels:FindFirstChild("RBXGeneral")
    if channel then channel:SendAsync("[STAFF] Server Status: Clear. Monitoring Active.") end
end

local function ToggleInvisSpeed()
    invisSpeedActive = not invisSpeedActive
    if player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                v.Transparency = invisSpeedActive and 1 or (v.Name == "HumanoidRootPart" and 1 or 0)
            end
        end
    end
end

-- ===== 3. UI SETUP =====
local gui = Instance.new("ScreenGui", player.PlayerGui); gui.ResetOnSpawn = false
local vBtn = Instance.new("TextButton", gui)
vBtn.Size = UDim2.new(0, 50, 0, 50); vBtn.Position = UDim2.new(0, 15, 0.5, 0); vBtn.Text = "V"; vBtn.BackgroundColor3 = Color3.fromRGB(30,30,30); vBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", vBtn).CornerRadius = UDim.new(1,0)

local function createWindow(title, pos)
    local f = Instance.new("Frame", gui); f.Size = UDim2.new(0, 260, 0, 320); f.Position = pos; f.BackgroundColor3 = Color3.fromRGB(15,15,15); f.Visible = false; Instance.new("UICorner", f)
    local s = Instance.new("ScrollingFrame", f); s.Size = UDim2.new(1,-10,1,-45); s.Position = UDim2.new(0,5,0,40); s.BackgroundTransparency = 1; s.CanvasSize = UDim2.new(0,0,2.5,0)
    Instance.new("UIListLayout", s).Padding = UDim.new(0,5)
    return f, s
end

local zorxFrame, zorxScroll = createWindow("ZORX HUB", UDim2.new(0.5, -130, 0.5, -150))
local function addBtn(txt, parent, cb)
    local b = Instance.new("TextButton", parent); b.Size = UDim2.new(0.95,0,0,40); b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(30,30,30); b.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb); return b
end

addBtn("🚀 FLY MODE", zorxScroll, function() flying = not flying end)
addBtn("🎯 AIMLOCK (ON/OFF)", zorxScroll, function() aimlockOn = not aimlockOn end)
addBtn("👻 INVIS SUPER SPEED", zorxScroll, function() ToggleInvisSpeed() end)
addBtn("🔊 TEST GLOBAL SOUND", zorxScroll, function() PlayKillEffect() end)
addBtn("📢 STAFF MSG", zorxScroll, function() SendStaffChat() end)

-- ===== 4. ENGINE LOOP =====
vBtn.MouseButton1Click:Connect(function() zorxFrame.Visible = not zorxFrame.Visible end)

RunService.Heartbeat:Connect(function()
    if invisSpeedActive and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hum = player.Character:FindFirstChild("Humanoid")
        if hum and hum.MoveDirection.Magnitude > 0 then
            player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame + (hum.MoveDirection * superSpeedValue)
        end
    end
    if aimlockOn then
        if not lockTarget or lockTarget.Parent.Humanoid.Health <= 0 then
            local dist = math.huge
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local mag = (v.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if mag < dist then dist = mag; lockTarget = v.Character.HumanoidRootPart end
                end
            end
        end
        if lockTarget then camera.CFrame = CFrame.new(camera.CFrame.Position, lockTarget.Position) end
    end
end)
