local DefaultSettings = {
    DungeonName = "Desert Temple",
    Difficulty = "Easy",
    Hardcore = true,
    AutoExecuteTheScript = true, --Synapse X only
}


if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Player = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")

local OwnScriptUrl = "https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/DungeonQuest.lua"
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
if not (game.PlaceId == 2606294912) then
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
end

if (game.PlaceId == 2606294912) then
    if not Player.Character then
        Player.CharacterAdded:Wait()
    end
    local function FindEnemy()
        while true do task.wait()
            for i, v in pairs(game:GetService("Workspace").dungeon:GetChildren()) do
                local EnemyFolder = v:FindFirstChildWhichIsA("Folder")
                if EnemyFolder then
                    local Enemy = EnemyFolder:FindFirstChildWhichIsA("Model")
                    if Enemy then
                        return Enemy
                    end
                end
            end
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

    while true do task.wait()
        local Enemy = FindEnemy()
        local EHrp = Enemy:FindFirstChild("HumanoidRootPart")
        local EHum = Enemy:FindFirstChild("Humanoid")
        local Hrp = Player.Character:FindFirstChild("HumanoidRootPart")
        if Hrp and EHum and EHrp then
            Hrp.CFrame = CFrame.new((EHrp.CFrame.Position - (EHrp.CFrame.LookVector*2)), EHrp.CFrame.Position)
            Pugno()
        end
    end
end