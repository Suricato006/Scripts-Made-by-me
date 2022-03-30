local Player = game.Players.LocalPlayer
_G.TopRespawn = true
coroutine.wrap(function()
    while _G.TopRespawn do task.wait()
        local SuperAction = Player.Character:FindFirstChild("SuperAction")
        if SuperAction then
            SuperAction:Destroy()
        end
    end
end)
while _G.TopRespawn do
    local Humanoid = Player.Character:FindFirstChild("Humanoid")
    local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
    if Humanoid.Health <= 1 then
        repeat
            task.wait()
        until Humanoid.Health == Humanoid.MaxHealth
        local tween = game:GetService("TweenService"):Create(HRP,TweenInfo.new(1,  Enum.EasingStyle.Quad),{CFrame = CFrame.new(100, 100, 100)})
        tween:Play()
        tween.Completed:Wait()
    end
end