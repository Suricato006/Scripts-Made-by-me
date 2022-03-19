if not game:IsLoaded() then game.Loaded:Wait() end

local FinalStandTable = {536102540, 569994010, 882399924, 2046990924, 478132461, 3552157537, 2651456105, 3565304751, 882375367, 3552158750}

if not table.find(FinalStandTable, game.PlaceId) then return end

local Player = game.Players.LocalPlayer

while not Player.Character do task.wait() end

game:GetService("RunService").Heartbeat:Connect(function()
    local TimerLabel = Player.PlayerGui:WaitForChild("HUD"):FindFirstChild("Timer", true)
    if TimerLabel then
        if TimerLabel.Visible and not (TimerLabel.Text == "") then
            local a = Player.Character:FindFirstChild("True")
            if a then
                a:Destroy()
            end
        end
    end
end)