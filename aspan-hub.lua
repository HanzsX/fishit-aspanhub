--=====================================================
-- ASPAN-HUB XENO SAFE VERSION
--=====================================================

--// SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

--=====================================================
-- STATE (LOGIC KAMU COLOKKAN SENDIRI)
--=====================================================
local Mode = { Legit = false, Blatant = false }
local Hub = { Enabled = false }
local AutoFishingInGame = false

--=====================================================
-- THEME SYSTEM (NO SAVE, XENO SAFE)
--=====================================================
local Themes = {
    Green = {
        Accent = Color3.fromRGB(0,200,160),
        ToggleOn = Color3.fromRGB(0,200,160),
        ToggleOff = Color3.fromRGB(120,80,80),
        Title = Color3.fromRGB(0,230,200)
    },
    Red = {
        Accent = Color3.fromRGB(220,70,70),
        ToggleOn = Color3.fromRGB(220,70,70),
        ToggleOff = Color3.fromRGB(90,90,90),
        Title = Color3.fromRGB(255,90,90)
    },
    Purple = {
        Accent = Color3.fromRGB(170,90,255),
        ToggleOn = Color3.fromRGB(170,90,255),
        ToggleOff = Color3.fromRGB(90,90,120),
        Title = Color3.fromRGB(200,150,255)
    }
}

local CurrentTheme = Themes.Green
local ThemedObjects = {}

local function ApplyTheme()
    for obj,fn in pairs(ThemedObjects) do
        if obj and obj.Parent then
            TweenService:Create(obj, TweenInfo.new(0.25), fn(CurrentTheme)):Play()
        end
    end
end

--=====================================================
-- GUI ROOT
--=====================================================
local gui = Instance.new("ScreenGui")
gui.Name = "ASPAN_HUB_XENO"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(620,380)
main.Position = UDim2.fromScale(0.5,0.5)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(17,18,22)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

--=====================================================
-- SAFE RESPONSIVE SCALE (XENO)
--=====================================================
local scale = Instance.new("UIScale", main)
task.spawn(function()
    while not workspace.CurrentCamera do
        task.wait()
    end
    local cam = workspace.CurrentCamera
    local function update()
        scale.Scale = math.clamp(cam.ViewportSize.X / 900, 0.75, 1)
    end
    update()
    cam:GetPropertyChangedSignal("ViewportSize"):Connect(update)
end)

--=====================================================
-- TITLE
--=====================================================
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,-20,0,44)
title.Position = UDim2.fromOffset(16,0)
title.Text = "ASPAN-HUB • Fish It (XENO)"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Left
title.BackgroundTransparency = 1

ThemedObjects[title] = function(t)
    return { TextColor3 = t.Title }
end

--=====================================================
-- SIDEBAR
--=====================================================
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.fromOffset(0,44)
sidebar.Size = UDim2.fromOffset(150,336)
sidebar.BackgroundColor3 = Color3.fromRGB(14,15,18)
sidebar.BorderSizePixel = 0

local layout = Instance.new("UIListLayout", sidebar)
layout.Padding = UDim.new(0,6)
layout.HorizontalAlignment = Center

local pad = Instance.new("UIPadding", sidebar)
pad.PaddingTop = UDim.new(0,10)

local function SidebarButton(text)
    local b = Instance.new("TextButton", sidebar)
    b.Size = UDim2.fromOffset(130,36)
    b.Text = text
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.TextColor3 = Color3.fromRGB(220,220,220)
    b.BackgroundColor3 = Color3.fromRGB(28,30,36)
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    return b
end

local farmBtn = SidebarButton("Farm")
local autoBtn = SidebarButton("Automatic")
local utilBtn = SidebarButton("Utilities")

--=====================================================
-- CONTENT + TABS
--=====================================================
local content = Instance.new("Frame", main)
content.Position = UDim2.fromOffset(150,44)
content.Size = UDim2.fromOffset(470,336)
content.BackgroundTransparency = 1

local Tabs = {}
local function CreateTab(name)
    local f = Instance.new("Frame", content)
    f.Size = UDim2.fromScale(1,1)
    f.BackgroundTransparency = 1
    f.Visible = false
    Tabs[name] = f
    return f
end

local FarmTab = CreateTab("Farm")
local AutoTab = CreateTab("Automatic")
local UtilTab = CreateTab("Utilities")
FarmTab.Visible = true

local function SwitchTab(name)
    for n,t in pairs(Tabs) do
        t.Visible = (n == name)
    end
end

farmBtn.MouseButton1Click:Connect(function() SwitchTab("Farm") end)
autoBtn.MouseButton1Click:Connect(function() SwitchTab("Automatic") end)
utilBtn.MouseButton1Click:Connect(function() SwitchTab("Utilities") end)

--=====================================================
-- STATUS
--=====================================================
local status = Instance.new("TextLabel", AutoTab)
status.Position = UDim2.fromOffset(15,10)
status.Size = UDim2.fromOffset(440,24)
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.TextXAlignment = Left
status.BackgroundTransparency = 1

task.spawn(function()
    while true do
        status.Text = "Auto Fishing In-Game: "..(AutoFishingInGame and "ON" or "OFF")
        status.TextColor3 = AutoFishingInGame and CurrentTheme.Accent or Color3.fromRGB(200,80,80)
        task.wait(0.3)
    end
end)

--=====================================================
-- ANIMATED TOGGLE (XENO SAFE)
--=====================================================
local function AnimatedToggle(parent, y, text, callback)
    local holder = Instance.new("Frame", parent)
    holder.Position = UDim2.fromOffset(15,y)
    holder.Size = UDim2.fromOffset(440,52)
    holder.BackgroundColor3 = Color3.fromRGB(28,30,36)
    holder.BorderSizePixel = 0
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0,14)

    local lbl = Instance.new("TextLabel", holder)
    lbl.Text = text
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.TextXAlignment = Left
    lbl.TextColor3 = Color3.fromRGB(235,235,235)
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1,-90,1,0)
    lbl.Position = UDim2.fromOffset(16,0)

    local bg = Instance.new("TextButton", holder)
    bg.Text = ""
    bg.Size = UDim2.fromOffset(52,26)
    bg.Position = UDim2.fromScale(1,0.5)
    bg.AnchorPoint = Vector2.new(1,0.5)
    bg.BorderSizePixel = 0
    Instance.new("UICorner", bg).CornerRadius = UDim.new(1,0)

    local knob = Instance.new("Frame", bg)
    knob.Size = UDim2.fromOffset(22,22)
    knob.Position = UDim2.fromOffset(2,2)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knob.BorderSizePixel = 0
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

    local state = false

    local function set(v)
        state = v
        TweenService:Create(bg, TweenInfo.new(0.25), {
            BackgroundColor3 = v and CurrentTheme.ToggleOn or CurrentTheme.ToggleOff
        }):Play()

        TweenService:Create(knob, TweenInfo.new(0.25), {
            Position = v and UDim2.fromOffset(28,2) or UDim2.fromOffset(2,2)
        }):Play()

        callback(v)
    end

    bg.MouseButton1Click:Connect(function()
        set(not state)
    end)

    ThemedObjects[bg] = function(t)
        return { BackgroundColor3 = state and t.ToggleOn or t.ToggleOff }
    end
end

--=====================================================
-- AUTO TAB (COLOKKAN LOGIC KAMU)
--=====================================================
AnimatedToggle(AutoTab, 50, "Auto Legit++ (Adaptive)", function(v)
    Mode.Legit = v
    Hub.Enabled = v
    -- setAutoFishingState(v)
end)

AnimatedToggle(AutoTab, 120, "Auto Blatant (Ultra)", function(v)
    Mode.Blatant = v
    Hub.Enabled = v
    -- UltraBlatant.Start()
end)

--=====================================================
-- THEME PICKER (UTIL TAB)
--=====================================================
local function ThemeButton(x, name, color)
    local b = Instance.new("TextButton", UtilTab)
    b.Size = UDim2.fromOffset(90,40)
    b.Position = UDim2.fromOffset(x,20)
    b.Text = name
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = color
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)

    b.MouseButton1Click:Connect(function()
        CurrentTheme = Themes[name]
        ApplyTheme()
    end)
end

ThemeButton(20,"Green",Themes.Green.Accent)
ThemeButton(130,"Red",Themes.Red.Accent)
ThemeButton(240,"Purple",Themes.Purple.Accent)

--=====================================================
-- INIT
--=====================================================
ApplyTheme()
print("ASPAN-HUB XENO SAFE LOADED")
