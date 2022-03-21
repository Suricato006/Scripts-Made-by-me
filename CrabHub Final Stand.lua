    local AutoExec = false
    if not game:IsLoaded() then
        AutoExec = true
        game.Loaded:Wait()
    end

    local Player = game.Players.LocalPlayer
    local Players = game:GetService("Players")
    local HttpService = game:GetService("HttpService")

    local DefaultSettings = {}

    local DeleteConfig = false
    local FileName = "Crab.hub"

    local OwnScriptUrl = ""
    if syn then
        Player.OnTeleport:Connect(function(State)
            if State == Enum.TeleportState.Started and not (OwnScriptUrl == "") then
                syn.queue_on_teleport(game:HttpGet(OwnScriptUrl))
            end
        end)

        if isfile(FileName) then
            _G.CrabHub = _G.CrabHub or HttpService:JSONDecode(readfile(FileName))
        end

        Players.PlayerRemoving:Connect(function(PlayerRemoved)
            if (PlayerRemoved == Player) and not DeleteConfig then
                writefile(FileName, HttpService:JSONEncode(_G.CrabHub))
            end
        end)
    end

    _G.CrabHub = _G.CrabHub or DefaultSettings

    if AutoExec then
        Player.CharacterAdded:Wait()
    end

    local Library = loadstring(game:HttpGet("https://pastebin.com/raw/GX28T0pH", true))()
    local Main = Library:CreateWindow("CrabHub")
    local Utilities = Main:AddFolder("Utilities")
    local AutoFarmFolder = Main:AddFolder("AutoFarm")

    local Names = {"Action", "Attacking", "Using", "hyper", "Hyper", "heavy", "KiBlasted", "Tele", "tele", "Killed", "Slow", "Blocked", "MoveStart", "NotHardBack"}
    local NoSlowToggle = Utilities:AddToggle({text = "No Slow", state = _G.CrabHub.NoSlow, callback = function(bool)
        _G.CrabHub.NoSlow = bool
        while _G.CrabHub.NoSlow do task.wait()
            if Player.Character:FindFirstChild("HumanoidRootPart") then
                for i, v in pairs(Names) do
                    local a = Player.Character:FindFirstChild(v)
                    if a then
                        a:Destroy()
                    end
                end
            end
        end
    end})

    Utilities:AddToggle({text = "Throw Stuck", state = _G.CrabHub.ThrowStuck, callback = function(bool)
        _G.CrabHub.ThrowStuck = bool
        while _G.CrabHub.ThrowStuck do task.wait()
            local Throw = Player.Character:FindFirstChild("Dragon Crush") or Player.Character:FindFirstChild("Dragon Throw")
            if Player.Character:FindFirstChild("HumanoidRootPart") and Throw then
                local a = Throw:FindFirstChild("Flip", true)
                if a then
                    a:Destroy()
                end
            end
        end
    end})
    local Moves = {
        "Deadly Dance",
        "Anger Rush",
        "Meteor Crash",
        "TS Molotov",
        "Flash Skewer",
        "Vital Strike",
        "Demon Flash",
        "Wolf Fang Fist",
        "Neo Wolf Fang Fist",
        "Strong Kick"
    }
    local function UseMove(Move)
        Move.Parent = Player.Character
        task.wait()
        Move:Activate()
        task.wait()
        Move:Deactivate()
        Move.Parent = Player.Backpack
    end
    local function Pugno()
        Player.Backpack.ServerTraits.Input:FireServer({"m2"}, Player.Character.HumanoidRootPart.CFrame)
    end
    local function FindNpc()
        for i, v in pairs(workspace.Live:GetChildren()) do
            if string.find(v.Name, _G.CrabHub.NpcToFarm) and (v.Humanoid.Health > 0) then
                return v
            end
        end
        return nil
    end

    AutoFarmFolder:AddToggle({text = "AutoFarm", state = _G.CrabHub.AutoFarm, callback = function(bool)
        _G.CrabHub.AutoFarm = bool
        while _G.CrabHub.AutoFarm do
            local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
            local KiStat = Player.Character:FindFirstChild("Ki")
            if HRP and KiStat then
                local Npc = FindNpc()
                if Npc then
                    while _G.CrabHub.AutoFarm do
                        if (Npc.Humanoid.Health > 0) then
                            if ((HRP.Position - Npc.HumanoidRootPart.Position).magnitude <= 900) then
                                HRP.CFrame = CFrame.new(Npc.HumanoidRootPart.Position - Npc.HumanoidRootPart.CFrame.LookVector, Npc.HumanoidRootPart.Position)
                                if _G.CrabHub.UseMoves then
                                    if (KiStat.Value > 32) then
                                        for i, v in pairs(Player.Backpack:GetChildren()) do
                                            if table.find(Moves, v.Name) then
                                                UseMove(v)
                                            end
                                        end
                                    else
                                        Pugno()
                                        task.wait()
                                    end
                                else
                                    Pugno()
                                    task.wait()
                                end
                            else
                                local tween = game:GetService("TweenService"):Create(HRP, TweenInfo.new(1), {CFrame = Npc.HumanoidRootPart.CFrame})
                                tween:Play()
                                while (tween.PlaybackState == Enum.PlaybackState.Playing) do task.wait()
                                    if ((HRP.Position - Npc.HumanoidRootPart.Position).magnitude <= 500) then
                                        tween:Cancel()
                                        break
                                    end
                                end
                            end
                        else
                            break
                        end
                    end
                end
            end
            task.wait()
        end
    end})

    local NpcToFarmBox = AutoFarmFolder:AddBox({text = "NpcToFarm", value = _G.CrabHub.NpcToFarm or "", callback = function(typed)
        _G.CrabHub.NpcToFarm = typed
    end})

    AutoFarmFolder:AddToggle({text = "UseMoves", state = _G.CrabHub.UseMoves, callback = function(bool)
        _G.CrabHub.UseMoves = bool
    end})

    AutoFarmFolder:AddButton({text = "Load Suggested Farm", callback = function()
        NpcToFarmBox:SetValue("Evil")
    end})

    if syn then
        Main:AddButton({text = "Delete Configuration", callback = function()
            if isfile(FileName) then
                delfile(FileName)
                DeleteConfig = true
            end
        end})
    end

    Main:AddButton({text = "Destroy Gui", callback = function()
        Library:Close()
    end})



    local Credits = Library:CreateWindow("Credits")

    Credits:AddLabel({text = "Who Created This Gui?"})

    Credits:AddLabel({text = "CrabGuy#8711"})

    Credits:AddLabel({text = "Nevertrack#4219"})

    Credits:AddLabel({text = "----DiscordServer----"})

    Credits:AddLabel({text = "discord.gg/5NYqSVwH9Q"})

    Credits:AddButton({text = "Join Discord Server", callback = function()
        pcall(function()
            syn.write_clipboard("https://discord.gg/5NYqSVwH9Q")
        end)
        local req = syn and syn.request or HttpService and HttpService.request or http_request or fluxus and fluxus.request or getgenv().request or request
        if req then
            req({
                Url = 'http://127.0.0.1:6463/rpc?v=1',
                Method = 'POST',
                Headers = {
                    ['Content-Type'] = 'application/json',
                    Origin = 'https://discord.com'
                },
                Body = HttpService:JSONEncode({
                    cmd = 'INVITE_BROWSER',
                    nonce = HttpService:GenerateGUID(false),
                    args = {code = '5NYqSVwH9Q'}
                })
            })
        end
    end})

    Library:Init()
