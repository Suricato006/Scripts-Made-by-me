local DefaultSettings = {
    DungeonName = "King's Castle",
    Difficulty = "Insane",
    Hardcore = false,
    AutoExecuteTheScript = true, --Synapse X only
}


if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Player = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")

local OwnScriptUrl = ""
if syn and not (OwnScriptUrl == "") then
    local FileName = "Dungeon.CRAB"
    if isfile(FileName) then
        _G.DungeonSettings = _G.DungeonSettings or HttpService:JSONDecode(readfile(FileName))
    end
    local ToEncode = _G.DungeonSettings or DefaultSettings
    writefile(FileName, HttpService:JSONEncode(ToEncode))
    if ToEncode == DefaultSettings then
        _G.DungeonSettings = DefaultSettings
    end
    if _G.DungeonSettings.AutoExecuteTheScript then
        Player.OnTeleport:Connect(function(State)
            if State == Enum.TeleportState.Started then
                syn.queue_on_teleport(game:HttpGet(OwnScriptUrl))
            end
        end)
    end
end

_G.DungeonSettings = _G.DungeonSettings or DefaultSettings

if (game.PlaceId == 2414851778) then
    local args = {
        [2] = true
    }
    game:GetService("ReplicatedStorage").remotes.loadPlayerCharacter:FireServer(unpack(args))
    if not Player.Character then
        Player.CharacterAdded:Wait()
    end
    game:GetService("ReplicatedStorage").remotes.createLobby:InvokeServer(_G.DungeonSettings.DungeonName, _G.DungeonSettings.Difficulty, 1, _G.DungeonSettings.Hardcore, false, false)
    task.wait(0.5)
    game:GetService("ReplicatedStorage").remotes.startDungeon:FireServer()
    return
end

if not Player.Character then
    Player.CharacterAdded:Wait()
end
local function FindEnemy()
    while true do
        local ClosestNpc = nil
        local Distance = 9e9
        if Player.Character then
            local Hrp = Player.Character:WaitForChild("HumanoidRootPart")
            for i, v in pairs(game:GetService("Workspace").dungeon:GetDescendants()) do
                if v:IsA("Humanoid") then
                    local Enemy = v.Parent
                    local EHrp = Enemy:WaitForChild("HumanoidRootPart", 2)
                    if EHrp then
                        local NewDistance = (Enemy.PrimaryPart.Position - Hrp.Position).Magnitude
                        if NewDistance < Distance then
                            Distance = NewDistance
                            ClosestNpc = Enemy
                        end
                    else
                        warn("No Hrp")
                    end
                end
            end
            if ClosestNpc then
                return ClosestNpc
            end
        end
        task.wait()
    end
end

local function Pugno()
    local WeaponEvent = Player.Character:FindFirstChild("swing", true)
    if WeaponEvent then
        WeaponEvent:FireServer()
    end
    for i, v in pairs(Player.Backpack:GetChildren()) do
        local a = v:FindFirstChildWhichIsA("RemoteEvent", true)
        a:FireServer()
    end
end

game:GetService("ReplicatedStorage").remotes.changeStartValue:FireServer()

--[[ game:GetService("RunService").Stepped:Connect(function()
    for _, child in pairs(Player.Character:GetDescendants()) do
        if child:IsA("BasePart") and child.CanCollide == true then
            child.CanCollide = false
        end
    end
end) ]]

local PathFind = game:GetService("PathfindingService")
_G.Test = not _G.Test
print(_G.Test)
while _G.Test do task.wait()
    if Player.Character then
        local Enemy = FindEnemy()
        local EHrp = Enemy:WaitForChild("HumanoidRootPart")
        EHrp.Transparency = 0
        EHrp.BrickColor = BrickColor.new("Bright red")
        local Hrp = Player.Character:WaitForChild("HumanoidRootPart")
        local Hum = Player.Character:WaitForChild("Humanoid")
        Hum.WalkSpeed = 32

        local Path = PathFind:FindPathAsync(Hrp.Position, EHrp.Position)
        local Array = Path:GetWaypoints()
        warn(Array[1])
        if Array[1] then
            for i, v in pairs(Array) do
                if (Hrp.Position - EHrp.Position).Magnitude < 50 then
                    break
                end
                Hum:MoveTo(v.Position)
                Hum.MoveToFinished:Wait()
            end

            while Enemy.Parent and _G.Test do
                local Hrp1 = Player.Character:FindFirstChild("HumanoidRootPart")
                local Hum1 = Player.Character:FindFirstChild("Humanoid")
                local EHrp1 = Enemy:FindFirstChild("HumanoidRootPart")
                if Hrp1 and Hum1 and EHrp1 then
                    Hrp1.CFrame = CFrame.new(Hrp1.Position, Vector3.new(EHrp1.Position.X, Hrp1.Position.Y, EHrp1.Position.Z))
                    local NpcPosition = EHrp1.Position + (Hrp1.Position - EHrp1.Position).Unit * 10 + Vector3.new(math.random(1, 7), 0, math.random(1, 7))
                    Hum1:MoveTo(NpcPosition)
                    Pugno()
                    Enemy.Humanoid.Health = 0
                end
                task.wait()
            end
        end
    end
end