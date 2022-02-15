local function ChildCheck(String1, ...)
    local a = game.Players.LocalPlayer.Character:FindFirstChild(String1)
    if a then
        local c = {...}
        for i, v in pairs(c) do
            local z = a:FindFirstChild(v)
            if z then
                z:Destroy()
            end
        end
    end
end

_G.AntiKB = true

game:GetService("RunService").Heartbeat:Connect(function()
    if _G.AntiKB then
        ChildCheck("LowerTorso", "BodyVelocity", "KnockBacked")
    ChildCheck("Head", "KnockBacked", "NotHardBack")
    ChildCheck("Humanoid", "creator")
    ChildCheck("HumanoidRootPart", "Throw", "Flip")
    ChildCheck("LeftHand", "BodyVelocity")
    end
end)