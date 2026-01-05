--==================================================
-- ASPAN HUB | MODERN UI FINAL
--==================================================
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer

--================ GUI ROOT =========================
local gui = Instance.new("ScreenGui")
gui.Name = "ASPAN_HUB_MODERN"
gui.ResetOnSpawn = false
pcall(function() gui.Parent = game:GetService("CoreGui") end)
if not gui.Parent then gui.Parent = lp:WaitForChild("PlayerGui") end

--================ MAIN WINDOW ======================
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(560, 360)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(18,20,26)
main.BorderSizePixel = 0
main.ZIndex = 10
main.BackgroundTransparency = 1
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

TweenService:Create(main, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()

--================ HEADER ===========================
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 60)
header.BackgroundColor3 = Color3.fromRGB(24,26,32)
header.BorderSizePixel = 0
header.ZIndex = 11
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 16)

-- LOGO
local logo = Instance.new("ImageLabel", header)
logo.Image = "rbxassetid://100446592606293"
logo.Size = UDim2.fromOffset(42,42)
logo.Position = UDim2.fromOffset(14,9)
logo.BackgroundTransparency = 1
logo.ZIndex = 12

-- TITLE
local title = Instance.new("TextLabel", header)
title.Text = "ASPAN HUB"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(0,255,200)
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(66,10)
title.Size = UDim2.fromOffset(300,24)
title.TextXAlignment = Left
title.ZIndex = 12

-- DISCORD
local discord = Instance.new("TextLabel", header)
discord.Text = "discord.gg/aspanhub"
discord.Font = Enum.Font.Gotham
discord.TextSize = 12
discord.TextColor3 = Color3.fromRGB(150,150,150)
discord.BackgroundTransparency = 1
discord.Position = UDim2.fromOffset(66,34)
discord.Size = UDim2.fromOffset(300,18)
discord.TextXAlignment = Left
discord.ZIndex = 12

-- MINIMIZE BUTTON
local minBtn = Instance.new("TextButton", header)
minBtn.Text = "—"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 22
minBtn.Size = UDim2.fromOffset(36,36)
minBtn.Position = UDim2.fromOffset(510,12)
minBtn.BackgroundColor3 = Color3.fromRGB(35,37,44)
minBtn.TextColor3 = Color3.fromRGB(220,220,220)
minBtn.BorderSizePixel = 0
minBtn.ZIndex = 13
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1,0)

--================ SIDEBAR ==========================
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.fromOffset(12,72)
sidebar.Size = UDim2.fromOffset(72,260)
sidebar.BackgroundColor3 = Color3.fromRGB(24,26,32)
sidebar.BorderSizePixel = 0
sidebar.ZIndex = 11
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,14)

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0,12)
sideLayout.HorizontalAlignment = Center

local function sideButton(assetId)
    local b = Instance.new("ImageButton")
    b.Size = UDim2.fromOffset(48,48)
    b.Image = "rbxassetid://"..assetId
    b.BackgroundColor3 = Color3.fromRGB(34,36,42)
    b.BorderSizePixel = 0
    b.ZIndex = 12
    Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
    b.Parent = sidebar
    return b
end

local btnFarm = sideButton(138961952076353)
local btnShop = sideButton(100764486880472)
local btnMap  = sideButton(92783589439849)

local function highlight(btn)
    for _,v in ipairs(sidebar:GetChildren()) do
        if v:IsA("ImageButton") then
            TweenService:Create(v, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(34,36,42)
            }):Play()
        end
    end
    TweenService:Create(btn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0,180,150)
    }):Play()
end

--================ CONTENT ==========================
local content = Instance.new("Frame", main)
content.Position = UDim2.fromOffset(96,72)
content.Size = UDim2.fromOffset(450,260)
content.BackgroundColor3 = Color3.fromRGB(22,24,30)
content.BorderSizePixel = 0
content.ZIndex = 11
Instance.new("UICorner", content).CornerRadius = UDim.new(0,14)

local layout = Instance.new("UIListLayout", content)
layout.Padding = UDim.new(0,14)

-- SECTION TITLE
local section = Instance.new("TextLabel", content)
section.Text = "AUTO FISHING"
section.Font = Enum.Font.GothamBold
section.TextSize = 16
section.TextColor3 = Color3.fromRGB(0,255,200)
section.BackgroundTransparency = 1
section.Size = UDim2.new(1,-20,0,28)
section.TextXAlignment = Left

--================ MODERN TOGGLE ====================
local function createToggle(text)
    local holder = Instance.new("Frame", content)
    holder.Size = UDim2.new(1,-20,0,44)
    holder.BackgroundColor3 = Color3.fromRGB(34,36,42)
    holder.BorderSizePixel = 0
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0,12)

    local label = Instance.new("TextLabel", holder)
    label.Text = text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(230,230,230)
    label.BackgroundTransparency = 1
    label.Position = UDim2.fromOffset(12,0)
    label.Size = UDim2.new(1,-100,1,0)
    label.TextXAlignment = Left

    local toggle = Instance.new("Frame", holder)
    toggle.Size = UDim2.fromOffset(46,24)
    toggle.Position = UDim2.fromOffset(360,10)
    toggle.BackgroundColor3 = Color3.fromRGB(80,80,80)
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(1,0)

    local knob = Instance.new("Frame", toggle)
    knob.Size = UDim2.fromOffset(20,20)
    knob.Position = UDim2.fromOffset(2,2)
    knob.BackgroundColor3 = Color3.fromRGB(220,220,220)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

    local state = false
    holder.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            state = not state
            TweenService:Create(toggle,TweenInfo.new(0.25),{
                BackgroundColor3 = state and Color3.fromRGB(0,200,150) or Color3.fromRGB(80,80,80)
            }):Play()
            TweenService:Create(knob,TweenInfo.new(0.25),{
                Position = state and UDim2.fromOffset(24,2) or UDim2.fromOffset(2,2)
            }):Play()
        end
    end)
end

createToggle("Auto Legit")
createToggle("Auto Blatant")

--================ MINIMIZE FLOAT ===================
local float = Instance.new("ImageButton", gui)
float.Image = "rbxassetid://100446592606293"
float.Size = UDim2.fromOffset(56,56)
float.Position = UDim2.fromScale(0.1,0.5)
float.BackgroundColor3 = Color3.fromRGB(25,27,34)
float.BorderSizePixel = 0
float.Visible = false
float.ZIndex = 50
Instance.new("UICorner", float).CornerRadius = UDim.new(1,0)

minBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    float.Visible = true
end)

float.MouseButton1Click:Connect(function()
    main.Visible = true
    float.Visible = false
end)

-- DEFAULT
highlight(btnFarm)
