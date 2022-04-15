local Player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
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
for i, v in pairs(workspace:GetDescendants()) do
    if v:IsA("Seat") then
        v:Destroy()
    end
end
AutoFarm.Toggle({
    Text = "AutoFarm Toggle",
    Callback = function(Value)
        _G.AutoFarm = Value
        coroutine.wrap(function()
            while _G.AutoFarm do task.wait()
                for i, v in pairs(workspace.Alive:GetChildren()) do
                    if string.find(v.Name, _G.NpcName or "Jotaro Kujo P4") then
                        local Npc = v
                        if _G.AutoQuest then
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
                                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                                    task.wait()
                                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                                end
                                game:GetService("ReplicatedStorage").GiveQuest:FireServer("Kill "..Npc.Name)
                            end
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

AutoFarm.Toggle({
    Text = "AutoQuest",
    Callback = function(value)
        _G.AutoQuest = value
    end,
    Enabled = _G.AutoQuest,
    Menu = {
        Information = function(self)
            CrabHub.Banner({
                Text = "It works only on some npc, set it to false for a normal autofarm"
            })
        end
    }
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
                                local tween = game:GetService("TweenService"):Create(Hrp, TweenInfo.new(_G.Speed or 5), {CFrame = v.CFrame})
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
    Def = 5
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

local StandFarm = CrabHub.New({
    Title = "StandFarm"
})
local Attributes = {"Daemon", "Invincible", "Tragic", "Legendary", "Mythic"}
local Stands = {"Silver Chariot OVA", "The World OVA", "Jotaro's Star Platinum", "Star Platinum OVA", "Dio's The World"}
local function ScaleToOffset(x, y)
	x *= workspace.Camera.ViewportSize.X
	y *= workspace.Camera.ViewportSize.Y
	return x, y
end
--Tanks to CandyIsAbsolute for the function and the virtual input manager stuff, big props to him. Check his github: https://github.com/CandyIsAbsolute
local StandFarmToggle = nil
StandFarmToggle = StandFarm.Toggle({
    Text = "StandFarm",
    Callback = function(Value)
        _G.StandFarm = Value
        coroutine.wrap(function()
            local Connection = nil
            Connection = UserInputService.InputBegan:Connect(function(a, b)
                if a.KeyCode == Enum.KeyCode.N then
                    StandFarmToggle:SetState(false)
                    Connection:Disconnect()
                end
            end)
            while _G.StandFarm do task.wait()
                while _G.StandFarm do
                    if Player.PlayerGui:FindFirstChild("ItemPrompt") then
                        break
                    end
                    local Object = nil
                    if Player.Data.Stand.Value == "None" then
                        Object = Player.Backpack:FindFirstChild("Stand Arrow") or Player.Backpack:FindFirstChild("Unusual Arrow")
                    else
                        pcall(function()
                            print(Player.Data.Stand.Value, Player.Data.Attribute.Value)
                        end)
                        if table.find(Attributes, Player.Data.Attribute.Value) or table.find(Stands, Player.Data.Stand.Value) then
                            StandFarmToggle:SetState(false)
                        end
                        Object = Player.Backpack:FindFirstChild("Rokakaka")
                    end
                    if Object then
                        Object.Parent = Player.Character
                        Object:Activate()
                    else
                        StandFarmToggle:SetState(false)
                    end
                    task.wait(0.5)
                end
                while _G.StandFarm do task.wait()
                    local ItemPrompt = Player.PlayerGui:FindFirstChild("ItemPrompt")
                    local YesLabel = nil
                    if ItemPrompt then
                        if not (ItemPrompt.Parent == Player.PlayerGui) then
                            break
                        end
                        YesLabel = ItemPrompt:FindFirstChild("Yes", true)
                        if YesLabel then
                            local X, Y = ScaleToOffset(YesLabel.Position.X.Scale, YesLabel.Position.Y.Scale)
                            VirtualInputManager:SendMouseButtonEvent(X + (YesLabel.AbsoluteSize.X / 2), Y + (YesLabel.AbsoluteSize.Y / 2), 0, true, game, 0)
                            task.wait()
                            VirtualInputManager:SendMouseButtonEvent(X + (YesLabel.AbsoluteSize.X / 2), Y + (YesLabel.AbsoluteSize.Y / 2), 0, true, game, 0)
                        else break end
                    else break end
                end
            end
        end)()
    end,
    Enabled = _G.StandFarm,
    Menu = {
        Information = function(self)
            CrabHub.Banner({
                Text = "Press N to stop it"
            })
        end
    }
})