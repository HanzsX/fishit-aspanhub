--=====================================================
-- ASPAN-HUB FINAL
-- Fish It | PC | XENO
-- Auto Fish REAL (Remote Based) + Clean UI
--=====================================================

--================ SERVICES =================
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

--================ NOTIFY =================
local function notify(txt)
    pcall(function()
        StarterGui:SetCore("SendNotification",{
            Title = "ASPAN-HUB",
            Text = txt,
            Duration = 4
        })
    end)
end

--=====================================================
-- AUTO FISH CORE (REMOTE BASED - WORKING)
--=====================================================

local AutoFish = {
    Enabled = false,
    CastDelay = 0.5,
    CheckDelay = 0.15,
    IsCasting = false,
    IsReeling = false
}

local RARE_KEYS = {"legendary","mythic","ancient","rare"}

local function getRod()
    local char = player.Character
    if not char then return end
    for _,t in ipairs(char:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find("rod") then
            return t
        end
    end
end

local function isBiting(rod)
    local bite = rod:FindFirstChild("Bite")
    return bite and bite.Value == true
end

local function castRod(rod)
    local cast = rod:FindFirstChild("Cast")
    if cast then
        cast:FireServer()
        AutoFish.IsCasting = true
    end
end

local function reelRod(rod)
    local reel = rod:FindFirstChild("Reel")
    if reel then
        reel:FireServer()
        AutoFish.IsReeling = true
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

local function isRare(name)
    if not name then return end
    name = name:lower()
    for _,k in ipairs(RARE_KEYS) do
        if name:find(k) then
            return true
        end
    end
end

task.spawn(function()
    while true do
        if AutoFish.Enabled then
            local rod = getRod()
            if rod and not AutoFish.IsCasting and not AutoFish.IsReeling then
                castRod(rod)
                task.wait(AutoFish.CastDelay)

                while AutoFish.Enabled and rod.Parent do
                    if isBiting(rod) then
                        task.wait(0.08)
                        reelRod(rod)
                        break
                    end
                    task.wait(AutoFish.CheckDelay)
                end

                task.wait(0.4)
                AutoFish.IsCasting = false
                AutoFish.IsReeling = false

                local fish =
                    rod:FindFirstChild("LastFish") and rod.LastFish.Value
                    or rod:FindFirstChild("FishName") and rod.FishName.Value

                if isRare(fish) then
                    notify("RARE FISH: "..fish)
                end

                autoSell()
            end
        end
        task.wait(0.12)
    end
end)

--=====================================================
-- UI (STYLE LIKE REFERENCE)
--=====================================================

local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "ASPAN_HUB"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.55,0.6)
main.Position = UDim2.fromScale(0.22,0.2)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
Instance.new("UICorner", main)

-- HEADER
local header = Instance.new("Frame", main)
header.Size = UDim2.fromScale(1,0.1)
header.BackgroundColor3 = Color3.fromRGB(30,30,30)
header.Active = true
header.Draggable = true
Instance.new("UICorner", header)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.fromScale(0.7,1)
title.Position = UDim2.fromScale(0.03,0)
title.Text = "ASPAN-HUB | Fish It"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(0,255,200)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

-- SIDEBAR
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.fromScale(0.22,0.9)
sidebar.Position = UDim2.fromScale(0,0.1)
sidebar.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner", sidebar)

-- CONTENT
local content = Instance.new("Frame", main)
content.Size = UDim2.fromScale(0.78,0.9)
content.Position = UDim2.fromScale(0.22,0.1)
content.BackgroundColor3 = Color3.fromRGB(22,22,22)
Instance.new("UICorner", content)

-- PAGES
local pages = {}
local function newPage(name)
    local f = Instance.new("Frame", content)
    f.Size = UDim2.fromScale(1,1)
    f.Visible = false
    f.BackgroundTransparency = 1
    pages[name] = f
    return f
end

local farmPage = newPage("Farm")
local profilePage = newPage("Profile")
pages.Farm.Visible = true

-- SIDEBAR BUTTON
local function sideBtn(text,y)
    local b = Instance.new("TextButton", sidebar)
    b.Size = UDim2.fromScale(0.9,0.12)
    b.Position = UDim2.fromScale(0.05,y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(50,50,50)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)

    b.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do p.Visible = false end
        pages[text].Visible = true
    end)
end

sideBtn("Farm",0.08)
sideBtn("Profile",0.24)

-- FARM PAGE
local autoBtn = Instance.new("TextButton", farmPage)
autoBtn.Size = UDim2.fromScale(0.6,0.18)
autoBtn.Position = UDim2.fromScale(0.2,0.2)
autoBtn.Text = "AUTO FISH : OFF"
autoBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
autoBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", autoBtn)

autoBtn.MouseButton1Click:Connect(function()
    AutoFish.Enabled = not AutoFish.Enabled
    autoBtn.Text = "AUTO FISH : "..(AutoFish.Enabled and "ON" or "OFF")
    autoBtn.BackgroundColor3 = AutoFish.Enabled
        and Color3.fromRGB(50,200,50)
        or Color3.fromRGB(200,50,50)
end)

-- PROFILE PAGE
local info = Instance.new("TextLabel", profilePage)
info.Size = UDim2.fromScale(1,1)
info.BackgroundTransparency = 1
info.Font = Enum.Font.Gotham
info.TextScaled = true
info.TextColor3 = Color3.new(1,1,1)
info.Text = "Username : "..player.Name..
"\nUserId : "..player.UserId..
"\nExecutor : Xeno"

notify("ASPAN-HUB loaded successfully")
