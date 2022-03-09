local Settings = Settings or {
    AllowedPlayers = {"SgCortez", "Corteso006", "suricato006"},
    RejoinTimer = 3600,
    TimeToWaitForForm = 3.9,
    Form = "h",
    Anchored = true,
    Moves = {
        "Deadly Dance",
        'Blaster Meteor',
        "Trash???",
        "Anger Rush",
        "Meteor Crash",
        "TS Molotov",
        "Flash Skewer",
        "Vital Strike",
        "Demon Flash",
        "Wolf Fang Fist",
        "Neo Wolf Fang Fist",
        "Trash?",
        "Strong Kick",
        "Strong Kick"
    }
}

local Dumb = true
if (Settings.Form == "h") or (Settings.Form == "h") then
    Dumb = false
end
if Dumb then
    warn("ofmg how did you mess up something so simple")
    Settings.Form = "h"
end

--[[
    Settings Explanation:
    **MOVES**
        The moves are customizable and you can add as much as you want. Just add a , and the name of the move between quotations (examples are provvided above).
        Also the default ones are the best but feel free to customise
    **ALLOWEDPLAYERS**
        The name of the players that can join the broly with you (its a lag free method not like other shitty anti-leach).
        The method to add more players is the same as the moves: Just add a , and the name of the move between quotations (examples are provvided above).
    **REJOINTIMER**
        After the set ammount of time you will go back to earth to prevent strange bugs and stuff
        (If the game crashes or other shit then you also rejoin automatically)
        Note: the time is in seconds.
    **FORM**
        If you are not an android then you go in form, add a TimeToWaitForForm in seconds and you will charge for that ammount of time.
        The form as to be either "g" or "h" otherwhise it wont work proprely.
        If you are an android then no problem at all, stuff doesnt apply.
    **ANCHORED**
        Blocks your character when doing the broly
    **GENEAL STUFF**
        The autobroly was made by me (uwu) and it is open source so people can learn from it, its honestly one of the best and more optimized out there (its not obfuscated so even memory is fine.)
        Luv u for using my broly and actually reading the source code stuff.


    Feel free to take parts of my autobroly but give credits (not as it happened with my GUI -_-)
    The discord server is the following: https://discord.gg/5NYqSVwH9Q
    Credit the discord server and join for some fun/help


    Much love :v:

]]

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

spawn(function()
    local Library = loadstring(game:HttpGet("https://pastebin.com/raw/GX28T0pH", true))()
    local Credits = Library:CreateWindow("Credits")

    Credits:AddLabel({text = "Who Created This Gui?"})

    Credits:AddLabel({text = "CrabGuy#8711"})

    Credits:AddLabel({text = "Nevertrack#4219"})

    local DiscordServer = Credits:AddFolder("DiscordServer")

    DiscordServer:AddLabel({text = "https://discord.gg/5NYqSVwH9Q"})

    Credits:AddButton({text = "Join Discord Server", callback = function()
        local http = game:GetService('HttpService')
        pcall(function()
            syn.write_clipboard("https://discord.gg/5NYqSVwH9Q")
        end)
        local req = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request
        if req then
            req({
                Url = 'http://127.0.0.1:6463/rpc?v=1',
                Method = 'POST',
                Headers = {
                    ['Content-Type'] = 'application/json',
                    Origin = 'https://discord.com'
                },
                Body = http:JSONEncode({
                    cmd = 'INVITE_BROWSER',
                    nonce = http:GenerateGUID(false),
                    args = {code = '5NYqSVwH9Q'}
                })
            })
        end
    end})

    Library:Init()
end)

local function ReturnToEarth()
    game:GetService("TeleportService"):Teleport(536102540, game.Players.LocalPlayer)
end

local OwnScriptUrl = "https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Final%20Stand%20AutoBroly.lua"
if syn then
    Player.OnTeleport:Connect(function(State)
        if State == Enum.TeleportState.Started then
            syn.queue_on_teleport(game:HttpGet(OwnScriptUrl))
        end
    end)
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

spawn(function()
    wait(Settings.RejoinTimer)
    ReturnToEarth()
end)

local Insults = {"Damn bro, Z-Shuko scripts roblox in python bro", "Sypse dont steal my jokes", "Chris is a cool guy", "Cake autobroly is sooo bad :kekw:", "DiscoServer: .gg/5NYqSVwH9Q", "Nevertrack, what a clown", "Damn bro, Crab looks so fine, DRIP"}

spawn(function()
    while true do
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Insults[math.random(1,#Insults)], "All")
        task.wait(1)
    end
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

if (game.PlaceId == 536102540) then
    local PowerOutput = Player.Character:FindFirstChild("PowerOutput")
    if PowerOutput then
        PowerOutput:Destroy()
    end
    task.wait()
    local TimerTime = game:GetService("Workspace").BrolyTeleport:FindFirstChildWhichIsA("Model")
    local BrolyPosition = CFrame.new(2762, 3945, -2250)
    RunService.Heartbeat:Connect(function()
        HRP.CFrame = BrolyPosition
    end)
elseif (game.PlaceId == 2050207304) then
    for i, v in pairs(game.Players:GetChildren()) do
        if not (v.Name == Player.Name) and not (v.Name == "Broly BR") and not table.find(Settings.AllowedPlayers, v.Name) then
            ReturnToEarth()
        end
    end
    local Broly = game:GetService("Workspace").Live:GetChildren()[1]

    if not (Broly.Name == "Broly BR") then
        ReturnToEarth()
    end

    while (not Broly:FindFirstChild("MoveStart")) do
        HRP.CFrame = CFrame.new(Broly.HumanoidRootPart.Position - Broly.HumanoidRootPart.CFrame.LookVector/2, Broly.HumanoidRootPart.Position)
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
        task.wait()
    end

    local function Pugno()
        Player.Backpack.ServerTraits.Input:FireServer({"m2"}, HRP.CFrame)
    end
    local KiStat = Player.Character:WaitForChild("Ki")
    local KiMax = KiStat.Value
    local Android = (Player.Character:WaitForChild("Race").Value == "Android")
    local Form = false
    local TransformEvent = Player.Backpack.ServerTraits.Transform
    local InputEvent = Player:FindFirstChild("Input", true)
    local Humanoid = Player.Character.Humanoid
    local MaxHealth = Humanoid.MaxHealth
    local GodForm = false

    local function UseMove(Move)
        Move.Parent = Player.Character
        task.wait()
        Move:Activate()
        task.wait()
        Move:Deactivate()
        Move.Parent = Player.Backpack
    end

    local BrolyPosition = CFrame.new(Broly.HumanoidRootPart.Position - Broly.HumanoidRootPart.CFrame.LookVector/2, Broly.HumanoidRootPart.Position)

    while true do
        local KiValue = KiStat.Value
        local KiPercentage = KiValue * 100 / KiMax
        if not Form then
            if Android then
                if (KiPercentage < 70) then
                    task.wait(0.2)
                    TransformEvent:FireServer("g")
                    Form = true
                end
            else
                if InputEvent and TransformEvent then
                    InputEvent:FireServer({[1] = "x"},CFrame.new(0,0,0),nil,false)
                    task.wait(Settings.TimeToWaitForForm)
                    TransformEvent:FireServer(Settings.Form)
                    task.wait(1)
                    InputEvent:FireServer({[1] = "xoff"},CFrame.new(0,0,0),nil,false)
                    Form = true
                end
            end
        end
        if KiValue > 32 then
            for i, v in pairs(Player.Backpack:GetChildren()) do
                if table.find(Settings.Moves, v.Name) then
                    UseMove(v)
                end
            end
        else
            Pugno()
            task.wait()
        end
        if (KiPercentage < 5) and ((Humanoid.Health * 100 / MaxHealth) < 15) and not GodForm then
            task.wait(0.2)
            TransformEvent:FireServer("g")
            GodForm = true
        end
        local BrolyHealth = math.floor(Broly.Humanoid.Health)
        Player.Backpack.ServerTraits.EatSenzu:FireServer(true)
        if (BrolyHealth == 0) and (Broly.HumanoidRootPart.Transformation3.Enabled == true) then
            ReturnToEarth()
        end
        if Settings.Anchored then
            Player.Character.HumanoidRootPart.Anchored = true
            HRP.CFrame = BrolyPosition
        else
            HRP.CFrame = CFrame.new(Broly.HumanoidRootPart.Position - Broly.HumanoidRootPart.CFrame.LookVector/2, Broly.HumanoidRootPart.Position)
        end
    end
end