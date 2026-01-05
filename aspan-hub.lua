--==================================================
-- ASPAN HUB | FINAL STABLE GUI
--==================================================
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")

--================ CLEAN OLD =================
pcall(function()
    PlayerGui:FindFirstChild("ASPAN_HUB"):Destroy()
end)

--================ LOAD MODULES =================
local Legit = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HanzsX/fishit-aspanhub/main/modules/auto-legit.lua"
))()

local Blatant = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HanzsX/fishit-aspanhub/main/modules/auto-blantant.lua"
))()

--================ ICON IDS =====================
local ICON_FARM  = "rbxassetid://138961952076353"
local ICON_MAP   = "rbxassetid://92783589439849"
local ICON_SHOP  = "rbxassetid://100764486880472"
local ICON_LOGO  = "rbxassetid://100446592606293"

--================ SCREEN GUI ===================
local gui = Instance.new("ScreenGui")
gui.Name = "ASPAN_HUB"
gui.Parent = PlayerGui
gui.DisplayOrder = 999999
gui.ResetOnSpawn = false

--================ MAIN =========================
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(560, 360)
main.Position = UDim2.fromScale(0.5,0.5)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(18,20,25)
main.BorderSizePixel = 0
main.ZIndex = 50
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

--================ HEADER =======================
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,56)
header.BackgroundColor3 = Color3.fromRGB(22,24,30)
header.BorderSizePixel = 0
header.ZIndex = 51
Instance.new("UICorner", header).CornerRadius = UDim.new(0,16)

local logo = Instance.new("ImageLabel", header)
logo.Image = ICON_LOGO
logo.Size = UDim2.fromOffset(38,38)
logo.Position = UDim2.fromOffset(14,9)
logo.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Text = "ASPAN HUB"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(0,255,200)
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(60,8)
title.Size = UDim2.fromOffset(200,22)
title.TextXAlignment = Left

local discord = Instance.new("TextLabel", header)
discord.Text = "discord.gg/aspanhub"
discord.Font = Enum.Font.Gotham
discord.TextSize = 11
discord.TextColor3 = Color3.fromRGB(160,160,160)
discord.BackgroundTransparency = 1
discord.Position = UDim2.fromOffset(60,30)
discord.Size = UDim2.fromOffset(200,16)
discord.TextXAlignment = Left

-- Minimize
local minimize = Instance.new("TextButton", header)
minimize.Text = "—"
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 20
minimize.TextColor3 = Color3.new(1,1,1)
minimize.Size = UDim2.fromOffset(32,32)
minimize.Position = UDim2.new(1,-44,0.5,-16)
minimize.BackgroundColor3 = Color3.fromRGB(40,40,45)
Instance.new("UICorner", minimize).CornerRadius = UDim.new(1,0)

--================ SIDEBAR =====================
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.fromOffset(0,56)
sidebar.Size = UDim2.new(0,150,1,-56)
sidebar.BackgroundColor3 = Color3.fromRGB(14,16,20)
sidebar.BorderSizePixel = 0
sidebar.ZIndex = 51

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0,8)
sideLayout.HorizontalAlignment = Center
sideLayout.VerticalAlignment = Top

--================ CONTENT =====================
local content = Instance.new("Frame", main)
content.Position = UDim2.fromOffset(150,56)
content.Size = UDim2.new(1,-150,1,-56)
content.BackgroundTransparency = 1

local pages = {}
local buttons = {}
local activeBtn

local function createPage(name)
    local f = Instance.new("Frame", content)
    f.Size = UDim2.fromScale(1,1)
    f.Visible = false
    f.BackgroundTransparency = 1
    pages[name] = f
    return f
end

local function showPage(name)
    for n,p in pairs(pages) do
        p.Visible = (n == name)
    end
end

local function setActive(btn)
    if activeBtn then
        TweenService:Create(activeBtn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(30,30,35)
        }):Play()
    end
    activeBtn = btn
    TweenService:Create(btn, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(0,255,200)
    }):Play()
end

local function sideButton(text, iconId, page)
    local btn = Instance.new("Frame", sidebar)
    btn.Size = UDim2.fromOffset(130,40)
    btn.BackgroundColor3 = Color3.fromRGB(30,30,35)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

    local icon = Instance.new("ImageLabel", btn)
    icon.Image = iconId
    icon.Size = UDim2.fromOffset(22,22)
    icon.Position = UDim2.fromOffset(10,9)
    icon.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", btn)
    label.Text = text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextColor3 = Color3.new(1,1,1)
    label.BackgroundTransparency = 1
    label.Position = UDim2.fromOffset(40,0)
    label.Size = UDim2.new(1,-40,1,0)
    label.TextXAlignment = Left

    btn.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            setActive(btn)
            showPage(page)
        end
    end)

    buttons[page] = btn
    return btn
end

--================ PAGES =======================
local farmPage = createPage("Farm")
local mapPage  = createPage("Map")
local shopPage = createPage("Shop")

local farmBtn = sideButton("Farm", ICON_FARM, "Farm")
sideButton("Map", ICON_MAP, "Map")
sideButton("Shop", ICON_SHOP, "Shop")

--================ TOGGLE ======================
local function toggle(parent, text, y, callback)
    local holder = Instance.new("Frame", parent)
    holder.Size = UDim2.fromOffset(300,42)
    holder.Position = UDim2.fromOffset(20,y)
    holder.BackgroundColor3 = Color3.fromRGB(30,30,35)
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0,12)

    local lbl = Instance.new("TextLabel", holder)
    lbl.Text = text
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.BackgroundTransparency = 1
    lbl.Position = UDim2.fromOffset(14,0)
    lbl.Size = UDim2.new(1,-80,1,0)
    lbl.TextXAlignment = Left

    local sw = Instance.new("Frame", holder)
    sw.Size = UDim2.fromOffset(46,24)
    sw.Position = UDim2.new(1,-56,0.5,-12)
    sw.BackgroundColor3 = Color3.fromRGB(80,80,80)
    Instance.new("UICorner", sw).CornerRadius = UDim.new(1,0)

    local knob = Instance.new("Frame", sw)
    knob.Size = UDim2.fromOffset(20,20)
    knob.Position = UDim2.fromOffset(2,2)
    knob.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

    local on = false
    holder.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            on = not on
            TweenService:Create(sw, TweenInfo.new(0.15), {
                BackgroundColor3 = on and Color3.fromRGB(0,255,200) or Color3.fromRGB(80,80,80)
            }):Play()
            TweenService:Create(knob, TweenInfo.new(0.15), {
                Position = on and UDim2.fromOffset(24,2) or UDim2.fromOffset(2,2)
            }):Play()
            callback(on)
        end
    end)
end

--================ FARM CONTENT =================
local legitOn = false

toggle(farmPage, "Auto Fishing Legit++", 20, function(v)
    legitOn = v
    if v then
        Blatant.Stop()
        Legit.Start()
    else
        Legit.Stop()
    end
end)

toggle(farmPage, "Auto Fishing Blatant", 70, function(v)
    if v then
        legitOn = false
        Legit.Stop()
        Blatant.Start()
    else
        Blatant.Stop()
    end
end)

--================ DEFAULT =====================
setActive(farmBtn)
showPage("Farm")

--================ DRAG ========================
do
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
            local d = i.Position - startInput
            main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y
            )
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = false
        end
    end)
end

--================ MINIMIZE ====================
local floating = Instance.new("ImageButton", gui)
floating.Image = ICON_LOGO
floating.Size = UDim2.fromOffset(54,54)
floating.Position = UDim2.new(0,24,0.5,-27)
floating.BackgroundTransparency = 1
floating.Visible = false
floating.ZIndex = 1000

minimize.MouseButton1Click:Connect(function()
    main.Visible = false
    floating.Visible = true
end)

floating.MouseButton1Click:Connect(function()
    main.Visible = true
    floating.Visible = false
end)

print("[ASPAN HUB] FINAL GUI LOADED")
