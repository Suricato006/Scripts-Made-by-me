_G.InstaKill = true

while _G.InstaKill do task.wait()
    for i, v in pairs(workspace:GetChildren()) do
        if v.Name == "Stuff" then
            local a = v:FindFirstChildWhichIsA("Humanoid", true)
            if a then
                a.Health = 0
            end
        end
    end
end