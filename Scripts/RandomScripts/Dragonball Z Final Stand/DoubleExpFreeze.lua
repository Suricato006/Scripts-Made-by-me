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
    Player.CharacterAdded:Connect(function(Character)
        local TimerLabel2 = Player:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("FullSize"):WaitForChild("Timer")
        TimerLabel2:GetPropertyChangedSignal("Text"):Wait()
        if not (TimerLabel2.Text == "") then
            Character:WaitForChild("HumanoidRootPart")
            local TrueLabel2 = Character:WaitForChild("True")
            if TrueLabel2 then
                TrueLabel2:Destroy()
            end
        end
    end)
end