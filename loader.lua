-- Fsvx Loader
-- by Bxkiller

if _G.FsvxLoaded then return end
_G.FsvxLoaded = true

local url = "https://raw.githubusercontent.com/Bxkiller/Fsvx/main/library.lua"
loadstring(game:HttpGet(url))()