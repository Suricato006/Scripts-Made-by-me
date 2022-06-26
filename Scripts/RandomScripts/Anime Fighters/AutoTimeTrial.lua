local Player = game.Players.LocalPlayer
local InputLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/InputFunctions%20Library.lua"))()

loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Scripts/RandomScripts/Anime%20Fighters/AutoClick%20and%20Collect.lua"))()

_G.AutoTimeTrial = not _G.AutoTimeTrial

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
        end
    end
end