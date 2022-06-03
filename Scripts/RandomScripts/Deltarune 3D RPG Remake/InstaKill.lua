local Char = game.Players.LocalPlayer.Character
for i, v in pairs(workspace:GetDescendants()) do
    if v:IsA("Humanoid") and not (v.Parent == Char) then
        v.Health = 0
    end
end