if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Player = game.Players.LocalPlayer
local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/Notification%20Library%20Optimization.lua"))()

local function RemoteAttack(Number, AttackPosition)
    if Player.Stats.Class.Value == "Angel" then
        Player.Stats.Class.Value = "Puri Puri"
    end
    if Player.Stats.Class.Value == "Toxin" then
        Player.Stats.Class.Value = "Broly"
    end
    local ClassString = string.gsub(Player.Stats.Class.Value, " ", "")
    local AttackArg = ClassString.."Attack"..tostring(Number)
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(AttackArg, AttackPosition)
end

if Player.Character:FindFirstChild("Form") and (Player.Character.Form.Value == "") then
    RemoteAttack(6)
end

Player.CharacterAdded:Connect(function()
    task.wait(2)
    RemoteAttack(6)
end)

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

local function KillNpc(Npc)
    TakeQuest(Npc.Name)
    local EHum = Npc:WaitForChild("Humanoid")
    local EHrp = Npc:WaitForChild("HumanoidRootPart")
    while true do task.wait()
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

NotificationLibrary.CustomNotification("Brought to you by CrabGuy", "Thanks for using the script <3\nDiscord Server Invite: https://discord.gg/5NYqSVwH9Q", 20)

local BossTable = {}
for i, v in pairs(QuestModule) do
    if v.Amount == 1 then
        table.insert(BossTable, v.Target)
    end
end

for i, v in pairs(BossTable) do
    local Npc = game:GetService("Workspace").Spawns:WaitForChild(v):WaitForChild(v)
    KillNpc(Npc)
end