_G.AutoFarm = true
_G.MonsterName = "Weak Dust Sans"

local Player = game.Players.LocalPlayer
local function Punch()
    local PunchTool = Player.Backpack:FindFirstChildWhichIsA("Tool") or Player.Character:FindFirstChildWhichIsA("Tool")
    if PunchTool.Parent == Player.Backpack then
        PunchTool.Parent = Player.Character
    end
    PunchTool:Activate()
end

game:GetService("RunService").Heartbeat:Connect(function()
    local InviteGUI = Player.PlayerGui:FindFirstChild("InviteGUI")
    if _G.AutoFarm then
        if InviteGUI then
            InviteGUI.Enabled = false
        end
    else
        if InviteGUI then
            InviteGUI.Enabled = true
        end
    end
end)

while _G.AutoFarm do task.wait()
    for i, v in pairs(workspace:GetChildren()) do
        if (v.Name == "Battle") and v:IsA("Part") then
            local UI = v:FindFirstChild("BattleInfoGui")
            if UI then
                local MonsterName = UI:FindFirstChild("MonsterName")
                if MonsterName then
                    local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
                    if string.match(MonsterName.Text, _G.MonsterName) and HRP then
                        HRP.CFrame = v.CFrame
                        wait(0.2)
                        local args = {
                            [1] = {},
                            [2] = v
                        }
                        game:GetService("Lighting").Invite:FireServer(unpack(args))
                    end
                end
            end
        end
    end
    for i, v in pairs(workspace:GetChildren()) do
        if v:IsA("Folder") then
            if v.Name == "Stuff" then
                local EHum = v:FindFirstChildWhichIsA("Humanoid", true)
                if EHum then
                    local Enemy = EHum.Parent
                    if Enemy then
                        local PlayerFolder = Enemy:FindFirstChild("Players")
                        if PlayerFolder then
                            if PlayerFolder:FindFirstChild(Player.Name) then
                                while (EHum.Health > 0) do task.wait()
                                    local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
                                    local EHRP = Enemy:FindFirstChild("HumanoidRootPart")
                                    if HRP and EHRP then
                                        HRP.CFrame = EHRP.CFrame
                                        Punch()
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