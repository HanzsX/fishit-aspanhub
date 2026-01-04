--=====================================================
-- FISH IT FINAL SCRIPT
-- AUTO FISH + MAP SCANNER
-- PC & MOBILE
--=====================================================

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local backpack = player:WaitForChild("Backpack")

local MOBILE = UIS.TouchEnabled

--==================== SETTINGS ====================
local AUTO_FISH = false
local AUTO_SELL = true
local INVENTORY_LIMIT = 100
local PERFECT_MIN = 0.88
local PERFECT_MAX = 0.95

--==================== ANTI AFK ====================
player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

--==================== UTIL ====================
local function click()
    VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(0.05)
    VirtualUser:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end

local function equipRod()
    for _,t in ipairs(backpack:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find("rod") then
            t.Parent = char
            return true
        end
    end
end

local function inventoryCount()
    local inv = player:FindFirstChild("Inventory")
    if inv then
        return #inv:GetChildren()
    end
    return 0
end

local function inventoryFull()
    return inventoryCount() >= INVENTORY_LIMIT
end

--==================== AUTO SELL ====================
local function autoSell()
    for _,v in ipairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("sell") then
            v:FireServer()
            return
        end
    end
end

--==================== FISHING BAR ====================
local function getFishingBar()
    for _,v in ipairs(player.PlayerGui:GetDescendants()) do
        if v:IsA("Frame") and v.Name:lower():find("bar") then
            return v
        end
    end
end

--==================== MAP SCANNER ====================
local KEYWORDS = {
    "treasure","sisyphus","statue","vault",
    "cave","ruin","island","temple","secret"
}

local FOUND = {}

local function scanMap()
    table.clear(FOUND)
    for _,obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("Part") or obj:IsA("Folder") then
            local lname = obj.Name:lower()
            for _,k in ipairs(KEYWORDS) do
                if lname:find(k) then
                    local cf
                    if obj:IsA("Model") then
                        cf = obj:GetPivot()
                    elseif obj:IsA("Part") then
                        cf = obj.CFrame
                    end
                    if cf then
                        table.insert(FOUND,{Name=obj.Name,CFrame=cf})
                    end
                    break
                end
            end
        end
    end
end

local function safeTeleport(cf)
    hrp.CFrame = cf + Vector3.new(0,5,0)
end

--==================== UI ====================
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "FishItFinalUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = MOBILE and UDim2.fromScale(0.85,0.7) or UDim2.fromScale(0.38,0.6)
frame.Position = UDim2.fromScale(0.31,0.22)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = not MOBILE
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.fromScale(1,0.1)
title.Text = "FISH IT - aspan-hub"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local function button(text,y)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.fromScale(0.9,0.1)
    b.Position = UDim2.fromScale(0.05,y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(60,60,60)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    return b
end

local toggleFish = button("AUTO FISH : OFF",0.12)
local scanBtn = button("SCAN MAP",0.24)
local sellBtn = button("SELL FISH",0.36)

local list = Instance.new("ScrollingFrame", frame)
list.Size = UDim2.fromScale(0.9,0.48)
list.Position = UDim2.fromScale(0.05,0.48)
list.CanvasSize = UDim2.new(0,0,0,0)
list.ScrollBarImageTransparency = 0.2

local layout = Instance.new("UIListLayout", list)
layout.Padding = UDim.new(0,6)

local function refreshList()
    for _,c in ipairs(list:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    for _,d in ipairs(FOUND) do
        local b = Instance.new("TextButton", list)
        b.Size = UDim2.new(1,-10,0,MOBILE and 48 or 30)
        b.Text = d.Name
        b.TextColor3 = Color3.new(1,1,1)
        b.BackgroundColor3 = Color3.fromRGB(55,55,55)
        b.TextScaled = true
        Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(function()
            safeTeleport(d.CFrame)
        end)
    end
    task.wait()
    list.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+10)
end

toggleFish.MouseButton1Click:Connect(function()
    AUTO_FISH = not AUTO_FISH
    toggleFish.Text = "AUTO FISH : "..(AUTO_FISH and "ON" or "OFF")
end)

scanBtn.MouseButton1Click:Connect(function()
    scanMap()
    refreshList()
end)

sellBtn.MouseButton1Click:Connect(autoSell)

-- Toggle UI PC
UIS.InputBegan:Connect(function(i,gp)
    if not gp and i.KeyCode == Enum.KeyCode.RightShift then
        frame.Visible = not frame.Visible
    end
end)

--==================== AUTO FISH LOOP ====================
task.spawn(function()
    while true do
        if AUTO_FISH then
            if inventoryFull() then
                if AUTO_SELL then
                    autoSell()
                    task.wait(2)
                else
                    AUTO_FISH = false
                end
            end

            equipRod()
            click() -- cast

            local bar
            local timeout = tick() + 6
            repeat
                bar = getFishingBar()
                task.wait()
            until bar or tick() > timeout or not AUTO_FISH

            if bar then
                local target = math.random(
                    PERFECT_MIN*100,
                    PERFECT_MAX*100
                )/100

                repeat
                    local fill = bar:FindFirstChild("Fill")
                    if fill and fill.Size.X.Scale >= target then
                        click() -- reel
                        break
                    end
                    task.wait()
                until not AUTO_FISH
            end
        end
        task.wait(0.4)
    end
end)

print("Fish It aspan-hub script loaded")
