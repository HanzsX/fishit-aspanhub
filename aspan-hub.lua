--=====================================================
-- ASPAN-HUB FINAL | Fish It
-- AUTO LEGIT (Visual / Klik Cepat) + AUTO BLATANT (Network)
--=====================================================

------------------ SERVICES ------------------
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VIM = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")

------------------ STATE ------------------
local Mode = { Legit = false, Blatant = false }
local Hub = { Enabled = false, Freeze = true }

------------------ UTIL ------------------
local function equipRod()
    local char = player.Character
    if not char then return end
    for _,t in ipairs(char:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find("rod") then return end
    end
    for _,t in ipairs(backpack:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find("rod") then
            char:FindFirstChildOfClass("Humanoid"):EquipTool(t)
            return
        end
    end
end

local frozenCF
local function freeze(on)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    frozenCF = on and hrp.CFrame or nil
end

------------------ AUTO LEGIT (VISUAL) ------------------
local function isQuickClick()
    -- berdasarkan hasil debug kamu: BillboardGui "Exclaim"
    return Workspace:FindFirstChild("Exclaim", true) ~= nil
end

local function click()
    VIM:SendMouseButtonEvent(0,0,0,true,game,0)
    task.wait(0.02)
    VIM:SendMouseButtonEvent(0,0,0,false,game,0)
end

task.spawn(function()
    while true do
        if Hub.Enabled and Mode.Legit then
            equipRod()
            if isQuickClick() then
                if Hub.Freeze then freeze(true) end
                click()
            else
                freeze(false)
            end
        end
        task.wait(0.03)
    end
end)

------------------ AUTO BLATANT (NETWORK) ------------------
local Blatant = {
    Enabled = false,
    Settings = {
        FishingDelay = 0.01,
        CancelDelay = 0.01,
        HookDetectionDelay = 0.01,
        RequestMinigameDelay = 0.01,
        TimeoutDelay = 0.5,
    }
}

local net = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net")

local RF_ChargeFishingRod = net:WaitForChild("RF/ChargeFishingRod")
local RF_RequestMinigame = net:WaitForChild("RF/RequestFishingMinigameStarted")
local RF_CancelFishingInputs = net:WaitForChild("RF/CancelFishingInputs")
local RE_FishingCompleted = net:WaitForChild("RE/FishingCompleted")
local RE_MinigameChanged = net:WaitForChild("RE/FishingMinigameChanged")
local RE_FishCaught = net:WaitForChild("RE/FishCaught")

local WaitingHook = false
local MinigameConn, FishCaughtConn

local function Cast()
    if not Blatant.Enabled or WaitingHook then return end
    pcall(function()
        RF_ChargeFishingRod:InvokeServer({[22] = tick()})
        task.wait(Blatant.Settings.RequestMinigameDelay)
        RF_RequestMinigame:InvokeServer(9,0,tick())
        WaitingHook = true
        task.delay(Blatant.Settings.TimeoutDelay, function()
            if WaitingHook and Blatant.Enabled then
                WaitingHook = false
                RE_FishingCompleted:FireServer()
                task.wait(Blatant.Settings.CancelDelay)
                pcall(function() RF_CancelFishingInputs:InvokeServer() end)
                task.wait(Blatant.Settings.FishingDelay)
                if Blatant.Enabled then Cast() end
            end
        end)
    end)
end

local function setupBlatant()
    if MinigameConn then MinigameConn:Disconnect() end
    if FishCaughtConn then FishCaughtConn:Disconnect() end

    MinigameConn = RE_MinigameChanged.OnClientEvent:Connect(function(state)
        if not Blatant.Enabled or not WaitingHook then return end
        if typeof(state)=="string" and state:lower():find("hook") then
            WaitingHook = false
            task.wait(Blatant.Settings.HookDetectionDelay)
            RE_FishingCompleted:FireServer()
            task.wait(Blatant.Settings.CancelDelay)
            pcall(function() RF_CancelFishingInputs:InvokeServer() end)
            task.wait(Blatant.Settings.FishingDelay)
            if Blatant.Enabled then Cast() end
        end
    end)

    FishCaughtConn = RE_FishCaught.OnClientEvent:Connect(function()
        if not Blatant.Enabled then return end
        WaitingHook = false
        task.wait(Blatant.Settings.CancelDelay)
        pcall(function() RF_CancelFishingInputs:InvokeServer() end)
        task.wait(Blatant.Settings.FishingDelay)
        if Blatant.Enabled then Cast() end
    end)
end

function Blatant.Start()
    if Blatant.Enabled then return end
    Blatant.Enabled = true
    WaitingHook = false
    setupBlatant()
    task.wait(0.3)
    Cast()
end

function Blatant.Stop()
    Blatant.Enabled = false
    WaitingHook = false
    if MinigameConn then MinigameConn:Disconnect() end
    if FishCaughtConn then FishCaughtConn:Disconnect() end
    pcall(function() RF_CancelFishingInputs:InvokeServer() end)
end

------------------ STOP ALL ------------------
local function stopAll()
    Mode.Legit = false
    Mode.Blatant = false
    Hub.Enabled = false
    Blatant.Stop()
    freeze(false)
end

------------------ UI ------------------
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "ASPAN_HUB"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(440,280)
main.Position = UDim2.fromScale(0.5,0.5)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(17,18,22)
main.BorderSizePixel = 0
main.Active, main.Draggable = true, true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,18)

local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,44)
header.BackgroundColor3 = Color3.fromRGB(22,24,30)
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0,18)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-80,1,0)
title.Position = UDim2.fromOffset(18,0)
title.Text = "ASPAN-HUB • Fish It"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(0,230,200)
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1

local close = Instance.new("TextButton", header)
close.Size = UDim2.fromOffset(30,26)
close.Position = UDim2.new(1,-38,0.5,-13)
close.Text = "✕"
close.Font = Enum.Font.GothamBold
close.TextSize = 14
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(160,60,60)
close.BorderSizePixel = 0
Instance.new("UICorner", close)

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1,-32,1,-76)
content.Position = UDim2.fromOffset(16,60)
content.BackgroundTransparency = 1

-- Buttons
local legitBtn = Instance.new("TextButton", content)
legitBtn.Size = UDim2.fromOffset(420,42)
legitBtn.Position = UDim2.fromOffset(0,0)
legitBtn.Font = Enum.Font.GothamBold
legitBtn.TextSize = 15
legitBtn.BorderSizePixel = 0
Instance.new("UICorner", legitBtn)

local blatantBtn = Instance.new("TextButton", content)
blatantBtn.Size = UDim2.fromOffset(420,42)
blatantBtn.Position = UDim2.fromOffset(0,54)
blatantBtn.Font = Enum.Font.GothamBold
blatantBtn.TextSize = 15
blatantBtn.BorderSizePixel = 0
Instance.new("UICorner", blatantBtn)

local warn = Instance.new("TextLabel", content)
warn.Position = UDim2.fromOffset(0,110)
warn.Size = UDim2.fromOffset(420,34)
warn.Text = "⚠ AUTO BLATANT = HIGH BAN RISK (gunakan singkat)"
warn.Font = Enum.Font.GothamBold
warn.TextSize = 13
warn.TextColor3 = Color3.fromRGB(255,120,120)
warn.TextXAlignment = Enum.TextXAlignment.Left
warn.BackgroundTransparency = 1

local function updateLegitUI()
    if Mode.Legit then
        legitBtn.Text = "AUTO LEGIT : ON"
        legitBtn.BackgroundColor3 = Color3.fromRGB(0,200,160)
    else
        legitBtn.Text = "AUTO LEGIT : OFF"
        legitBtn.BackgroundColor3 = Color3.fromRGB(90,95,120)
    end
end

local function updateBlatantUI()
    if Mode.Blatant then
        blatantBtn.Text = "AUTO BLATANT : ON"
        blatantBtn.BackgroundColor3 = Color3.fromRGB(220,70,70)
    else
        blatantBtn.Text = "AUTO BLATANT : OFF"
        blatantBtn.BackgroundColor3 = Color3.fromRGB(120,80,80)
    end
end

legitBtn.MouseButton1Click:Connect(function()
    if Mode.Legit then
        stopAll()
    else
        stopAll()
        Mode.Legit = true
        Hub.Enabled = true
    end
    updateLegitUI(); updateBlatantUI()
end)

blatantBtn.MouseButton1Click:Connect(function()
    if Mode.Blatant then
        stopAll()
    else
        stopAll()
        Mode.Blatant = true
        Hub.Enabled = true
        Blatant.Start()
    end
    updateBlatantUI(); updateLegitUI()
end)

updateLegitUI()
updateBlatantUI()

-- Minimize
local mini = Instance.new("TextButton", gui)
mini.Size = UDim2.fromOffset(150,38)
mini.Position = UDim2.fromScale(0.02,0.9)
mini.Text = "ASPAN HUB"
mini.Font = Enum.Font.GothamBold
mini.TextSize = 14
mini.TextColor3 = Color3.fromRGB(0,230,200)
mini.BackgroundColor3 = Color3.fromRGB(22,24,30)
mini.BorderSizePixel = 0
Instance.new("UICorner", mini)
mini.Visible = false

close.MouseButton1Click:Connect(function()
    main.Visible = false
    mini.Visible = true
end)
mini.MouseButton1Click:Connect(function()
    main.Visible = true
    mini.Visible = false
end)

print("ASPAN-HUB FINAL LOADED")
