local Player = game.Players.LocalPlayer
_G.TopRespawn = true
while _G.TopRespawn do task.wait()
    local SuperAction = Player.Character:FindFirstChild("SuperAction")
    if SuperAction then
        SuperAction:Destroy()
    end
end