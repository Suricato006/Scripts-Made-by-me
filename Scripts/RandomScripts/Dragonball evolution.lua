if not game:IsLoaded() then
    game.Loaded:Wait()
end

_G.AutoFarm = true
_G.NpcName = "Shaggy"
_G.FormName = "mystic"

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
                            Hrp.CFrame = CFrame.new(EHrp.CFrame.Position - (EHrp.CFrame.LookVector * (math.ceil(EHrp.Size.Z))), EHrp.CFrame.Position)
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