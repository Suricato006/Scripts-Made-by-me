loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Functions%20and%20stuff.lua'),true))()

_G.AutoFarm = true

local function Pugno(z)
    local args = {
       [1] = "UseSkill",
       [2] = {
          ["hrpCFrame"] = z.CFrame,
          ["attackNumber"] = 1
       },
       [3] = "BasicAttack"
    }
    game:GetService("ReplicatedStorage").RemoteEvents.MainRemoteEvent:FireServer(unpack(args))
end

while _G.AutoFarm do FastWait()
    for i, v in pairs(game:GetService("Workspace").Folders.Monsters:GetChildren()) do
        local EnemyHRP = v:FindFirstChild("HumanoidRootPart")
        local HRP = PlayerCheck()
        if _G.AutoFarm and EnemyHRP and not (v.Parent == nil) and HRP then
            if ((HRP.Position - EnemyHRP.Position).magnitude > 30) then
                LerpCFrame(EnemyHRP.CFrame)
            end
        end
        while _G.AutoFarm and EnemyHRP and not (v.Parent == nil) do FastWait()
            local a = PlayerCheck()
            if a then
                a.CFrame = CFrame.new(EnemyHRP.CFrame.Position + Vector3.new(0, (EnemyHRP.Size.Y * 2.2), 0), EnemyHRP.CFrame.Position)
                Pugno(a)
            else
                break
            end
        end
    end
end