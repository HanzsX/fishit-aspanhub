--=====================================================
-- ASPAN-HUB | AUTO BLATANT (FAST / RISK)
--=====================================================

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local net = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0")
    :WaitForChild("net")

local RF_Charge = net:WaitForChild("RF/ChargeFishingRod")
local RF_Request = net:WaitForChild("RF/RequestFishingMinigameStarted")
local RF_Cancel = net:WaitForChild("RF/CancelFishingInputs")
local RF_Auto = net:WaitForChild("RF/UpdateAutoFishingState")
local RE_Complete = net:WaitForChild("RE/FishingCompleted")

local AutoBlatant = {}
AutoBlatant.Enabled = false

task.spawn(function()
    while task.wait(0.15) do
        if AutoBlatant.Enabled then
            local t = tick()
            pcall(function()
                RF_Charge:InvokeServer({[1] = t})
                RF_Request:InvokeServer(1,0,t)
            end)

            task.wait(0.7)

            if AutoBlatant.Enabled then
                pcall(function()
                    RE_Complete:FireServer()
                    RF_Cancel:InvokeServer()
                end)
            end
        end
    end
end)

function AutoBlatant.Start()
    if AutoBlatant.Enabled then return end
    AutoBlatant.Enabled = true
    pcall(function() RF_Auto:InvokeServer(true) end)
    warn("[ASPAN] Auto Blatant STARTED")
end

function AutoBlatant.Stop()
    AutoBlatant.Enabled = false
    pcall(function() RF_Cancel:InvokeServer() end)
    warn("[ASPAN] Auto Blatant STOPPED")
end

return AutoBlatant
