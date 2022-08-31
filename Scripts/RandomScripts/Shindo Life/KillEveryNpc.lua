local Player = game.Players.LocalPlayer
local TweenService = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/OptimizedTweenLibrary.lua"))()

local TimeItTakes = 10

local Camera = workspace:FindFirstChildWhichIsA("Camera")

for i, v in pairs(workspace.npc:GetChildren()) do
    if not (v.Name == "logtraining") then
        local NpcName = v.Name
        while v:FindFirstAncestor(workspace.Name) do
            local Hrp = Player.Character:WaitForChild("HumanoidRootPart")
            local NpcHrp = v:WaitForChild("HumanoidRootPart", 2)
            if not NpcHrp then
                break
            end
            local NpcPos = NpcHrp.Position
            if NpcPos.Y <= -1000 then
                break
            end
            if (Hrp.Position - NpcPos).Magnitude > 100 then
                local Tween = TweenService:Create(Hrp, TimeItTakes, {CFrame = NpcHrp.CFrame})
                Tween:Play()
                wait(TimeItTakes)
            else
                task.wait()
                Camera.CameraType = Enum.CameraType.Scriptable
                Camera.CFrame = CFrame.new(NpcPos + Vector3.new(0, 10, 0), NpcPos)
                Hrp.CFrame = CFrame.new(NpcPos + Vector3.new(0, -10, 0), NpcPos)
                Player.Character.combat.update:FireServer("key", "e")
                Player.Character.combat.update:FireServer("key", "eend")
                Player.Character.combat.update:FireServer("mouse1", true)
                Player.Character.combat.update:FireServer("mouse1", false)
            end
            local NpcHum = v:WaitForChild("Humanoid", 2)
            if not NpcHum then
                break
            end
            NpcHum.Health = 0
        end
    end
end

Camera.CameraType = Enum.CameraType.Custom