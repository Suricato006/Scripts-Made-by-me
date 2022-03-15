Settings = Settings or {
    Moves = {"TS Molotov", "Wolf Fang Fist", "Mach Kick", "Flash Skewer", "Vital Strike", "Meteor Crash", "Neo Wolf Fang Fist","GOD Hakai","GOD Wrath","Trash","Strong Kick", "Combo Barrage", "Aerial Breaker"}
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

local OwnScriptUrl = "https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/AutoHTC%20final%20stand.lua"
if syn then
    Player.OnTeleport:Connect(function(State)
        if State == Enum.TeleportState.Started then
            syn.queue_on_teleport(game:HttpGet(OwnScriptUrl))
        end
    end)
end

local HRP = Player.Character:WaitForChild("HumanoidRootPart")
local KiStat = Player.Character:WaitForChild("Ki")

local TrueDestroyed = false
RunService.Heartbeat:Connect(function()
    if TrueDestroyed then return end
    local a = Player.Character:FindFirstChild("True")
    if a then
        TrueDestroyed = true
        a:Destroy()
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

local function Rejoin()
    local Players = game.Players
    if #Players:GetPlayers() <= 1 then
        Players.LocalPlayer:Kick("\nRejoining...")
        task.wait()
        game:GetService('TeleportService'):Teleport(game.PlaceId, Players.LocalPlayer)
    else
        game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
    end
end

RunService.Heartbeat:Connect(function()
    if game:GetService("CoreGui").RobloxPromptGui:FindFirstChild("ErrorPrompt", true) then
        Rejoin()
    end
end)

spawn(function()
    local Library = loadstring(game:HttpGet("https://pastebin.com/raw/GX28T0pH", true))()
    local Credits = Library:CreateWindow("Credits")

    Credits:AddLabel({text = "Who Created This Gui?"})

    Credits:AddLabel({text = "CrabGuy#8711"})

    Credits:AddLabel({text = "Nevertrack#4219"})

    Credits:AddLabel({text = "----DiscordServer----"})

    Credits:AddLabel({text = "discord.gg/5NYqSVwH9Q"})

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

if not (game.PlaceId == 882375367) then
    local EarthMessage = Instance.new("Message", game:GetService("CoreGui"))
    EarthMessage.Text = "Teleporting to HTC"
    game:GetService("TeleportService"):Teleport(882375367, Player)
end

if (game.PlaceId == 882375367) then
    local Goku = game:GetService("Workspace").Live:GetChildren()[1]
    local Throw = Player.Backpack:FindFirstChild("Dragon Crush") or Player.Backpack:FindFirstChild("Dragon Throw") or Player.Backpack:WaitForChild("Dragon Throw", 5)
    while (not Goku:FindFirstChild("MoveStart")) do
        HRP.CFrame = CFrame.new(Goku.HumanoidRootPart.Position - Goku.HumanoidRootPart.CFrame.LookVector/2, Goku.HumanoidRootPart.Position)
        if not Throw then
            local ThrowMessage = Instance.new("Message", game:GetService("CoreGui"))
            ThrowMessage.Text = "You need to have Dragon Crush or Dragon Throw, rejoin and buy it"
            return
        end
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

        local args = {
            [1] = {
                [1] = "m2"
            },
            [2] = Player.Character.HumanoidRootPart.CFrame,
        }

        Player.Backpack.ServerTraits.Input:FireServer(unpack(args))
    end

    local function UseMove(Move)
        Move.Parent = Player.Character
        task.wait()
        Move:Activate()
        task.wait()
        Move:Deactivate()
        Move.Parent = Player.Backpack
    end

    local GokuPosition = CFrame.new(Goku.HumanoidRootPart.Position - Goku.HumanoidRootPart.CFrame.LookVector/2, Goku.HumanoidRootPart.Position)
    local LevelLabel = Player.PlayerGui:WaitForChild("HUD"):WaitForChild("Bottom"):WaitForChild("Stats"):WaitForChild("LVL"):WaitForChild("Val")
    local SenzuLabel = Player.PlayerGui:FindFirstChild("Senzu", true)
    local LevelsToRejoin = {100, 180, 250, 320}
    local ActualLevelToRejoin = {101, 181, 251, 321}

    local Returning = false

    while true do
        local KiValue = KiStat.Value
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
        Player.Character.HumanoidRootPart.Anchored = true
        HRP.CFrame = GokuPosition
        if (SenzuLabel.Image == "rbxassetid://1228105947") or (SenzuLabel.Image == "rbxassetid://1228105406") then
            Player.Backpack.ServerTraits.EatSenzu:FireServer(true)
        end

        if (table.find(LevelsToRejoin, tonumber(LevelLabel.Text))) and not Returning then
            Returning = true
        end
        if Returning then
            if (table.find(ActualLevelToRejoin, tonumber(LevelLabel.Text))) then
               Rejoin()
            end
        end
    end
end