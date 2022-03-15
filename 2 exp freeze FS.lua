if not game:IsLoaded() then game.Loaded:Wait() end

local FinalStandTable = {536102540, 569994010, 882399924, 2046990924, 478132461, 3552157537, 2651456105, 3565304751, 882375367, 2050207304, 535527772}

if not table.find(FinalStandTable, game.PlaceId) then return end

while not game.Players.LocalPlayer.Character do wait() end

wait(0.5)

while true do task.wait()
    local a = game.Players.LocalPlayer.Character:FindFirstChild("True")
    if a then
        a:Destroy()
    end
end