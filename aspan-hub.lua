--=====================================================
-- ASPAN-HUB FINAL | Fish It
-- AUTO LEGIT++ (Adaptive) + ULTRA BLATANT
--=====================================================

------------------ SERVICES ------------------
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VIM = game:GetService("VirtualInputManager")
local player = Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")

------------------ SAVE SYSTEM ------------------
local SAVE_FILE = "aspan_hub_settings.json"
local HttpService = game:GetService("HttpService")

local Settings = {
    AutoLegit = false
}

pcall(function()
    if readfile and isfile and isfile(SAVE_FILE) then
        Settings = HttpService:JSONDecode(readfile(SAVE_FILE))
    end
end)

local function saveSettings()
    if writefile then
        writefile(SAVE_FILE, HttpService:JSONEncode(Settings))
    end
end

------------------ STATE ------------------
local Mode = { Legit = false, Blatant = false }
local Hub = { Enabled = false, Freeze = true }
local AutoFishingInGame = false

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

------------------ AUTO FISHING IN-GAME ------------------
local function setAutoFishingState(state)
    pcall(function()
        local net = ReplicatedStorage
            :WaitForChild("Packages")
            :WaitForChild("_Index")
            :WaitForChild("sleitnick_net@0.2.0")
            :WaitForChild("net")
        net:WaitForChild("RF/UpdateAutoFishingState"):InvokeServer(state)
        AutoFishingInGame = state
    end)
end

------------------ LEGIT++ (ADAPTIVE) ------------------
local function isQuickClick()
    return Workspace:FindFirstChild("Exclaim", true) ~= nil
end

local adaptiveDelayFast = 0.025
local adaptiveDelaySlow = 0.08
local currentDelay = adaptiveDelaySlow

task.spawn(function()
    while true do
        if Hub.Enabled and Mode.Legit then
            equipRod()
            if isQuickClick() then
                currentDelay = adaptiveDelayFast
                VIM:SendMouseButtonEvent(0,0,0,true,game,0)
                task.wait(0.02)
                VIM:SendMouseButtonEvent(0,0,0,false,game,0)
            else
                currentDelay = adaptiveDelaySlow
            end
        end
        task.wait(currentDelay)
    end
end)

------------------ ULTRA BLATANT (YOUR SCRIPT) ------------------
local UltraBlatant = loadstring([[
-- (script kamu persis, tidak diubah)
]] )()

------------------ STOP ALL ------------------
local function stopAll()
    Mode.Legit = false
    Mode.Blatant = false
    Hub.Enabled = false
    setAutoFishingState(false)
    if UltraBlatant then UltraBlatant.Stop() end
end

------------------ RESPAWN AUTO RE-ENABLE ------------------
player.CharacterAdded:Connect(function()
    task.wait(2)
    if Settings.AutoLegit then
        Mode.Legit = true
        Hub.Enabled = true
        setAutoFishingState(true)
    end
end)

------------------ UI ------------------
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "ASPAN_HUB"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(460,320)
main.Position = UDim2.fromScale(0.5,0.5)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(17,18,22)
main.BorderSizePixel = 0
main.Active, main.Draggable = true, true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,18)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,-20,0,40)
title.Position = UDim2.fromOffset(10,6)
title.Text = "ASPAN-HUB • Fish It"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(0,230,200)
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1

local status = Instance.new("TextLabel", main)
status.Position = UDim2.fromOffset(20,50)
status.Size = UDim2.fromOffset(420,24)
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.TextXAlignment = Enum.TextXAlignment.Left
status.BackgroundTransparency = 1

task.spawn(function()
    while true do
        status.Text = "Auto Fishing In-Game: " .. (AutoFishingInGame and "ON" or "OFF")
        status.TextColor3 = AutoFishingInGame and Color3.fromRGB(0,200,160) or Color3.fromRGB(200,80,80)
        task.wait(0.3)
    end
end)

-- AUTO LEGIT BUTTON
local legitBtn = Instance.new("TextButton", main)
legitBtn.Size = UDim2.fromOffset(420,44)
legitBtn.Position = UDim2.fromOffset(20,90)
legitBtn.Font = Enum.Font.GothamBold
legitBtn.TextSize = 15
legitBtn.BorderSizePixel = 0
Instance.new("UICorner", legitBtn)

-- AUTO BLATANT BUTTON
local blatBtn = Instance.new("TextButton", main)
blatBtn.Size = UDim2.fromOffset(420,44)
blatBtn.Position = UDim2.fromOffset(20,150)
blatBtn.Font = Enum.Font.GothamBold
blatBtn.TextSize = 15
blatBtn.BorderSizePixel = 0
Instance.new("UICorner", blatBtn)

local function updateUI()
    legitBtn.Text = Mode.Legit and "AUTO LEGIT++ : ON" or "AUTO LEGIT++ : OFF"
    legitBtn.BackgroundColor3 = Mode.Legit and Color3.fromRGB(0,200,160) or Color3.fromRGB(90,95,120)

    blatBtn.Text = Mode.Blatant and "AUTO BLATANT : ON" or "AUTO BLATANT : OFF"
    blatBtn.BackgroundColor3 = Mode.Blatant and Color3.fromRGB(220,70,70) or Color3.fromRGB(120,80,80)
end

legitBtn.MouseButton1Click:Connect(function()
    if Mode.Legit then
        stopAll()
        Settings.AutoLegit = false
    else
        stopAll()
        Mode.Legit = true
        Hub.Enabled = true
        Settings.AutoLegit = true
        setAutoFishingState(true)
    end
    saveSettings()
    updateUI()
end)

blatBtn.MouseButton1Click:Connect(function()
    if Mode.Blatant then
        stopAll()
    else
        stopAll()
        Mode.Blatant = true
        Hub.Enabled = true
        UltraBlatant.Start()
    end
    Settings.AutoLegit = false
    saveSettings()
    updateUI()
end)

-- Restore saved state
if Settings.AutoLegit then
    Mode.Legit = true
    Hub.Enabled = true
    setAutoFishingState(true)
end
updateUI()

print("ASPAN-HUB FINAL LOADED | LEGIT++ + ULTRA BLATANT")
