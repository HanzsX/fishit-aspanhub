--=====================================================
-- ASPAN-HUB XENO SAFE VERSION (ZINDEX FIX)
--=====================================================

--// SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

--=====================================================
-- STATE (COLOKKAN LOGIC KAMU)
--=====================================================
local Mode = { Legit = false, Blatant = false }
local Hub = { Enabled = false }
local AutoFishingInGame = false

--=====================================================
-- THEME SYSTEM (XENO SAFE)
--=====================================================
local Themes = {
    Green = {
        Accent = Color3.fromRGB(0,200,160),
        ToggleOn = Color3.fromRGB(0,200,160),
        ToggleOff = Color3.fromRGB(120,80,80),
        Title = Color3.fromRGB(0,230,200)
    },
    Red = {
        Accent = Color3.fromRGB(220,70,70),
        ToggleOn = Color3.fromRGB(220,70,70),
        ToggleOff = Color3.fromRGB(90,90,90),
        Title = Color3.fromRGB(255,90,90)
    },
    Purple = {
        Accent = Color3.fromRGB(170,90,255),
        ToggleOn = Color3.fromRGB(170,90,255),
        ToggleOff = Color3.fromRGB(90,90,120),
        Title = Color3.fromRGB(200,150,255)
    }
}

local CurrentTheme = Themes.Green
local ThemedObjects = {}

local function ApplyTheme()
    for obj,fn in pairs(ThemedObjects) do
        if obj and obj.Parent then
            TweenService:Create(obj, TweenInfo.new(0.25), fn(CurrentTheme)):Play()
        end
    end
end

--=====================================================
-- GUI ROOT
--=====================================================
local gui = Instance.new("ScreenGui")
gui.Name = "ASPAN_HUB_XENO"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(620,380)
main.Position = UDim2.fromScale(0.5,0.5)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(17,18,22)
main.BorderSizePixel = 0
main.
