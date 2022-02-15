_G.AutoFarm = true
_G.Difficulty = "Hard" --"Easy", "Hard", "Nightmare"
_G.FriendsOnly = false -- true or false
_G.Hardcore = false --true or false
_G.TimeToWaitBeforeStartsTheDungeon = 0 --Time To wait in between creating the dungeon and starting it
_G.RetryDungeon = true --true or false

local AutoExec = false
if not game:IsLoaded() then
    game.Loaded:Wait()
    AutoExec = true
end
if AutoExec then
    game.Players.LocalPlayer.CharacterAdded:wait()
else
    while not game.Players.LocalPlayer:FindFirstChild("HumanoidRootPart") do task.wait() end
end

if game.PlaceId == 6938803436 then
    local args = {
        [1] = "CreateRoom",
        [2] = {
            ["Difficulty"] = _G.Difficulty,
            ["FriendsOnly"] = false,
            ["MapName"] = "Titan Dimension",
            ["Hardcore"] = false
        }
    }

    game:GetService("ReplicatedStorage").RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))

    wait(_G.TimeToWaitBeforeStartsTheDungeon)

    local args = {
        [1] = "TeleportPlayers"
    }

    game:GetService("ReplicatedStorage").RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
    return
else
    if _G.RetryDungeon then
        spawn(function()
            while _G.AutoFarm do wait(1)
                local args = {
                    [1] = "RetryDungeon"
                }

                game:GetService("ReplicatedStorage").RemoteEvents.MainRemoteEvent:FireServer(unpack(args))
            end
        end)
    end

    local Combo = 1
    local function Pugno(a)
        Combo += 1
        local args = {
            [1] = "UseSkill",
            [2] = {
                ["hrpCFrame"] = a.CFrame,
                ["attackNumber"] = Combo
            },
            [3] = "BasicAttack"
        }
        game:GetService("ReplicatedStorage").RemoteEvents.MainRemoteEvent:FireServer(unpack(args))
        if Combo == 4 then
            Combo = 1
        end
    end

    local function NpcHealthCheck(Npc)
        local a = Npc:FindFirstChild("EnemyHealthBarGui")
        if a then
            local b = a:FindFirstChild("HealthText")
            if b then
                return tonumber(b.Text)
            end
        end
        return 0
    end

    while _G.AutoFarm do task.wait()
        for i, v in pairs(game:GetService("Workspace").Folders.Monsters:GetChildren()) do
            local EnemyHRP = v:FindFirstChild("HumanoidRootPart")
            local NpcHead = v:FindFirstChild("Head")
            local HRP = game.Players.LocalPlayer:FindFirstChild("HumanoidRootPart")
            if _G.AutoFarm and EnemyHRP and not (NpcHealthCheck(v) <= 0) and HRP and NpcHead then
                if ((HRP.Position - EnemyHRP.Position).magnitude > 30) then
                    HRP.CFrame = EnemyHRP.CFrame
                end
            end
            while _G.AutoFarm and EnemyHRP and not (NpcHealthCheck(v) <= 0) and NpcHead do task.wait()
                local a = game.Players.LocalPlayer:FindFirstChild("HumanoidRootPart")
                if a then
                    a.CFrame = CFrame.new(NpcHead.CFrame.Position + Vector3.new(0, NpcHead.Size.Y/2, 0), EnemyHRP.CFrame.Position)
                    Pugno(HRP)
                    for i=1, 4 do
                        local args = {
                            [1] = "UseSkill",
                            [2] = {
                                ["hrpCFrame"] = a.CFrame
                            },
                            [3] = i
                        }
                        game:GetService("ReplicatedStorage").RemoteEvents.MainRemoteEvent:FireServer(unpack(args))
                    end
                else
                    break
                end
            end
        end
    end
end