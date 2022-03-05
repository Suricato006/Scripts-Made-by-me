local Settings = Settings or {
    Moves = {"TS Molotov", "Wolf Fang Fist", "Mach Kick", "Flash Skewer", "Vital Strike", "Meteor Crash", "Neo Wolf Fang Fist","GOD Hakai","GOD Wrath","Trash","Strong Kick", "Combo Barrage", "Aerial Breaker"},
    AllowedPlayers = {"SgCortez", "Corteso006", "suricato006"},
    RejoinTimer = 3600
}


local AutoExec = false
if not game:IsLoaded() then
    AutoExec = true
    game.Loaded:Wait()
end

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
if AutoExec then
    Player.CharacterAdded:Wait()
end

local OwnScriptUrl = "https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Final%20Stand%20AutoBroly.lua" --https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Final%20Stand%20AutoBroly.lua
if not (OwnScriptUrl == "") then
    syn.queue_on_teleport(game:HttpGet(OwnScriptUrl))
end

local function ReturnToEarth()
    game:GetService("TeleportService"):Teleport(536102540, game.Players.LocalPlayer)
end

local HRP = Player.Character:WaitForChild("HumanoidRootPart")

local TrueDestroyed = false
RunService.Heartbeat:Connect(function()
    if TrueDestroyed then return end
    local a = Player.Character:FindFirstChild("True")
    if a then
        TrueDestroyed = true
        a:Destroy()
    end
end)

local KiMax = Player.Character:WaitForChild("Ki").Value

coroutine.wrap(function()
    wait(Settings.RejoinTimer)
    ReturnToEarth()
end)

RunService.Heartbeat:Connect(function()
    if game:GetService("CoreGui").RobloxPromptGui:FindFirstChild("ErrorPrompt", true) then
        ReturnToEarth()
    end
end)

local MoveNames = {"Action", "Attacking", "Using", "hyper", "Hyper", "heavy", "KiBlasted", "Tele", "tele", "Killed", "Slow", "Blocked", "MoveStart", "NotHardBack"}
RunService.Heartbeat:Connect(function()
    for i, v in pairs(MoveNames) do
        local a = Player.Character:FindFirstChild(v)
        if a then
            a:Destroy()
        end
    end
end)

local QuestLabel = Player:FindFirstChild("Quests", true).TextLabel

if (game.PlaceId == 536102540) then
    local PowerOutput = Player.Character:FindFirstChild("PowerOutput")
    if PowerOutput then
        PowerOutput:Destroy() 
    end
    HRP.CFrame = CFrame.new(219, 46, -6381)
    local Joint = Player.Character:FindFirstChild("Root", true)
    if Joint then
        Joint:Destroy()
    end
    wait()
    HRP.Transparency = 0
    local TimerTime = game:GetService("Workspace").BrolyTeleport:FindFirstChildWhichIsA("Model")
    local OriginalBrolyPosition = CFrame.new(2762, 3945, -2250)
    local BrolyPosition = OriginalBrolyPosition
    RunService.Heartbeat:Connect(function()
        HRP.CFrame = BrolyPosition
        QuestLabel.Text = "Timer: "..TimerTime.Name
    end)
elseif (game.PlaceId == 2050207304) then
    for i, v in pairs(game.Players:GetChildren()) do
        if not (v.Name == Player.Name) and not (v.Name == "Broly BR") and not table.find(Settings.AllowedPlayers, v.Name) then
            ReturnToEarth()
        end
    end
    local Broly = game:GetService("Workspace").Live:GetChildren()[1]
    --Bug Check
    if not (Broly.Name == "Broly BR") or ((HRP.Position - Broly.HumanoidRootPart.Position).magnitude > 5000) then
        ReturnToEarth()
    end
    Broly.Destroying:Connect(function()
        ReturnToEarth()
    end)

    local OriginalPosition = CFrame.new(Broly.HumanoidRootPart.Position - Broly.HumanoidRootPart.CFrame.LookVector/2, Broly.HumanoidRootPart.Position)

    local Connection = nil
    Connection = RunService.Heartbeat:Connect(function()
        if Broly:FindFirstChild("MoveStart") then
            Connection:Disconnect()
            return
        end
        HRP.CFrame = CFrame.new(Broly.HumanoidRootPart.Position - Broly.HumanoidRootPart.CFrame.LookVector/2, Broly.HumanoidRootPart.Position)
    end)

    local SecondConnection = nil
    SecondConnection = RunService.Heartbeat:Connect(function()
        if Broly:FindFirstChild("MoveStart") then
            SecondConnection:Disconnect()
            return
        end
        -- SISTEMA CHE STA ROBA NON FUNZIONA
        local Throw = Player.Backpack:FindFirstChild("Dragon Crush") or Player.Backpack:FindFirstChild("Dragon Throw") or Player.Backpack:WaitForChild("Dragon Throw")
        if Throw then
            Throw.Parent = Player.Character
            local b = Throw:FindFirstChild("Flip", true)
            if b then
                b:Destroy()
            end
            wait()
            Throw:Activate()
            wait()
            Throw:Deactivate()
            Throw.Parent = Player.Backpack
        end
    end)

    Broly:WaitForChild("MoveStart")

    local function Pugno()
        Player.Backpack.ServerTraits.Input:FireServer({"m2"}, HRP.CFrame)
    end
    local KiStat = Player.Character:WaitForChild("Ki")
    local Android = (Player.Character:WaitForChild("Race").Value == "Android")
    local Form = false

    RunService.Heartbeat:Connect(function()
        HRP.CFrame = CFrame.new(Broly.HumanoidRootPart.Position - Broly.HumanoidRootPart.CFrame.LookVector/2, Broly.HumanoidRootPart.Position)
        local KiPercentage = KiStat.Value
        if Android and not Form and ((KiPercentage * 100 / KiMax) < 80) then
            wait(0.2)
            Player.Backpack.ServerTraits.Transform:FireServer("g")
            Form = true
        elseif KiPercentage > 32 then
            for i, v in pairs(Player.Backpack:GetChildren()) do
                if table.find(Settings.Moves, v.Name) then
                    v.Parent = Player.Character
                    wait()
                    v:Activate()
                    wait()
                    v:Deactivate()
                    v.Parent = Player.Backpack
                end
            end
        else
            Pugno()
        end
        local BrolyHealth = tostring(math.floor(tonumber(Broly.Humanoid.Health)))
        QuestLabel.Text = "BrolyHealth: "..BrolyHealth
        Player.Backpack.ServerTraits.EatSenzu:FireServer(true)
    end)
end