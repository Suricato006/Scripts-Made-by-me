local Char = game.Players.LocalPlayer.Character

local Destroy = {"TempAura", "RebirthWings", "RealHalo", "SaiyanAuraWeak", "MajinParticle", "Lightning2", "SaiyanHair", "Tatoo", "MajinAura"}
for i, v in pairs(Destroy) do
    local a = Char:FindFirstChild(v, true)
    if a then
        a:Destroy()
    end
end