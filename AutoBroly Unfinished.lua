loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Functions%20and%20stuff.lua'),true))()

_G.AutoBroly = true

local Moves = {"TS Molotov", "Wolf Fang Fist", "Mach Kick", "Flash Skewer", "Vital Strike", "Meteor Crash", "Neo Wolf Fang Fist","GOD Hakai","GOD Wrath","Trash","Strong Kick", "Combo Barrage", "Aerial Breaker"}

local RejoinTimer = 3600




local AutoExec = false
if not game:IsLoaded() then
    game.Loaded:Wait()
    AutoExec = true
end

if not AutoExec then
    Player.CharacterAdded:wait()
else
    while not PlayerCheck() do FastWait() end
end

local function ReturnToEarth()
    game:GetService("TeleportService"):Teleport(536102540, game.Players.LocalPlayer)
end

spawn(function()
    if not PlayerCheck("True") then return end
    while true do FastWait()
        local a = PlayerCheck("True")
        if a then
            a:Destroy()
        else
            return
        end
    end
end)

local Race = nil
spawn(function()
    while true do FastWait()
        local a = PlayerCheck("Race")
        if a then
            Race = a.Value
            return
        end
    end
end)

local KiMax = nil
spawn(function()
    while true do FastWait()
        local a = PlayerCheck("Ki")
        if a then
            KiMax = a.Value
            return
        end
    end
end)

spawn(function()
    while true do wait(1)
        if game:GetService("CoreGui").RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt") then 
            ReturnToEarth()
        end
    end
end)

spawn(function()
    wait(RejoinTimer)
    ReturnToEarth()
end)

spawn(function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Dragon%20Crush%20Stuck%20Final%20Stand.lua'),true))()
end)

spawn(function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/No%20Slow%20Final%20Stand.lua'),true))()
end)

local QuestLabel = WaitForMoreChilds({"PlayerGui", "HUD", "FullSize", "Quests", "TextLabel"}, Player)

if (game.PlaceId == 536102540) then
    --Hearth Setup
    local HRP = PlayerCheck()
    if HRP then
        LerpCFrame(CFrame.new(219, 46, -6381))
        local Joint = Player.Character.LowerTorso:FindFirstChild("Root")
        if Joint then
            Joint:Destroy()
        end
        wait()
        local BrolyPosition = CFrame.new(2755, 3945, -2273)
        LerpCFrame(BrolyPosition)
        while PlayerCheck() and _G.AutoBroly do FastWait()
            HRP.CFrame = BrolyPosition
            HRP.Transparency = 0
            local TimerTime = game:GetService("Workspace").BrolyTeleport:FindFirstChildWhichIsA("Model").Name
            QuestLabel.Text = "Timer: "..TimerTime
        end
    end
end

if (game.PlaceId == 2050207304) then
    for i, v in pairs(game.Players:GetChildren()) do
        if not (v.Name == Player.Name) and not (v.Name == "Broly BR") then
            ReturnToEarth()
        end
    end
    local Broly = game:GetService("Workspace").Live:GetChildren()[1]
    local HRP = PlayerCheck()

    --Bug Check
    if not (Broly.Name == "Broly BR") or ((HRP.Position - Broly.HumanoidRootPart.Position).magnitude > 5000) then
        ReturnToEarth()
    end

    spawn(function()
        while not Broly:FindFirstChild("MoveStart") and PlayerCheck() and _G.AutoBroly do FastWait()
            HRP.CFrame = CFrame.new(Broly.HumanoidRootPart.Position - Broly.HumanoidRootPart.CFrame.LookVector/2, Broly.HumanoidRootPart.Position)
        end
    end)

    spawn(function()
        while not Broly:FindFirstChild("MoveStart") and PlayerCheck() and _G.AutoBroly do FastWait()
            local Throw = Player.Backpack:WaitForChild("Dragon Crush")
            if Throw then
                Throw.Parent = Player.Character 
                Throw:Activate()
                wait(0.5)
                Throw:Deactivate()
                Throw.Parent = Player.Backpack
            end
        end
    end)

    while not Broly:FindFirstChild("MoveStart") and _G.AutoBroly do FastWait() end

    spawn(function()
        while _G.AutoBroly and PlayerCheck() do FastWait()
            HRP.CFrame = CFrame.new(-24, -127, -12)
        end
    end)

    local function Pugno()

        local args = {
            [1] = {
                [1] = "m2"
            },
            [2] = Player.Character.HumanoidRootPart.CFrame
        }
    
        Player.Backpack.ServerTraits.Input:FireServer(unpack(args))
    end

    local KiStat = PlayerCheck("Ki")
    local Android = (Race == "Android")
    local Form = false

    while _G.AutoBroly and PlayerCheck() do FastWait()
        local KiPercentage = KiStat.Value
        if Android and not Form and ((KiPercentage * 100 / KiMax) < 80) then
            wait(0.2)
            Player.Backpack.ServerTraits.Transform:FireServer("g")
            Form = true
        elseif KiPercentage > 32 then
            for i, v in pairs(Player.Backpack:GetChildren()) do
                if table.find(Moves, v.Name) and PlayerCheck() then
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

        --Broly goes bonkers prevention
        if tonumber(BrolyHealth) == 0 then
            spawn(function()
                wait(2)
                ReturnToEarth()
            end)
        end
        local Prevention = {"CanDieFin", "True", "Opos", "MoveStart", "Action"}
        for i, v in pairs(Broly:GetChildren()) do
            if table.find(Prevention, v.Name) then
                v:Destroy()
            end
        end

        Player.Backpack.ServerTraits.EatSenzu:FireServer(true)
    end
end