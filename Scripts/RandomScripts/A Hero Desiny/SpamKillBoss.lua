if not game:IsLoaded() then
    game.Loaded:Wait()
end

local NpcName = "Auroris"

local Player = game.Players.LocalPlayer
local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/Notification%20Library%20Optimization.lua"))()

if syn then
    syn.queue_on_teleport(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Scripts/RandomScripts/A%20Hero%20Desiny/SpamKillBoss.lua"))
end

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

local function ServerHop()
    while true do
        local x = {}
        for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
            if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
                x[#x + 1] = v.id
            end
        end
        if #x > 0 then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
            return
        else
            NotificationLibrary.CustomNotification("Error", "Couldn't find any server to join")
        end
        task.wait(1)
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

NotificationLibrary.CustomNotification("Brought to you by CrabGuy", "Thanks for using the script <3\nDiscord Server Invite: https://discord.gg/5NYqSVwH9Q", 9e9)

local SpawnPart = workspace:WaitForChild("Spawns"):WaitForChild(NpcName, 5)
if not SpawnPart then
    NotificationLibrary.CustomNotification("Enemy not found", "Incorrect NpcName probably", 9e9)
    return
end
local Npc = SpawnPart:WaitForChild(NpcName, 10)
if not Npc then
    ServerHop()
    return
end
TakeQuest(NpcName)
KillNpc(Npc)
ServerHop()