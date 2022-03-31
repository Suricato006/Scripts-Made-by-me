local camera = workspace.CurrentCamera;
local Player = game.Players.LocalPlayer

_G.AutoFarm = true
_G.NpcNames = {"Evil", "Saiba", "Chi", "Kick"}

while _G.AutoFarm do task.wait()
    for i, Enemy in pairs(workspace.Live:GetChildren()) do
        for i, v in pairs(_G.NpcNames) do
            if Enemy.Name:find(v) then
                local EHrp = Enemy:FindFirstChild("HumanoidRootPart")
                local EHum = Enemy:FindFirstChild("Humanoid")
                local Hrp = Player.Character:FindFirstChild("HumanoidRootPart")
                if EHrp and EHum and Hrp then
                    while (EHum.Health > 0) and _G.AutoFarm do task.wait()
                        local Distance = (EHrp.Position - Hrp.Position).magnitude
                        if (EHrp.Position - Hrp.Position).magnitude < 900 then
                            Hrp.CFrame = CFrame.new((EHrp.CFrame.Position - (EHrp.CFrame.LookVector*2)), EHrp.CFrame.Position)
                        else
                            local TweenSpeed = Distance/500
                            local tween = game:GetService("TweenService"):Create(Hrp, TweenInfo.new(TweenSpeed), {CFrame = EHrp.CFrame})
                            tween:Play()
                            while (tween.PlaybackState == Enum.PlaybackState.Playing) and _G.AutoFarm do
                                if (EHrp.Position - Hrp.Position).magnitude > 900 then
                                    task.wait()
                                else
                                    tween:Cancel()
                                    Hrp.CFrame = CFrame.new((EHrp.CFrame.Position - (EHrp.CFrame.LookVector*2)), EHrp.CFrame.Position)
                                end
                            end
                        end
                        Player.Backpack.ServerTraits.Input:FireServer({"m2"}, Hrp.CFrame)
                        camera.CameraType = Enum.CameraType.Scriptable
                        camera.CFrame = CFrame.new((Hrp.CFrame.Position - (Hrp.CFrame.LookVector*13)), Hrp.CFrame.Position)
                    end
                end
            end
        end
    end
end
camera.CameraType = Enum.CameraType.Custom