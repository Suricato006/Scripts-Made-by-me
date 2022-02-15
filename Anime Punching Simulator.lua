_G.AutoClick = true
_G.AutoUpGrade = true

local function AutoClick()
    if _G.AutoClick then
        game:GetService("ReplicatedStorage").Remotes.TappingEvent:FireServer()
    end
end
game:GetService("RunService").Heartbeat:Connect(AutoClick)

local mod = require(game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("InteractCallBack", true))

local a = nil
for i, v in pairs(game:GetService("Workspace")["__SETTINGS"]["__INTERACT"]:GetChildren()) do
    if v.Name == "Practice" then
        if v.Area.Value == "Spawn" and v.Boost.Value == 120 then
            a = v
        end
    end
end

local function AutoUpgrade()
    if _G.AutoUpGrade then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = a.CFrame
        mod.CallBack(nil, nil, a)
    end
end
game:GetService("RunService").Heartbeat:Connect(AutoUpgrade)