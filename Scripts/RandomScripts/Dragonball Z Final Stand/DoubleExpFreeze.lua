if not game:IsLoaded() then
    game.Loaded:Wait()
end
local Player = game.Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local TimerLabel = Player:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("FullSize"):WaitForChild("Timer")
TimerLabel:GetPropertyChangedSignal("Text"):Wait()
if not (TimerLabel.Text == "") then
    local TrueLabel = Char:WaitForChild("True", 5)
    if TrueLabel then
        TrueLabel:Destroy()
    end
    Player.CharacterAdded:Connect(function(Char)
        local TrueLabel2 = Char:WaitForChild("True")
        TimerLabel:GetPropertyChangedSignal("Text"):Wait()
        Char:WaitForChild("HumanoidRootPart")
        if TrueLabel2 then
            TrueLabel2:Destroy()
        end
    end)
end