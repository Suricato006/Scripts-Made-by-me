local NpcName = "Ajeje"


if not game:IsLoaded() then game.Loaded:Wait() end
local Player = game.Players.LocalPlayer
if not Player.Character then
    Player.CharacterAdded:Wait()
    task.wait(0.5)

    local args = {
        [1] = "OpenRengoku"
    }

    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    local args = {
        [1] = "SetTeam",
        [2] = "Marines"
    }

    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))

    task.wait(1.5)
end

coroutine.wrap(function()
    local StopCamera = require(game.ReplicatedStorage.Util.CameraShaker)StopCamera:Stop()
   for v,v in pairs(getreg()) do
        if typeof(v) == "function" and getfenv(v).script == Player.PlayerScripts.CombatFramework then
            for v,v in pairs(debug.getupvalues(v)) do
                if typeof(v) == "table" then
                    spawn(function()
                        game:GetService("RunService").RenderStepped:Connect(function()
                            pcall(function()
                                v.activeController.timeToNextAttack = -(9e9)
                                v.activeController.attacking = false
                                v.activeController.increment = 4
                                v.activeController.blocking = false
                                v.activeController.hitboxMagnitude = 150
                                v.activeController.humanoid.AutoRotate = true
                                v.activeController.focusStart = 0
                                v.activeController.currentAttackTrack = 0
                                sethiddenproperty(Player, "SimulationRaxNerous", math.huge)
                            end)
                        end)
                    end)
                end
            end
        end
   end
end)()

