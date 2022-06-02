if not game:IsLoaded() then
    game.Loaded:Wait()
end

_G.Moves = _G.Moves or {"TS Molotov",
    "Wolf Fang Fist",
    "Mach Kick",
    "Flash Skewer",
    "Vital Strike",
    "Meteor Crash",
    "Neo Wolf Fang Fist",
    "GOD Hakai",
    "GOD Wrath",
    "Trash?",
    "Strong Kick",
    "Combo Barrage",
    "Aerial Breaker"
}

local Player = game.Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local RunService = game:GetService("RunService")
local Camera = workspace:WaitForChild("Camera")
local Backpack = Player:WaitForChild("Backpack")
local ServerTraits = nil
while not ServerTraits do task.wait()
    pcall(function()
        ServerTraits = Player.Backpack.ServerTraits
    end)
end

coroutine.wrap(function()
    local TimerLabel = Player:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("FullSize"):WaitForChild("Timer")
    if not (TimerLabel.Text == "") then
        local TrueLabel = Char:WaitForChild("True", 5)
        if TrueLabel then
            TrueLabel:Destroy()
        end
    end
end)()

workspace:FindFirstChildOfClass('Terrain').WaterWaveSize = 0
workspace:FindFirstChildOfClass('Terrain').WaterWaveSpeed = 0
workspace:FindFirstChildOfClass('Terrain').WaterReflectance = 0
workspace:FindFirstChildOfClass('Terrain').WaterTransparency = 0
game:GetService("Lighting").GlobalShadows = false
game:GetService("Lighting").FogEnd = 9e9
settings().Rendering.QualityLevel = 1
for i,v in pairs(game:GetDescendants()) do
    if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
    elseif v:IsA("Decal") then
        v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
        v.BlastPressure = 1
        v.BlastRadius = 1
    end
end
for i,v in pairs(game:GetService("Lighting"):GetDescendants()) do
    if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
        v.Enabled = false
    end
end
workspace.DescendantAdded:Connect(function(child)
    coroutine.wrap(function()
        if child:IsA('ForceField') then
            game:GetService('RunService').Heartbeat:Wait()
            child:Destroy()
        elseif child:IsA('Sparkles') then
            game:GetService('RunService').Heartbeat:Wait()
            child:Destroy()
        elseif child:IsA('Smoke') or child:IsA('Fire') then
            game:GetService('RunService').Heartbeat:Wait()
            child:Destroy()
        end
    end)()
end)

local WeAreInHTC = (game.PlaceId == 882375367)
local MainWorldId = 882375367
local function BackToMainWorld()
    game:GetService("TeleportService"):Teleport(MainWorldId)
end
if not (game.PlaceId == MainWorldId) and not WeAreInHTC then
    BackToMainWorld()
end
game:GetService("CoreGui").DescendantAdded:Connect(function(descendant)
    if descendant.Name == "ErrorTitle" then
        BackToMainWorld()
    end
end)

local Hrp = Char:WaitForChild("HumanoidRootPart")
local Hum = Char:WaitForChild("Humanoid")

if not WeAreInHTC then --MainWorld Setup
    BackToMainWorld()
    return
end

local Goku = workspace:WaitForChild("Live"):GetChildren()[1] or workspace.Live.ChildAdded:Wait()
local GokuHrp = Goku:WaitForChild("HumanoidRootPart")
for i, v in pairs(Goku:GetDescendants()) do
    if v:IsA("BasePart") and not v.Anchored then
        v.Anchored = true
    end
end

workspace.ChildAdded:Connect(function(child)
    if child.Name == "ExplosiveWave" then
        game:GetService("RunService").Stepped:Wait()
        child:Destroy()
    end
end)

local Slows = {
    "KnockBacked",
    "creator",
    "Action",
    "Slow",
    "NotHardBack",
    "Using",
    "Attacking",
    "Hyper",
    "heavy",
    "BodyVelocity",
    "hyper",
    "Throw",
    "Flip",
    "RightGrip"
}
Char.DescendantAdded:Connect(function(child)
    if table.find(Slows, child.Name) then
        game:GetService("RunService").Stepped:Wait()
        child:Destroy()
    end
end)

local EnoughKi = true
local KiValue = Char:WaitForChild("Ki")
KiValue.Changed:Connect(function(property)
    if property < 40 then
        EnoughKi = false
    else
        EnoughKi = true
    end
end)

Hum:ChangeState(Enum.HumanoidStateType.StrafingNoPhysics) -- Might as well ¯\_(ツ)_/¯

RunService.Heartbeat:Connect(function()
    local GokuPosition = GokuHrp.CFrame.Position
    Hrp.CFrame = CFrame.new(GokuPosition + Vector3.new(2, 0, 0), GokuPosition)
    Camera.CameraType = Enum.CameraType.Scriptable
    Camera.CFrame = CFrame.new(Hrp.Position + Vector3.new(0, 10, 0) - Hrp.CFrame.LookVector * 10, GokuPosition)
end)

local ThrowMove = Backpack:FindFirstChild("Dragon Throw") or Backpack:FindFirstChild("Dragon Crush") or Backpack:WaitForChild("Dragon Throw", 5) or Backpack:WaitForChild("Dragon Crush")

while not Goku:FindFirstChild("MoveStart") do
    ThrowMove.Parent = Char
    local Flip = ThrowMove:FindFirstChild("Flip", true)
    if Flip then
        Flip:Destroy()
    end
    wait()
    ThrowMove:Activate()
    task.wait()
    ThrowMove.Parent = Backpack
end

local HUD = Player:WaitForChild("PlayerGui"):WaitForChild("HUD")
local Senzu = HUD:WaitForChild("Bottom"):WaitForChild("Senzu")
if (Senzu.Image == "rbxassetid://1228105406") or Senzu.Image == ("rbxassetid://1228105947") then
    local SenzuEvent = ServerTraits:WaitForChild("EatSenzu")
    SenzuEvent:FireServer(true)
    Hrp.ChildRemoved:Connect(function(child)
        if child.Name == "Inf" then
            SenzuEvent:FireServer(true)
            local a = Hrp:WaitForChild("Inf", 2)
            if a then
                return
            end
            SenzuEvent:FireServer(true)
        end
    end)
end

local LevelsToRejoin = {101, 181, 251, 321}
local LevelLabel = HUD:WaitForChild("Bottom"):WaitForChild("Stats"):WaitForChild("LVL"):WaitForChild("Val")
LevelLabel:GetPropertyChangedSignal("Text"):Connect(function()
    if table.find(LevelsToRejoin, tonumber(LevelLabel.Text)) then
        BackToMainWorld()
    end
end)

local InputEvent = ServerTraits:WaitForChild("Input")
while true do --Needs to be a loop because of the wait <3
    if EnoughKi then
        for i, Move in pairs(Backpack:GetChildren()) do
            if table.find(_G.Moves, Move.Name) then
                Move.Parent = Char
                Move:Activate()
                task.wait()
                Move.Parent = Backpack
            end
        end
    else
        InputEvent:FireServer({"m2"}, CFrame.new(), nil, false)
        task.wait()
    end
end