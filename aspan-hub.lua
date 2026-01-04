--=====================================================
-- ASPAN-HUB FINAL | Fish It
-- Method: TAP HERE (Visual Clicker Only)
--=====================================================

--================ SERVICES =================
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local Backpack = player:WaitForChild("Backpack")

math.randomseed(tick())

--================ CONFIG =================
local CFG = {
    RodKeyword = "rod",
    TapKeywords = {"tap","click","strike"},
    StartKeywords = {"start","fish","cast"},
    ScanMapKeywords = {"island","pulau","treasure","statue","sisyphus","dock","port","harbor","cave","ruin","temple"},
}

--================ UTIL =================
local function rand(a,b) return a + (b-a)*math.random() end

local function equipRod()
    local char = player.Character or player.CharacterAdded:Wait()
    for _,t in ipairs(char:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find(CFG.RodKeyword) then
            return true
        end
    end
    for _,t in ipairs(Backpack:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find(CFG.RodKeyword) then
            char.Humanoid:EquipTool(t)
            return true
        end
    end
end

local function findTextButtonByKeywords(keywords)
    local pg = player:FindFirstChild("PlayerGui")
    if not pg then return end
    for _,v in ipairs(pg:GetDescendants()) do
        if v:IsA("TextButton") and v.Visible then
            local txt = (v.Text or ""):lower()
            for _,k in ipairs(keywords) do
                if txt:find(k) then
                    return v
                end
            end
        end
    end
end

local function safeClick(btn)
    if not btn then return end
    pcall(function()
        firesignal(btn.MouseButton1Click)
    end)
end

--================ AUTO FISH (TAP HERE) =================
local AutoFish = {
    Enabled = false,
    Busy = false,
}

task.spawn(function()
    while true do
        if AutoFish.Enabled then
            equipRod()

            -- auto start fishing (jika ada)
            local startBtn = findTextButtonByKeywords(CFG.StartKeywords)
            if startBtn then
                safeClick(startBtn)
                task.wait(rand(0.12,0.18))
            end

            -- auto tap here / strike
            local tapBtn = findTextButtonByKeywords(CFG.TapKeywords)
            if tapBtn and not AutoFish.Busy then
                AutoFish.Busy = true
                safeClick(tapBtn)
                task.wait(rand(0.12,0.18))
                AutoFish.Busy = false
            end
        end
        task.wait(0.08)
    end
end)

--================ AUTO SELL =================
local AutoSell = {
    Enabled = true,
    Cooldown = false
}

local function trySell()
    if AutoSell.Cooldown then return end
    AutoSell.Cooldown = true

    -- ProximityPrompt (aman)
    for _,p in ipairs(workspace:GetDescendants()) do
        if p:IsA("ProximityPrompt") then
            local a = (p.ActionText or ""):lower()
            if a:find("sell") or a:find("jual") then
                p:InputHoldBegin()
                task.wait(0.25)
                p:InputHoldEnd()
                task.delay(1.8,function() AutoSell.Cooldown=false end)
                return
            end
        end
    end

    -- fallback remote
    for _,r in ipairs(RS:GetDescendants()) do
        if r:IsA("RemoteEvent") and r.Name:lower():find("sell") then
            r:FireServer()
            task.delay(1.8,function() AutoSell.Cooldown=false end)
            return
        end
    end

    AutoSell.Cooldown = false
end

-- trigger sell setelah dapat ikan (jika ada event)
for _,r in ipairs(RS:GetDescendants()) do
    if r:IsA("RemoteEvent") and (r.Name=="ObtainedNewFishNotification" or r.Name=="FishCaught") then
        r.OnClientEvent:Connect(function()
            if AutoSell.Enabled then
                task.wait(0.4)
                trySell()
            end
        end)
    end
end

--================ MAP SCANNER + TELEPORT =================
local MapScanner = { Results = {} }

local function scanMap()
    table.clear(MapScanner.Results)
    for _,o in ipairs(workspace:GetDescendants()) do
        if o:IsA("BasePart") or o:IsA("Model") then
            local n = o.Name:lower()
            for _,k in ipairs(CFG.ScanMapKeywords) do
                if n:find(k) then
                    local cf = o:IsA("Model") and o:GetPivot() or o.CFrame
                    table.insert(MapScanner.Results,{Name=o.Name, CFrame=cf})
                    break
                end
            end
        end
    end
end

local function teleport(cf)
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = cf + Vector3.new(0,5,0) end
end

--================ UI =================
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "ASPAN_HUB"
gui.ResetOnSpawn = false

-- Main
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.52,0.56)
main.Position = UDim2.fromScale(0.24,0.22)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

-- Header
local header = Instance.new("Frame", main)
header.Size = UDim2.fromScale(1,0.12)
header.BackgroundColor3 = Color3.fromRGB(24,24,24)
header.Active = true
header.Draggable = true
Instance.new("UICorner", header).CornerRadius = UDim.new(0,14)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.fromScale(0.7,1)
title.Position = UDim2.fromScale(0.04,0)
title.Text = "ASPAN-HUB | Fish It"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(0,255,200)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local function hBtn(txt,x)
    local b = Instance.new("TextButton", header)
    b.Size = UDim2.fromScale(0.07,0.6)
    b.Position = UDim2.fromScale(x,0.2)
    b.Text = txt
    b.Font = Enum.Font.GothamBold
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    return b
end

local minBtn = hBtn("—",0.86)
local closeBtn = hBtn("X",0.93)

-- Body
local body = Instance.new("Frame", main)
body.Size = UDim2.fromScale(1,0.88)
body.Position = UDim2.fromScale(0,0.12)
body.BackgroundTransparency = 1

-- Sidebar
local sidebar = Instance.new("Frame", body)
sidebar.Size = UDim2.fromScale(0.22,1)
sidebar.BackgroundColor3 = Color3.fromRGB(22,22,22)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,12)

-- Content
local content = Instance.new("Frame", body)
content.Size = UDim2.fromScale(0.78,1)
content.Position = UDim2.fromScale(0.22,0)
content.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", content).CornerRadius = UDim.new(0,12)

-- Pages
local pages = {}
local function page(name)
    local f = Instance.new("Frame", content)
    f.Size = UDim2.fromScale(1,1)
    f.BackgroundTransparency = 1
    f.Visible = false
    pages[name]=f
    return f
end

local farm = page("Farm")
local map = page("Map")
local profile = page("Profile")
farm.Visible = true

local function sideBtn(txt,y)
    local b = Instance.new("TextButton", sidebar)
    b.Size = UDim2.fromScale(0.9,0.1)
    b.Position = UDim2.fromScale(0.05,y)
    b.Text = txt
    b.Font = Enum.Font.Gotham
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    b.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do p.Visible=false end
        pages[txt].Visible=true
    end)
end

sideBtn("Farm",0.08)
sideBtn("Map",0.22)
sideBtn("Profile",0.36)

-- Toggle pill
local function togglePill(parent,y,default,cb)
    local state = default
    local base = Instance.new("Frame", parent)
    base.Size = UDim2.fromScale(0.22,0.08)
    base.Position = UDim2.fromScale(0.62,y)
    base.BackgroundColor3 = state and Color3.fromRGB(0,200,150) or Color3.fromRGB(70,70,70)
    Instance.new("UICorner", base).CornerRadius = UDim.new(1,0)

    local knob = Instance.new("Frame", base)
    knob.Size = UDim2.fromScale(0.45,0.8)
    knob.Position = state and UDim2.fromScale(0.52,0.1) or UDim2.fromScale(0.03,0.1)
    knob.BackgroundColor3 = Color3.fromRGB(20,20,20)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

    local btn = Instance.new("TextButton", base)
    btn.Size = UDim2.fromScale(1,1)
    btn.Text = ""
    btn.BackgroundTransparency = 1

    local function redraw()
        TweenService:Create(base, TweenInfo.new(0.2), {
            BackgroundColor3 = state and Color3.fromRGB(0,200,150) or Color3.fromRGB(70,70,70)
        }):Play()
        TweenService:Create(knob, TweenInfo.new(0.2), {
            Position = state and UDim2.fromScale(0.52,0.1) or UDim2.fromScale(0.03,0.1)
        }):Play()
        cb(state)
    end

    btn.MouseButton1Click:Connect(function()
        state = not state
        redraw()
    end)
    cb(state)
end

local function label(parent, text, y)
    local l = Instance.new("TextLabel", parent)
    l.Size = UDim2.fromScale(0.45,0.08)
    l.Position = UDim2.fromScale(0.12,y)
    l.Text = text
    l.Font = Enum.Font.Gotham
    l.TextScaled = true
    l.TextColor3 = Color3.fromRGB(220,220,220)
    l.BackgroundTransparency = 1
    l.TextXAlignment = Enum.TextXAlignment.Left
end

-- Farm content
label(farm,"Auto Fishing (Tap Here)",0.18)
togglePill(farm,0.18,false,function(v) AutoFish.Enabled=v end)

label(farm,"Auto Sell Fish",0.34)
togglePill(farm,0.34,true,function(v) AutoSell.Enabled=v end)

-- Map content
map:ClearAllChildren()
local scanBtn = Instance.new("TextButton", map)
scanBtn.Size = UDim2.fromScale(0.4,0.12)
scanBtn.Position = UDim2.fromScale(0.05,0.05)
scanBtn.Text = "SCAN MAP"
scanBtn.Font = Enum.Font.GothamBold
scanBtn.TextScaled = true
scanBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
scanBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", scanBtn)

local list = Instance.new("ScrollingFrame", map)
list.Size = UDim2.fromScale(0.9,0.75)
list.Position = UDim2.fromScale(0.05,0.22)
list.CanvasSize = UDim2.new(0,0,0,0)
list.ScrollBarImageTransparency = 0.2
list.BackgroundTransparency = 1
local layout = Instance.new("UIListLayout", list)
layout.Padding = UDim.new(0,6)

local function refreshList()
    for _,c in ipairs(list:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    for _,d in ipairs(MapScanner.Results) do
        local b = Instance.new("TextButton", list)
        b.Size = UDim2.new(1,-10,0,34)
        b.Text = d.Name
        b.Font = Enum.Font.Gotham
        b.TextScaled = true
        b.BackgroundColor3 = Color3.fromRGB(50,50,50)
        b.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(function() teleport(d.CFrame) end)
    end
    task.wait()
    list.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+10)
end

scanBtn.MouseButton1Click:Connect(function()
    scanMap()
    refreshList()
end)

-- Profile
local info = Instance.new("TextLabel", profile)
info.Size = UDim2.fromScale(1,1)
info.BackgroundTransparency = 1
info.Font = Enum.Font.Gotham
info.TextScaled = true
info.TextColor3 = Color3.new(1,1,1)
info.Text = "Username: "..player.Name.."\nHub: ASPAN-HUB"

-- Minimize to small box
local minimized = false
local mini = Instance.new("TextButton", gui)
mini.Size = UDim2.fromOffset(140,36)
mini.Position = UDim2.fromScale(0.02,0.85)
mini.Text = "ASPAN HUB"
mini.Font = Enum.Font.GothamBold
mini.TextScaled = true
mini.BackgroundColor3 = Color3.fromRGB(24,24,24)
mini.TextColor3 = Color3.fromRGB(0,255,200)
mini.Visible = false
Instance.new("UICorner", mini)

minBtn.MouseButton1Click:Connect(function()
    minimized = true
    main.Visible = false
    mini.Visible = true
end)

mini.MouseButton1Click:Connect(function()
    minimized = false
    main.Visible = true
    mini.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

print("ASPAN-HUB FINAL LOADED")
