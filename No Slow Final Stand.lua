--No Slow Final Stand
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

_G.NoSlow = true
local Names = {"Action", "Attacking", "Using", "hyper", "Hyper", "heavy", "KiBlasted", "Tele", "tele", "Killed", "Slow"}

while _G.NoSlow do FastWait()
    if PlayerCheck() then
        for i, v in pairs(Names) do
            local a = Player.Character:FindFirstChild(v)
            if a then
                a:Destroy()
            end
        end
    end
end
