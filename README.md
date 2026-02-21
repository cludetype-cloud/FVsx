(1001423943.jpg),


    -- FLY
    if flying then
        local bv = root:FindFirstChild("FlyVel") or Instance.new("BodyVelocity", root); bv.Name = "FlyVel"
        local bg = root:FindFirstChild("FlyGyro") or Instance.new("BodyGyro", root); bg.Name = "FlyGyro"
        bv.MaxForce = Vector3.new(9e9,9e9,9e9); bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
        bg.CFrame = camera.CFrame
        bv.Velocity = Vector3.new(char.Humanoid.MoveDirection.X * flySpeed, vDir, char.Humanoid.MoveDirection.Z * flySpeed)
        char.Humanoid.PlatformStand = true
    end

    -- STICK ENGINE (AUTO-RELEASE IF TARGET FLINGED)
    if stickTarget and stickTarget.Character and stickTarget.Character:FindFirstChild("HumanoidRootPart") then
        local tRoot = stickTarget.Character.HumanoidRootPart
        local dist = (root.Position - tRoot.Position).Magnitude
        
        -- JIKA TERLALU JAUH (>20) BERARTI TARGET KEPENTAL, MATIKAN OTOMATIS
        if dist > 20 or stickTarget.Character.Humanoid.Health <= 0 then
            stickTarget = nil
            char.Humanoid.PlatformStand = false
            showCopyNotif("Auto-Release: Target Terpental!")
        else
            root.CFrame = tRoot.CFrame * CFrame.new(0, 0, 3.5)
            char.Humanoid.PlatformStand = true
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if aimlockOn then
        if not lockTarget or not lockTarget.Parent or lockTarget.Parent:FindFirstChild("Humanoid").Health <= 0 then lockTarget = getClosest() end
        if lockTarget then camera.CFrame = CFrame.new(camera.CFrame.Position, lockTarget.Position) end
    end
end)
# FVsx
FVsx Script Loader
