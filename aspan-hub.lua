--==============================
-- ASPAN HUB - XENO ULTRA SAFE
--==============================

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(600,360)
main.Position = UDim2.fromScale(0.5,0.5)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,40)
title.Text = "ASPAN HUB • Fish It (XENO SAFE)"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

-- SIDEBAR
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.fromOffset(0,40)
sidebar.Size = UDim2.fromOffset(140,320)
sidebar.BackgroundColor3 = Color3.fromRGB(30,30,30)

local function SideBtn(text,y)
    local b = Instance.new("TextButton", sidebar)
    b.Size = UDim2.fromOffset(120,36)
    b.Position = UDim2.fromOffset(10,y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(60,60,60)
    b.TextColor3 = Color3.new(1,1,1)
    return b
end

local farmBtn = SideBtn("Farm",10)
local autoBtn = SideBtn("Auto",56)
local utilBtn = SideBtn("Util",102)

-- CONTENT
local content = Instance.new("Frame", main)
content.Position = UDim2.fromOffset(140,40)
content.Size = UDim2.fromOffset(460,320)
content.BackgroundColor3 = Color3.fromRGB(25,25,25)

local label = Instance.new("TextLabel", content)
label.Size = UDim2.fromScale(1,1)
label.Text = "TAB CONTENT"
label.TextColor3 = Color3.new(1,1,1)
label.BackgroundTransparency = 1

farmBtn.MouseButton1Click:Connect(function()
    label.Text = "FARM TAB"
end)

autoBtn.MouseButton1Click:Connect(function()
    label.Text = "AUTO TAB"
end)

utilBtn.MouseButton1Click:Connect(function()
    label.Text = "UTIL TAB"
end)

print("ASPAN HUB XENO ULTRA SAFE LOADED")
