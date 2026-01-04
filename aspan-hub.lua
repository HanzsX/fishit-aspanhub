--=====================================================
-- ASPAN-HUB FINAL | Fish It
-- VinzHub Method (GUI + VirtualInput)
--=====================================================

--================ SERVICES =================
local Players = game:GetService("Players")
local VIM = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
math.randomseed(tick())

--================ AUTO FISH CORE =================
local AutoFish = {
    Enabled = false,
    Casting = false,
    Mode = "SAFE" -- SAFE / FAST
}

local CFG = {
    SAFE = { castGap=0.45, scan=0.045, min=0.12, max=0.18 },
    FAST = { castGap=0.25, scan=0.025, min=0.07, max=0.11 }
}

local function rand(a,b)
    return a + (b-a)*math.random()
end

local function mouseClick()
    VIM:SendMouseButtonEvent(0,0,0,true,game,0)
    task.wait(0.035)
    VIM:SendMouseButtonEvent(0,0,0,false,game,0)
end

-- Find fishing minigame GUI
local function findMinigame()
    local pg = player:FindFirstChild("PlayerGui")
    if not pg then return end

    for _,gui in ipairs(pg:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Enabled then
            for _,f in ipairs(gui:GetDescendants()) do
                if f:IsA("Frame") and f.Visible then
                    for _,c in ipairs(f:GetDescendants()) do
                        if c:IsA("Frame") and c.Size.X.Scale > 0 and c.Size.X.Scale < 1 then
                            return f
                        end
                    end
                end
            end
        end
    end
end

local function findMarker(bar)
    for _,c in ipairs(bar:GetDescendants()) do
        if c:IsA("Frame") and c.Visible then
            if c.Size.X.Scale > 0 and c.Size.X.Scale < 1 then
                return c
            end
        end
    end
end

local function safeWindow(marker)
    local x = marker.Size.X.Scale
    return x >= 0.46 and x <= 0.58
end

-- CAST LOOP
task.spawn(function()
    while true do
        if AutoFish.Enabled and not AutoFish.Casting then
            AutoFish.Casting = true
            mouseClick()
        end
        task.wait(CFG[AutoFish.Mode].castGap)
    end
end)

-- REEL LOOP
task.spawn(function()
    while true do
        if AutoFish.Enabled and AutoFish.Casting then
            local bar = findMinigame()
            if bar then
                local t0 = tick()
                while AutoFish.Enabled and AutoFish.Casting and tick()-t0 < 3 do
                    local mk = findMarker(bar)
                    if mk and safeWindow(mk) then
                        task.wait(rand(CFG[AutoFish.Mode].min, CFG[AutoFish.Mode].max))
                        mouseClick()
                        break
                    end
                    task.wait(CFG[AutoFish.Mode].scan)
                end
            end
            task.wait(0.35)
            AutoFish.Casting = false
        end
        task.wait(0.03)
    end
end)

--================ UI =================
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "ASPAN_HUB"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.50,0.52)
main.Position = UDim2.fromScale(0.25,0.24)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

-- Header
local header = Instance.new("Frame", main)
header.Size = UDim2.fromScale(1,0.12)
header.BackgroundColor3 = Color3.fromRGB(24,24,24)
header.Active = true
header.Draggable = true
Instance.new("UICorner", header).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.fromScale(0.65,1)
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

local body = Instance.new("Frame", main)
body.Size = UDim2.fromScale(1,0.88)
body.Position = UDim2.fromScale(0,0.12)
body.BackgroundTransparency = 1

-- Sidebar
local sidebar = Instance.new("Frame", body)
sidebar.Size = UDim2.fromScale(0.22,1)
sidebar.BackgroundColor3 = Color3.fromRGB(22,22,22)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,10)

-- Content
local content = Instance.new("Frame", body)
content.Size = UDim2.fromScale(0.78,1)
content.Position = UDim2.fromScale(0.22,0)
content.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", content).CornerRadius = UDim.new(0,10)

local farm = Instance.new("Frame", content)
farm.Size = UDim2.fromScale(1,1)
farm.BackgroundTransparency = 1

-- Toggle pill
local function toggle(parent,y,default,cb)
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

local function label(text,y)
    local l = Instance.new("TextLabel", farm)
    l.Size = UDim2.fromScale(0.45,0.08)
    l.Position = UDim2.fromScale(0.12,y)
    l.Text = text
    l.Font = Enum.Font.Gotham
    l.TextScaled = true
    l.TextColor3 = Color3.fromRGB(220,220,220)
    l.BackgroundTransparency = 1
    l.TextXAlignment = Enum.TextXAlignment.Left
end

label("Auto Fishing",0.22)
toggle(farm,0.22,false,function(v)
    AutoFish.Enabled = v
    if not v then AutoFish.Casting=false end
end)

local modeBtn = Instance.new("TextButton", farm)
modeBtn.Size = UDim2.fromScale(0.38,0.12)
modeBtn.Position = UDim2.fromScale(0.12,0.40)
modeBtn.Text = "MODE : SAFE"
modeBtn.Font = Enum.Font.GothamBold
modeBtn.TextScaled = true
modeBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
modeBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", modeBtn).CornerRadius = UDim.new(0,10)

modeBtn.MouseButton1Click:Connect(function()
    AutoFish.Mode = (AutoFish.Mode=="SAFE") and "FAST" or "SAFE"
    modeBtn.Text = "MODE : "..AutoFish.Mode
end)

local minimized=false
minBtn.MouseButton1Click:Connect(function()
    minimized=not minimized
    body.Visible=not minimized
    main.Size=minimized and UDim2.fromScale(0.50,0.12) or UDim2.fromScale(0.50,0.52)
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

print("ASPAN-HUB FINAL LOADED")
