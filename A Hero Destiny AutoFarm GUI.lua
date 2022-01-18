if not game:IsLoaded() then game.Loaded:Wait() end
loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Functions%20and%20stuff.lua'),true))()
local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local FileName = "CrabHub.JSON"
local function SaveSettings()
    writefile(FileName, game:GetService("HttpService"):JSONEncode(_G.CrabHub))
end

local function LoadSettings()
    if isfile(FileName) then
        _G.CrabHub = game:GetService("HttpService"):JSONDecode(readfile(FileName))
    end
end

_G.CrabHub = {}
LoadSettings()

local CrabHubUI = Material.Load({
	Title = "CrabHub",
	Style = 2,
	SizeX = 690,
	SizeY = 690,
	Theme = "Aqua"
})

local General = CrabHubUI.New({
    Title = "General",
    ImageID = 8496586222
})

if (game.PlaceId == 6461766546) then
    local AHD = CrabHubUI.New({Title = "A Hero Destiny", ImageID = 8496586222})

    local function AutoFarmAHD(bool)
        spawn(function()
            _G.CrabHub.AutoFarmAHD = bool
            SaveSettings()
            local PlayerLevelInstance = Player:WaitForChild("Stats"):WaitForChild("Level")
            while _G.CrabHub.AutoFarmAHD do FastWait()
                for i, v in pairs(game:GetService("Workspace").Spawns:GetChildren()) do
                    if _G.CrabHub.ChosenNpcListAHD[v.Name] then
                        local NpcInstance = v:FindFirstChild(v.Name)
                        if NpcInstance then
                            local QuestNumber = 0
                            local QuestMod = require(game:GetService("ReplicatedStorage").Modules.Quests)
                            for i, v in pairs(QuestMod) do
                                if v.Target == NpcInstance.Name then
                                    QuestNumber = i
                                    break
                                end
                            end
                            local NpcHuman = NpcInstance:FindFirstChild("Humanoid")
                            local NpcHRP = NpcInstance:FindFirstChild("HumanoidRootPart")
                            if NpcHuman and NpcHRP then
                                while _G.CrabHub.AutoFarmAHD and not (NpcInstance.Parent == nil) do FastWait()
                                    local PlayerHRP = PlayerCheck()
                                    if PlayerHRP then
                                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("GetQuest", QuestNumber)
                                        PlayerHRP.CFrame = CFrame.new(NpcHRP.Position - (NpcHRP.CFrame.LookVector * 1.5), NpcHRP.Position)
                                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Punch", "Right")
                                        if Player.Stats.Class.Value == "Angel" then
                                            Player.Stats.Class.Value = "PuriPuri"
                                        end
                                        for i=1, 5 do
                                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(string.gsub(Player.Stats.Class.Value.. "Attack"..i, " ", ""), NpcHRP.Position)
                                        end
                                        if PlayerCheck() and PlayerLevelInstance.Value >= 200 then
                                            while Player.Character:FindFirstChild("Form") and _G.CrabHub.AutoFarmAHD do 
                                                if PlayerCheck() then
                                                    local AttackMod = require(Player.PlayerGui.Cooldown.CooldownBackground.Input.LocalAttacks)
                                                    if Player.Character.Form.Value == nil or Player.Character.Form.Value == "" or Player.Character.Form.Value == " " then
                                                        AttackMod[string.gsub(Player.Stats.Class.Value.. "Attack"..6, " ", "")]()
                                                        wait(0.5)
                                                    else
                                                        break
                                                    end
                                                    FastWait()
                                                else break
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end

    AHD.Toggle({Text = "AutoFarm", Callback = AutoFarmAHD, Enabled = _G.CrabHub.AutoFarmAHD})

    if not _G.CrabHub.ChosenNpcListAHD then
        _G.CrabHub.ChosenNpcListAHD = {}
        for i, v in pairs(game:GetService("Workspace").Spawns:GetChildren()) do
            local QuestMod = require(game:GetService("ReplicatedStorage").Modules.Quests)
            for i1, v1 in pairs(QuestMod) do
                if (v1.Target == v.Name) and (v1.Amount == 1) then
                    _G.CrabHub.ChosenNpcListAHD[v.Name] = false
                    break
                end
            end
        end
    end

    local NpcTable = _G.CrabHub.ChosenNpcListAHD

    AHD.DataTable({
        Text = "Choose the Npcs",
        Options = NpcTable,
        Callback = function(NpcTableTemp)
            table.foreach(NpcTableTemp, function(Option, Value)
                _G.CrabHub.ChosenNpcListAHD[Option] = Value
                SaveSettings()
            end)
        end})

end