local Player = game.Players.LocalPlayer
local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local CrabHub = Material.Load({
    Title = "CrabHub",
    Style = 3,
    SizeX = 500,
    SizeY = 350,
    Theme = "Light",
    ColorOverrides = {
        MainFrame = Color3.fromRGB(235,235,235)
    }
})

local AutoFarm = CrabHub.New({
    Title = "AutoFarm"
})

AutoFarm.Toggle({
    Text = "AutoFarm Toggle",
    Callback = function(Value)
        _G.AutoFarm = Value
        coroutine.wrap(function()
            while _G.AutoFarm do task.wait()
                for i, v in pairs(workspace.Alive:GetChildren()) do
                    if string.find(v.Name, _G.NpcName or "Jotaro Kujo P4") then
                        local Npc = v
                        while not Player:WaitForChild("Quests"):FindFirstChild("Kill "..Npc.Name) and _G.AutoFarm do task.wait()
                            if not Player.PlayerGui:FindFirstChild("Dialogue") then
                                local Hrp = Player.Character:FindFirstChild("HumanoidRootPart")
                                local GiornoGiovanna = workspace:FindFirstChild("Giorno Giovanna", true)
                                local GHrp = GiornoGiovanna:FindFirstChild("HumanoidRootPart")
                                if Hrp and GHrp then
                                    if (Hrp.Position - GHrp.Position).magnitude < 100 then
                                        local Stand = Player.Character:FindFirstChild("Stand")
                                        local StandHrp = nil
                                        if Stand then
                                            StandHrp = Stand:FindFirstChild("HumanoidRootPart")
                                        end
                                        if StandHrp then
                                            StandHrp.CFrame = GHrp.CFrame
                                        end
                                    else
                                        local tween = game:GetService("TweenService"):Create(Hrp, TweenInfo.new(3), {CFrame = GHrp.CFrame})
                                        tween:Play()
                                        tween.Completed:Wait()
                                    end
                                end
                                if not fireproximityprompt then
                                    local ErrorMessage = Instance.new("Message", game:GetService("CoreGui"))
                                    ErrorMessage.Text = 'function "fireproximityprompt" not found.\nIf you REALLY want to farm then just open a chat with an npc (giorno giovanna for example) and execute again.'
                                    return
                                end
                                fireproximityprompt(GiornoGiovanna:FindFirstChildWhichIsA("ProximityPrompt", true))
                            end
                            game:GetService("ReplicatedStorage").GiveQuest:FireServer("Kill "..Npc.Name)
                        end
                        while _G.AutoFarm do task.wait()
                            if not Npc or (Npc.Parent == nil) then
                                break
                            end
                            local Hrp = Player.Character:FindFirstChild("HumanoidRootPart")
                            local EHrp = Npc:FindFirstChild("HumanoidRootPart")
                            local EHum = Npc:FindFirstChild("Humanoid")
                            if EHum then
                                if EHum.Health == 0 then
                                    game:GetService("ReplicatedStorage").CheckQuest:FireServer("Kill "..Npc.Name)
                                    break
                                end
                            end
                            local Summoned = Player.Character:FindFirstChild("Summoned")
                            if Summoned then
                                if not Summoned.Value then
                                    game:GetService("ReplicatedStorage").Ability:FireServer("Stand Summon", {})
                                end
                            end
                            if Hrp and EHrp then
                                if (Hrp.Position - EHrp.Position).magnitude < 100 then
                                    local Stand = Player.Character:FindFirstChild("Stand")
                                    local StandHrp = nil
                                    if Stand then
                                        StandHrp = Stand:FindFirstChild("HumanoidRootPart")
                                    end
                                    if StandHrp then
                                        StandHrp.CFrame = EHrp.CFrame
                                    end
                                    Hrp.CFrame = CFrame.new(EHrp.CFrame.Position - EHrp.CFrame.LookVector * (_G.Distance or 10), EHrp.CFrame.Position)
                                    game:GetService("ReplicatedStorage").Ability:FireServer("Punch", {})
                                else
                                    local tween = game:GetService("TweenService"):Create(Hrp, TweenInfo.new(3), {CFrame = EHrp.CFrame})
                                    tween:Play()
                                    tween.Completed:Wait()
                                end
                            end
                        end
                    end
                end
            end
        end)()
    end,
    Enabled = _G.AutoFarm
})

AutoFarm.TextField({
    Text = "NpcToFarm",
    Callback = function(Value)
        _G.NpcName = Value
    end
})

AutoFarm.Slider({
    Text = "Distance",
    Callback = function(Value)
        _G.Distance = Value
    end,
    Min = 1,
    Max = 25,
    Def = 10
})

local ItemFarm = CrabHub.New({
    Title = "ItemFarm"
})

ItemFarm.Toggle({
    Text = "ItemFarm",
    Callback = function(Value)
        _G.ItemFarm = Value
        coroutine.wrap(function()
            while _G.ItemFarm do task.wait()
                for i, v in pairs(workspace:GetChildren()) do
                    if _G.ItemToFarm[v.Name] then
                        while (v.Parent == workspace) and _G.ItemFarm do task.wait()
                            local Hrp = Player.Character:FindFirstChild("HumanoidRootPart")
                            if Hrp then
                                local tween = game:GetService("TweenService"):Create(Hrp, TweenInfo.new(_G.Speed or 3), {CFrame = v.CFrame})
                                tween:Play()
                                tween.Completed:Wait()
                                while Hrp and (v.Parent == workspace) and _G.ItemFarm do task.wait()
                                    Hrp.CFrame = v.CFrame
                                end
                            end
                        end
                    end
                end
            end
        end)()
    end,
    Enabled = _G.ItemFarm
})

ItemFarm.Slider({
    Text = "TimeToTween",
    Callback = function(Value)
        _G.Speed = Value
    end,
    Min = 1,
    Max = 10,
    Def = 3
})
_G.ItemToFarm = {
    ["Rokakaka"] = true,
    ["Stand Arrow"] = true,
    ["Unusual Arrow"] = true,
    ["DIO's Diary"] = true,
    ["Requiem Arrow"] = true,
    ["Ketchup"] = false
}
ItemFarm.ChipSet({
    Text = "ItemToFarm",
    Callback = function(chipset)
        for i, v in pairs(chipset) do
            _G.ItemToFarm[i] = v
        end
    end,
    Options = _G.ItemToFarm
})
