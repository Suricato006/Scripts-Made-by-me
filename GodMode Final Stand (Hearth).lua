--GodMode Final Stand (Hearth)
local Player = game:GetService("Players").LocalPlayer
local function PlayerCheck()
    if Player.Character:FindFirstChild("HumanoidRootPart") then
        return true
    else
        return nil
    end
end

local function FastWait()
    game:GetService("RunService").Heartbeat:wait()
end

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