-- ASPAN HUB FINAL GUI
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer

-- =======================
-- LOAD MODULES (RAW)
-- =======================
local AutoLegit = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HanzsX/fishit-aspanhub/main/modules/auto-legit.lua"
))()

local AutoBlatant = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HanzsX/fishit-aspanhub/main/modules/auto-blantant.lua"
))()

-- =======================
-- ICON IDS
-- =======================
local ICON_FARM = "rbxassetid://138961952076353"
local ICON_SHOP = "rbxassetid://100764486880472"
local ICON_MAP  = "rbxassetid://92783589439849"
local ICON_LOGO = "rbxassetid://100446592606293"

-- =======================
-- SCREEN GUI
-- =======================
local gui = Instance.new("ScreenGui")
gui.Name = "ASPAN_HUB"
gui.Parent = LP:WaitForChild("PlayerGui")
gui.DisplayOrder = 999999
gui.ResetOnSpawn = false

-- =======================
-- MAIN WINDOW
-- =======================
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(520, 330)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(16, 18, 22)
main.ZIndex = 50
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

-- =======================
-- HEADER
-- =======================
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 48)
header.BackgroundTransparency = 1

-- Logo
local logo = Instance.new("ImageLabel", header)
logo.Image = ICON_LOGO
logo.Size = UDim2.fromOffset(36, 36)
logo.Position = UDim2.fromOffset(12, 6)
logo.BackgroundTransparency = 1

-- Title
local title = Instance.new("TextLabel", header)
title.Text = "ASPAN HUB"
title.Position = UDim2.fromOffset(58, 6)
title.Size = UDim2.fromOffset(200, 22)
title.TextXAlignment = Left
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(0, 220, 200)

-- Discord
local discord = Instance.new("TextLabel", header)
discord.Text = "discord.gg/aspanhub"
discord.Position = UDim2.fromOffset(58, 26)
discord.Size = UDim2.fromOffset(200, 14)
discord.BackgroundTransparency = 1
discord.Font = Enum.Font.Gotham
discord.TextSize = 11
discord.TextColor3 = Color3.fromRGB(160,160,160)

-- =======================
-- SIDEBAR
-- =======================
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.fromOffset(0, 48)
sidebar.Size = UDim2.new(0, 68, 1, -48)
sidebar.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
sidebar.ZIndex = 51

local pages = {}
local buttons = {}
local currentPage

local function createPage(name)
    local f = Instance.new("Frame", main)
    f.Position = UDim2.fromOffset(78, 58)
    f.Size = UDim2.new(1, -90, 1, -70)
    f.Visible = false
    f.BackgroundTransparency = 1
    pages[name] = f
    return f
end

local function showPage(name)
    for n,p in pairs(pages) do
        p.Visible = (n == name)
        if buttons[n] then
            buttons[n].BackgroundColor3 =
                n == name and Color3.fromRGB(0,200,180) or Color3.fromRGB(20,22,26)
        end
    end
    currentPage = name
end

local function sideButton(icon, page, y)
    local b = Instance.new("ImageButton", sidebar)
    b.Image = icon
    b.Size = UDim2.fromOffset(44,44)
    b.Position = UDim2.fromOffset(12, y)
    b.BackgroundColor3 = Color3.fromRGB(20,22,26)
    Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
    buttons[page] = b

    b.MouseButton1Click:Connect(function()
        showPage(page)
    end)
end

-- =======================
-- CREATE PAGES
-- =======================
local farmPage = createPage("Farm")
local mapPage  = createPage("Map")
local shopPage = createPage("Shop")

sideButton(ICON_FARM, "Farm", 10)
sideButton(ICON_MAP,  "Map", 64)
sideButton(ICON_SHOP, "Shop", 118)

-- =======================
-- TOGGLE COMPONENT
-- =======================
local function toggle(parent, text, y, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Text = text
    btn.Size = UDim2.fromOffset(220, 36)
    btn.Position = UDim2.fromOffset(0, y)
    btn.BackgroundColor3 = Color3.fromRGB(30,32,38)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on
        btn.BackgroundColor3 = on and Color3.fromRGB(0,180,160) or Color3.fromRGB(30,32,38)
        callback(on)
    end)
end

-- =======================
-- FARM CONTENT
-- =======================
toggle(farmPage, "AUTO LEGIT ++", 0, function(v)
    if v then AutoLegit.Start() else AutoLegit.Stop() end
end)

toggle(farmPage, "AUTO BLATANT", 46, function(v)
    if v then AutoBlatant.Start() else AutoBlatant.Stop() end
end)

-- =======================
-- DEFAULT PAGE
-- =======================
showPage("Farm")

-- =======================
-- DRAG WINDOW
-- =======================
local drag, startPos, startInput
header.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = true
        startInput = i.Position
        startPos = main.Position
    end
end)

UIS.InputChanged:Connect(function(i)
    if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = i.Position - startInput
        main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = false
    end
end)
