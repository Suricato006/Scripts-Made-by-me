if not game:IsLoaded() then game.Loaded:Wait() end
local Player = game.Players.LocalPlayer

while not Player.Character do task.wait() end

while true do
    local TimerLabel = Player.PlayerGui:WaitForChild("HUD"):FindFirstChild("Timer", true)
    if TimerLabel then
        if TimerLabel.Visible and not (TimerLabel.Text == "") then
            local a = Player.Character:FindFirstChild("True")
            if a then
                a:Destroy()
            end
        end
    end
    task.wait()
end