loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Functions%20and%20stuff.lua'),true))()

_G.AutoBroly = true

if not game:IsLoaded() then game.Loaded:Wait() end

spawn(function()
    if not PlayerCheck("True") then return
    while true do FastWait()
        local a = PlayerCheck("True")
        if a then
            a:Destroy()
        else
            return
        end
    end
end)

spawn(function()
    while true do wait(1)
        if game:GetService("CoreGui").RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt") then 
            game:GetService("TeleportService"):Teleport(536102540, LocalPlayer)
        end
    end
end)

spawn(function()
    wait(360)
    game:GetService("TeleportService"):Teleport(536102540, game.Players.LocalPlayer)
end)

spawn(function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Dragon%20Crush%20Stuck%20Final%20Stand.lua'),true))()
end)

spawn(function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/No%20Slow%20Final%20Stand.lua'),true))()
end)

while not PlayerCheck() do wait() end

local QuestLabel = Player:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("FullSize"):WaitForChild("Quests"):WaitForChild("TextLabel")

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

local Moves = {"TS Molotov", "Wolf Fang Fist", "Mach Kick", "Flash Skewer", "Vital Strike", "Meteor Crash", "Neo Wolf Fang Fist","GOD Hakai","GOD Wrath","Trash","Strong Kick", "Combo Barrage", "Aerial Breaker"}

if (game.PlaceId == 2050207304) then
    local Broly = game:GetService("Workspace").Live:GetChildren()[1]
    local HRP = PlayerCheck()

    --Bug Check
    if not (Broly.Name == "Broly BR") or ((HRP.Position - Broly.HumanoidRootPart.Position).magnitude > 5000) then
        game:GetService("TeleportService"):Teleport(536102540, game.Players.LocalPlayer)
    end

    HRP.CFrame = CFrame.new(Broly.HumanoidRootPart.Position + Broly.HumanoidRootPart.CFrame.LookVector/2, Broly.HumanoidRootPart.Position)

    spawn(function()
        while _G.AutoBroly and PlayerCheck() do FastWait()
            HRP.CFrame = CFrame.new(-20, -127, -15)
        end
    end)

    local Throw = Player.Backpack:FindFirstChild("Dragon Throw")
    if Throw then
        Throw.Parent = Player.Character 
        Throw:Activate()
        wait(0.5)
        Throw:Deactivate()
        Throw.Parent = Player.Backpack
    end

    local function Pugno()

        local args = {
            [1] = {
                [1] = "m2"
            },
            [2] = Player.Character.HumanoidRootPart.CFrame,
        }
    
        Player.Backpack.ServerTraits.Input:FireServer(unpack(args))
    end

    local KiStat = Player.Character:WaitForChild("Ki")

    while _G.AutoBroly and PlayerCheck() do FastWait()
        local KiPercentage = KiStat.Value
        if KiPercentage > 32 then
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
        QuestLabel.Text = "BrolyHealth: "..Broly.Humanoid.Health
        Player.Backpack.ServerTraits.EatSenzu:FireServer(true)
    end
end