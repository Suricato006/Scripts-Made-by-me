local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

_G.NpcName = ""
_G.AutoFarm = false

local function FindNpc()
    for i, v in pairs(workspace.Live:GetChildren()) do
        if string.find(v.Name, _G.NpcName) and (v.Humanoid.Health > 0) then
            return v
        end
    end
    return nil
end
local function Pugno()
    Player.Backpack.ServerTraits.Input:FireServer({"m2"}, Player.Character.HumanoidRootPart.CFrame)
end

local Npc = nil
local Tweening = false

local Library = loadstring(game:HttpGet("https://pastebin.com/raw/GX28T0pH"))()
local Main = Library:CreateWindow("AutoFarm Final Stand")
Main:AddToggle({text = "AutoFarm", state = false, callback = function(bool)
    _G.AutoFarm = bool
    while _G.AutoFarm do task.wait()
        local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
        if HRP then
            if not Npc then
                Npc = FindNpc()
            end
            if Npc then
                if not string.find(Npc.Name, _G.NpcName) then
                    Npc = nil
                    return
                end
                if not (Npc.Humanoid.Health > 0) then
                    Npc = FindNpc()
                    return
                end
                if not Tweening then
                    if ((HRP.Position - Npc.HumanoidRootPart.Position).magnitude <= 900) then
                        HRP.CFrame = CFrame.new(Npc.HumanoidRootPart.Position - Npc.HumanoidRootPart.CFrame.LookVector/2, Npc.HumanoidRootPart.Position)
                        Pugno()
                    else
                        local tween = game:GetService("TweenService"):Create(HRP, TweenInfo.new(3), {CFrame = CFrame.new(Npc.HumanoidRootPart.Position - Npc.HumanoidRootPart.CFrame.LookVector/2, Npc.HumanoidRootPart.Position)})
                        tween:Play()
                        Tweening = true
                        tween.Completed:Wait()
                        Tweening = false
                    end
                end
            end
        end
    end
end})
Main:AddBox({text = "NpcName", value = "", callback = function(typed)
    _G.NpcName = typed
end})

Library:Init()