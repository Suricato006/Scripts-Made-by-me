local Players = game:GetService("Players")
if not game:IsLoaded() then game.Loaded:Wait() end

local FinalStandTable = {536102540, 569994010, 882399924, 2046990924, 478132461, 3552157537, 2651456105, 3565304751, 882375367}

if not table.find(FinalStandTable, game.PlaceId) then return end

game:GetService("RunService").Heartbeat:Connect(function()
    pcall(function()
        game.Players.LocalPlayer.Character.True:Destroy()
    end)
end)