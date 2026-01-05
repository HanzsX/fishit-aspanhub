--================ UI (THEME UPGRADE & FIX) =================

local gui = Instance.new("ScreenGui")
gui.Name = "ASPAN_HUB"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

-- Main
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(420,260)
main.Position = UDim2.fromScale(0.5,0.5)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(17,18,22)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,18)

-- Shadow
local shadow = Instance.new("ImageLabel", main)
shadow.Size = UDim2.new(1,40,1,40)
shadow.Position = UDim2.new(0,-20,0,-20)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.75
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10,10,118,118)
shadow.ZIndex = 0

-- Header
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,44)
header.BackgroundColor3 = Color3.fromRGB(22,24,30)
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0,18)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-80,1,0)
title.Position = UDim2.fromOffset(18,0)
title.Text = "ASPAN-HUB  •  Fish It"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(0,230,200)
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1

local close = Instance.new("TextButton", header)
close.Size = UDim2.fromOffset(30,26)
close.Position = UDim2.new(1,-38,0.5,-13)
close.Text = "✕"
close.Font = Enum.Font.GothamBold
close.TextSize = 14
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(160,60,60)
close.BorderSizePixel = 0
Instance.new("UICorner", close)

-- Content
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1,-32,1,-76)
content.Position = UDim2.fromOffset(16,60)
content.BackgroundTransparency = 1

-- Toggle Row (Reusable)
local function ToggleRow(y, text, default, callback)
    local label = Instance.new("TextLabel", content)
    label.Position = UDim2.fromOffset(0,y)
    label.Size = UDim2.fromOffset(260,26)
    label.Text = text
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(230,230,235)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1

    local btn = Instance.new("TextButton", content)
    btn.Position = UDim2.fromOffset(290,y)
    btn.Size = UDim2.fromOffset(80,26)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn)

    local state = default
    local function redraw()
        btn.Text = state and "ON" or "OFF"
        btn.BackgroundColor3 = state and Color3.fromRGB(0,190,150)
            or Color3.fromRGB(90,95,120)
        callback(state)
    end

    btn.MouseButton1Click:Connect(function()
        state = not state
        redraw()
    end)

    redraw()
end

ToggleRow(0, "Auto Fishing (Klik Cepat)", false, function(v)
    Hub.AutoFish = v
end)

ToggleRow(40, "Freeze Position Saat Fishing", true, function(v)
    Hub.Freeze = v
end)

-- Minimize
local mini = Instance.new("TextButton", gui)
mini.Size = UDim2.fromOffset(150,38)
mini.Position = UDim2.fromScale(0.02,0.9)
mini.Text = "ASPAN HUB"
mini.Font = Enum.Font.GothamBold
mini.TextSize = 14
mini.TextColor3 = Color3.fromRGB(0,230,200)
mini.BackgroundColor3 = Color3.fromRGB(22,24,30)
mini.BorderSizePixel = 0
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
