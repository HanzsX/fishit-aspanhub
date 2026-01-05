--=====================================================
-- ASPAN-HUB | AUTO LEGIT++ (SAFE)
--=====================================================

local VirtualInputManager = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")

local AutoLegit = {}
AutoLegit.Enabled = false

-- Deteksi prompt fishing (Exclaim / Tap Here)
local function isFishingPrompt()
    return Workspace:FindFirstChild("Exclaim", true) ~= nil
end

-- Loop utama
task.spawn(function()
    while task.wait(0.03) do
        if AutoLegit.Enabled and isFishingPrompt() then
            VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,0)
            task.wait(0.02)
            VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,0)
        end
    end
end)

function AutoLegit.Start()
    if AutoLegit.Enabled then return end
    AutoLegit.Enabled = true
    warn("[ASPAN] Auto Legit++ STARTED")
end

function AutoLegit.Stop()
    AutoLegit.Enabled = false
    warn("[ASPAN] Auto Legit++ STOPPED")
end

return AutoLegit
