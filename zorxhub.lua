-- [[ ZORX HUB & i V1: STAFF EDITION + KILL SOUND 9087024260 ]] --
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
local superSpeedValue = 15 

-- ===== KILL SOUND SYSTEM =====
local KILL_SOUND_ID = "rbxassetid://9087024260"
local function PlayKillEffect()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local sound = Instance.new("Sound", char.HumanoidRootPart)
        sound.SoundId = KILL_SOUND_ID
        sound.Volume = 10
        sound.RollOffMaxDistance = 500
        sound:Play()
        sound.Ended:Connect(function() sound:Destroy() end)
    end
end

-- Deteksi Kill
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

-- [ LANJUTKAN DENGAN UI SETUP DARI SCRIPT SEBELUMNYA ]
-- Pastikan bagian UI dan Button tetap ada di bawah sini.
