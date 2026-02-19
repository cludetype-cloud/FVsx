-- [[ GLOBAL EMOTE REPLICATION SYSTEM ]] --
local args = {...}
local emoteName = args[1]
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Fungsi agar animasi terlihat oleh semua pemain (Server-Side Replication)
local function playGlobal(id)
    -- Hentikan animasi yang sedang berjalan agar tidak tumpang tindih
    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
        track:Stop()
    end

    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. id
    local track = humanoid:LoadAnimation(anim)
    
    -- Priority ACTION memastikan gerakan terlihat oleh player lain meskipun kamu bergerak
    track.Priority = Enum.AnimationPriority.Action 
    track.Looped = true
    track:Play()
end

-- Logika pemilihan emote berdasarkan argumen loadstring
if emoteName == "NeedyShake" then
    playGlobal("18043914845")
elseif emoteName == "TripOut" then
    playGlobal("11352467571")
elseif emoteName == "Spider" then
    loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
end
