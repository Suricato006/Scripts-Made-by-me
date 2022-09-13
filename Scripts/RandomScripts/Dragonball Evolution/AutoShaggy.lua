if not game:IsLoaded() then
    game.Loaded:Wait()
end

_G.AutoFarm = not _G.AutoFarm
warn(_G.AutoFarm)

local Player = game.Players.LocalPlayer

local function Pugno()
    game:GetService("ReplicatedStorage").Combat:FireServer("comboAttack")
end

local function FindEnemy()
    while true do
        for i, v in pairs(workspace:GetChildren()) do
            if string.find(v.Name, "Shaggy") == 1 then
                return v
            end
        end
        workspace.ChildAdded:Wait()
    end
end

local Transformed = false
while _G.AutoFarm do task.wait()
    local Enemy = FindEnemy()
    local EHum = Enemy:WaitForChild("Humanoid")
    local EHrp = Enemy:WaitForChild("HumanoidRootPart", 2)
    local Char = Player.Character or Player.CharacterAdded:Wait()
    local Hrp = Char:WaitForChild("HumanoidRootPart")
    local DataFolder = Char:WaitForChild("Data")
    local Transformation = DataFolder:WaitForChild("Transformation")
    local Blocking = DataFolder:FindFirstChild("Blocking")
    if Blocking then
        Blocking:Destroy()
    end
    if not EHrp then
        local HrpConnection = nil
        HrpConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not _G.AutoFarm then
                HrpConnection:Disconnect()
            end
            Hrp.CFrame = Enemy:GetModelCFrame()
            if EHrp then
                HrpConnection:Disconnect()
            end
        end)
        EHrp = Enemy:WaitForChild("HumanoidRootPart")
    end
    local KillConnection = nil
    KillConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not _G.AutoFarm then
            KillConnection:Disconnect()
        end
        local Char1 = Player.Character
        local Hrp1 = Char1:FindFirstChild("HumanoidRootPart")
        if not (Char1 and Hrp1) then return end
        Hrp1.CFrame = EHrp.CFrame * CFrame.new(0, 0, 2)
        Pugno()
        if (Transformation.Value == "off") and not Transformed then
            Transformed = true
            game:GetService("ReplicatedStorage").Transform:FireServer(_G.FormName)
        end

        if EHum.Health <= 0 then
            task.wait(0.5)
            if EHum.Health <= 0 then
                KillConnection:Disconnect()
            end
        end
    end)
    repeat
        task.wait()
    until not KillConnection.Connected
end