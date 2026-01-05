--=====================================================
--  ASPAN-HUB FINAL (LEGIT++ + BLATANT + MODERN UI)
--=====================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")

--=====================================================
-- AUTO LEGIT++ (WORKING)
--=====================================================
local AutoLegit = {}
AutoLegit.Enabled = false

local function isQuickClickActive()
    return Workspace:FindFirstChild("Exclaim", true) ~= nil
end

task.spawn(function()
    while true do
        if AutoLegit.Enabled and isQuickClickActive() then
            VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,0)
            task.wait(0.02)
            VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,0)
        end
        task.wait(0.03)
    end
end)

function AutoLegit.Start()
    AutoLegit.Enabled = true
    print("[ASPAN] Auto Legit++ ON")
end

function AutoLegit.Stop()
    AutoLegit.Enabled = false
    print("[ASPAN] Auto Legit++ OFF")
end

--=====================================================
-- AUTO BLATANT (FIXED)
--=====================================================
local net = ReplicatedStorage:WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0")
    :WaitForChild("net")

local RF_Charge = net:WaitForChild("RF/ChargeFishingRod")
local RF_Request = net:WaitForChild("RF/RequestFishingMinigameStarted")
local RF_Cancel = net:WaitForChild("RF/CancelFishingInputs")
local RF_AutoState = net:WaitForChild("RF/UpdateAutoFishingState")
local RE_Complete = net:WaitForChild("RE/FishingCompleted")

local AutoBlatant = { Enabled = false }

task.spawn(function()
    while true do
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
        task.wait(0.2)
    end
end)

function AutoBlatant.Start()
    AutoBlatant.Enabled = true
    pcall(function() RF_AutoState:InvokeServer(true) end)
    print("[ASPAN] Auto Blatant ON")
end

function AutoBlatant.Stop()
    AutoBlatant.Enabled = false
    pcall(function() RF_Cancel:InvokeServer() end)
    print("[ASPAN] Auto Blatant OFF")
end

--=====================================================
-- UI CREATION
--=====================================================
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "ASPAN_HUB"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.55,0.6)
main.Position = UDim2.fromScale(0.22,0.2)
main.BackgroundColor3 = Color3.fromRGB(18,20,25)
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

-- Sidebar
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0.22,0,1,0)
sidebar.BackgroundColor3 = Color3.fromRGB(22,24,30)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,16)

-- Title
local title = Instance.new("TextLabel", sidebar)
title.Text = "ASPAN HUB"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(0,200,170)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1,0,0,50)

-- Content
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0.24,0,0,0)
content.Size = UDim2.new(0.76,0,1,0)
content.BackgroundTransparency = 1

-- Pages
local pages = {}
local function newPage(name)
    local f = Instance.new("Frame", content)
    f.Size = UDim2.fromScale(1,1)
    f.Visible = false
    f.BackgroundTransparency = 1
    local l = Instance.new("UIListLayout", f)
    l.Padding = UDim.new(0,14)
    pages[name] = f
    return f
end

local function showPage(name)
    for _,p in pairs(pages) do p.Visible = false end
    pages[name].Visible = true
end

-- Section
local function section(parent, text)
    local box = Instance.new("Frame", parent)
    box.Size = UDim2.new(1,0,0,120)
    box.BackgroundColor3 = Color3.fromRGB(28,30,36)
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,14)

    local lbl = Instance.new("TextLabel", box)
    lbl.Text = text
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.BackgroundTransparency = 1
    lbl.Position = UDim2.new(0,16,0,10)
    lbl.Size = UDim2.new(1,-32,0,20)
    return box
end

-- Toggle
local function toggle(parent, text, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.6,0,0,36)
    btn.Position = UDim2.new(0,16,0,50)
    btn.BackgroundColor3 = Color3.fromRGB(40,42,50)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

    local state = false
    btn.Text = text.." : OFF"

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. (state and " : ON" or " : OFF")
        callback(state)
    end)
end

-- Pages
local farm = newPage("Farm")
local map = newPage("Map")
local auto = newPage("Automatic")
local shop = newPage("Shop")

local secFish = section(farm, "AUTO FISHING")
toggle(secFish, "Auto Legit++", function(on)
    if on then AutoLegit.Start() else AutoLegit.Stop() end
end)

toggle(secFish, "Auto Blatant", function(on)
    if on then AutoBlatant.Start() else AutoBlatant.Stop() end
end)

section(farm, "AUTO SELL FISH")
section(map, "MAP & TELEPORT")
section(auto, "AUTOMATION")
section(shop, "SHOP")

-- Sidebar buttons + icons
local function sideBtn(text, page, y)
    local btn = Instance.new("TextButton", sidebar)
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.TextColor3 = Color3.fromRGB(220,220,220)
    btn.BackgroundTransparency = 1
    btn.Size = UDim2.new(1,0,0,42)
    btn.Position = UDim2.new(0,0,0,y)
    btn.MouseButton1Click:Connect(function()
        showPage(page)
    end)
end

sideBtn("Farm", "Farm", 60)
sideBtn("Map", "Map", 104)
sideBtn("Automatic", "Automatic", 148)
sideBtn("Shop", "Shop", 192)

--=====================================================
-- MINIMIZE BUTTON
--=====================================================
local mini = Instance.new("TextButton", gui)
mini.Text = "ASPAN"
mini.Size = UDim2.new(0,90,0,32)
mini.Position = UDim2.new(0,20,0.5,0)
mini.Visible = false
mini.BackgroundColor3 = Color3.fromRGB(20,22,28)
mini.TextColor3 = Color3.fromRGB(0,200,170)
Instance.new("UICorner", mini).CornerRadius = UDim.new(0,12)

mini.MouseButton1Click:Connect(function()
    main.Visible = true
    mini.Visible = false
end)

-- Close button
local close = Instance.new("TextButton", main)
close.Text = "–"
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-50,0,10)
close.BackgroundTransparency = 1
close.TextColor3 = Color3.new(1,1,1)
close.TextSize = 26

close.MouseButton1Click:Connect(function()
    main.Visible = false
    mini.Visible = true
end)

showPage("Farm")
print("ASPAN-HUB FINAL LOADED")
