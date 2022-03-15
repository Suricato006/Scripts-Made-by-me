if not game:IsLoaded() then game.Loaded:Wait() end

local FinalStandTable = {536102540, 569994010, 882399924, 2046990924, 478132461, 3552157537, 2651456105, 3565304751, 882375367, 3552158750}

if not table.find(FinalStandTable, game.PlaceId) then return end

while not game.Players.LocalPlayer.Character do task.wait() end

task.wait(0.5)

game:GetService("RunService").Heartbeat:Connect(function()
    local a = game.Players.LocalPlayer.Character:FindFirstChild("True")
    if a then
        a:Destroy()
    end
end)