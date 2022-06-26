local Player = game.Players.LocalPlayer

if _G.AutoClick then
    return
end
_G.AutoClick = true

local Collectables = {"Yen", "GenericItem", "MultiOpen"}
game:GetService("Workspace").Effects.ChildAdded:Connect(function(Child)
    if table.find(Collectables, Child.Name) or string.find(Child.Name, "Shard") then
        while true do task.wait()
            Child:WaitForChild("Base").CFrame = Player.Character.HumanoidRootPart.CFrame
        end
    end
end)

if getconnections then
    local Connection = Player.PlayerGui.MainGui.ClickFrame.Click.Activated
    repeat
        task.wait()
    until getconnections(Connection)[2]
    coroutine.wrap(function()
        while true do task.wait()
            getconnections(Connection)[1]:Fire()
        end
    end)()
else
    while true do task.wait()
        game:GetService("ReplicatedStorage").Remote.ClickerDamage:FireServer()
    end
end