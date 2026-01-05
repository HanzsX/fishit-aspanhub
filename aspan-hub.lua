--====================================================
-- ASPAN HUB - FINAL ANTI BLANK VERSION
--====================================================
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer

--================ LOAD MODULE =======================
local Legit = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HanzsX/fishit-aspanhub/refs/heads/main/modules/auto-legit.lua"
))()

local Blatant = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HanzsX/fishit-aspanhub/refs/heads/main/modules/auto-blantant.lua"
))()

--================ SCREEN GUI ========================
local gui = Instance.new("ScreenGui")
gui.Name = "ASPAN_HUB_GUI"
gui.Parent = lp:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false
gui.DisplayOrder = 999999
gui.Enabled = true

--================ MAIN WINDOW =======================
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(600, 380)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(18, 20, 25)
main.BorderSizePixel = 0
main.Visible = true
main.ZIndex = 10
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

--================ HEADER ============================
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 60)
header.BackgroundTransparency = 1
header.ZIndex = 20

local logo = Instance.new("ImageLabel", header)
logo.Image = "rbxassetid://100446592606293"
logo.Size = UDim2.fromOffset(42, 42)
logo.Position = UDim2.fromOffset(16, 9)
logo.BackgroundTransparency = 1
logo.ZIndex = 21

local title = Instance.new("TextLabel", header)
title.Text = "ASPAN HUB"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(0,255,200)
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(68, 10)
title.Size = UDim2.fromOffset(300, 26)
title.TextXAlignment = Left
title.ZIndex = 21

local discord = Instance.new("TextLabel", header)
discord.Text = "discord.gg/aspanhub"
discord.Font = Enum.Font.Gotham
discord.TextSize = 12
discord.TextColor3 = Color3.fromRGB(160,160,160)
discord.BackgroundTransparency = 1
discord.Position = UDim2.fromOffset(68, 36)
discord.Size = UDim2.fromOffset(300, 18)
discord.TextXAlignment = Left
discord.ZIndex = 21

--================ SIDEBAR ===========================
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.fromOffset(70, 300)
sidebar.Position = UDim2.fromOffset(10, 70)
sidebar.BackgroundColor3 = Color3.fromRGB(22,24,30)
sidebar.BorderSizePixel = 0
sidebar.Visible = true
sidebar.ZIndex = 15
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 14)

local sidebarLayout = Instance.new("UIListLayout", sidebar)
sidebarLayout.Padding = UDim.new(0, 12)
sidebarLayout.HorizontalAlignment = Center
sidebarLayout.VerticalAlignment = Top

local function sidebarBtn(assetId)
    local b = Instance.new("ImageButton")
    b.Size = UDim2.fromOffset(44,44)
    b.Image = "rbxassetid://"..assetId
    b.BackgroundColor3 = Color3.fromRGB(30,32,38)
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.ZIndex = 16
    Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
    b.Parent = sidebar
    return b
end

local btnFarm = sidebarBtn(138961952076353)
local btnShop = sidebarBtn(100764486880472)
local btnMap  = sidebarBtn(92783589439849)

--================ CONTENT ===========================
local content = Instance.new("Frame", main)
content.Position = UDim2.fromOffset(90, 80)
content.Size = UDim2.fromOffset(490, 270)
content.BackgroundTransparency = 1
content.Visible = true
content.ZIndex = 12

local panel = Instance.new("Frame", content)
panel.Size = UDim2.new(1, 0, 1, 0)
panel.BackgroundColor3 = Color3.fromRGB(24,26,32)
panel.BorderSizePixel = 0
panel.Visible = true
panel.ZIndex = 13
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 14)

local panelLayout = Instance.new("UIListLayout", panel)
panelLayout.Padding = UDim.new(0, 14)

--================ PANEL TITLE =======================
local panelTitle = Instance.new("TextLabel", panel)
panelTitle.Text = "AUTO FISHING"
panelTitle.Font = Enum.Font.GothamBold
panelTitle.TextSize = 18
panelTitle.TextColor3 = Color3.fromRGB(0,255,200)
panelTitle.BackgroundTransparency = 1
panelTitle.Size = UDim2.fromOffset(300, 28)
panelTitle.TextXAlignment = Left
panelTitle.ZIndex = 14

--================ MODERN BUTTON =====================
local function Toggle(text, callback)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.fromOffset(450, 46)
    holder.BackgroundColor3 = Color3.fromRGB(32,34,40)
    holder.BorderSizePixel = 0
    holder.ZIndex = 14
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0,12)

    local lbl = Instance.new("TextLabel", holder)
    lbl.Text = text
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.TextColor3 = Color3.fromRGB(230,230,230)
    lbl.BackgroundTransparency = 1
    lbl.Position = UDim2.fromOffset(14,0)
    lbl.Size = UDim2.fromScale(1,1)
    lbl.TextXAlignment = Left

    local btn = Instance.new("TextButton", holder)
    btn.Size = UDim2.fromOffset(52,24)
    btn.Position = UDim2.fromOffset(380,11)
    btn.Text = ""
    btn.BackgroundColor3 = Color3.fromRGB(90,90,90)
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1,0)

    local dot = Instance.new("Frame", btn)
    dot.Size = UDim2.fromOffset(20,20)
    dot.Position = UDim2.fromOffset(2,2)
    dot.BackgroundColor3 = Color3.fromRGB(230,230,230)
    dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)

    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = on and Color3.fromRGB(0,255,200) or Color3.fromRGB(90,90,90)
        }):Play()
        TweenService:Create(dot, TweenInfo.new(0.2), {
            Position = on and UDim2.fromOffset(30,2) or UDim2.fromOffset(2,2)
        }):Play()
        callback(on)
    end)

    holder.Parent = panel
end

--================ TOGGLES ===========================
Toggle("Auto Fishing Legit++", function(v)
    if v then
        Blatant.Stop()
        Legit.Start()
    else
        Legit.Stop()
    end
end)

Toggle("Auto Fishing Blatant", function(v)
    if v then
        Legit.Stop()
        Blatant.Start()
    else
        Blatant.Stop()
    end
end)

print("✅ ASPAN HUB GUI FULLY LOADED (ANTI BLANK)")
