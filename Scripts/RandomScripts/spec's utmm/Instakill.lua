_G.InstaKill = true

local KillConnection = nil
KillConnection = workspace.DescendantAdded:Connect(function(Descendant)
    if not _G.InstaKill then
        KillConnection:Disconnect()
    end
    if Descendant:IsA("Humanoid") and not Descendant:FindFirstAncestor(game.Players.LocalPlayer.Name) then
        Descendant.Health = 0
    end
end)