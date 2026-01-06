--==================================================
-- ASPAN HUB | FISH IT
-- FULL FINAL FIX (SAFE MODE + GRACE CLICK)
--==================================================

pcall(function()
    game.CoreGui.AspanHub:Destroy()
end)

----------------------------------------------------
-- SERVICES
----------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

----------------------------------------------------
-- AUTO FISH BAWAAN GAME
----------------------------------------------------
local AutoFishGame = { Enabled = false }

local function enableAutoFishing(state)
    pcall(function()
        local net = ReplicatedStorage.Packages
            ._Index["sleitnick_net@0.2.0"]
            .net

        local rf = net:FindFirstChild("RF/UpdateAutoFishingState")
        if rf then
            rf:InvokeServer(state)
        end
    end)
end

function AutoFishGame.Start()
    if AutoFishGame.Enabled then return end
    AutoFishGame.Enabled = true
    task.wait(0.25)
    enableAutoFishing(true)
end

function AutoFishGame.Stop()
    AutoFishGame.Enabled = false
    enableAutoFishing(false)
end

----------------------------------------------------
-- AUTO EQUIP ROD
----------------------------------------------------
local AutoEquipRod = {
    Enabled = false,
    RodSlot = 1,
    Conn = nil
}

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local EquipToolRE = ReplicatedStorage.Packages
    ._Index["sleitnick_net@0.2.0"]
    .net["RE/EquipToolFromHotbar"]

local function holdingRod()
    local tool = Character:FindFirstChildOfClass("Tool")
    if not tool then return false end
    local n = tool.Name:lower()
    return n:find("rod") or n:find("fishing") or n:find("pole")
end

function AutoEquipRod.Start()
    AutoEquipRod.Enabled = true
    if AutoEquipRod.Conn then AutoEquipRod.Conn:Disconnect() end

    AutoEquipRod.Conn = RunService.Heartbeat:Connect(function()
        if AutoEquipRod.Enabled and not holdingRod() then
            pcall(function()
                EquipToolRE:FireServer(AutoEquipRod.RodSlot)
            end)
        end
    end)
end

function AutoEquipRod.Stop()
    AutoEquipRod.Enabled = false
    if AutoEquipRod.Conn then
        AutoEquipRod.Conn:Disconnect()
        AutoEquipRod.Conn = nil
    end
end

LocalPlayer.CharacterAdded:Connect(function(c)
    Character = c
end)

----------------------------------------------------
-- NO FISHING ANIMATION (SAFE)
----------------------------------------------------
local NoAnim = { Enabled = false, Conn = nil, Pose = {} }

local function stopAnimations()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local anim = hum:FindFirstChildOfClass("Animator")
    if not anim then return end

    for _,t in ipairs(anim:GetPlayingAnimationTracks()) do
        t:Stop(0)
    end
end

local function capturePose()
    NoAnim.Pose = {}
    for _,m in ipairs(LocalPlayer.Character:GetDescendants()) do
        if m:IsA("Motor6D") then
            NoAnim.Pose[m] = { C0 = m.C0, C1 = m.C1 }
        end
    end
end

function NoAnim.Start()
    if NoAnim.Enabled then return end
    task.delay(1,function()
        stopAnimations()
        capturePose()
        NoAnim.Enabled = true

        NoAnim.Conn = RunService.RenderStepped:Connect(function()
            if not NoAnim.Enabled then return end
            stopAnimations()
            for m,d in pairs(NoAnim.Pose) do
                if m and m.Parent then
                    m.C0 = d.C0
                    m.C1 = d.C1
                end
            end
        end)
    end)
end

function NoAnim.Stop()
    NoAnim.Enabled = false
    if NoAnim.Conn then
        NoAnim.Conn:Disconnect()
        NoAnim.Conn = nil
    end
    NoAnim.Pose = {}
end

----------------------------------------------------
-- GUI (STABLE)
----------------------------------------------------
local Gui = Instance.new("ScreenGui", game.CoreGui)
Gui.Name = "AspanHub"

local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0,520,0,320)
Main.Position = UDim2.new(0.5,-260,0.5,-160)
Main.BackgroundColor3 = Color3.fromRGB(18,18,18)
Main.BackgroundTransparency = 0.15
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

----------------------------------------------------
-- HEADER
----------------------------------------------------
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1,0,0,42)
Header.BackgroundTransparency = 1
Header.ZIndex = 10

local Logo = Instance.new("ImageLabel", Header)
Logo.Size = UDim2.new(0,28,0,28)
Logo.Position = UDim2.new(0,10,0.5,-14)
Logo.Image = "rbxassetid://100446592606293"
Logo.BackgroundTransparency = 1
Logo.ZIndex = 11

local Title = Instance.new("TextLabel", Header)
Title.Text = "Aspan Hub | Fish It"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0,46,0,0)
Title.Size = UDim2.new(1,-140,1,0)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 11

local MinBtn = Instance.new("TextButton", Header)
MinBtn.Text = "-"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 22
MinBtn.Size = UDim2.new(0,40,1,0)
MinBtn.Position = UDim2.new(1,-80,0,0)
MinBtn.BackgroundTransparency = 1
MinBtn.ZIndex = 11

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.TextColor3 = Color3.fromRGB(255,90,90)
CloseBtn.Size = UDim2.new(0,40,1,0)
CloseBtn.Position = UDim2.new(1,-40,0,0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.ZIndex = 11

----------------------------------------------------
-- BODY / SIDEBAR / CONTENT
----------------------------------------------------
local Body = Instance.new("Frame", Main)
Body.Position = UDim2.new(0,0,0,42)
Body.Size = UDim2.new(1,0,1,-42)
Body.BackgroundTransparency = 1

local Sidebar = Instance.new("Frame", Body)
Sidebar.Size = UDim2.new(0,120,1,0)
Sidebar.BackgroundColor3 = Color3.fromRGB(25,25,25)
Sidebar.BackgroundTransparency = 0.1
Instance.new("UICorner", Sidebar)

local Content = Instance.new("Frame", Body)
Content.Position = UDim2.new(0,130,0,0)
Content.Size = UDim2.new(1,-140,1,0)
Content.BackgroundTransparency = 1

----------------------------------------------------
-- TAB SYSTEM
----------------------------------------------------
local Tabs = {}
local function CreateTab(name, order)
    local Btn = Instance.new("TextButton", Sidebar)
    Btn.Size = UDim2.new(1,-10,0,36)
    Btn.Position = UDim2.new(0,5,0,10+(order-1)*42)
    Btn.Text = name
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 13
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", Btn)

    local Frame = Instance.new("Frame", Content)
    Frame.Size = UDim2.new(1,0,1,0)
    Frame.Visible = false
    Frame.BackgroundTransparency = 1

    Btn.MouseButton1Click:Connect(function()
        for _,v in pairs(Tabs) do v.Visible = false end
        Frame.Visible = true
    end)

    Tabs[name] = Frame
    return Frame
end

local InfoTab = CreateTab("Info",1)
local FarmTab = CreateTab("Farm",2)
local ShopTab = CreateTab("Shop",3)
local TeleportTab = CreateTab("Teleport",4)
Tabs.Info.Visible = true

----------------------------------------------------
-- FARM TAB
----------------------------------------------------
local AutoFarm = false
local FarmConn
local ClickConn
local lastClick = 0

local CLICK_INTERVAL = 0.035
local EXCLAIM_GRACE_TIME = 1.8
local lastExclaimSeen = 0

local AutoFarmBtn = Instance.new("TextButton", FarmTab)
AutoFarmBtn.Size = UDim2.new(0,220,0,42)
AutoFarmBtn.Position = UDim2.new(0,20,0,20)
AutoFarmBtn.Text = "Auto Farm Legit : OFF"
AutoFarmBtn.Font = Enum.Font.Gotham
AutoFarmBtn.TextSize = 14
AutoFarmBtn.TextColor3 = Color3.new(1,1,1)
AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
Instance.new("UICorner", AutoFarmBtn)

----------------------------------------------------
-- SLIDER
----------------------------------------------------
local SliderBG = Instance.new("Frame", FarmTab)
SliderBG.Size = UDim2.new(0,220,0,8)
SliderBG.Position = UDim2.new(0,20,0,80)
SliderBG.BackgroundColor3 = Color3.fromRGB(60,60,60)
Instance.new("UICorner", SliderBG)

local SliderFill = Instance.new("Frame", SliderBG)
SliderFill.Size = UDim2.new(0.5,0,1,0)
SliderFill.BackgroundColor3 = Color3.fromRGB(0,200,180)
Instance.new("UICorner", SliderFill)

local SliderKnob = Instance.new("Frame", SliderBG)
SliderKnob.Size = UDim2.new(0,14,0,14)
SliderKnob.Position = UDim2.new(0.5,-7,0.5,-7)
SliderKnob.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", SliderKnob)

local SpeedLabel = Instance.new("TextLabel", FarmTab)
SpeedLabel.Position = UDim2.new(0,20,0,96)
SpeedLabel.Size = UDim2.new(0,220,0,20)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Click Speed : Medium"
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 13
SpeedLabel.TextColor3 = Color3.new(1,1,1)

local function setSlider(x)
    local rel = math.clamp((x - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X, 0, 1)
    SliderFill.Size = UDim2.new(rel,0,1,0)
    SliderKnob.Position = UDim2.new(rel,-7,0.5,-7)
    CLICK_INTERVAL = 0.11 - (rel * 0.05)

    if rel < 0.26 then
        SpeedLabel.Text = "Click Speed : Slow"
    elseif rel < 0.63 then
        SpeedLabel.Text = "Click Speed : Medium"
    else
        SpeedLabel.Text = "Click Speed : Fast"
    end
end

SliderBG.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        setSlider(i.Position.X)
    end
end)

SliderKnob.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        local move
        move = UserInputService.InputChanged:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseMovement then
                setSlider(inp.Position.X)
            end
        end)
        UserInputService.InputEnded:Once(function()
            if move then move:Disconnect() end
        end)
    end
end)

----------------------------------------------------
-- EXCLAIM DETECTION
----------------------------------------------------
local function isExclaim()
    for _,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BillboardGui")
           and v.Name == "Exclaim"
           and (v.Enabled or v.Adornee) then
            lastExclaimSeen = tick()
            return true
        end
    end
    return false
end

----------------------------------------------------
-- AUTO CLICK (ANTI FREEZE)
----------------------------------------------------
local clickBurst = 0
local lastPause = 0

local function startClick()
    if ClickConn then return end
    clickBurst = 0
    lastPause = tick()
    lastClick = 0

    ClickConn = RunService.Heartbeat:Connect(function()
        local now = tick()

        if clickBurst >= 6 then
            if now - lastPause < 0.07 then return end
            clickBurst = 0
            lastPause = now
        end

        if now - lastClick >= CLICK_INTERVAL then
            lastClick = now
            clickBurst += 1
            VirtualInputManager:SendMouseButtonEvent(0.5,0.5,0,true,game,0)
            VirtualInputManager:SendMouseButtonEvent(0.5,0.5,0,false,game,0)
        end
    end)
end

local function stopClick()
    if ClickConn then
        ClickConn:Disconnect()
        ClickConn = nil
    end
    lastClick = 0
    clickBurst = 0
end

----------------------------------------------------
-- AUTO FARM TOGGLE
----------------------------------------------------
AutoFarmBtn.MouseButton1Click:Connect(function()
    AutoFarm = not AutoFarm
    AutoFarmBtn.Text = "Auto Farm Legit : "..(AutoFarm and "ON" or "OFF")

    if AutoFarm then
        AutoEquipRod.Start()
        AutoFishGame.Start()
        NoAnim.Start()

        FarmConn = RunService.Heartbeat:Connect(function()
            if isExclaim() then
                startClick()
            else
                if ClickConn and (tick() - lastExclaimSeen) > EXCLAIM_GRACE_TIME then
                    stopClick()
                end
            end
        end)
    else
        if FarmConn then
            FarmConn:Disconnect()
            FarmConn = nil
        end
        stopClick()
        AutoEquipRod.Stop()
        AutoFishGame.Stop()
        NoAnim.Stop()
    end
end)

----------------------------------------------------
-- MINIMIZE / CLOSE
----------------------------------------------------
local Mini
MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false

    Mini = Instance.new("Frame", Gui)
    Mini.Size = UDim2.new(0,60,0,60)
    Mini.Position = Main.Position
    Mini.BackgroundColor3 = Color3.fromRGB(18,18,18)
    Mini.BackgroundTransparency = 0.15
    Mini.Active = true
    Mini.Draggable = true
    Instance.new("UICorner", Mini)

    local I = Instance.new("ImageButton", Mini)
    I.Size = UDim2.new(0,40,0,40)
    I.Position = UDim2.new(0.5,-20,0.5,-20)
    I.Image = "rbxassetid://100446592606293"
    I.BackgroundTransparency = 1

    I.MouseButton1Click:Connect(function()
        Mini:Destroy()
        Main.Visible = true
    end)
end)

CloseBtn.MouseButton1Click:Connect(function()
    if FarmConn then FarmConn:Disconnect() end
    stopClick()
    AutoEquipRod.Stop()
    AutoFishGame.Stop()
    NoAnim.Stop()
    Gui:Destroy()
end)

----------------------------------------------------
-- ANTI AFK
----------------------------------------------------
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

print("[ASPAN HUB] FULL FINAL FIX LOADED")
