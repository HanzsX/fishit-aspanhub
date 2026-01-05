--====================================================
-- ASPAN HUB FINAL GUI (ANTI BLANK)
--====================================================
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

--================ LOAD MODULES ======================
local Legit = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HanzsX/fishit-aspanhub/refs/heads/main/modules/auto-legit.lua"
))()

local Blatant = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HanzsX/fishit-aspanhub/refs/heads/main/modules/auto-blantant.lua"
))()

--================ GUI ROOT ==========================
local gui = Instance.new("ScreenGui")
gui.Name = "ASPAN_HUB"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
gui.DisplayOrder = 999999

--================ MAIN WINDOW =======================
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(560, 360)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(16, 18, 22)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

-- Shadow
local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 1
stroke.Color = Color3.fromRGB(0, 255, 200)
stroke.Transparency = 0.8

--================ HEADER ============================
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 56)
header.BackgroundTransparency = 1

local logo = Instance.new("ImageLabel", header)
logo.Image = "rbxassetid://100446592606293"
logo.Size = UDim2.fromOffset(36, 36)
logo.Position = UDim2.fromOffset(16, 10)
logo.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Text = "ASPAN HUB"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(0, 255, 200)
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(60, 8)
title.Size = UDim2.fromOffset(200, 26)
title.TextXAlignment = Left

local discord = Instance.new("TextLabel", header)
discord.Text = "discord.gg/aspanhub"
discord.Font = Enum.Font.Gotham
discord.TextSize = 12
discord.TextColor3 = Color3.fromRGB(170,170,170)
discord.BackgroundTransparency = 1
discord.Position = UDim2.fromOffset(60, 30)
discord.Size = UDim2.fromOffset(260, 18)
discord.TextXAlignment = Left

--================ SIDEBAR ===========================
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.fromOffset(64, 300)
sidebar.Position = UDim2.fromOffset(12, 56)
sidebar.BackgroundColor3 = Color3.fromRGB(20,22,28)
sidebar.BorderSizePixel = 0
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 14)

local function sidebarBtn(iconId, y)
    local b = Instance.new("ImageButton", sidebar)
    b.Size = UDim2.fromOffset(40,40)
    b.Position = UDim2.fromOffset(12,y)
    b.Image = "rbxassetid://"..iconId
    b.BackgroundColor3 = Color3.fromRGB(28,30,36)
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
    return b
end

local btnFarm = sidebarBtn(138961952076353, 20)
local btnShop = sidebarBtn(100764486880472, 80)
local btnMap  = sidebarBtn(92783589439849, 140)

--================ CONTENT ===========================
local content = Instance.new("Frame", main)
content.Position = UDim2.fromOffset(88, 68)
content.Size = UDim2.fromOffset(450, 270)
content.BackgroundTransparency = 1

-- PANEL (INI YANG BIKIN TIDAK BLANK)
local panel = Instance.new("Frame", content)
panel.Size = UDim2.new(1, -20, 1, -20)
panel.Position = UDim2.fromOffset(10,10)
panel.BackgroundColor3 = Color3.fromRGB(22,24,30)
panel.BorderSizePixel = 0
panel.ZIndex = 10
Instance.new("UICorner", panel).CornerRadius = UDim.new(0,14)

local panelTitle = Instance.new("TextLabel", panel)
panelTitle.Text = "AUTO FISHING"
panelTitle.Font = Enum.Font.GothamBold
panelTitle.TextSize = 18
panelTitle.TextColor3 = Color3.fromRGB(0,255,200)
panelTitle.BackgroundTransparency = 1
panelTitle.Position = UDim2.fromOffset(16, 12)
panelTitle.Size = UDim2.fromOffset(300, 24)

--================ MODERN TOGGLE =====================
local function Toggle(text, y, callback)
    local holder = Instance.new("Frame", panel)
    holder.Position = UDim2.fromOffset(16, y)
    holder.Size = UDim2.fromOffset(400, 44)
    holder.BackgroundColor3 = Color3.fromRGB(28,30,36)
    holder.BorderSizePixel = 0
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0,12)

    local lbl = Instance.new("TextLabel", holder)
    lbl.Text = text
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.TextColor3 = Color3.fromRGB(230,230,230)
    lbl.BackgroundTransparency = 1
    lbl.Position = UDim2.fromOffset(16,0)
    lbl.Size = UDim2.fromScale(1,1)
    lbl.TextXAlignment = Left

    local btn = Instance.new("TextButton", holder)
    btn.Size = UDim2.fromOffset(50,24)
    btn.Position = UDim2.fromOffset(330,10)
    btn.Text = ""
    btn.BackgroundColor3 = Color3.fromRGB(80,80,80)
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1,0)

    local circle = Instance.new("Frame", btn)
    circle.Size = UDim2.fromOffset(20,20)
    circle.Position = UDim2.fromOffset(2,2)
    circle.BackgroundColor3 = Color3.fromRGB(220,220,220)
    circle.BorderSizePixel = 0
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1,0)

    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = on and Color3.fromRGB(0,255,200) or Color3.fromRGB(80,80,80)
        }):Play()
        TweenService:Create(circle, TweenInfo.new(0.2), {
            Position = on and UDim2.fromOffset(28,2) or UDim2.fromOffset(2,2)
        }):Play()
        callback(on)
    end)
end

--================ TOGGLES ===========================
Toggle("Auto Fishing Legit++", 60, function(v)
    if v then
        Blatant.Stop()
        Legit.Start()
    else
        Legit.Stop()
    end
end)

Toggle("Auto Fishing Blatant", 120, function(v)
    if v then
        Legit.Stop()
        Blatant.Start()
    else
        Blatant.Stop()
    end
end)

--================ DRAG ==============================
do
    local dragging, start, pos
    header.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            start = i.Position
            pos = main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = i.Position - start
            main.Position = pos + UDim2.fromOffset(delta.X, delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

print("✅ ASPAN HUB FINAL LOADED")
