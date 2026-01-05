--=====================================================
-- ASPAN-HUB | FINAL GUI (HIGHLIGHT + TOGGLE + ANIM)
--=====================================================

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")

--================ LOAD MODULES =================
local AutoLegit = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HanzsX/fishit-aspanhub/refs/heads/main/modules/auto-legit.lua"
))()

local AutoBlatant = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HanzsX/fishit-aspanhub/refs/heads/main/modules/auto-blantant.lua"
))()

--================ ICON IDS =====================
local ICON_FARM  = "rbxassetid://138961952076353"
local ICON_MAP   = "rbxassetid://92783589439849"
local ICON_SHOP  = "rbxassetid://100764486880472"
local ICON_LOGO  = "rbxassetid://100446592606293"

--================ GUI ROOT =====================
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "ASPAN_HUB"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999999

--================ MAIN =========================
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(640, 420)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(18,20,25)
main.BorderSizePixel = 0
main.Active = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,18)

--================ HEADER =======================
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,64)
header.BackgroundColor3 = Color3.fromRGB(22,25,30)
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0,18)

-- Logo
local logo = Instance.new("ImageLabel", header)
logo.Image = ICON_LOGO
logo.Size = UDim2.fromOffset(42,42)
logo.Position = UDim2.fromOffset(14,11)
logo.BackgroundTransparency = 1

-- Title
local title = Instance.new("TextLabel", header)
title.Text = "ASPAN HUB"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(0,220,180)
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(64,10)
title.Size = UDim2.new(1,-200,0,26)
title.TextXAlignment = Left

-- Discord
local discord = Instance.new("TextLabel", header)
discord.Text = "discord.gg/aspanhub"
discord.Font = Enum.Font.Gotham
discord.TextSize = 12
discord.TextColor3 = Color3.fromRGB(160,160,160)
discord.BackgroundTransparency = 1
discord.Position = UDim2.fromOffset(64,34)
discord.Size = UDim2.new(1,-200,0,18)
discord.TextXAlignment = Left

--================ SIDEBAR =====================
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.fromOffset(0,64)
sidebar.Size = UDim2.new(0,190,1,-64)
sidebar.BackgroundColor3 = Color3.fromRGB(22,25,30)
sidebar.BorderSizePixel = 0
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,18)

local sideList = Instance.new("UIListLayout", sidebar)
sideList.Padding = UDim.new(0,8)
sideList.HorizontalAlignment = Center

--================ CONTENT =====================
local content = Instance.new("Frame", main)
content.Position = UDim2.fromOffset(190,64)
content.Size = UDim2.new(1,-190,1,-64)
content.BackgroundTransparency = 1

local pages = {}

local function createPage(name)
    local f = Instance.new("Frame", content)
    f.Size = UDim2.fromScale(1,1)
    f.Visible = false
    f.BackgroundTransparency = 1
    pages[name] = f
    return f
end

local function showPage(name)
    for _,p in pairs(pages) do p.Visible = false end
    local page = pages[name]
    page.Visible = true
    page.BackgroundTransparency = 1
    TweenService:Create(page, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
end

--================ SIDEBAR BUTTON =================
local sidebarButtons = {}

local function sideButton(text, iconId, page)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1,-16,0,44)
    btn.Text = "   "..text
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 14
    btn.TextColor3 = Color3.fromRGB(200,200,200)
    btn.BackgroundColor3 = Color3.fromRGB(30,32,38)
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,12)

    local icon = Instance.new("ImageLabel", btn)
    icon.Image = iconId
    icon.Size = UDim2.fromOffset(20,20)
    icon.Position = UDim2.fromOffset(12,12)
    icon.BackgroundTransparency = 1
    icon.ImageColor3 = Color3.fromRGB(200,200,200)

    btn.MouseButton1Click:Connect(function()
        -- reset highlight
        for _,b in pairs(sidebarButtons) do
            TweenService:Create(b, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(30,32,38)
            }):Play()
        end

        -- highlight active
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(0,180,150)
        }):Play()

        showPage(page)
    end)

    table.insert(sidebarButtons, btn)
    return btn
end

--================ PAGES ======================
local farm = createPage("Farm")
local map  = createPage("Map")
local shop = createPage("Shop")

local farmBtn = sideButton("Farm", ICON_FARM, "Farm")
local mapBtn  = sideButton("Map", ICON_MAP, "Map")
local shopBtn = sideButton("Shop", ICON_SHOP, "Shop")

-- Default highlight
TweenService:Create(farmBtn, TweenInfo.new(0), {
    BackgroundColor3 = Color3.fromRGB(0,180,150)
}):Play()

--================ FARM CONTENT =================
local function section(parent, text, y)
    local box = Instance.new("Frame", parent)
    box.Size = UDim2.new(0.95,0,0,160)
    box.Position = UDim2.fromOffset(16,y)
    box.BackgroundColor3 = Color3.fromRGB(28,30,36)
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,14)

    local lbl = Instance.new("TextLabel", box)
    lbl.Text = text
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.BackgroundTransparency = 1
    lbl.Position = UDim2.fromOffset(16,12)
    lbl.Size = UDim2.new(1,-32,0,20)

    return box
end

-- Toggle with animation
local function toggle(parent, label, y, callback)
    local holder = Instance.new("Frame", parent)
    holder.Size = UDim2.new(1,-32,0,36)
    holder.Position = UDim2.fromOffset(16,y)
    holder.BackgroundTransparency = 1

    local txt = Instance.new("TextLabel", holder)
    txt.Text = label
    txt.Font = Enum.Font.Gotham
    txt.TextSize = 13
    txt.TextColor3 = Color3.fromRGB(220,220,220)
    txt.Size = UDim2.new(0.7,0,1,0)
    txt.BackgroundTransparency = 1
    txt.TextXAlignment = Left

    local switch = Instance.new("Frame", holder)
    switch.Size = UDim2.fromOffset(44,22)
    switch.Position = UDim2.new(1,-44,0.5,-11)
    switch.BackgroundColor3 = Color3.fromRGB(60,60,60)
    Instance.new("UICorner", switch).CornerRadius = UDim.new(1,0)

    local knob = Instance.new("Frame", switch)
    knob.Size = UDim2.fromOffset(18,18)
    knob.Position = UDim2.fromOffset(2,2)
    knob.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

    local btn = Instance.new("TextButton", switch)
    btn.Size = UDim2.fromScale(1,1)
    btn.BackgroundTransparency = 1
    btn.Text = ""

    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on
        TweenService:Create(switch, TweenInfo.new(0.15), {
            BackgroundColor3 = on and Color3.fromRGB(0,200,160) or Color3.fromRGB(60,60,60)
        }):Play()
        TweenService:Create(knob, TweenInfo.new(0.15), {
            Position = on and UDim2.fromOffset(24,2) or UDim2.fromOffset(2,2)
        }):Play()
        callback(on)
    end)
end

local fishSec = section(farm, "AUTO FISHING", 20)

toggle(fishSec, "Auto Legit++", 56, function(on)
    if on then
        AutoBlatant.Stop()
        AutoLegit.Start()
    else
        AutoLegit.Stop()
    end
end)

toggle(fishSec, "Auto Blatant", 100, function(on)
    if on then
        AutoLegit.Stop()
        AutoBlatant.Start()
    else
        AutoBlatant.Stop()
    end
end)

showPage("Farm")
print("[ASPAN-HUB] GUI LOADED WITH HIGHLIGHT & ANIMATION")
