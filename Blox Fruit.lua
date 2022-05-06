local Player = game.Players.LocalPlayer
local Camera = workspace:FindFirstChildWhichIsA("Camera")
local QuestModule = require(game:GetService("ReplicatedStorage"):WaitForChild("Quests"))
local InputLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/InputFunctions%20Library.lua"))()

local function TakeQuest(QuestName, QuestNumber)
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", QuestName, QuestNumber)
end
_G.SettingsTable = {}
_G.SettingsTable.AutoFarm = true
_G.SettingsTable.Tool = "Melee" -- "Melee", "Blox Fruit" or "Gun"
_G.SettingsTable.Moves = {
    Punch = true,
    MoveZ = true,
    MoveX = true,
    MoveC = true,
    MoveV = true,
    MoveF = false
}
_G.SettingsTable.Position = "Above" -- "Above", "Under" or "Behind"
_G.SettingsTable.Distance = 20
_G.SettingsTable.ChangeCamera = true

local function FindQuest()
    local ClosestQuestLevel = 0
    local ClosestQuestName = ""
    local QuestIndex = 0
    local NpcName = ""
    for i, v in pairs(QuestModule) do
        for i1, v1 in pairs(v) do
            if (v1.LevelReq <= Player.Data.Level.Value) and (ClosestQuestLevel < v1.LevelReq) then
                ClosestQuestLevel = v1.LevelReq
                ClosestQuestName = i
                QuestIndex = i1
                NpcName = v1.Name
            end
        end
    end
    return ClosestQuestName, QuestIndex, NpcName
end

local function NpcCheck(NpcModel)
    local EHum = NpcModel:FindFirstChild("Humanoid")
    if EHum then
        if EHum.Health > 0 then
            return NpcModel, EHum
        end
    end
    return nil
end

while _G.SettingsTable.AutoFarm do task.wait()
    local QuestName, QuestIndex, NpcName = FindQuest()
    if not Player.PlayerGui.Main.Quest.Visible then
        TakeQuest(QuestName, QuestIndex)
    elseif not Player.PlayerGui.Main.Quest:FindFirstChild("QuestTitle", true).Title.Text:lower():find(NpcName:lower()) then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
    end
    local Npc
    local EHum
    for i, v in pairs(workspace.Enemies:GetChildren()) do
        if v.Name:find(NpcName) then
            Npc, EHum = NpcCheck(v)
        end
    end
    if not Npc then
        for i, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
            if v.Name:find(NpcName) then
                Npc, EHum = NpcCheck(v)
            end
        end
    end
    while _G.SettingsTable.AutoFarm do task.wait()
        if _G.SettingsTable.ChangeCamera then
            if not (Camera.CameraType == Enum.CameraType.Scriptable) then
                Camera.CameraType = Enum.CameraType.Scriptable
            end
        end
        local Hrp = Player.Character:FindFirstChild("HumanoidRootPart")
        if Hrp then
            if not Npc then
                break
            end
            local EHrp = Npc:FindFirstChild("HumanoidRootPart")
            if (not EHrp) or (EHum.Health <= 0) then
                break
            end
            if not Player.Character:FindFirstChildWhichIsA("Tool") then
                local Tool
                if _G.SettingsTable.Tool then
                    for i, v in pairs(Player.Backpack:GetChildren()) do
                        if v.ToolTip == _G.SettingsTable.Tool then
                            Tool = v
                        end
                    end
                end
                if not Tool then
                    Tool = Player.Backpack:FindFirstChildWhichIsA("Tool")
                end
                if Tool then
                    Tool.Parent = Player.Character
                end
            end
            _G.SettingsTable.Distance = _G.SettingsTable.Distance or 20
            EHrp.Size = Vector3.new(_G.SettingsTable.Distance * 2.5, _G.SettingsTable.Distance * 2.5, _G.SettingsTable.Distance * 2.5)
            local PositionChange = Vector3.new(0, _G.SettingsTable.Distance, 0)
            if _G.SettingsTable.Position == "Under" then
                PositionChange = PositionChange * -1
            end
            if _G.SettingsTable.Position == "Behind" then
                PositionChange = -EHrp.CFrame.LookVector * (_G.SettingsTable.Distance)
            end
            EHrp.Transparency = 0.5
            EHrp.CanCollide = false
            Hrp.CFrame = CFrame.new(EHrp.CFrame.Position + PositionChange, EHrp.CFrame.Position)
            Camera.CFrame = CFrame.new(EHrp.CFrame.Position - Hrp.CFrame.LookVector * (_G.SettingsTable.Distance - 1), EHrp.CFrame.Position)
            if _G.SettingsTable.Moves.Punch then
                InputLibrary.MouseClick(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
            else
                InputLibrary.MoveMouse(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
            end
            for i, v in pairs(_G.SettingsTable.Moves) do
                if v and string.find(tostring(i), "Move") then
                    InputLibrary.PressKey(Enum.KeyCode[string.gsub(i, "Move", "")])
                end
            end
        end
    end
end
Camera.CameraType = Enum.CameraType.Custom