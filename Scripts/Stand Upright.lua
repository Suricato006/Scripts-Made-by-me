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
local OldNameCall = nil

OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
    local Args = {...}
    local NamecallMethod = getnamecallmethod()

    if not checkcaller() and (Self.Name == "SpeedJump") and (NamecallMethod == "FireServer") then
        return nil
    end

    return OldNameCall(Self, ...)
end)
AutoFarm.Toggle({
    Text = "AutoFarm Toggle",
    Callback = function(Value)
        _G.AutoFarm = Value
        coroutine.wrap(function()
            while _G.AutoFarm do task.wait()
                for i, v in pairs(workspace.Living:GetChildren()) do
                    if string.find(v.Name, _G.NpcName or "Jotaro Kujo P4") then
                        local Npc = v
                        while _G.AutoFarm do task.wait()
                            if not Npc or (Npc.Parent == nil) then
                                break
                            end
                            local Hrp = Player.Character:FindFirstChild("HumanoidRootPart")
                            local EHrp = Npc:FindFirstChild("HumanoidRootPart")
                            local EHum = Npc:FindFirstChild("Humanoid")
                            local PunchEvent = Player.Character:FindFirstChild("M1", true)
                            local SummonEvent = Player.Character:FindFirstChild("Summon", true)
                            local Stand = Player.Character:FindFirstChild("Stand")
                            if EHum then
                                if EHum.Health == 0 then
                                    break
                                end
                            end
                            if Stand then
                                local StandTorso = Stand:FindFirstChild("UpperTorso")
                                if StandTorso then
                                    if StandTorso.Transparency == 1 then
                                        SummonEvent:FireServer()
                                    end
                                end
                            end
                            if Hrp and EHrp and PunchEvent and Stand then
                                if (Hrp.Position - EHrp.Position).magnitude < 100 then
                                    Hrp.CFrame = CFrame.new(EHrp.CFrame.Position - Vector3.new(EHrp.CFrame.LookVector.X, 0, EHrp.CFrame.LookVector.Z) * (_G.Distance or 5), EHrp.CFrame.Position)
                                    PunchEvent:FireServer()
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
    Max = 10,
    Def = _G.Distance or 4
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
                for i, v in pairs(workspace.Items:GetChildren()) do
                    if _G.ItemToFarm[v.Name] then
                        while (v.Parent == workspace.Items) and _G.ItemFarm do task.wait()
                            local Hrp = Player.Character:FindFirstChild("HumanoidRootPart")
                            local Handle = v:FindFirstChild("Handle")
                            if Hrp and Handle then
                                local tween = game:GetService("TweenService"):Create(Hrp, TweenInfo.new(_G.Speed or 5), {CFrame = Handle.CFrame})
                                tween:Play()
                                tween.Completed:Wait()
                                while Hrp and (v.Parent == workspace.Items) and _G.ItemFarm do task.wait()
                                    Hrp.CFrame = Handle.CFrame
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
    Def = _G.Speed or 3
})
_G.ItemToFarm = {
    ["Rokakaka"] = true,
    ["Stand Arrow"] = true,
    ["Charged Arrow"] = true,
    ["DIO's Diary"] = true,
    ["Requiem Arrow"] = true,
    ["Ketchup"] = false,
    ["Green Baby"] = false
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