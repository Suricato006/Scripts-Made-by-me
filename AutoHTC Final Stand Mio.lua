if not game:IsLoaded() then game.Loaded:Wait() end

loadstring(game:HttpGet(('https://pastebin.com/raw/5ksZRmMp'),true))()

_G.AutoHTC = true

Notify("Thanks for using my script", "By Suricato006#8711")
if not game.PlaceId == 882375367 and _G.AutoHTC then
    Notify("Teleporting to HTC")
    game:GetService("TeleportService"):Teleport(882375367, LocalPlayer)
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

spawn(function()
    while _G.AutoHTC do FastWait()
        if PlayerCheck() then
            local a = Player.Character:FindFirstChild("Dragon Crush") or Player.Character:FindFirstChild("Dragon Throw")
            if a then
                local b = a:FindFirstChild("Activator")
                if b then
                    local c = b:FindFirstChild("Flip")
                    if c then
                        c:Destroy()
                    end
                end
            end
        end
    end
end)

spawn(function()
    local Names = {"Slow", "Using", "hyper", "Action", "Attacking", "heavy"}
    while _G.AutoHTC do FastWait()
        if PlayerCheck() then
            for i, v in pairs(Names) do
                local a = Player.Character:FindFirstChild(v)
                if a then
                    a:Destroy()
                end
            end
        end
    end
end)

local LevelLabel = Player.PlayerGui:WaitForChild("HUD"):WaitForChild("Bottom"):WaitForChild("Stats"):WaitForChild("LVL"):WaitForChild("Val")

local function MoveSpam()
    local Moves = {"TS Molotov", "Wolf Fang Fist", "Mach Kick", "Flash Skewer", "Vital Strike", "Meteor Crash", "Neo Wolf Fang Fist", "Combo Barrage", "Aerial Breaker"}
    while _G.AutoHTC do FastWait()
        if PlayerCheck() then
            Player.Character.HumanoidRootPart.Anchored = true
            local KiPercentage = Player.Character.Ki.Value/Player.Character.Stats["Ki-Max"].Value * 100
            print(KiPercentage)
            if KiPercentage > 10 then
                for i, v in pairs(Player.Backpack:GetChildren()) do
                    for _, Move in pairs(Moves) do
                        if v.Name == Move and PlayerCheck() then
                            v.Parent = Player.Character 
                            FastWait()
                            v:Activate()
                            FastWait()
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
        if tonumber(LevelLabel.Text) == 101 or tonumber(LevelLabel.Text) == 181 or tonumber(LevelLabel.Text) == 251 or tonumber(LevelLabel.Text) == 321 then
            Notify("Rejoining...", "Wait a sec")
            local Players = game.Players
            if #Players:GetPlayers() <= 1 then
                Players.LocalPlayer:Kick("\nRejoining...")
                wait()
                game:GetService('TeleportService'):Teleport(game.PlaceId, Players.LocalPlayer)
            else
                game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
            end
        end
    end
end

if game.PlaceId == 882375367 and _G.AutoHTC then
    while not PlayerCheck() do wait() end
    local Goku = game:GetService("Workspace").Live:GetChildren()[1]
    Player.Character.HumanoidRootPart.CFrame = CFrame.new(Goku.HumanoidRootPart.CFrame.Position - Goku.HumanoidRootPart.CFrame.LookVector/2, Goku.HumanoidRootPart.CFrame.Position)
    local v = Player.Backpack:FindFirstChild("Dragon Throw")
    if v then
        v.Parent = Player.Character 
        FastWait()
        v:Activate()
        wait(0.5)
        v:Deactivate()
        v.Parent = Player.Backpack
    end
    wait(0.5)
    MoveSpam()
end