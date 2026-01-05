--=====================================================
-- ASPAN-HUB FINAL | Fish It
-- Auto Fish: "Klik Cepat" BAR-TRIGGER (SAFE)
-- UI: Modern, Icons via Shapes (No Emoji/Image)
--=====================================================

--================ SERVICES =================
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local VIM = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local Backpack = player:WaitForChild("Backpack")
math.randomseed(tick())

--================ CONFIG =================
local CFG = {
    RodKeyword = "rod",
    ScanMapKeywords = {"island","pulau","treasure","statue","sisyphus","dock","port","harbor","cave","ruin","temple"},
}

--================ UTIL =================
local function rand(a,b) return a + (b-a)*math.random() end

local function equipRod()
    local char = player.Character or player.CharacterAdded:Wait()
    for _,t in ipairs(char:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find(CFG.RodKeyword) then return true end
    end
    for _,t in ipairs(Backpack:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find(CFG.RodKeyword) then
            char:FindFirstChildOfClass("Humanoid"):EquipTool(t)
            return true
        end
    end
end

--================ AUTO FISH (BAR TRIGGER) =================
local AutoFish = { Enabled=false }

local function isQuickBarVisible()
    local pg = player:FindFirstChild("PlayerGui")
    if not pg then return false end
    for _,v in ipairs(pg:GetDescendants()) do
        if v.Visible then
            if v:IsA("TextLabel") then
                local t=v.Text:lower()
                if t:find("klik") and t:find("cepat") then return true end
            end
            if v:IsA("Frame") or v:IsA("ImageLabel") then
                local tl=v:FindFirstChildWhichIsA("TextLabel",true)
                if tl then
                    local t=tl.Text:lower()
                    if t:find("klik") and t:find("cepat") then return true end
                end
            end
        end
    end
    return false
end

local function globalClick()
    VIM:SendMouseButtonEvent(0,0,0,true,game,0)
    task.wait(0.02)
    VIM:SendMouseButtonEvent(0,0,0,false,game,0)
end

task.spawn(function()
    while true do
        if AutoFish.Enabled then
            equipRod()
            if isQuickBarVisible() then
                globalClick()
            end
        end
        task.wait(0.03)
    end
end)

--================ AUTO SELL =================
local AutoSell = { Enabled=true, Cooldown=false }

local function trySell()
    if AutoSell.Cooldown then return end
    AutoSell.Cooldown=true

    for _,p in ipairs(workspace:GetDescendants()) do
        if p:IsA("ProximityPrompt") then
            local a=(p.ActionText or ""):lower()
            if a:find("sell") or a:find("jual") then
                p:InputHoldBegin(); task.wait(0.25); p:InputHoldEnd()
                task.delay(1.6,function() AutoSell.Cooldown=false end)
                return
            end
        end
    end

    for _,r in ipairs(RS:GetDescendants()) do
        if r:IsA("RemoteEvent") and r.Name:lower():find("sell") then
            r:FireServer()
            task.delay(1.6,function() AutoSell.Cooldown=false end)
            return
        end
    end
    AutoSell.Cooldown=false
end

for _,r in ipairs(RS:GetDescendants()) do
    if r:IsA("RemoteEvent") and (r.Name=="ObtainedNewFishNotification" or r.Name=="FishCaught") then
        r.OnClientEvent:Connect(function()
            if AutoSell.Enabled then task.wait(0.4); trySell() end
        end)
    end
end

--================ MAP SCANNER + TELEPORT =================
local MapScanner={Results={}}

local function scanMap()
    table.clear(MapScanner.Results)
    for _,o in ipairs(workspace:GetDescendants()) do
        if o:IsA("BasePart") or o:IsA("Model") then
            local n=o.Name:lower()
            for _,k in ipairs(CFG.ScanMapKeywords) do
                if n:find(k) then
                    local cf=o:IsA("Model") and o:GetPivot() or o.CFrame
                    table.insert(MapScanner.Results,{Name=o.Name,CFrame=cf})
                    break
                end
            end
        end
    end
end

local function teleport(cf)
    local hrp=(player.Character or {}).HumanoidRootPart
    if hrp then hrp.CFrame=cf+Vector3.new(0,5,0) end
end

--================ UI =================
local gui=Instance.new("ScreenGui",player.PlayerGui)
gui.Name="ASPAN_HUB"; gui.ResetOnSpawn=false

local main=Instance.new("Frame",gui)
main.Size=UDim2.fromScale(0.54,0.58)
main.Position=UDim2.fromScale(0.23,0.2)
main.BackgroundColor3=Color3.fromRGB(16,16,18)
main.BorderSizePixel=0
Instance.new("UICorner",main).CornerRadius=UDim.new(0,16)

-- Header
local header=Instance.new("Frame",main)
header.Size=UDim2.fromScale(1,0.12)
header.BackgroundColor3=Color3.fromRGB(22,22,26)
header.Active=true; header.Draggable=true
Instance.new("UICorner",header).CornerRadius=UDim.new(0,16)

local title=Instance.new("TextLabel",header)
title.Size=UDim2.fromScale(0.7,1)
title.Position=UDim2.fromScale(0.04,0)
title.Text="ASPAN-HUB | Fish It"
title.Font=Enum.Font.GothamBold
title.TextScaled=true
title.TextColor3=Color3.fromRGB(0,230,200)
title.BackgroundTransparency=1
title.TextXAlignment=Enum.TextXAlignment.Left

local function hBtn(txt,x)
    local b=Instance.new("TextButton",header)
    b.Size=UDim2.fromScale(0.07,0.6)
    b.Position=UDim2.fromScale(x,0.2)
    b.Text=txt; b.Font=Enum.Font.GothamBold; b.TextScaled=true
    b.BackgroundColor3=Color3.fromRGB(44,44,52)
    b.TextColor3=Color3.new(1,1,1)
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)
    return b
end

local minBtn=hBtn("—",0.86)
local closeBtn=hBtn("X",0.93)

-- Body
local body=Instance.new("Frame",main)
body.Size=UDim2.fromScale(1,0.88)
body.Position=UDim2.fromScale(0,0.12)
body.BackgroundTransparency=1

-- Sidebar
local sidebar=Instance.new("Frame",body)
sidebar.Size=UDim2.fromScale(0.22,1)
sidebar.BackgroundColor3=Color3.fromRGB(20,20,24)
Instance.new("UICorner",sidebar).CornerRadius=UDim.new(0,14)

-- Content
local content=Instance.new("Frame",body)
content.Size=UDim2.fromScale(0.78,1)
content.Position=UDim2.fromScale(0.22,0)
content.BackgroundColor3=Color3.fromRGB(18,18,22)
Instance.new("UICorner",content).CornerRadius=UDim.new(0,14)

-- Pages
local pages={}
local function page(name)
    local f=Instance.new("Frame",content)
    f.Size=UDim2.fromScale(1,1); f.BackgroundTransparency=1; f.Visible=false
    pages[name]=f; return f
end
local farm=page("Farm"); local map=page("Map"); local profile=page("Profile")
farm.Visible=true

-- ==== SHAPE ICONS (NO EMOJI/IMAGE) ====
local function iconGamepad(parent)
    local g=Instance.new("Frame",parent)
    g.Size=UDim2.fromOffset(20,12); g.BackgroundColor3=Color3.fromRGB(180,180,200)
    Instance.new("UICorner",g).CornerRadius=UDim.new(1,0)
    local l=Instance.new("Frame",g); l.Size=UDim2.fromOffset(6,6); l.Position=UDim2.fromOffset(3,3); l.BackgroundColor3=Color3.fromRGB(30,30,40)
    Instance.new("UICorner",l).CornerRadius=UDim.new(1,0)
    local r=l:Clone(); r.Parent=g; r.Position=UDim2.fromOffset(11,3)
end

local function iconMap(parent)
    local m=Instance.new("Frame",parent)
    m.Size=UDim2.fromOffset(16,16); m.BackgroundColor3=Color3.fromRGB(180,200,180)
    Instance.new("UICorner",m).CornerRadius=UDim.new(0,4)
    local l=Instance.new("Frame",m); l.Size=UDim2.fromScale(0.2,1); l.BackgroundColor3=Color3.fromRGB(40,50,40)
end

local function iconUser(parent)
    local head=Instance.new("Frame",parent)
    head.Size=UDim2.fromOffset(12,12); head.Position=UDim2.fromOffset(4,0)
    head.BackgroundColor3=Color3.fromRGB(200,200,210)
    Instance.new("UICorner",head).CornerRadius=UDim.new(1,0)
    local body=Instance.new("Frame",parent)
    body.Size=UDim2.fromOffset(20,10); body.Position=UDim2.fromOffset(0,12)
    body.BackgroundColor3=Color3.fromRGB(200,200,210)
    Instance.new("UICorner",body).CornerRadius=UDim.new(1,0)
end

local function sideBtn(txt,y,iconBuilder)
    local b=Instance.new("TextButton",sidebar)
    b.Size=UDim2.fromScale(0.9,0.1)
    b.Position=UDim2.fromScale(0.05,y)
    b.Text="  "..txt
    b.Font=Enum.Font.Gotham; b.TextScaled=true
    b.BackgroundColor3=Color3.fromRGB(44,44,52)
    b.TextColor3=Color3.new(1,1,1)
    b.TextXAlignment=Enum.TextXAlignment.Left
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,12)
    local icon=Instance.new("Frame",b)
    icon.Size=UDim2.fromOffset(24,24); icon.Position=UDim2.fromOffset(10,6)
    icon.BackgroundTransparency=1
    iconBuilder(icon)
    b.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do p.Visible=false end
        pages[txt].Visible=true
    end)
end

sideBtn("Farm",0.08,iconGamepad)
sideBtn("Map",0.22,iconMap)
sideBtn("Profile",0.36,iconUser)

-- Toggle Pill
local function togglePill(parent,y,default,cb)
    local state=default
    local base=Instance.new("Frame",parent)
    base.Size=UDim2.fromScale(0.22,0.08)
    base.Position=UDim2.fromScale(0.62,y)
    base.BackgroundColor3=state and Color3.fromRGB(0,200,160) or Color3.fromRGB(80,80,96)
    Instance.new("UICorner",base).CornerRadius=UDim.new(1,0)
    local knob=Instance.new("Frame",base)
    knob.Size=UDim2.fromScale(0.45,0.8)
    knob.Position=state and UDim2.fromScale(0.52,0.1) or UDim2.fromScale(0.03,0.1)
    knob.BackgroundColor3=Color3.fromRGB(18,18,22)
    Instance.new("UICorner",knob).CornerRadius=UDim.new(1,0)
    local btn=Instance.new("TextButton",base); btn.Size=UDim2.fromScale(1,1); btn.Text=""; btn.BackgroundTransparency=1
    local function redraw()
        TweenService:Create(base,TweenInfo.new(0.2),{BackgroundColor3=state and Color3.fromRGB(0,200,160) or Color3.fromRGB(80,80,96)}):Play()
        TweenService:Create(knob,TweenInfo.new(0.2),{Position=state and UDim2.fromScale(0.52,0.1) or UDim2.fromScale(0.03,0.1)}):Play()
        cb(state)
    end
    btn.MouseButton1Click:Connect(function() state=not state; redraw() end)
    cb(state)
end

local function label(parent,text,y)
    local l=Instance.new("TextLabel",parent)
    l.Size=UDim2.fromScale(0.45,0.08)
    l.Position=UDim2.fromScale(0.12,y)
    l.Text=text; l.Font=Enum.Font.Gotham; l.TextScaled=true
    l.TextColor3=Color3.fromRGB(220,220,230)
    l.BackgroundTransparency=1
    l.TextXAlignment=Enum.TextXAlignment.Left
end

-- Farm page
label(farm,"Auto Fishing (Klik Cepat)",0.18)
togglePill(farm,0.18,false,function(v) AutoFish.Enabled=v end)
label(farm,"Auto Sell Fish",0.34)
togglePill(farm,0.34,true,function(v) AutoSell.Enabled=v end)

-- Map page
local scanBtn=Instance.new("TextButton",map)
scanBtn.Size=UDim2.fromScale(0.4,0.12)
scanBtn.Position=UDim2.fromScale(0.05,0.05)
scanBtn.Text="SCAN MAP"
scanBtn.Font=Enum.Font.GothamBold; scanBtn.TextScaled=true
scanBtn.BackgroundColor3=Color3.fromRGB(44,44,52)
scanBtn.TextColor3=Color3.new(1,1,1)
Instance.new("UICorner",scanBtn).CornerRadius=UDim.new(0,12)

local list=Instance.new("ScrollingFrame",map)
list.Size=UDim2.fromScale(0.9,0.75)
list.Position=UDim2.fromScale(0.05,0.22)
list.CanvasSize=UDim2.new(0,0,0,0)
list.ScrollBarImageTransparency=0.2
list.BackgroundTransparency=1
local layout=Instance.new("UIListLayout",list); layout.Padding=UDim.new(0,6)

local function refreshList()
    for _,c in ipairs(list:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for _,d in ipairs(MapScanner.Results) do
        local b=Instance.new("TextButton",list)
        b.Size=UDim2.new(1,-10,0,34)
        b.Text=d.Name; b.Font=Enum.Font.Gotham; b.TextScaled=true
        b.BackgroundColor3=Color3.fromRGB(52,52,60)
        b.TextColor3=Color3.new(1,1,1)
        Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)
        b.MouseButton1Click:Connect(function() teleport(d.CFrame) end)
    end
    task.wait()
    list.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+10)
end

scanBtn.MouseButton1Click:Connect(function() scanMap(); refreshList() end)

-- Profile page
local card=Instance.new("Frame",profile)
card.Size=UDim2.fromScale(0.6,0.4)
card.Position=UDim2.fromScale(0.2,0.2)
card.BackgroundColor3=Color3.fromRGB(36,36,44)
Instance.new("UICorner",card).CornerRadius=UDim.new(0,14)
local iconWrap=Instance.new("Frame",card)
iconWrap.Size=UDim2.fromOffset(28,28); iconWrap.Position=UDim2.fromOffset(16,16); iconWrap.BackgroundTransparency=1
iconUser(iconWrap)
local info=Instance.new("TextLabel",card)
info.Size=UDim2.fromScale(1,-0.2)
info.Position=UDim2.fromScale(0.2,0.15)
info.Text="Username: "..player.Name.."\nHub: ASPAN-HUB"
info.Font=Enum.Font.Gotham; info.TextScaled=true
info.TextColor3=Color3.new(1,1,1)
info.BackgroundTransparency=1
info.TextXAlignment=Enum.TextXAlignment.Left

-- Minimize → small box
local mini=Instance.new("TextButton",gui)
mini.Size=UDim2.fromOffset(150,38)
mini.Position=UDim2.fromScale(0.02,0.86)
mini.Text="ASPAN HUB"
mini.Font=Enum.Font.GothamBold; mini.TextScaled=true
mini.BackgroundColor3=Color3.fromRGB(22,22,26)
mini.TextColor3=Color3.fromRGB(0,230,200)
Instance.new("UICorner",mini).CornerRadius=UDim.new(0,12)
mini.Visible=false

minBtn.MouseButton1Click:Connect(function() main.Visible=false; mini.Visible=true end)
mini.MouseButton1Click:Connect(function() main.Visible=true; mini.Visible=false end)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

print("ASPAN-HUB FINAL LOADED")
