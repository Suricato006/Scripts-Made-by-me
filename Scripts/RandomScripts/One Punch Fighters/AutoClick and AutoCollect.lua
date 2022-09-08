_G.ScriptRunning = not _G.ScriptRunning

local Player = game:GetService("Players").LocalPlayer

local InputLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/InputFunctions%20Library.lua"))()

--[[ for i, v in pairs(workspace:GetDescendants()) do
    if v:IsA("BasePart") and ((v.Position - Player.Character:WaitForChild("HumanoidRootPart").Position).Magnitude <= 10) then
        print(v.Name, v.Parent)
    end
end ]]

local Exclude = {"CollisionPart", "HitEffect"}
coroutine.wrap(function()
    local A = nil
    A = game:GetService("RunService").Heartbeat:Connect(function()
        if not _G.ScriptRunning then
            A:Disconnect()
        end
        for i, v in pairs(workspace["__Cache"]:GetChildren()) do
            if not table.find(Exclude, v.Name) then
                v.CanCollide = false
                v.CFrame = Player.Character:WaitForChild("HumanoidRootPart").CFrame
                local a = v:FindFirstChild("BillboardGui")
                if a and a.Enabled then
                    a.Enabled = false
                end
            end
        end
    end)
end)()

local C = nil
C = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
    if not _G.ScriptRunning then
        C:Disconnect()
    end
    if (not gameProcessedEvent) and (input.KeyCode == Enum.KeyCode.V) then
        _G.AutoClick = not _G.AutoClick
    end
end)

while _G.ScriptRunning do task.wait(0.15)
    if _G.AutoClick then
        InputLibrary.CenterMouseClick()
    end
end