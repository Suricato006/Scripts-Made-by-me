_G.BrolySettings = {
    Moves = {
    "Deadly Dance",
    "Blaster Meteor",
    "God Slicer",
    "Anger Rush",
    "Meteor Crash",
    "TS Molotov",
    "Flash Skewer",
    "Vital Strike",
    "Demon Flash",
    "Wolf Fang Fist",
    "Neo Wolf Fang Fist",
    "Power Impact",
    "Combo Barrage",
    "Sweep Kick",
    "Strong Kick",
    },
    FreezeExp = true, --Self explanatory
    ChargeTime = 3.9, -- Time to charge before going in form (for androids its automatic)
    World = "Earth" -- Either "Queue" or "Earth"
}

if not game:IsLoaded() then
    game.Loaded:Wait()
end
local RunService = game:GetService("RunService")
local Player = game.Players.LocalPlayer
local Backpack = Player:WaitForChild("Backpack")

if _G.BrolySettings.FreezeExp then
    local TimerLabel = Player.PlayerGui:WaitForChild("HUD"):WaitForChild("FullSize"):WaitForChild("Timer")
    if not (TimerLabel.Text == "") then
        Player.CharacterAdded:Connect(function(Char)
            local TrueValue = Char:WaitForChild("True")
            TrueValue:Destroy()
        end)
    end
end

local WeAreInBroly = (game.PlaceId == 2050207304)
local MainWorldId = 3565304751 --Queue Id
if _G.BrolySettings.World == "Earth" then
    MainWorldId = 536102540 --Earth Id
end
local function BackToMainWorld()
    game:GetService("TeleportService"):Teleport(MainWorldId)
end
if not (game.PlaceId == MainWorldId) and not WeAreInBroly then
    BackToMainWorld()
end

local Char = Player.Character or Player.CharacterAdded:Wait()
local Hrp = Char:WaitForChild("HumanoidRootPart")

if not WeAreInBroly then --MainWorld Setup
    local PowerOutput = Char:WaitForChild("PowerOutput")
    PowerOutput:Destroy()
    local TeleportPad = workspace:WaitForChild("BrolyTeleport")
    local GoalCFrame = TeleportPad:GetModelCFrame() * CFrame.new(0, -3, 0)
    RunService.Heartbeat:Connect(function(deltaTime)
        Hrp.CFrame = GoalCFrame
    end)
    return
end

local Broly = workspace:WaitForChild("Live"):WaitForChild("Broly BR")
local BrolyHrp = Broly:WaitForChild("HumanoidRootPart")
local BrolyHum = Broly:WaitForChild("Humanoid")
for i, v in pairs(Broly:GetDescendants()) do
    if v:IsA("BasePart") and not v.Anchored then
        v.Anchored = true
    end
end

workspace.ChildAdded:Connect(function(child)
    if child.Name == "ExplosiveWave" then
        child:Destroy()
    end
end)

RunService.Heartbeat:Connect(function()
    local BrolyPosition = BrolyHrp.CFrame.Position
    Hrp.CFrame = CFrame.new(BrolyPosition + Vector3.new(3, 0, 0), BrolyPosition)
end)

local Slows = {"Action", "Attacking", "Using", "hyper", "Hyper", "heavy", "KiBlasted", "Tele", "tele", "Killed", "Slow", "Blocked", "MoveStart", "NotHardBack"}
Char.ChildAdded:Connect(function(child)
    if table.find(Slows, child.Name) then
        child:Destroy()
    end
end)


local ThrowMove = Backpack:FindFirstChild("Dragon Throw") or Backpack:FindFirstChild("Dragon Throw") or Backpack:WaitForChild("Dragon Throw", 5) or Backpack:WaitForChild("Dragon Crush")
while not Broly:FindFirstChild("MoveStart") do task.wait()
    ThrowMove.Parent = Player.Character
    local Flip = ThrowMove:FindFirstChild("Flip", true)
    if Flip then
        Flip:Destroy()
    end
    ThrowMove:Activate()
    wait()
    ThrowMove.Parent = Backpack
end

while true do
    for i, Move in pairs(Backpack:GetChildren()) do
        if table.find(_G.BrolySettings.Moves, Move.Name) then
            Move.Parent = Player.Character
            Move:Activate()
            wait()
            Move.Parent = Backpack
        end
        task.wait()
    end
end