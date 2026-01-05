----------------------------------------------------
-- ASPAN HUB | MODERN GUI LAYER (STABLE)
----------------------------------------------------
local TweenService = game:GetService("TweenService")
local PlayerGui = player:WaitForChild("PlayerGui")

-- ROOT GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "ASPAN_HUB_GUI"
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui

----------------------------------------------------
-- MAIN WINDOW
----------------------------------------------------
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.fromOffset(680, 420)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 16)

----------------------------------------------------
-- HEADER
----------------------------------------------------
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 56)
Header.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
Header.BorderSizePixel = 0
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 16)

local Logo = Instance.new("ImageLabel", Header)
Logo.Image = "rbxassetid://100446592606293"
Logo.Size = UDim2.fromOffset(36, 36)
Logo.Position = UDim2.fromOffset(14, 10)
Logo.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Text = "ASPAN HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(0, 240, 200)
Title.BackgroundTransparency = 1
Title.Position = UDim2.fromOffset(60, 8)
Title.Size = UDim2.fromOffset(300, 22)
Title.TextXAlignment = Left

local Discord = Instance.new("TextLabel", Header)
Discord.Text = "discord.gg/aspanhub"
Discord.Font = Enum.Font.Gotham
Discord.TextSize = 12
Discord.TextColor3 = Color3.fromRGB(160,160,160)
Discord.BackgroundTransparency = 1
Discord.Position = UDim2.fromOffset(60, 30)
Discord.Size = UDim2.fromOffset(300, 16)
Discord.TextXAlignment = Left

-- Minimize
local MinBtn = Instance.new("TextButton", Header)
MinBtn.Text = "–"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 22
MinBtn.Size = UDim2.fromOffset(36,36)
MinBtn.Position = UDim2.fromOffset(608,10)
MinBtn.BackgroundColor3 = Color3.fromRGB(40,42,52)
MinBtn.TextColor3 = Color3.fromRGB(220,220,220)
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1,0)

-- Close
local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.Size = UDim2.fromOffset(36,36)
CloseBtn.Position = UDim2.fromOffset(650,10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(50,30,30)
CloseBtn.TextColor3 = Color3.fromRGB(255,120,120)
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1,0)

----------------------------------------------------
-- SIDEBAR
----------------------------------------------------
local Sidebar = Instance.new("Frame", Main)
Sidebar.Position = UDim2.fromOffset(14, 70)
Sidebar.Size = UDim2.fromOffset(130, 330)
Sidebar.BackgroundColor3 = Color3.fromRGB(22, 24, 32)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 14)

local SideLayout = Instance.new("UIListLayout", Sidebar)
SideLayout.Padding = UDim.new(0, 10)
SideLayout.HorizontalAlignment = Center

local function SideButton(text)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(110, 44)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.fromRGB(200,200,200)
    b.BackgroundColor3 = Color3.fromRGB(34,36,44)
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 12)
    b.Parent = Sidebar
    return b
end

local FarmTab = SideButton("Farm")
local AutoTab = SideButton("Automatic")
local MapTab  = SideButton("Map")
local ShopTab = SideButton("Shop")

----------------------------------------------------
-- CONTENT
----------------------------------------------------
local Content = Instance.new("Frame", Main)
Content.Position = UDim2.fromOffset(160, 70)
Content.Size = UDim2.fromOffset(500, 330)
Content.BackgroundColor3 = Color3.fromRGB(22,24,32)
Content.BorderSizePixel = 0
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 14)

local ContentLayout = Instance.new("UIListLayout", Content)
ContentLayout.Padding = UDim.new(0, 14)

local function SectionTitle(text)
    local t = Instance.new("TextLabel", Content)
    t.Text = text
    t.Font = Enum.Font.GothamBold
    t.TextSize = 16
    t.TextColor3 = Color3.fromRGB(0,240,200)
    t.BackgroundTransparency = 1
    t.Size = UDim2.new(1,-20,0,26)
    t.TextXAlignment = Left
    return t
end

local function Toggle(text, callback)
    local f = Instance.new("Frame", Content)
    f.Size = UDim2.new(1,-20,0,48)
    f.BackgroundColor3 = Color3.fromRGB(34,36,46)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)

    local lbl = Instance.new("TextLabel", f)
    lbl.Text = text
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.TextColor3 = Color3.fromRGB(230,230,230)
    lbl.BackgroundTransparency = 1
    lbl.Position = UDim2.fromOffset(14,0)
    lbl.Size = UDim2.new(1,-80,1,0)
    lbl.TextXAlignment = Left

    local btn = Instance.new("TextButton", f)
    btn.Size = UDim2.fromOffset(46,24)
    btn.Position = UDim2.fromOffset(420,12)
    btn.BackgroundColor3 = Color3.fromRGB(90,90,90)
    btn.Text = ""
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1,0)

    local dot = Instance.new("Frame", btn)
    dot.Size = UDim2.fromOffset(20,20)
    dot.Position = UDim2.fromOffset(2,2)
    dot.BackgroundColor3 = Color3.fromRGB(220,220,220)
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)

    local state = false
    local function refresh()
        TweenService:Create(dot, TweenInfo.new(0.2), {
            Position = state and UDim2.fromOffset(24,2) or UDim2.fromOffset(2,2)
        }):Play()
        btn.BackgroundColor3 = state and Color3.fromRGB(0,200,160) or Color3.fromRGB(90,90,90)
    end

    btn.MouseButton1Click:Connect(function()
        state = not state
        refresh()
        callback(state)
    end)

    refresh()
end

----------------------------------------------------
-- FARM PAGE DEFAULT
----------------------------------------------------
SectionTitle("AUTO FISHING")

Toggle("Auto Fishing Legit++", function(v)
    if v then
        stopAll()
        Mode.Legit = true
        Hub.Enabled = true
        Settings.AutoLegit = true
        setAutoFishingState(true)
    else
        stopAll()
        Settings.AutoLegit = false
    end
    saveSettings()
end)

Toggle("Auto Fishing Blatant", function(v)
    if v then
        stopAll()
        Mode.Blatant = true
        Hub.Enabled = true
        UltraBlatant.Start()
    else
        stopAll()
    end
end)

----------------------------------------------------
-- FLOATING LOGO
----------------------------------------------------
local Float = Instance.new("ImageButton", Gui)
Float.Image = "rbxassetid://100446592606293"
Float.Size = UDim2.fromOffset(56,56)
Float.Position = UDim2.fromScale(0.08,0.5)
Float.BackgroundColor3 = Color3.fromRGB(24,26,34)
Float.Visible = false
Instance.new("UICorner", Float).CornerRadius = UDim.new(0,14)

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    Float.Visible = true
end)

Float.MouseButton1Click:Connect(function()
    Main.Visible = true
    Float.Visible = false
end)

CloseBtn.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)

print("ASPAN HUB GUI LOADED (MODERN)")
