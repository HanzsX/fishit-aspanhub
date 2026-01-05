--=====================================================
-- ASPAN-HUB FINAL | FISH IT
-- Auto Fish FIXED via BillboardGui "Exclaim"
--=====================================================

--================ SERVICES =================
local Players = game:GetService("Players")
local VIM = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")

--================ STATE =================
local Hub = {
    AutoFish = false,
    Freeze = true
}

--================ AUTO EQUIP ROD =================
local function equipRod()
    local char = player.Character
    if not char then return end

    for _,t in ipairs(char:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find("rod") then
            return
        end
    end

    for _,t in ipairs(backpack:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find("rod") then
            char:FindFirstChildOfClass("Humanoid"):EquipTool(t)
            return
        end
    end
end

--================ FREEZE =================
local frozenCF
local function freeze(on)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if on then
        frozenCF = hrp.CFrame
    else
        frozenCF = nil
    end
end

--================ AUTO CLICK CORE =================
local function isQuickClick()
    return Workspace:FindFirstChild("Exclaim", true) ~= nil
end

local function click()
    VIM:SendMouseButtonEvent(0,0,0,true,game,0)
    task.wait(0.02)
    VIM:SendMouseButtonEvent(0,0,0,false,game,0)
end

task.spawn(function()
    while true do
        if Hub.AutoFish then
            equipRod()

            if isQuickClick() then
                if Hub.Freeze then freeze(true) end
                click()
            else
                freeze(false)
            end
        end
        task.wait(0.03)
    end
end)

--================ UI =================
local gui = Instance.new("ScreenGui")
gui.Name = "ASPAN_HUB"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(380,220)
main.Position = UDim2.fromScale(0.5,0.5)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(18,18,22)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,-40,0,32)
title.Position = UDim2.fromOffset(12,6)
title.Text = "ASPAN-HUB | Fish It"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Left
title.TextColor3 = Color3.fromRGB(0,230,200)
title.BackgroundTransparency = 1

-- Close
local close = Instance.new("TextButton", main)
close.Size = UDim2.fromOffset(26,22)
close.Position = UDim2.new(1,-32,0,6)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 14
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(160,60,60)
Instance.new("UICorner", close)

-- AutoFish Toggle
local function toggleRow(y, text, default, callback)
    local lbl = Instance.new("TextLabel", main)
    lbl.Position = UDim2.fromOffset(20,y)
    lbl.Size = UDim2.fromOffset(200,24)
    lbl.Text = text
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.TextXAlignment = Left
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.BackgroundTransparency = 1

    local btn = Instance.new("TextButton", main)
    btn.Position = UDim2.fromOffset(260,y)
    btn.Size = UDim2.fromOffset(80,24)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn)

    local state = default
    local function redraw()
        btn.Text = state and "ON" or "OFF"
        btn.BackgroundColor3 = state and Color3.fromRGB(0,180,140) or Color3.fromRGB(90,90,110)
        callback(state)
    end

    btn.MouseButton1Click:Connect(function()
        state = not state
        redraw()
    end)

    redraw()
end

toggleRow(60, "Auto Fishing (Klik Cepat)", false, function(v)
    Hub.AutoFish = v
end)

toggleRow(100, "Freeze Position", true, function(v)
    Hub.Freeze = v
end)

-- Minimize
local mini = Instance.new("TextButton", gui)
mini.Size = UDim2.fromOffset(140,36)
mini.Position = UDim2.fromScale(0.02,0.9)
mini.Text = "ASPAN HUB"
mini.Font = Enum.Font.GothamBold
mini.TextSize = 14
mini.TextColor3 = Color3.fromRGB(0,230,200)
mini.BackgroundColor3 = Color3.fromRGB(22,22,26)
Instance.new("UICorner", mini)
mini.Visible = false

close.MouseButton1Click:Connect(function()
    main.Visible = false
    mini.Visible = true
end)

mini.MouseButton1Click:Connect(function()
    main.Visible = true
    mini.Visible = false
end)

print("ASPAN-HUB FINAL LOADED | Auto Fish FIXED")
