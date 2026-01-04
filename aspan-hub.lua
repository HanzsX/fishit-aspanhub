--=====================================================
-- ASPAN-HUB v1.1 FINAL (NO IMAGE)
-- Fish It | PC | XENO | SAFE + FAST FARM
--=====================================================

--================ SERVICES =================
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local backpack = player:WaitForChild("Backpack")

--================ SETTINGS =================
local AUTO_FISH = false
local AUTO_SELL = true
local MODE = "SAFE" -- SAFE / FAST

local DELAY = {
    SAFE = {0.25, 0.45},
    FAST = {0.10, 0.18}
}
local REEL = {
    SAFE = {0.85, 0.94},
    FAST = {0.80, 0.92}
}

--================ UTIL =================
local function rand(a,b)
    return math.random(a*100,b*100)/100
end

local function delay()
    local d = DELAY[MODE]
    task.wait(rand(d[1], d[2]))
end

local function reelTarget()
    local r = REEL[MODE]
    return rand(r[1], r[2])
end

local function notify(txt)
    pcall(function()
        StarterGui:SetCore("SendNotification",{
            Title="ASPAN-HUB",
            Text=txt,
            Duration=4
        })
    end)
end

local function equipRod()
    for _,t in ipairs(backpack:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find("rod") then
            t.Parent = char
            return t
        end
    end
end

local function getBar()
    for _,v in ipairs(player.PlayerGui:GetDescendants()) do
        if v:IsA("Frame") and v.Name:lower():find("bar") then
            return v
        end
    end
end

local function autoSell()
    for _,v in ipairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("sell") then
            v:FireServer()
            return
        end
    end
end

--================ AUTO FISH CORE =================
task.spawn(function()
    while true do
        if AUTO_FISH then
            local rod = equipRod()
            if rod then
                rod:Activate() -- cast
                delay()

                local bar
                local timeout = tick() + 6
                repeat
                    bar = getBar()
                    task.wait()
                until bar or tick() > timeout or not AUTO_FISH

                if bar then
                    local target = reelTarget()
                    repeat
                        local fill = bar:FindFirstChild("Fill")
                        if fill and fill.Size.X.Scale >= target then
                            rod:Activate() -- reel
                            break
                        end
                        task.wait()
                    until not AUTO_FISH
                end

                if AUTO_SELL then
                    autoSell()
                end
            end
        end
        task.wait(0.25)
    end
end)

--================ MAP SCANNER =================
local KEYWORDS = {
    "treasure","sisyphus","statue","vault",
    "cave","ruin","island","temple","secret"
}
local FOUND = {}

local function scanMap()
    table.clear(FOUND)
    for _,o in ipairs(workspace:GetDescendants()) do
        if o:IsA("Model") or o:IsA("Part") then
            for _,k in ipairs(KEYWORDS) do
                if o.Name:lower():find(k) then
                    local cf = o:IsA("Model") and o:GetPivot() or o.CFrame
                    table.insert(FOUND,{Name=o.Name,CFrame=cf})
                    break
                end
            end
        end
    end
end

local function tp(cf)
    hrp.CFrame = cf + Vector3.new(0,5,0)
end

--================ UI =================
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "ASPAN_HUB"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.42,0.58)
main.Position = UDim2.fromScale(0.29,0.22)
main.BackgroundColor3 = Color3.fromRGB(22,22,22)
main.BorderSizePixel = 0
Instance.new("UICorner", main)

-- HEADER (DRAG ONLY HERE)
local header = Instance.new("Frame", main)
header.Size = UDim2.fromScale(1,0.12)
header.BackgroundColor3 = Color3.fromRGB(30,30,30)
header.Active = true
header.Draggable = true
Instance.new("UICorner", header)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.fromScale(0.7,1)
title.Position = UDim2.fromScale(0.04,0)
title.Text = "ASPAN-HUB v1.1"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(0,255,200)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local function hBtn(txt,x)
    local b = Instance.new("TextButton", header)
    b.Size = UDim2.fromScale(0.08,0.7)
    b.Position = UDim2.fromScale(x,0.15)
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(55,55,55)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    return b
end

local minBtn = hBtn("-",0.82)
local closeBtn = hBtn("X",0.91)

local body = Instance.new("Frame", main)
body.Size = UDim2.fromScale(1,0.88)
body.Position = UDim2.fromScale(0,0.12)
body.BackgroundTransparency = 1

--================ TABS =================
local tabs = {"Profile","Game","Map"}
local pages = {}

for i,n in ipairs(tabs) do
    local tb = Instance.new("TextButton", body)
    tb.Size = UDim2.fromScale(0.3,0.1)
    tb.Position = UDim2.fromScale(0.02+(i-1)*0.32,0.02)
    tb.Text = n
    tb.BackgroundColor3 = Color3.fromRGB(45,45,45)
    tb.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", tb)

    local pg = Instance.new("Frame", body)
    pg.Size = UDim2.fromScale(0.96,0.78)
    pg.Position = UDim2.fromScale(0.02,0.18)
    pg.BackgroundColor3 = Color3.fromRGB(28,28,28)
    pg.Visible = false
    Instance.new("UICorner", pg)
    pages[n] = pg

    tb.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do p.Visible = false end
        pg.Visible = true
    end)
end
pages.Profile.Visible = true

-- PROFILE
do
    local p = pages.Profile
    local info = Instance.new("TextLabel", p)
    info.Size = UDim2.fromScale(1,1)
    info.BackgroundTransparency = 1
    info.Font = Enum.Font.Gotham
    info.TextScaled = true
    info.TextColor3 = Color3.new(1,1,1)
    info.Text = ("Username : %s\nUserId : %d\nExecutor : Xeno\nMode : %s")
        :format(player.Name, player.UserId, MODE)
end

-- GAME
do
    local g = pages.Game

    local fishBtn = Instance.new("TextButton", g)
    fishBtn.Size = UDim2.fromScale(0.9,0.18)
    fishBtn.Position = UDim2.fromScale(0.05,0.10)
    fishBtn.Text = "AUTO FISH : OFF"
    fishBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    fishBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", fishBtn)

    local modeBtn = Instance.new("TextButton", g)
    modeBtn.Size = UDim2.fromScale(0.9,0.18)
    modeBtn.Position = UDim2.fromScale(0.05,0.34)
    modeBtn.Text = "MODE : SAFE"
    modeBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
    modeBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", modeBtn)

    fishBtn.MouseButton1Click:Connect(function()
        AUTO_FISH = not AUTO_FISH
        fishBtn.Text = "AUTO FISH : "..(AUTO_FISH and "ON" or "OFF")
    end)

    modeBtn.MouseButton1Click:Connect(function()
        MODE = (MODE == "SAFE") and "FAST" or "SAFE"
        modeBtn.Text = "MODE : "..MODE
        notify("Mode switched to "..MODE)
    end)
end

-- MAP
do
    local m = pages.Map

    local scanBtn = Instance.new("TextButton", m)
    scanBtn.Size = UDim2.fromScale(0.9,0.16)
    scanBtn.Position = UDim2.fromScale(0.05,0.06)
    scanBtn.Text = "SCAN MAP"
    scanBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    scanBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", scanBtn)

    local list = Instance.new("ScrollingFrame", m)
    list.Size = UDim2.fromScale(0.9,0.60)
    list.Position = UDim2.fromScale(0.05,0.28)
    list.CanvasSize = UDim2.new(0,0,0,0)
    list.ScrollBarImageTransparency = 0.3

    local layout = Instance.new("UIListLayout", list)
    layout.Padding = UDim.new(0,6)

    local function refresh()
        for _,c in ipairs(list:GetChildren()) do
            if c:IsA("TextButton") then c:Destroy() end
        end
        for _,d in ipairs(FOUND) do
            local b = Instance.new("TextButton", list)
            b.Size = UDim2.new(1,-10,0,30)
            b.Text = d.Name
            b.BackgroundColor3 = Color3.fromRGB(55,55,55)
            b.TextColor3 = Color3.new(1,1,1)
            Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(function()
                tp(d.CFrame)
            end)
        end
        task.wait()
        list.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+10)
    end

    scanBtn.MouseButton1Click:Connect(function()
        scanMap()
        refresh()
        notify("Map scanned: "..#FOUND.." locations")
    end)
end

-- MINIMIZE / CLOSE
local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    body.Visible = not minimized
    main.Size = minimized and UDim2.fromScale(0.42,0.12) or UDim2.fromScale(0.42,0.58)
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

print("ASPAN-HUB v1.1 FINAL loaded | PC | Xeno")
