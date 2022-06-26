local Player = game.Players.LocalPlayer
local InputLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/InputFunctions%20Library.lua"))()

_G.AutoTimeTrial = not _G.AutoTimeTrial

local Collectables = {"Yen", "GenericItem"}
game:GetService("Workspace").Effects.ChildAdded:Connect(function(Child)
    if table.find(Collectables, Child.Name) or string.find(Child.Name, "Shard") then
        while _G.AutoTimeTrial do task.wait()
            Child:WaitForChild("Base").CFrame = Player.Character.HumanoidRootPart.CFrame
        end
    end
end)

local Optimized = false
if getconnections then
    local Connection = Player.PlayerGui.MainGui.ClickFrame.Click.Activated
    repeat
        task.wait()
    until getconnections(Connection)[2]
    Optimized = true
    coroutine.wrap(function()
        while _G.AutoTimeTrial do task.wait()
            getconnections(Connection)[1]:Fire()
        end
    end)()
end

while _G.AutoTimeTrial do task.wait()
    for i, v in pairs(workspace.Worlds[Player.World.Value].Map:GetChildren()) do
        if v.Name == "RestRoom" then
            local ConfirmPart = v:FindFirstChild("ConfirmPart")
            if ConfirmPart and ConfirmPart:FindFirstChildWhichIsA("ProximityPrompt") then
                while ConfirmPart:FindFirstChildWhichIsA("ProximityPrompt") do task.wait()
                    Player.Character.HumanoidRootPart.CFrame = ConfirmPart.CFrame
                    InputLibrary.PressKey(Enum.KeyCode.E)
                end
            end
        end
    end
    for i, v in pairs(workspace.Worlds[Player.World.Value].Enemies:GetChildren()) do
        Player.Character.HumanoidRootPart.CFrame = v:WaitForChild("HumanoidRootPart").CFrame
        game:GetService("ReplicatedStorage").Bindable.SendPet:Fire(v, true, true)
        while v:FindFirstAncestor("Worlds") and _G.AutoTimeTrial do task.wait()
            Player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
            if not Optimized then
                game:GetService("ReplicatedStorage").Remote.ClickerDamage:FireServer()
            end
        end
    end
end