if not game:IsLoaded() then
    game.Loaded:Wait()
end

_G.AutoFarm = true
_G.NpcName = "Vegito"
_G.FormName = "mystic"
_G.Sponsor = false

if _G.Sponsor then
    -- Instances:

    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local TextLabel = Instance.new("TextLabel")
    local UIGradient = Instance.new("UIGradient")

    --Properties:

    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.Position = UDim2.new(0, 0, 0.186289117, 0)
    Frame.Size = UDim2.new(1, 0, 0.300000012, 0)

    TextLabel.Parent = Frame
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 0.350
    TextLabel.Position = UDim2.new(0, 0, 3.79006195e-08, 0)
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.Text = "Play Maradona Simulator while you farm Vegito or any npc. Game Link: https://www.roblox.com/games/8095847868/SoccerStar-Simulator"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextScaled = true
    TextLabel.TextSize = 14.000
    TextLabel.TextStrokeTransparency = 0.000
    TextLabel.TextWrapped = true

    UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 68, 255))}
    UIGradient.Rotation = 90
    UIGradient.Parent = TextLabel
end

local Player = game.Players.LocalPlayer

local function Pugno()
    game:GetService("Players").LocalPlayer.Backpack.Combat.RemoteEvent:FireServer("comboAttack")
end

local Transformed = false
while _G.AutoFarm do task.wait()
    for i, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") then
            if string.find(v.Name, _G.NpcName) then
                local Enemy = v
                while _G.AutoFarm do task.wait()
                    local EHrp = Enemy:FindFirstChild("HumanoidRootPart")
                    local EHum = Enemy:FindFirstChild("Humanoid")
                    local Hrp = Player.Character:FindFirstChild("HumanoidRootPart")
                    local Transformation = Player.Character:FindFirstChild("Transformation", true)
                    local CombatState = Player.PlayerGui:FindFirstChild("CombatState", true)
                    local Blocking = Player.Character:FindFirstChild("Blocking", true)
                    if Blocking then
                        Blocking:Destroy()
                    end
                    if not EHum then
                        break
                    end
                    if not (EHum.Health > 0) then
                        break
                    end
                    if CombatState then
                        CombatState.Visible = true
                        CombatState.Text = Enemy.Name.." Health = "..tostring(math.floor(EHum.Health))
                        CombatState.Font = Enum.Font.Arial
                        CombatState.BackgroundTransparency = 0
                    end
                    if EHrp then
                        if Hrp and Transformation then
                            if (Transformation.Value == "off") and (Transformed == false) then
                                Transformed = true
                                game:GetService("ReplicatedStorage").Transform:FireServer(_G.FormName)
                            end
                            Hrp.CFrame = CFrame.new(EHrp.CFrame.Position - (EHrp.CFrame.LookVector*3), EHrp.CFrame.Position)
                            Pugno()
                        else
                            Transformed = false
                        end
                    else
                        if Hrp then
                            Hrp.CFrame = Enemy:GetModelCFrame()
                        end
                    end
                end
            end
        end
    end
end