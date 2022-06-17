if not game:IsLoaded() then
    game.Loaded:Wait()
end

_G.AutoFarm = not _G.AutoFarm

local Player = game.Players.LocalPlayer
local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/Notification%20Library%20Optimization.lua"))()

local function RemoteAttack(Number, AttackPosition)
    local ClassLabel = Player:WaitForChild("Stats"):WaitForChild("Class")
    if ClassLabel.Value == "Angel" then
        ClassLabel.Value = "Puri Puri"
    end
    local ClassString = string.gsub(ClassLabel.Value, " ", "")
    local AttackArg = ClassString.."Attack"..tostring(Number)
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(AttackArg, AttackPosition)
end

local function KillNpc(Npc)
    local EHum = Npc:WaitForChild("Humanoid")
    local EHrp = Npc:WaitForChild("HumanoidRootPart")
    while _G.AutoFarm do task.wait()
        local Char = Player.Character or Player.CharacterAdded:Wait()
        local Hrp = Char:WaitForChild("HumanoidRootPart")
        if EHum.Health == 0 then
            break
        end
        Hrp.CFrame = CFrame.new(EHrp.Position - EHrp.CFrame.LookVector * 3, EHrp.Position)
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Punch", "Right")
        for Number=1, 5 do
            RemoteAttack(Number, EHrp.Position)
        end
    end
end

local QuestModule = require(game:GetService("ReplicatedStorage").Modules.Quests)
local function TakeQuest(QuestNpcName)
    for i, v in pairs(QuestModule) do
        if v.Target == QuestNpcName then
            for _, Folder in pairs(Player:GetChildren()) do
                if Folder:IsA("Folder") and (Folder.Name == "Quest") then
                    Folder:Destroy()
                end
            end
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer("GetQuest", i)
            Player:WaitForChild("Quest")
            break
        end
    end
end

--NotificationLibrary.CustomNotification("Brought to you by CrabGuy", "Thanks for using the script <3\nDiscord Server Invite: https://discord.gg/5NYqSVwH9Q", 9e9)

if Player.Character:FindFirstChild("Form") and (Player.Character.Form.Value == "") then
    RemoteAttack(6)
end
Player.CharacterAdded:Connect(function()
    task.wait(2)
    RemoteAttack(6)
end)

local SpawnFolder = workspace:WaitForChild("Spawns")
local function UpdateTable()
    local NewTable = {}
    for i, v in pairs(QuestModule) do
        if v.Amount == 1 then
            local Npc = SpawnFolder:WaitForChild(v.Target):FindFirstChild(v.Target)
            if Npc then
                table.insert(NewTable,{
                    Name = v.Target,
                    RequiredStrength = Npc:WaitForChild("Humanoid").MaxHealth * 3/20
                })
            else
                table.insert(NewTable,{
                    Name = v.Target,
                    RequiredStrength = nil
                })
            end
        end
    end
    table.sort(NewTable, function(a, b)
        if not (a.RequiredStrength and b.RequiredStrength) then
            return false
        end
        if a.RequiredStrength > b.RequiredStrength then
            return true
        end
    end)
    for i, v in pairs(NewTable) do
        if not v.RequiredStrength then
            print("Missing "..v.Name)
        end
    end
    return NewTable
end
UpdateTable()

local StrengthLabel = Player:WaitForChild("Stats"):WaitForChild("Strength")

while _G.AutoFarm do task.wait()
    local Loops = 0
    local NpcToFarm = {}
    local EnemyTable = UpdateTable()
    for i, v in ipairs(EnemyTable) do
        print(v.Name, v.RequiredStrength and (StrengthLabel.Value > v.RequiredStrength))
        if v.RequiredStrength and (StrengthLabel.Value > v.RequiredStrength) then
            print(v.Name, v.RequiredStrength, StrengthLabel.Value)
            table.insert(NpcToFarm, v.Name)
            Loops = Loops + 1
            if Loops == 3 then
                break
            end
        end
    end
    if Loops < 3 then
        for i=0, 2 do
            table.insert(NpcToFarm, EnemyTable[#EnemyTable - i].Name)
        end
    end
    --table.foreach(NpcToFarm, print)
    SpawnFolder.DescendantAdded:Wait()
end