--==================================================
-- ASPAN-HUB UI TEMPLATE (Farm / Map / Automatic / Shop)
-- LEGIT++ & BLATANT BUTTON READY
--==================================================

local Players = game:GetService("Players")
local player = Players.LocalPlayer

--================= GUI =================
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "ASPAN_HUB_UI"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(600, 360)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(20,22,28)
main.BackgroundTransparency = 0.15
main.BorderSizePixel = 0
main.Active, main.Draggable = true, true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

--================= SIDEBAR =================
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 150, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(16,18,23)
sidebar.BackgroundTransparency = 0.2
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,16)

local sideList = Instance.new("UIListLayout", sidebar)
sideList.Padding = UDim.new(0,10)
sideList.HorizontalAlignment = Center

local sidePad = Instance.new("UIPadding", sidebar)
sidePad.PaddingTop = UDim.new(0,16)

local function createMenu(text)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(120, 36)
    b.Text = text
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 14
    b.TextColor3 = Color3.fromRGB(230,230,230)
    b.BackgroundColor3 = Color3.fromRGB(30,32,38)
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
content.Position = UDim2.fromOffset(150,0)
content.Size = UDim2.new(1,-150,1,0)
content.BackgroundTransparency = 1

local pages = {}

local function createPage(name)
    local f = Instance.new("Frame", content)
    f.Size = UDim2.fromScale(1,1)
    f.Visible = false
    f.BackgroundTransparency = 1
    pages[name] = f

    local pad = Instance.new("UIPadding", f)
    pad.PaddingTop = UDim.new(0,20)
    pad.PaddingLeft = UDim.new(0,20)
    pad.PaddingRight = UDim.new(0,20)

    local list = Instance.new("UIListLayout", f)
    list.Padding = UDim.new(0,14)

    return f
end

local farmPage = createPage("Farm")
local mapPage = createPage("Map")
local autoPage = createPage("Automatic")
local shopPage = createPage("Shop")

local function showPage(name)
    for _,p in pairs(pages) do p.Visible = false end
    pages[name].Visible = true
end
showPage("Farm")

--================= UI COMPONENT =================
local function title(text, parent)
    local t = Instance.new("TextLabel", parent)
    t.Size = UDim2.new(1,0,0,22)
    t.Text = text
    t.Font = Enum.Font.GothamBold
    t.TextSize = 14
    t.TextXAlignment = Left
    t.TextColor3 = Color3.fromRGB(0,200,160)
    t.BackgroundTransparency = 1
end

local function section(parent)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1,0,0,60)
    f.BackgroundColor3 = Color3.fromRGB(26,28,34)
    f.BackgroundTransparency = 0.2
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,12)

    local pad = Instance.new("UIPadding", f)
    pad.PaddingLeft = UDim.new(0,14)
    pad.PaddingRight = UDim.new(0,14)

    return f
end

local function toggleRow(text, callback, parent)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1,0,0,44)
    row.BackgroundTransparency = 1

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(1,-60,1,0)
    lbl.Text = text
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.TextXAlignment = Left
    lbl.TextColor3 = Color3.fromRGB(230,230,230)
    lbl.BackgroundTransparency = 1

    local toggle = Instance.new("Frame", row)
    toggle.Size = UDim2.fromOffset(44,22)
    toggle.Position = UDim2.new(1,-44,0.5,-11)
    toggle.BackgroundColor3 = Color3.fromRGB(80,80,80)
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(1,0)

    local knob = Instance.new("Frame", toggle)
    knob.Size = UDim2.fromOffset(18,18)
    knob.Position = UDim2.fromOffset(2,2)
    knob.BackgroundColor3 = Color3.fromRGB(230,230,230)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

    local state = false
    toggle.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            state = not state
            if state then
                toggle.BackgroundColor3 = Color3.fromRGB(60,200,160)
                knob:TweenPosition(UDim2.fromOffset(24,2),"Out","Quad",0.15,true)
            else
                toggle.BackgroundColor3 = Color3.fromRGB(80,80,80)
                knob:TweenPosition(UDim2.fromOffset(2,2),"Out","Quad",0.15,true)
            end
            callback(state)
        end
    end)
end

--================= FARM PAGE =================
title("AUTO FISHING", farmPage)

local fishingSection = section(farmPage)

local function onLegitToggle(state)
    print("AUTO LEGIT++:", state)
    -- HUB.LegitStart() / Stop()
end

local function onBlatantToggle(state)
    print("AUTO BLATANT:", state)
    -- HUB.BlatantStart() / Stop()
end

toggleRow("Auto Fishing Legit++", onLegitToggle, fishingSection)
toggleRow("Auto Fishing Blatant", onBlatantToggle, fishingSection)

title("AUTO SELL FISH", farmPage)
section(farmPage) -- kosong (logic nanti)

--================= EMPTY PAGES =================
title("MAP", mapPage)
section(mapPage)

title("AUTOMATIC", autoPage)
section(autoPage)

title("SHOP", shopPage)
section(shopPage)

--================= MENU LOGIC =================
farmBtn.MouseButton1Click:Connect(function() showPage("Farm") end)
mapBtn.MouseButton1Click:Connect(function() showPage("Map") end)
autoBtn.MouseButton1Click:Connect(function() showPage("Automatic") end)
shopBtn.MouseButton1Click:Connect(function() showPage("Shop") end)

print("ASPAN-HUB UI TEMPLATE LOADED")
