local Char = game.Players.LocalPlayer.Character
for i, v in pairs(workspace:GetDescendants()) do
    if v:IsA("BasePart") and isnetworkowner(v) then
        local Racist = v.Parent
        if not (Racist == Char) and Racist:FindFirstChild("Humanoid") then
            Racist.Humanoid.Health = 0
        end
    end
end