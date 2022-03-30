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

local OwnScriptUrl = "https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/CrabHub%20Final%20Stand.lua"
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
local Teleport = Main:AddFolder("Teleport")
local Aimbot = Main:AddFolder("Aimbot")
local TeleSpeed = Main:AddFolder("Telespeed")

Utilities:AddToggle({text = "No Slow", state = _G.CrabHub.NoSlow, callback = function(bool)
    local Names = {"Action", "Attacking", "Using", "hyper", "Hyper", "heavy", "KiBlasted", "Tele", "tele", "Killed", "Slow", "Blocked", "MoveStart", "NotHardBack"}
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

local ChatChannelParentFrame = Player.PlayerGui:FindFirstChild("ChatChannelParentFrame")
if ChatChannelParentFrame then
    ChatChannelParentFrame.Visible = true
end

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

Utilities:AddToggle({text = "GodMode", state = _G.CrabHub.GodMode, callback = function(bool)
    _G.CrabHub.GodMode = bool
    while _G.CrabHub.GodMode do task.wait()
        local Animator = Player.Character:FindFirstChild("Animator", true)
        if Animator then
            local Parent = Animator.Parent
            local Animator2 = Animator:Clone()
            Animator2.Name = "Animator2"
            Animator:Destroy()
            task.wait()
            Animator2.Parent = Parent
        end
    end
end})

Utilities:AddButton({text = "Smol", callback = function()
    local Hum = Player.Character:FindFirstChild("Humanoid")
    if Hum then
        for i, v in pairs(Hum:GetChildren()) do
            if v:IsA("NumberValue") then
                v:Destroy()
            end
        end
    end
end})

Utilities:AddToggle({text = "Hide Level", state = _G.CrabHub.HideLevel, callback = function(bool)
    _G.CrabHub.HideLevel = bool
    while _G.CrabHub.HideLevel do task.wait()
        local LevelLabel = Player.Character:FindFirstChildWhichIsA("Model")
        if LevelLabel then
            LevelLabel:Destroy()
        end
    end
end})

Utilities:AddToggle({text = "Hide Wings/Halo", state = _G.CrabHub.HideWings, callback = function(bool)
    _G.CrabHub.HideWings = bool
    while _G.CrabHub.HideWings do task.wait()
        local Wings = Player.Character:FindFirstChild("RebirthWings") or Player.Character:FindFirstChild("RealHalo")
        if Wings then
            local Handle = Wings:FindFirstChild("Handle")
            if Handle then
                Handle:Destroy()
            end
        end
    end
end})

Utilities:AddToggle({text = "AntiKnockBack", state = _G.CrabHub.AntiKnockBack, callback = function(bool)
    local Names = {"BodyVelocity", "KnockBacked", "NotHardBack", "creator", "Throw", "Flip"}
    _G.CrabHub.AntiKnockBack = bool
    while _G.CrabHub.AntiKnockBack do task.wait()
        for i, v in pairs(Names) do
            local a = Player.Character:FindFirstChild(v, true)
            if a then
                a:Destroy()
            end
        end
    end
end})

Teleport:AddToggle({text = "Teleport", state = _G.CrabHub.Teleport, callback = function(bool)
    _G.CrabHub.Teleport = bool
end})

Teleport:AddBox({text = "Player or Npc To Teleport", value = _G.CrabHub.TeleportPlayerName or "", callback = function(typed)
    _G.CrabHub.TeleportPlayerName = typed
end})

Teleport:AddBind({text = "TeleportBind", key = Enum.KeyCode.KeypadPlus, hold = false, callback = function()
    if _G.CrabHub.Teleport then
        local Hrp = Player.Character:FindFirstChild("HumanoidRootPart")
        local PlayerToTp = game.Workspace.Live:FindFirstChild(_G.CrabHub.TeleportPlayerName)
        if not PlayerToTp then
            for i, v in pairs(game.Workspace.Live:GetChildren()) do
                if string.find(v.Name, _G.CrabHub.TeleportPlayerName) then
                    PlayerToTp = v
                    break
                end
            end
        end
        if PlayerToTp then
            local TpHrp = PlayerToTp:FindFirstChild("HumanoidRootPart")
            if TpHrp and Hrp then
                game:GetService("TweenService"):Create(Hrp,TweenInfo.new(_G.CrabHub.TeleportTime or 1),{CFrame = TpHrp.CFrame}):Play()
            end
        end
    end
end})

Teleport:AddSlider({text = "Time it takes", min = 1, max = 10, dual = false, value = 1, callback = function(number)
    _G.CrabHub.TeleportTime = number
end})

local function Hit(Part)
    for i, v in pairs(game.Workspace.Live:GetChildren()) do
        if _G.CrabHub.TrackedName then
            if string.find(v.Name:lower(), _G.CrabHub.TrackedName:lower()) then
                local Hrp = v:FindFirstChild("HumanoidRootPart")
                local Hum = v:FindFirstChild("Humanoid")
                if Hrp and Hum then
                    if (Hum.Health > 0) then
                        Part.CFrame = Hrp.CFrame
                    end
                end
            end
        end
    end
end

local function TableHit(Folder)
    for i, v in pairs(Folder:GetChildren()) do
        if v:FindFirstChild("Ki") and v:FindFirstChild("Mesh") then
            Hit(v)
        end
    end
end

Aimbot:AddToggle({text = "Ki attacks Aimbot", state = _G.CrabHub.Aimbot, callback = function(bool)
    _G.CrabHub.Aimbot = bool
    while _G.CrabHub.Aimbot do task.wait()
        TableHit(game.Players.LocalPlayer.Character)
        TableHit(game.Workspace.Effects)
        TableHit(game.Workspace)
        TableHit(game.Players.LocalPlayer.Character.Humanoid)
    end
end})

Aimbot:AddBox({text = "Npc or Player Name", value = _G.CrabHub.TrackedName or "", callback = function(typed)
    _G.CrabHub.TrackedName = typed
end})

TeleSpeed:AddToggle({text = "Telespeed", state = _G.CrabHub.Telespeed, callback = function(bool)
    _G.CrabHub.Telespeed = bool
end})

TeleSpeed:AddBind({text = "TelespeedBind", key = Enum.KeyCode.V, hold = true, callback = function()
    local Hrp = Player.Character:FindFirstChild("HumanoidRootPart")
    if Hrp then
        Hrp:ApplyImpulse(Hrp.CFrame.LookVector*30000)
    end
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

Credits:AddButton({text = "Became Pokimane by sypse", callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Sypse/Freescripts/main/BecomePokimane.lua", true))()
end})

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
