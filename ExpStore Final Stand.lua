local Player = game.Players.LocalPlayer
_G.ExpStore = true
local Names = {"LevelParticle"}
while _G.ExpStore do task.wait()
    local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
    if HRP then
        for i, v in pairs(HRP:GetChildren()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") then
                if table.find(Names, v.Name) then
                    v:Destroy()
                end
            end
        end
    end
end