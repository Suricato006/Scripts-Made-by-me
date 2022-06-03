
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/uwuware-ui/main/main.lua"))()
local Player = game.Players.LocalPlayer
local Window = Library:CreateWindow("AutoFarm")

game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
    if _G.AutoFarm and Player.Character:FindFirstChildWhichIsA("ObjectValue") then
        for i, v1 in pairs(workspace:GetDescendants()) do
            if v1:IsA("Humanoid") and not (v1.Parent == Player.Character) then
                v1.Health = 0
            end
        end
    end
end)
--HardMode K Round
Window:AddToggle({text = "AutoFarm", callback = function(bool)
    _G.AutoFarm = bool
    while _G.AutoFarm do task.wait()
        for i, v in pairs(workspace:GetDescendants()) do
            if v.Name == "MonsterName" then
                if v.Text == _G.NpcName then
                    while _G.AutoFarm do task.wait()
                        local Hrp = Player.Character:WaitForChild("HumanoidRootPart")
                        local Handle = v.Parent.Parent
                        Hrp.CFrame = Handle.CFrame
                        while _G.AutoFarm and not Player.Character:FindFirstChildWhichIsA("ObjectValue") do task.wait()
                            local args = {
                                [1] = {},
                                [2] = Handle
                            }
                            game:GetService("Lighting").Invite:FireServer(unpack(args))
                        end
                        Player.CharacterAdded:Wait()
                    end
                end
            end
        end
    end
end})
_G.NpcName = _G.NpcName or "???"
Window:AddBox({text = 'Npc Name', callback = function(NpcName)
    _G.NpcName = NpcName
end})
Library:Init()