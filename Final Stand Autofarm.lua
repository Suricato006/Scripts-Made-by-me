local camera = workspace.CurrentCamera;
local Player = game.Players.LocalPlayer

_G.AutoFarm = true
_G.NpcName = "Evil"


local Tweening = false
while _G.AutoFarm do task.wait()
    for i, Enemy in pairs(workspace.Live:GetChildren()) do
        if Enemy.Name:find(_G.NpcName) then
            local EHrp = Enemy:FindFirstChild("HumanoidRootPart")
            local EHum = Enemy:FindFirstChild("Humanoid")
            local Hrp = Player.Character:FindFirstChild("HumanoidRootPart")
            if EHrp and EHum and Hrp then
                while (EHum.Health > 0) and _G.AutoFarm do task.wait()
                    local Distance = (EHrp.Position - Hrp.Position).magnitude
                    if not Tweening then
                        if (EHrp.Position - Hrp.Position).magnitude < 900 then
                            Hrp.CFrame = CFrame.new((EHrp.CFrame.Position - (EHrp.CFrame.LookVector*2)), EHrp.CFrame.Position)
                        else
                            local TweenSpeed = math.max(1, Distance/1000)
                            local tween = game:GetService("TweenService"):Create(Hrp, TweenInfo.new(TweenSpeed), {CFrame = EHrp.CFrame})
                            Tweening = true
                            tween:Play()
                            coroutine.wrap(function()
                                tween.Completed:Wait()
                            end)()
                            Tweening = false
                        end
                        Player.Backpack.ServerTraits.Input:FireServer({"m2"}, Hrp.CFrame)
                    end
                    camera.CameraType = Enum.CameraType.Scriptable
                    camera.CFrame = CFrame.new((Hrp.CFrame.Position - (Hrp.CFrame.LookVector*13)), Hrp.CFrame.Position)
                end
            end
        end
    end
end
camera.CameraType = Enum.CameraType.Custom