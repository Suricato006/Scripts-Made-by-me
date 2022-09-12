if not game:IsLoaded() then
    game.Loaded:Wait()
end

_G.AutoFarm = not _G.AutoFarm
_G.NpcName = "Goku Black"
_G.FormName = "final form"

local Player = game.Players.LocalPlayer

local function Pugno()
    game:GetService("ReplicatedStorage").Combat:FireServer("comboAttack")
end

local ActualNpcName = nil
local ActualParent = nil

local function NpcCheck(Npc)
    if not Npc:IsA("Model") or not Npc:FindFirstChild("Humanoid") or (Npc.Humanoid.Health <= 0) then
        return
    end
    if string.find(Npc.Name:lower(), _G.NpcName:lower()) == 1 then
        return Npc.Name, Npc.Parent
    end
end

for i, v in pairs(workspace:GetDescendants()) do
    ActualNpcName, ActualParent = NpcCheck(v)
    if ActualParent and ActualParent then
        break
    end
end
if not ActualNpcName or not ActualParent then
    local Connection = nil
    Connection = workspace.DescendantAdded:Connect(function(v)
        ActualNpcName, ActualParent = NpcCheck(v)
        if ActualNpcName and ActualParent then
            Connection:Disconnect()
        end
    end)
end
repeat
    task.wait()
until ActualNpcName and ActualParent

local A = nil
A = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
    if not _G.AutoFarm then
        A:Disconnect()
    end
    if not gameProcessedEvent and input.KeyCode == Enum.KeyCode.C then
        local Enemy = ActualParent:WaitForChild(ActualNpcName)
        if isnetworkowner and Enemy:FindFirstChild("HumanoidRootPart") and isnetworkowner(Enemy:FindFirstChild("HumanoidRootPart")) then
            Enemy:WaitForChild("Humanoid").Health = 0
        else
            Enemy:WaitForChild("Humanoid").Health = 0
        end
    end
end)

local Transformed = false
while _G.AutoFarm do task.wait()
    local Enemy = ActualParent:WaitForChild(ActualNpcName)
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
        Hrp.CFrame = CFrame.new(EHrp.CFrame.Position + (EHrp.CFrame.LookVector * (math.ceil(EHrp.Size.Z))) * 2, EHrp.CFrame.Position)
        Pugno()
        if (Transformation.Value == "off") and not Transformed then
            Transformed = true
            game:GetService("ReplicatedStorage").Transform:FireServer(_G.FormName)
        end
        if EHum.Health <= 0 then
            task.wait(0.5)
            if EHum.Health <= 0 then
                Enemy:Destroy()
                KillConnection:Disconnect()
            end
        end
    end)
    repeat
        task.wait()
    until not KillConnection.Connected
end