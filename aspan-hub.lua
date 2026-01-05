--==================================================
-- ASPAN-HUB UI FINAL--=====================================================
--  ASPAN-HUB FINAL UI (LEGIT++ & BLATANT READY)
--=====================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")

--======================
-- MODULE PLACEHOLDER
-- (isi logic sendiri)
--======================
local AutoLegit = {
    Enabled = false,
    Start = function()
        AutoLegit.Enabled = true
        print("[ASPAN] Auto Legit++ ON")
    end,
    Stop = function()
        AutoLegit.Enabled = false
        print("[ASPAN] Auto Legit++ OFF")
    end
}

local AutoBlatant = {
    Enabled = false,
    Start = function()
        AutoBlatant.Enabled = true
        print("[ASPAN] Auto Blatant ON")
    end,
    Stop = function()
        AutoBlatant.Enabled = false
        print("[ASPAN] Auto Blatant OFF")
    end
}

--======================
-- GUI ROOT
--======================
local gui = Instance.new("ScreenGui")
gui.Name = "ASPAN_HUB"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

--======================
-- MAIN WINDOW
--======================
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.55, 0.6)
main.Position = UDim2.fromScale(0.22, 0.2)
main.BackgroundColor3 = Color3.fromRGB(18,20,25)
main.BackgroundTransparency = 0.05
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

--======================
-- SIDEBAR
--======================
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0.22,0,1,0)
sidebar.BackgroundColor3 = Color3.fromRGB(22,24,30)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,16)

local title = Instance.new("TextLabel", sidebar)
title.Text = "ASPAN HUB"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(0,200,170)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1,0,0,50)

--======================
-- CONTENT HOLDER
--======================
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0.24,0,0,0)
content.Size = UDim2.new(0.76,0,1,0)
content.BackgroundTransparency = 1

--======================
-- PAGE SYSTEM
--======================
local pages = {}

local function newPage(name)
    local f = Instance.new("Frame", content)
    f.Size = UDim2.fromScale(1,1)
    f.Visible = false
    f.BackgroundTransparency = 1

    local layout = Instance.new("UIListLayout", f)
    layout.Padding = UDim.new(0,14)

    pages[name] = f
    return f
end

local function showPage(name)
    for _,p in pairs(pages) do p.Visible = false end
    pages[name].Visible = true
end

--======================
-- UI COMPONENTS
--======================
local function section(parent, text)
    local box = Instance.new("Frame", parent)
    box.Size = UDim2.new(1,0,0,120)
    box.BackgroundColor3 = Color3.fromRGB(28,30,36)
    box.BackgroundTransparency = 0.05
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,14)

    local lbl = Instance.new("TextLabel", box)
    lbl.Text = text
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.TextColor3 = Color3.fromRGB(255,255,255)
    lbl.BackgroundTransparency = 1
    lbl.Position = UDim2.new(0,16,0,10)
    lbl.Size = UDim2.new(1,-32,0,20)

    return box
end

local function toggle(parent, text, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Text = text .. " : OFF"
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.TextColor3 = Color3.fromRGB(230,230,230)
    btn.BackgroundColor3 = Color3.fromRGB(40,42,50)
    btn.Size = UDim2.new(0.6,0,0,36)
    btn.Position = UDim2.new(0,16,0,50)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. (state and " : ON" or " : OFF")
        callback(state)
    end)
end

--======================
-- PAGES
--======================
local farm = newPage("Farm")
local map = newPage("Map")
local automatic = newPage("Automatic")
local shop = newPage("Shop")

--======================
-- FARM CONTENT
--======================
local autoFish = section(farm, "AUTO FISHING")
toggle(autoFish, "Auto Fishing Legit++", function(on)
    if on then AutoLegit.Start() else AutoLegit.Stop() end
end)

toggle(autoFish, "Auto Fishing Blatant", function(on)
    if on then AutoBlatant.Start() else AutoBlatant.Stop() end
end)

local autoSell = section(farm, "AUTO SELL FISH")
-- kosong (logic nanti)

--======================
-- MAP / AUTOMATIC / SHOP (placeholder)
--======================
section(map, "MAP & TELEPORT")
section(automatic, "AUTOMATION")
section(shop, "SHOP")

--======================
-- SIDEBAR BUTTONS
--======================
local function sideBtn(text, page, order)
    local b = Instance.new("TextButton", sidebar)
    b.Text = text
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.TextColor3 = Color3.fromRGB(220,220,220)
    b.BackgroundTransparency = 1
    b.Size = UDim2.new(1,0,0,42)
    b.Position = UDim2.new(0,0,0,50 + (order*44))

    b.MouseButton1Click:Connect(function()
        showPage(page)
    end)
end

sideBtn("Farm", "Farm", 0)
sideBtn("Map", "Map", 1)
sideBtn("Automatic", "Automatic", 2)
sideBtn("Shop", "Shop", 3)

--======================
-- DEFAULT
--======================
showPage("Farm")
print("ASPAN-HUB FINAL UI LOADED")

-- Sidebar + Highlight + Minimize
--==================================================

local Players = game:GetService("Players")
local player = Players.LocalPlayer

--================= GUI =================
local gui = Instance.new("ScreenGui")
gui.Name = "ASPAN_HUB_UI"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

--================= MAIN FRAME =================
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(620, 380)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(18,20,26)
main.BackgroundTransparency = 0.05
main.BorderSizePixel = 0
main.Active, main.Draggable = true, true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,18)

--================= HEADER =================
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,46)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-80,1,0)
title.Position = UDim2.fromOffset(16,0)
title.Text = "ASPAN-HUB"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(0,220,190)
title.TextXAlignment = Left
title.BackgroundTransparency = 1

local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.fromOffset(32,32)
minimizeBtn.Position = UDim2.fromScale(1,0.5)
minimizeBtn.AnchorPoint = Vector2.new(1,0.5)
minimizeBtn.Text = "–"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 20
minimizeBtn.TextColor3 = Color3.fromRGB(230,230,230)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(40,42,50)
minimizeBtn.BorderSizePixel = 0
Instance.new("UICorner", minimizeBtn)

--================= SIDEBAR =================
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.fromOffset(0,46)
sidebar.Size = UDim2.new(0,150,1,-46)
sidebar.BackgroundColor3 = Color3.fromRGB(15,17,22)
sidebar.BackgroundTransparency = 0.15
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,18)

local sidePad = Instance.new("UIPadding", sidebar)
sidePad.PaddingTop = UDim.new(0,14)

local sideList = Instance.new("UIListLayout", sidebar)
sideList.Padding = UDim.new(0,10)
sideList.HorizontalAlignment = Center

local function createMenu(name)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(120,36)
    b.Text = name
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 14
    b.TextColor3 = Color3.fromRGB(230,230,230)
    b.BackgroundColor3 = Color3.fromRGB(32,34,40)
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    b.Parent = sidebar
    return b
end

local farmBtn = createMenu("Farm")
local mapBtn = createMenu("Map")
local autoBtn = createMenu("Automatic")
local shopBtn = createMenu("Shop")

--================= CONTENT =================
local content = Instance.new("Frame", main)
content.Position = UDim2.fromOffset(150,46)
content.Size = UDim2.new(1,-150,1,-46)
content.BackgroundTransparency = 1

local pages = {}

local function createPage(name)
    local f = Instance.new("Frame", content)
    f.Size = UDim2.fromScale(1,1)
    f.Visible = false
    f.BackgroundTransparency = 1

    local pad = Instance.new("UIPadding", f)
    pad.PaddingTop = UDim.new(0,16)
    pad.PaddingLeft = UDim.new(0,16)
    pad.PaddingRight = UDim.new(0,16)

    local list = Instance.new("UIListLayout", f)
    list.Padding = UDim.new(0,14)

    pages[name] = f
    return f
end

local farmPage = createPage("Farm")
local mapPage = createPage("Map")
local autoPage = createPage("Automatic")
local shopPage = createPage("Shop")

--================= PAGE SWITCH + HIGHLIGHT =================
local function highlight(active)
    for _,b in ipairs({farmBtn,mapBtn,autoBtn,shopBtn}) do
        b.BackgroundColor3 = Color3.fromRGB(32,34,40)
    end
    active.BackgroundColor3 = Color3.fromRGB(0,200,160)
end

local function showPage(name, btn)
    for _,p in pairs(pages) do p.Visible = false end
    pages[name].Visible = true
    highlight(btn)
end

showPage("Farm", farmBtn)

--================= COMPONENT =================
local function titleText(txt, parent)
    local t = Instance.new("TextLabel", parent)
    t.Size = UDim2.new(1,0,0,22)
    t.Text = txt
    t.Font = Enum.Font.GothamBold
    t.TextSize = 14
    t.TextColor3 = Color3.fromRGB(0,200,160)
    t.TextXAlignment = Left
    t.BackgroundTransparency = 1
end

local function section(parent, height)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1,0,0,height or 100)
    f.BackgroundColor3 = Color3.fromRGB(26,28,34)
    f.BackgroundTransparency = 0.1
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,12)

    local pad = Instance.new("UIPadding", f)
    pad.PaddingLeft = UDim.new(0,14)
    pad.PaddingTop = UDim.new(0,10)
    return f
end

--================= FARM CONTENT =================
titleText("AUTO FISHING", farmPage)
local fishingSection = section(farmPage,120)

titleText("AUTO SELL FISH", farmPage)
section(farmPage,80) -- kosong

--================= EMPTY PAGES =================
titleText("MAP", mapPage)
section(mapPage,120)

titleText("AUTOMATIC", autoPage)
section(autoPage,120)

titleText("SHOP", shopPage)
section(shopPage,120)

--================= MENU EVENTS =================
farmBtn.MouseButton1Click:Connect(function() showPage("Farm", farmBtn) end)
mapBtn.MouseButton1Click:Connect(function() showPage("Map", mapBtn) end)
autoBtn.MouseButton1Click:Connect(function() showPage("Automatic", autoBtn) end)
shopBtn.MouseButton1Click:Connect(function() showPage("Shop", shopBtn) end)

--================= MINIMIZE =================
local mini = Instance.new("TextButton", gui)
mini.Size = UDim2.fromOffset(120,36)
mini.Position = UDim2.fromScale(0.5,0.9)
mini.AnchorPoint = Vector2.new(0.5,0.5)
mini.Text = "ASPAN-HUB"
mini.Font = Enum.Font.GothamBold
mini.TextSize = 14
mini.TextColor3 = Color3.fromRGB(230,230,230)
mini.BackgroundColor3 = Color3.fromRGB(0,200,160)
mini.BorderSizePixel = 0
mini.Visible = false
Instance.new("UICorner", mini).CornerRadius = UDim.new(0,12)
mini.Active, mini.Draggable = true, true

minimizeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    mini.Visible = true
end)

mini.MouseButton1Click:Connect(function()
    main.Visible = true
    mini.Visible = false
end)

print("ASPAN-HUB UI FINAL LOADED")
