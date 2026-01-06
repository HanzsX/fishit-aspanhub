--==================================================
-- ASPAN HUB | FISH IT
-- Script Owner : Aspan
-- FINAL FULL STABLE VERSION
--==================================================

pcall(function()
    game.CoreGui.AspanHub:Destroy()
end)

--================ SERVICES =================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

--==================================================
-- NO FISHING ANIMATION (ROBUST & WORKING)
--==================================================

local NoFishingAnimation = {
    Enabled = false,
    Connection = nil,
    SavedPose = {}
}

local function getHumanoid()
    local char = LocalPlayer.Character
    if not char then return end
    return char:FindFirstChildOfClass("Humanoid")
end

local function stopAllAnimations()
    local hum = getHumanoid()
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then return end
    for _,track in ipairs(animator:GetPlayingAnimationTracks()) do
        track:Stop(0)
    end
end

local function capturePose()
    NoFishingAnimation.SavedPose = {}
    local char = LocalPlayer.Character
    if not char then return false end
    for _,m in ipairs(char:GetDescendants()) do
        if m:IsA("Motor6D") then
            NoFishingAnimation.SavedPose[m] = {
                C0 = m.C0,
                C1 = m.C1
            }
        end
    end
    return next(NoFishingAnimation.SavedPose) ~= nil
end

local function freezePose()
    if NoFishingAnimation.Connection then return end
    NoFishingAnimation.Connection = RunService.RenderStepped:Connect(function()
        if not NoFishingAnimation.Enabled then return end
        stopAllAnimations()
        for motor,data in pairs(NoFishingAnimation.SavedPose) do
            if motor and motor.Parent then
                motor.C0 = data.C0
                motor.C1 = data.C1
            end
        end
    end)
end

function NoFishingAnimation.StartAfterFishing()
    if NoFishingAnimation.Enabled then return end
    task.spawn(function()
        local start = tick()
        while tick() - start < 3 do
            local hum = getHumanoid()
            if hum then
                local animator = hum:FindFirstChildOfClass("Animator")
                if animator and #animator:GetPlayingAnimationTracks() > 0 then
                    break
                end
            end
            task.wait(0.1)
        end
        stopAllAnimations()
        if capturePose() then
            NoFishingAnimation.Enabled = true
            freezePose()
        end
    end)
end

function NoFishingAnimation.Stop()
    NoFishingAnimation.Enabled = false
    if NoFishingAnimation.Connection then
        NoFishingAnimation.Connection:Disconnect()
        NoFishingAnimation.Connection = nil
    end
    NoFishingAnimation.SavedPose = {}
end

LocalPlayer.CharacterAdded:Connect(function()
    NoFishingAnimation.Stop()
end)

--================ GUI =================
local Gui = Instance.new("ScreenGui")
Gui.Name = "AspanHub"
Gui.Parent = game.CoreGui

--================ MAIN =================
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0,520,0,320)
Main.Position = UDim2.new(0.5,-260,0.5,-160)
Main.BackgroundColor3 = Color3.fromRGB(18,18,18)
Main.BackgroundTransparency = 0.15
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)

--================ HEADER =================
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1,0,0,42)
Header.BackgroundTransparency = 1

local Logo = Instance.new("ImageLabel", Header)
Logo.Size = UDim2.new(0,28,0,28)
Logo.Position = UDim2.new(0,10,0.5,-14)
Logo.Image = "rbxassetid://100446592606293"
Logo.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Text = "Aspan Hub | Fish It"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0,46,0,0)
Title.Size = UDim2.new(1,-140,1,0)
Title.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton", Header)
MinBtn.Text = "-"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 22
MinBtn.TextColor3 = Color3.fromRGB(200,200,200)
MinBtn.Size = UDim2.new(0,40,1,0)
MinBtn.Position = UDim2.new(1,-80,0,0)
MinBtn.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.TextColor3 = Color3.fromRGB(255,90,90)
CloseBtn.Size = UDim2.new(0,40,1,0)
CloseBtn.Position = UDim2.new(1,-40,0,0)
CloseBtn.BackgroundTransparency = 1

--================ BODY =================
local Body = Instance.new("Frame", Main)
Body.Position = UDim2.new(0,0,0,42)
Body.Size = UDim2.new(1,0,1,-42)
Body.BackgroundTransparency = 1

--================ SIDEBAR =================
local Sidebar = Instance.new("Frame", Body)
Sidebar.Size = UDim2.new(0,120,1,0)
Sidebar.BackgroundColor3 = Color3.fromRGB(25,25,25)
Sidebar.BackgroundTransparency = 0.1
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0,10)

local Content = Instance.new("Frame", Body)
Content.Position = UDim2.new(0,130,0,0)
Content.Size = UDim2.new(1,-140,1,0)
Content.BackgroundTransparency = 1

--================ TAB SYSTEM =================
local Tabs = {}
local function CreateTab(name, order)
    local Button = Instance.new("TextButton", Sidebar)
    Button.Size = UDim2.new(1,-10,0,36)
    Button.Position = UDim2.new(0,5,0,10+(order-1)*42)
    Button.Text = name
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 13
    Button.TextColor3 = Color3.new(1,1,1)
    Button.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0,8)

    local Frame = Instance.new("Frame", Content)
    Frame.Size = UDim2.new(1,0,1,0)
    Frame.Visible = false
    Frame.BackgroundTransparency = 1

    Button.MouseButton1Click:Connect(function()
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

--================ FARM TAB =================
local AutoFarmBtn = Instance.new("TextButton", FarmTab)
AutoFarmBtn.Size = UDim2.new(0,220,0,42)
AutoFarmBtn.Position = UDim2.new(0,20,0,20)
AutoFarmBtn.Text = "Auto Farm Legit : OFF"
AutoFarmBtn.Font = Enum.Font.Gotham
AutoFarmBtn.TextSize = 14
AutoFarmBtn.TextColor3 = Color3.new(1,1,1)
AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
Instance.new("UICorner", AutoFarmBtn).CornerRadius = UDim.new(0,8)

--==================================================
-- AUTO FARM LEGIT (STABLE + BIG FISH)
--==================================================

local AutoFarm = false
local FarmConn, ClickConn
local lastCast = 0
local exclaimStart, lastExclaim = 0, 0

local CAST_DELAY = 2.1
local CLICK_MIN = 1.2
local CLICK_MAX = 2.2
local CLICK_MULTIPLIER = 2.8

local RF_UpdateAutoFishingState = ReplicatedStorage:FindFirstChild("RF_UpdateAutoFishingState", true)
local RF_CancelFishingInputs   = ReplicatedStorage:FindFirstChild("RF_CancelFishingInputs", true)

local function safeFire(fn) pcall(fn) end

local function IsExclaimActive()
    for _,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BillboardGui") and v.Name == "Exclaim" then
            if v.Enabled or v.Adornee then return true end
        end
    end
    return false
end

local function FishCaught()
    for _,v in ipairs(workspace:GetChildren()) do
        if v:IsA("Model") then
            local n=v.Name:lower()
            if n:find("fish") or n:find("shell") then return true end
        end
    end
    return false
end

local function StartAutoClick()
    if ClickConn then return end
    ClickConn = RunService.RenderStepped:Connect(function()
        VirtualInputManager:SendMouseButtonEvent(0.5,0.5,0,true,game,0)
        VirtualInputManager:SendMouseButtonEvent(0.5,0.5,0,false,game,0)
    end)
end

local function StopAutoClick()
    if ClickConn then ClickConn:Disconnect() ClickConn=nil end
end

local function AutoCast()
    VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,0)
    task.wait(0.25)
    VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,0)
end

AutoFarmBtn.MouseButton1Click:Connect(function()
    AutoFarm = not AutoFarm
    AutoFarmBtn.Text = "Auto Farm Legit : "..(AutoFarm and "ON" or "OFF")

    if AutoFarm then
        NoFishingAnimation.StartAfterFishing()

        FarmConn = RunService.Heartbeat:Connect(function()
            if RF_UpdateAutoFishingState then
                safeFire(function()
                    RF_UpdateAutoFishingState:InvokeServer(true)
                end)
            end

            if RF_CancelFishingInputs then
                safeFire(function()
                    RF_CancelFishingInputs:InvokeServer()
                end)
            end

            if tick() - lastCast > CAST_DELAY then
                AutoCast()
                lastCast = tick()
            end

            if IsExclaimActive() then
                if exclaimStart == 0 then exclaimStart = tick() end
                lastExclaim = tick()
                StartAutoClick()
            end

            if ClickConn then
                local dur = math.clamp(
                    (lastExclaim - exclaimStart) * CLICK_MULTIPLIER,
                    CLICK_MIN,
                    CLICK_MAX
                )
                if tick() - lastExclaim > dur then
                    StopAutoClick()
                    exclaimStart = 0
                end
            end

            if FishCaught() then
                StopAutoClick()
                exclaimStart = 0
            end
        end)
    else
        if FarmConn then FarmConn:Disconnect() FarmConn=nil end
        StopAutoClick()
        NoFishingAnimation.Stop()
        exclaimStart = 0
    end
end)

--================ MINIMIZE =================
local MiniFrame
MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    MiniFrame = Instance.new("Frame", Gui)
    MiniFrame.Size = UDim2.new(0,60,0,60)
    MiniFrame.Position = Main.Position
    MiniFrame.BackgroundColor3 = Color3.fromRGB(18,18,18)
    MiniFrame.BackgroundTransparency = 0.15
    MiniFrame.Active = true
    MiniFrame.Draggable = true
    Instance.new("UICorner", MiniFrame).CornerRadius = UDim.new(0,12)

    local MiniLogo = Instance.new("ImageButton", MiniFrame)
    MiniLogo.Size = UDim2.new(0,40,0,40)
    MiniLogo.Position = UDim2.new(0.5,-20,0.5,-20)
    MiniLogo.Image = "rbxassetid://100446592606293"
    MiniLogo.BackgroundTransparency = 1

    MiniLogo.MouseButton1Click:Connect(function()
        MiniFrame:Destroy()
        Main.Visible = true
    end)
end)

--================ CLOSE =================
CloseBtn.MouseButton1Click:Connect(function()
    if FarmConn then FarmConn:Disconnect() end
    NoFishingAnimation.Stop()
    Gui:Destroy()
end)

--================ ANTI AFK =================
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

print("[ASPAN HUB] FINAL SCRIPT LOADED SUCCESSFULLY")
