if not game:IsLoaded() then game.Loaded:Wait() end

loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Functions%20and%20stuff.lua'),true))()

_G.AutoHTC = true

Notify("Thanks for using my script", "By Suricato006#8711")
if not (game.PlaceId == 882375367) and _G.AutoHTC then
    Notify("Teleporting to HTC")
    game:GetService("TeleportService"):Teleport(882375367, LocalPlayer)
end

spawn(function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Dragon%20Crush%20Stuck%20Final%20Stand.lua'),true))()
end)

spawn(function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/No%20Slow%20Final%20Stand.lua'),true))()
end)

local function Pugno()

    local args = {
        [1] = {
            [1] = "m2"
        },
        [2] = Player.Character.HumanoidRootPart.CFrame,
    }

    Player.Backpack.ServerTraits.Input:FireServer(unpack(args))
end

local function Rejoin()
    local Players = game.Players
    if #Players:GetPlayers() <= 1 then
        Players.LocalPlayer:Kick("\nRejoining...")
        wait()
        game:GetService('TeleportService'):Teleport(game.PlaceId, Players.LocalPlayer)
    else
        game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
    end
end

local LevelLabel = Player.PlayerGui:WaitForChild("HUD"):WaitForChild("Bottom"):WaitForChild("Stats"):WaitForChild("LVL"):WaitForChild("Val")

local CurrentLevel = 0

local function MoveSpam()
    local HasToRejoin = false
    local Moves = {"TS Molotov", "Wolf Fang Fist", "Mach Kick", "Flash Skewer", "Vital Strike", "Meteor Crash", "Neo Wolf Fang Fist","GOD Hakai","GOD Wrath","Trash","Strong Kick", "Combo Barrage", "Aerial Breaker"}
    while  _G.AutoHTC do FastWait()
        if PlayerCheck() then
            Player.Character.HumanoidRootPart.Anchored = true
            local KiPercentage = Player.Character.Ki.Value
            if KiPercentage > 32 then
                for i, v in pairs(Player.Backpack:GetChildren()) do
                    for _, Move in pairs(Moves) do
                        if v.Name == Move and PlayerCheck() then
                            v.Parent = Player.Character 
                            wait()
                            v:Activate()
                            wait()
                            v:Deactivate()
                            v.Parent = Player.Backpack
                        end
                    end
                end
            else
                Player.Backpack.ServerTraits.EatSenzu:FireServer(true)
                Pugno()
            end
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(-40, 244, 3)
        end
        if tonumber(LevelLabel.Text) == 101 or tonumber(LevelLabel.Text) == 181 or tonumber(LevelLabel.Text) == 251 or tonumber(LevelLabel.Text) == 321 and not HasToRejoin then
            HasToRejoin = true
            CurrentLevel = tonumber(LevelLabel.Text)
            spawn(function()
                while tonumber(LevelLabel.Text) == CurrentLevel do wait() end
                Notify("Rejoining...", "Wait a sec")
                Rejoin()
            end)
        end
    end
end

if (game.PlaceId == 882375367) and  _G.AutoHTC then
    while not PlayerCheck() do wait() end
    local Goku = game:GetService("Workspace").Live:GetChildren()[1]
    Player.Character.HumanoidRootPart.CFrame = CFrame.new(Goku.HumanoidRootPart.CFrame.Position - Goku.HumanoidRootPart.CFrame.LookVector/2, Goku.HumanoidRootPart.CFrame.Position)
    local v = Player.Backpack:FindFirstChild("Dragon Throw")
    if v then
        v.Parent = Player.Character 
        wait()
        v:Activate()
        wait(0.5)
        v:Deactivate()
        v.Parent = Player.Backpack
    end
    wait(0.5)
    MoveSpam()
end