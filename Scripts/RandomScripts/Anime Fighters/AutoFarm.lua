_G.AutoFarm = true
local Player = game.Players.LocalPlayer

local Collectables = {"Yen", "GenericItem"}
game:GetService("Workspace").Effects.ChildAdded:Connect(function(Child)
    if table.find(Collectables, Child.Name) then
        while true do task.wait()
            Child:WaitForChild("Base").CFrame = Player.Character.HumanoidRootPart.CFrame
        end
    end
end)

while _G.AutoFarm do task.wait()
    for i, v in pairs(workspace.Worlds[Player.World.Value].Enemies:GetChildren()) do
        Player.Character.HumanoidRootPart.CFrame = v:WaitForChild("HumanoidRootPart").CFrame
        game:GetService("ReplicatedStorage").Bindable.SendPet:Fire(v, true, true)
        while _G.AutoFarm and (v:FindFirstAncestor("Worlds")) do task.wait()
            Player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
            game:GetService("ReplicatedStorage").Remote.ClickerDamage:FireServer()
        end
    end
end