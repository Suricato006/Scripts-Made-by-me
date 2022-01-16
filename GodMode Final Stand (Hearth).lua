--GodMode Final Stand (Hearth)
loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Functions%20and%20stuff.lua'),true))()

_G.GodMode = true


while _G.GodMode do FastWait()
    if PlayerCheck() then
        firetouchinterest(Player.Character.HumanoidRootPart, game:GetService("Workspace").Touchy.Part, 0)
        Player.PlayerGui:WaitForChild("Popup").Enabled = false
        while PlayerCheck() and _G.GodMode do FastWait()
            if not Player.Character:FindFirstChild("i") then
                firetouchinterest(Player.Character.HumanoidRootPart, game:GetService("Workspace").Touchy.Part, 1)
                break
            end
        end
    end
end