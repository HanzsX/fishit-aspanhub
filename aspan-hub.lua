--==================================================
-- ASPAN HUB UI FINAL (VINZHUB STYLE)
--==================================================
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer

--================ GUI ==============================
local gui = Instance.new("ScreenGui")
gui.Name = "ASPAN_HUB"
gui.ResetOnSpawn = false
pcall(function() gui.Parent = game:GetService("CoreGui") end)
if not gui.Parent then gui.Parent = lp:WaitForChild("PlayerGui") end

--================ MAIN =============================
local Main = Instance.new("Frame", gui)
Main.Size = UDim2.fromOffset(640, 420)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(18,20,25)
Main.BorderSizePixel = 0
Main.ZIndex = 10
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

--================ HEADER ===========================
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 56)
Header.BackgroundColor3 = Color3.fromRGB(24,26,32)
Header.BorderSizePixel = 0
Header.ZIndex = 11
Instance.new("UICorner", Header).CornerRadius = UDim.new(0,14)

-- Logo
local Logo = Instance.new("ImageLabel", Header)
Logo.Image = "rbxassetid://100446592606293"
Logo.Size = UDim2.fromOffset(36,36)
Logo.Position = UDim2.fromOffset(12,10)
Logo.BackgroundTransparency = 1

-- Title
local Title = Instance.new("TextLabel", Header)
Title.Text = "ASPAN HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(0,255,200)
Title.BackgroundTransparency = 1
Title.Position = UDim2.fromOffset(56,10)
Title.Size = UDim2.fromOffset(300,20)
Title.TextXAlignment = Left

-- Discord
local Discord = Instance.new("TextLabel", Header)
Discord.Text = "discord.gg/aspanhub"
Discord.Font = Enum.Font.Gotham
Discord.TextSize = 12
Discord.TextColor3 = Color3.fromRGB(160,160,160)
Discord.BackgroundTransparency = 1
Discord.Position = UDim2.fromOffset(56,30)
Discord.Size = UDim2.fromOffset(300,16)
Discord.TextXAlignment = Left

-- Close
local Close = Instance.new("TextButton", Header)
Close.Text = "✕"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 18
Close.Size = UDim2.fromOffset(36,36)
Close.Position = UDim2.fromOffset(592,10)
Close.BackgroundColor3 = Color3.fromRGB(40,42,50)
Close.TextColor3 = Color3.fromRGB(255,100,100)
Instance.new("UICorner", Close).CornerRadius = UDim.new(1,0)

-- Minimize
local Min = Instance.new("TextButton", Header)
Min.Text = "—"
Min.Font = Enum.Font.GothamBold
Min.TextSize = 20
Min.Size = UDim2.fromOffset(36,36)
Min.Position = UDim2.fromOffset(548,10)
Min.BackgroundColor3 = Color3.fromRGB(40,42,50)
Min.TextColor3 = Color3.fromRGB(220,220,220)
Instance.new("UICorner", Min).CornerRadius = UDim.new(1,0)

--================ SIDEBAR ==========================
local Sidebar = Instance.new("Frame", Main)
Sidebar.Position = UDim2.fromOffset(12,68)
Sidebar.Size = UDim2.fromOffset(120,330)
Sidebar.BackgroundColor3 = Color3.fromRGB(22,24,30)
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 11
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0,12)

local SLayout = Instance.new("UIListLayout", Sidebar)
SLayout.Padding = UDim.new(0,8)

local function MenuButton(text)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-12,0,44)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.fromRGB(220,220,220)
    b.BackgroundColor3 = Color3.fromRGB(34,36,42)
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    b.Parent = Sidebar
    return b
end

local FarmBtn = MenuButton("Farm")
local AutoBtn = MenuButton("Automatic")
local MapBtn  = MenuButton("Map")
local ShopBtn = MenuButton("Shop")

--================ CONTENT ==========================
local Content = Instance.new("Frame", Main)
Content.Position = UDim2.fromOffset(144,68)
Content.Size = UDim2.fromOffset(484,330)
Content.BackgroundColor3 = Color3.fromRGB(22,24,30)
Content.BorderSizePixel = 0
Content.ZIndex = 11
Instance.new("UICorner", Content).CornerRadius = UDim.new(0,12)

local CLayout = Instance.new("UIListLayout", Content)
CLayout.Padding = UDim.new(0,12)

local Section = Instance.new("TextLabel", Content)
Section.Text = "AUTO FISHING"
Section.Font = Enum.Font.GothamBold
Section.TextSize = 16
Section.TextColor3 = Color3.fromRGB(0,255,200)
Section.BackgroundTransparency = 1
Section.Size = UDim2.new(1,-20,0,28)
Section.TextXAlignment = Left

-- Toggle
local function Toggle(text)
    local f = Instance.new("Frame", Content)
    f.Size = UDim2.new(1,-20,0,44)
    f.BackgroundColor3 = Color3.fromRGB(34,36,42)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)

    local l = Instance.new("TextLabel", f)
    l.Text = text
    l.Font = Enum.Font.GothamBold
    l.TextSize = 14
    l.TextColor3 = Color3.fromRGB(230,230,230)
    l.BackgroundTransparency = 1
    l.Position = UDim2.fromOffset(12,0)
    l.Size = UDim2.new(1,-100,1,0)
    l.TextXAlignment = Left
end

Toggle("Auto Fishing Legit")
Toggle("Auto Fishing Blatant")

--================ FLOATING LOGO ====================
local Float = Instance.new("ImageButton", gui)
Float.Image = "rbxassetid://100446592606293"
Float.Size = UDim2.fromOffset(56,56)
Float.Position = UDim2.fromScale(0.1,0.5)
Float.BackgroundColor3 = Color3.fromRGB(24,26,32)
Float.Visible = false
Instance.new("UICorner", Float).CornerRadius = UDim.new(0,12)

Min.MouseButton1Click:Connect(function()
    Main.Visible = false
    Float.Visible = true
end)

Float.MouseButton1Click:Connect(function()
    Main.Visible = true
    Float.Visible = false
end)

Close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
