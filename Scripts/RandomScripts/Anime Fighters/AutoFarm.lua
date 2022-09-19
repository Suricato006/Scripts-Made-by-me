_G.AutoFarm = not _G.AutoFarm
_G.NpcName = "The Death Bringer"

local Player = game.Players.LocalPlayer

loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Scripts/RandomScripts/Anime%20Fighters/AutoClick%20and%20Collect.lua"))()

local Checked = false
while _G.AutoFarm do task.wait()
    local Found = false
    for i, v in pairs(workspace.Worlds[Player.World.Value].Enemies:GetChildren()) do
        if v:WaitForChild("DisplayName").Value:lower() == _G.NpcName:lower() then
            Found = true
            Player.Character.HumanoidRootPart.CFrame = v:WaitForChild("HumanoidRootPart").CFrame
            game:GetService("ReplicatedStorage").Bindable.SendPet:Fire(v, true, true)
            while _G.AutoFarm and (v:FindFirstAncestor("Worlds")) do task.wait()
                Player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
            end
        end
    end
    if not Found and not Checked then
        for i, v in pairs(workspace.Worlds[Player.World.Value].EnemySpawners:GetChildren()) do
            if not _G.AutoFarm then
                break
            end
            Player.Character.HumanoidRootPart.CFrame = v.CFrame
            task.wait()
        end
        Checked = true
    end
end