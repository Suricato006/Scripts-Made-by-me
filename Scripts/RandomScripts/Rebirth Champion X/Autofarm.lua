local A = {"Common", "Uncommon", "Rare", "Epic"}
local WorldName = "Aqua"
_G.AutoFarm = not _G.AutoFarm

for i, v in pairs(A) do
    game:GetService("ReplicatedStorage").Events.AutoDelete:FireServer(v, true)
end

local Connection = nil
Connection = game:GetService("RunService").Heartbeat:Connect(function()
    if not _G.AutoFarm then
        Connection:Disconnect()
    end
    game:GetService("ReplicatedStorage").Events.Click3:FireServer()
    game:GetService("ReplicatedStorage").Events.WorldBoost:FireServer(WorldName)
    coroutine.wrap(function()
        game:GetService("ReplicatedStorage").Functions.Unbox:InvokeServer(WorldName, "Triple")
        game:GetService("ReplicatedStorage").Functions.Request:InvokeServer("CraftAll", {})
    end)()
    local Char = game.Players.LocalPlayer.Character
    local Hrp = Char:FindFirstChild("HumanoidRootPart")
    if not Hrp then return end
    Hrp.CFrame = game:GetService("Workspace").Scripts.Eggs[WorldName]:GetModelCFrame()
    local Camera = workspace:FindFirstChildWhichIsA("Camera")
    Camera.CFrame = Hrp.CFrame * CFrame.new(0, 2, -10)
end)