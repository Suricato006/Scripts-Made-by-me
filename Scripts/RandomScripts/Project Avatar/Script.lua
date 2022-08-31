local Player = game.Players.LocalPlayer

if not getgenv().MTAPIMutex then loadstring(game:HttpGet("https://raw.githubusercontent.com/KikoTheDon/MT-Api-v2/main/__source/mt-api%20v2.lua", true))() end

game:GetService("UserInputService").JumpRequest:Connect(function()
    Player.Character:WaitForChild("Humanoid"):ChangeState("Jumping")
end)

local Bind = "V"
local Force = 400

local function ScriptSetup(Char)
    local Hrp = Char:WaitForChild("HumanoidRootPart")
    Hrp:AddPropertyEmulator("Velocity")

    local BindService = game:GetService("ContextActionService")
    BindService:BindAction(
    "Sprint",
    function(_, InputState, InputObject)
        if InputState == Enum.UserInputState.Begin then
            if  InputObject.UserInputType == Enum.UserInputType.Keyboard then
                while game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode[Bind]) do task.wait()
                    Hrp:ApplyImpulse(Hrp.CFrame.LookVector * Force/4 * Hrp.AssemblyMass)
                end
            else
                Hrp:ApplyImpulse(Hrp.CFrame.LookVector * Force * Hrp.AssemblyMass)
            end
        end
    end,
    true,
    Enum.KeyCode[Bind]
    )

    local Config = Player.Character:WaitForChild("Config")
    local Falses = {
        Config:WaitForChild("Stunned"),
        Config:WaitForChild("FullyStunned"),
        Config:WaitForChild("HitByKB"),
        Config:WaitForChild("HitByMelee"),
        Config:WaitForChild("Attacking"),
        Config:WaitForChild("AttackCooldown"),
        Config:WaitForChild("ToggleRagdoll")
    }
    for i, v in pairs(Falses) do
        v.Changed:Connect(function()
            v.Value = false
        end)
    end
end

local Char = Player.Character or Player.CharacterAdded:Wait()
ScriptSetup(Char)
Player.CharacterAdded:Connect(ScriptSetup)

--[[Feature 1: Auto Farm (not necessary if add speed script)
Feature 2: No Cooldown
Feature 3: Speed or Flight
Feature 4: Redeem All Codes
Feature 5: Hitbox
Feature 6: Anti Cheat Bypass (Important)
]]


--Player.Character.Humanoid.WalkSpeed = 50

--[[ Player.Character.Humanoid:AddPropertyEmulator("WalkSpeed")
Player.Character.Humanoid:AddPropertyEmulator("JumpPower")

Player.Character.Humanoid.WalkSpeed = 100 --Change to whatever you want
Player.Character.Humanoid.JumpPower = 260 --Change to whatever you want ]]