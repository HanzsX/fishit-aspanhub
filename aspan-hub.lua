--=====================================================
-- ASPAN-HUB FINAL | Fish It
-- PC | Xeno | REAL AUTO FISH
--=====================================================

--================ SERVICES =================
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

--================ NOTIFY =================
local function notify(txt)
    pcall(function()
        StarterGui:SetCore("SendNotification",{
            Title="ASPAN-HUB",
            Text=txt,
            Duration=4
        })
    end)
end

--=====================================================
-- AUTO FISH CORE (VALID FOR YOUR SERVER)
--=====================================================
local AutoFish = {
    Enabled = false,
    Casting = false,
    Freeze = true,
    Mode = "SAFE", -- SAFE / FAST
}

local MODE_CFG = {
    SAFE = {castGap = 0.45, reelDelay = 0.14},
    FAST = {castGap = 0.25, reelDelay = 0.08},
}

local freezeConn = nil
local frozenCF = nil

local function freezeOn()
    if freezeConn then return end
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    frozenCF = hrp.CFrame
    freezeConn = RunService.Heartbeat:Connect(function()
        if AutoFish.Enabled and AutoFish.Freeze and frozenCF then
            hrp.CFrame = frozenCF
        end
    end)
end

local function freezeOff()
    if freezeConn then
        freezeConn:Disconnect()
        freezeConn = nil
        frozenCF = nil
    end
end

local function mouseClick()
    VIM:SendMouseButtonEvent(0,0,0,true,game,0)
    task.wait(0.04)
    VIM:SendMouseButtonEvent(0,0,0,false,game,0)
end

-- CAST LOOP
task.spawn(function()
    while true do
        if AutoFish.Enabled and not AutoFish.Casting then
            AutoFish.Casting = true
            if AutoFish.Freeze then freezeOn() end
            mouseClick() -- CAST (klik asli)
        end
        task.wait(MODE_CFG[AutoFish.Mode].castGap)
    end
end)

-- LISTEN SERVER STATE (REEL TIMING)
local function hookRemotes()
    for _,v in ipairs(RS:GetDescendants()) do
        if v:IsA("RemoteEvent") then
            if v.Name == "FishingMinigameChanged" then
                v.OnClientEvent:Connect(function()
                    if AutoFish.Enabled and AutoFish.Casting then
                        task.wait(MODE_CFG[AutoFish.Mode].reelDelay)
                        mouseClick() -- REEL
                    end
                end)
            elseif v.Name == "FishingCompleted" or v.Name == "FishingStopped" then
                v.OnClientEvent:Connect(function()
                    AutoFish.Casting = false
                    freezeOff()
                end)
            elseif v.Name == "ObtainedNewFishNotification" then
                v.OnClientEvent:Connect(function(info)
                    notify("Fish caught!")
                end)
            end
        end
    end
end
hookRemotes()

--=====================================================
-- UI MODERN
--=====================================================
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "ASPAN_HUB"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.52,0.56)
main.Position = UDim2.fromScale(0.24,0.22)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

-- HEADER
local header = Instance.new("Frame", main)
header.Size = UDim2.fromScale(1,0.12)
header.BackgroundColor3 = Color3.fromRGB(24,24,24)
header.Active = true
header.Draggable = true
Instance.new("UICorner", header).CornerRadius = UDim.new(0,14)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.fromScale(0.6,1)
title.Position = UDim2.fromScale(0.04,0)
title.Text = "ASPAN-HUB | Fish It"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(0,255,200)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local function headerBtn(text,x)
    local b = Instance.new("TextButton", header)
    b.Size = UDim2.fromScale(0.07,0.6)
    b.Position = UDim2.fromScale(x,0.2)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    return b
end

local minBtn = headerBtn("—",0.86)
local closeBtn = headerBtn("X",0.93)

-- BODY
local body = Instance.new("Frame", main)
body.Size = UDim2.fromScale(1,0.88)
body.Position = UDim2.fromScale(0,0.12)
body.BackgroundTransparency = 1

-- SIDEBAR
local sidebar = Instance.new("Frame", body)
sidebar.Size = UDim2.fromScale(0.22,1)
sidebar.BackgroundColor3 = Color3.fromRGB(22,22,22)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,12)

-- CONTENT
local content = Instance.new("Frame", body)
content.Size = UDim2.fromScale(0.78,1)
content.Position = UDim2.fromScale(0.22,0)
content.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", content).CornerRadius = UDim.new(0,12)

-- PAGES
local pages = {}
local function page(name)
    local f = Instance.new("Frame", content)
    f.Size = UDim2.fromScale(1,1)
    f.BackgroundTransparency = 1
    f.Visible = false
    pages[name] = f
    return f
end

local farm = page("Farm")
local map = page("Map")
local profile = page("Profile")
farm.Visible = true

local function sideBtn(text,y)
    local b = Instance.new("TextButton", sidebar)
    b.Size = UDim2.fromScale(0.9,0.1)
    b.Position = UDim2.fromScale(0.05,y)
    b.Text = text
    b.Font = Enum.Font.Gotham
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    b.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do p.Visible=false end
        pages[text].Visible = true
    end)
end

sideBtn("Farm",0.08)
sideBtn("Map",0.22)
sideBtn("Profile",0.36)

-- TOGGLE SWITCH (PILL)
local function createToggle(parent, y, default, onChange)
    local state = default
    local base = Instance.new("Frame", parent)
    base.Size = UDim2.fromScale(0.22,0.08)
    base.Position = UDim2.fromScale(0.6,y)
    base.BackgroundColor3 = state and Color3.fromRGB(0,200,150) or Color3.fromRGB(70,70,70)
    base.BorderSizePixel = 0
    Instance.new("UICorner", base).CornerRadius = UDim.new(1,0)

    local knob = Instance.new("Frame", base)
    knob.Size = UDim2.fromScale(0.45,0.8)
    knob.Position = state and UDim2.fromScale(0.52,0.1) or UDim2.fromScale(0.03,0.1)
    knob.BackgroundColor3 = Color3.fromRGB(20,20,20)
    knob.BorderSizePixel = 0
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
        onChange(state)
    end

    btn.MouseButton1Click:Connect(function()
        state = not state
        redraw()
    end)

    onChange(state)
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

-- FARM CONTENT
label(farm,"Auto Fishing",0.2)
createToggle(farm,0.2,false,function(v)
    AutoFish.Enabled = v
    if not v then
        AutoFish.Casting = false
        freezeOff()
    end
end)

label(farm,"Freeze Position",0.36)
createToggle(farm,0.36,true,function(v)
    AutoFish.Freeze = v
    if not v then freezeOff() end
end)

-- MODE BUTTON
local modeBtn = Instance.new("TextButton", farm)
modeBtn.Size = UDim2.fromScale(0.38,0.12)
modeBtn.Position = UDim2.fromScale(0.12,0.54)
modeBtn.Text = "MODE : SAFE"
modeBtn.Font = Enum.Font.GothamBold
modeBtn.TextScaled = true
modeBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
modeBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", modeBtn).CornerRadius = UDim.new(0,10)

modeBtn.MouseButton1Click:Connect(function()
    AutoFish.Mode = (AutoFish.Mode=="SAFE") and "FAST" or "SAFE"
    modeBtn.Text = "MODE : "..AutoFish.Mode
    notify("Mode "..AutoFish.Mode)
end)

-- MAP PAGE (placeholder – teleport bisa ditambah)
local mapLbl = Instance.new("TextLabel", map)
mapLbl.Size = UDim2.fromScale(1,1)
mapLbl.Text = "Map / Teleport\n(ready for next update)"
mapLbl.Font = Enum.Font.Gotham
mapLbl.TextScaled = true
mapLbl.TextColor3 = Color3.fromRGB(200,200,200)
mapLbl.BackgroundTransparency = 1

-- PROFILE
local info = Instance.new("TextLabel", profile)
info.Size = UDim2.fromScale(1,1)
info.BackgroundTransparency = 1
info.Font = Enum.Font.Gotham
info.TextScaled = true
info.TextColor3 = Color3.new(1,1,1)
info.Text = "Username : "..player.Name.."\nExecutor : Xeno"

-- MINIMIZE / CLOSE
local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    body.Visible = not minimized
    main.Size = minimized and UDim2.fromScale(0.52,0.12) or UDim2.fromScale(0.52,0.56)
end)

closeBtn.MouseButton1Click:Connect(function()
    freezeOff()
    gui:Destroy()
end)

notify("ASPAN-HUB loaded")
