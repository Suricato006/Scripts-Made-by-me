local Names = {"BodyVelocity", "KnockBacked", "NotHardBack", "creator", "Throw", "Flip"}

_G.AntiKB = true
while _G.AntiKB do task.wait()
    for i, v in pairs(Names) do
        local a = game.Players.LocalPlayer.Character:FindFirstChild(v, true)
        if a then
            a:Destroy()
        end
    end
end