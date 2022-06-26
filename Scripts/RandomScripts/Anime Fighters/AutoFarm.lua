_G.AutoFarm = not _G.AutoFarm

local Player = game.Players.LocalPlayer

loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Scripts/RandomScripts/Anime%20Fighters/AutoClick%20and%20Collect.lua"))()

while _G.AutoFarm do task.wait()
    for i, v in pairs(workspace.Worlds[Player.World.Value].Enemies:GetChildren()) do
        Player.Character.HumanoidRootPart.CFrame = v:WaitForChild("HumanoidRootPart").CFrame
        game:GetService("ReplicatedStorage").Bindable.SendPet:Fire(v, true, true)
        while _G.AutoFarm and (v:FindFirstAncestor("Worlds")) do task.wait()
            Player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
        end
    end
end