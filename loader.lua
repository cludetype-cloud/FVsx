-- FVsx Loader
-- made by cludetype-cloud

print("FVsx Loader Loaded")

-- contoh notifikasi (opsional)
if game:GetService("StarterGui") then
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "FVsx",
            Text = "Loader berhasil dijalankan",
            Duration = 5
        })
    end)
end