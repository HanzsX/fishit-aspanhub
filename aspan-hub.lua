--=====================================================
-- ASPAN-HUB | FINAL MODERN GUI
--=====================================================

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")

--================ LOAD MODULES (RAW GITHUB) =================
local AutoLegit = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HanzsX/fishit-aspanhub/refs/heads/main/modules/auto-legit.lua"
))()

local AutoBlatant = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HanzsX/fishit-aspanhub/refs/heads/main/modules/auto-blantant.lua"
))()

--================ ICON IDS ================================
local ICON_FARM = "rbxassetid://138961952076353"
local ICON_SHOP = "rbxassetid://100764486880472"
local ICON_MAP  = "rbxassetid://92783589439849"
local ICON_LOGO = "rbxassetid://100446592606293"

--================ GUI ROOT ================================
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "ASPAN_HUB"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999999

--================ MAIN WINDOW =============================
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(560, 360)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(18,20,25)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,18)
main.Active = true

--================ HEADER ================================
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,48)
header.BackgroundTransparency = 1

-- Logo
local logo = Instance.new("ImageLabel", header)
logo.Image = ICON_LOGO
logo.Size = UDim2.fromOffset(26,26)
logo.Position = UDim2.fromOffset(16,11)
logo.BackgroundTransparency = 1

-- Title
local title = Instance.new("TextLabel", header)
title.Text = "ASPAN HUB"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(0,220,180)
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(48,0)
title.Size = UDim2.new(1,-120,1,0)
title.TextXAlignment = Left

-- Minimize button
local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.fromOffset(32,32)
minimizeBtn.Position = UDim2.new(1,-44,0.5,-16)
minimizeBtn.Text = "—"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 20
minimizeBtn.TextColor3 = Color3.fromRGB(220,220,220)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(35,38,45)
minimizeBtn.BorderSizePixel = 0
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(1,0)

--================ SIDEBAR ================================
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.fromOffset(0,48)
sidebar.Size = UDim2.new(0,160,1,-48)
sidebar.BackgroundColor3 = Color3.fromRGB(22,25,30)
sidebar.BorderSizePixel = 0
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,18)

--================ CONTENT ================================
local content = Instance.new("Frame", main)
content.Position = UDim2.fromOffset(160,48)
content.Size = UDim2.new(1,-160,1,-48)
content.BackgroundTransparency = 1

local pages = {}

local function createPage(name)
    local f = Instance.new("Frame", content)
    f.Size = UDim2.fromScale(1,1)
    f.Visible = false
    f.BackgroundTransparency = 1
    local list = Instance.new("UIListLayout", f)
    list.Padding = UDim.new(0,14)
    list.HorizontalAlignment = Center
    pages[name] = f
    return f
end

local function showPage(name)
    for _,p in pairs(pages) do p.Visible = false end
    pages[name].Visible = true
end

--================ UI COMPONENTS =========================
local function section(parent, text, height)
    local box = Instance.new("Frame", parent)
    box.Size = UDim2.new(0.95,0,0,height or 140)
    box.BackgroundColor3 = Color3.fromRGB(28,30,36)
    box.BorderSizePixel = 0
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

-- Modern switch
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
        if on then
            switch.BackgroundColor3 = Color3.fromRGB(0,200,160)
            knob.Position = UDim2.fromOffset(24,2)
        else
            switch.BackgroundColor3 = Color3.fromRGB(60,60,60)
            knob.Position = UDim2.fromOffset(2,2)
        end
        callback(on)
    end)
end

--================ PAGES ================================
local farm = createPage("Farm")
local map = createPage("Map")
local auto = createPage("Automatic")
local shop = createPage("Shop")

-- Farm content
local fishSec = section(farm, "AUTO FISHING", 160)
toggle(fishSec, "Auto Legit++", 48, function(on)
    if on then
        AutoBlatant.Stop()
        AutoLegit.Start()
    else
        AutoLegit.Stop()
    end
end)
toggle(fishSec, "Auto Blatant", 92, function(on)
    if on then
        AutoLegit.Stop()
        AutoBlatant.Start()
    else
        AutoBlatant.Stop()
    end
end)

section(farm, "AUTO SELL FISH (COMING SOON)", 100)
section(map, "MAP & TELEPORT", 120)
section(auto, "AUTOMATION", 120)
section(shop, "SHOP", 120)

--================ SIDEBAR BUTTONS ======================
local function sideBtn(text, iconId, page, y)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1,-12,0,40)
    btn.Position = UDim2.fromOffset(6,y)
    btn.BackgroundColor3 = Color3.fromRGB(30,32,38)
    btn.Text = "   "..text
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 14
    btn.TextColor3 = Color3.fromRGB(220,220,220)
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

    local icon = Instance.new("ImageLabel", btn)
    icon.Image = iconId
    icon.Size = UDim2.fromOffset(18,18)
    icon.Position = UDim2.fromOffset(10,11)
    icon.BackgroundTransparency = 1
    icon.ImageColor3 = Color3.fromRGB(220,220,220)

    btn.MouseButton1Click:Connect(function()
        showPage(page)
    end)
end

sideBtn("Farm", ICON_FARM, "Farm", 16)
sideBtn("Map", ICON_MAP, "Map", 62)
sideBtn("Automatic", ICON_FARM, "Automatic", 108)
sideBtn("Shop", ICON_SHOP, "Shop", 154)

--================ MINIMIZE → FLOATING LOGO =================
local floating = Instance.new("Frame", gui)
floating.Size = UDim2.fromOffset(54,54)
floating.Position = UDim2.new(0,24,0.5,-27)
floating.BackgroundColor3 = Color3.fromRGB(20,25,30)
floating.Visible = false
floating.BorderSizePixel = 0
floating.ZIndex = 1000
Instance.new("UICorner", floating).CornerRadius = UDim.new(1,0)

local floatLogo = Instance.new("ImageLabel", floating)
floatLogo.Image = ICON_LOGO
floatLogo.Size = UDim2.fromScale(0.7,0.7)
floatLogo.Position = UDim2.fromScale(0.15,0.15)
floatLogo.BackgroundTransparency = 1

minimizeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    floating.Visible = true
end)

floating.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        main.Visible = true
        floating.Visible = false
    end
end)

-- Drag main & floating
do
    local dragging, dragStart, startPos, target

    local function beginDrag(frame, input)
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        target = frame
    end

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            beginDrag(main, input)
        end
    end)

    floating.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            beginDrag(floating, input)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            target.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

showPage("Farm")
warn("[ASPAN-HUB] GUI LOADED SUCCESSFULLY")
