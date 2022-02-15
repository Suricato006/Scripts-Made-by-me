loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Functions%20and%20stuff.lua'),true))()

_G.InfiniteBreath = true

game:GetService("RunService").Heartbeat:Connect(function()
    if _G.InfiniteBreath then
        local a = game.Players.LocalPlayer.Character:FindFirstChild("Oxygen")
        if a then
            a.Value = math.huge
        end
    end
end)