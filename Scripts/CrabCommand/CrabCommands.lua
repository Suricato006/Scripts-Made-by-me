--[[
    Script Made by CrabGuy (aka suricato006)

    It was made with a lot of love so dont steal it, if you wanna learn or are going to credit me then go ahead.
    If you are here checking the source code it means you really liked the script xoxo
]]

if not game:IsLoaded() then game.Loaded:Wait() end

local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/Notification%20Library%20Optimization.lua"))()
local SendNotification = NotificationLibrary.CustomNotification

local Prefix = "/e"
if _G.CrabCommand then
    SendNotification("Already Running", "Crab Commands is already running sweetie <3")
    SendNotification("Need Help?", "Are you lost and need help?", 9e9, "option", function(bool)
        if bool then
            SendNotification("Documentation", 'Type "'..Prefix..' cmds" to get a list of all the commands, ok?', 9e9, "option", function(bool2)
                if not bool2 then
                    SendNotification("（。々°）", "Dumbass", 9e9)
                else
                    SendNotification("( ˘͈ ᵕ ˘͈♡)", "Good Job sweethearth")
                end
            end)
        end
    end)
    return
end
_G.CrabCommand = true

local Version = loadstring(game:HttpGet('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Scripts/CrabCommand/CommandVersion.lua'))()
local LastVersion = 1.0
if not (Version == LastVersion) then
    SendNotification("OutDated", "The script is outdated\nplease use the loadstring to get the new version", 30)
end

local Player = game:GetService("Players").LocalPlayer
local Camera = workspace:FindFirstChildWhichIsA("Camera")
local RunService = game:GetService("RunService")
local TweenService = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/OptimizedTweenLibrary.lua"))()

local Commands = {}
local CommandStates = {}
local GamesSupported = {
    FinalStand = {536102540, 882399924, 478132461, 569994010, 2046990924, 3565304751, 2651456105, 3552157537, 2050207304, 535527772, 3552158750, 3618359401, 489979581, 566006798, 882375367}
}
SendNotification("CrabCommands", 'Thanks for using the script.\nType "'..Prefix..' cmds" to get a list of all the commands', 10)
local GameDetected = nil
for i, v in pairs(GamesSupported) do
    if table.find(v, game.PlaceId) then
        GameDetected = tostring(i)
    end
end
if GameDetected then
    SendNotification("Gamde Supported", "Detected: "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
end
local function FindPlayer(PlayerName)
    for _, v in pairs(game.Players:GetChildren()) do
        if v.Name:lower():find(PlayerName:lower()) == 1 then
            if not (v == Player) then
                return v
            end
        end
    end
end
local function AddCommand(CommandName, CommandAliases, CommandDescription, CommandCallback, CommandArguments)
    table.insert(Commands, {
        Name = CommandName,
        Aliases = CommandAliases,
        Description = CommandDescription,
        Callback = CommandCallback,
        Arguments = CommandArguments
    })
end
local ChattedConnection = nil

AddCommand(
    "Unload",
    {"disconnect"},
    "Unloads the script",
    function()
        CommandStates = {}
        _G.CrabCommand = false
        SendNotification("Thanks For Using The Script", "It really means a lot to me <3")
        ChattedConnection:Disconnect()
    end,
    {}
)
AddCommand(
    "CommandHelp",
    {"help", "cmds", "commands"},
    "Prints the list of all the commands",
    function()
        SendNotification("Commands Printed", "Press F9 and scroll down to see all the commands\nHope it helps")
        for i, v in pairs(Commands) do
            print("======================")
            print("Command Name: "..v.Name)
            local CommandAliasesString = ""
            for i1, v1 in pairs(v.Aliases) do
                if CommandAliasesString == "" then
                    CommandAliasesString = v1
                else
                    CommandAliasesString = CommandAliasesString..", "..v1
                end
            end
            print("Other ways to call the command: "..CommandAliasesString)
            local CommandArgumentsString = "none"
            for i1, v1 in pairs(v.Arguments or {}) do
                if i1 == 1 then
                    CommandArgumentsString = v1
                else
                    CommandArgumentsString = CommandArgumentsString..", "..v1
                end
            end
            print("Arguments passed: "..CommandArgumentsString)
        end
    end,
    {}
)
AddCommand(
    "Discord",
    {"server"},
    "Gives you the discord server invite",
    function()
        local NotificationString = "discord.gg/5NYqSVwH9Q"
        if setclipboard then
            setclipboard(NotificationString)
            NotificationString = NotificationString.."\nCopied to clipboard"
        end
        SendNotification("Discord Server Link", NotificationString, 20)
        local req = syn and syn.request or game:GetService("HttpService") and game:GetService("HttpService").request or http_request or fluxus and fluxus.request or getgenv().request or request
        if req then --Credits to Infinite Yield
            req({
                Url = 'http://127.0.0.1:6463/rpc?v=1',
                Method = 'POST',
                Headers = {
                    ['Content-Type'] = 'application/json',
                    Origin = 'https://discord.com'
                },
                Body = game:GetService("HttpService"):JSONEncode({
                    cmd = 'INVITE_BROWSER',
                    nonce = game:GetService("HttpService"):GenerateGUID(false),
                    args = {code = '5NYqSVwH9Q'}
                })
            })
        end
    end,
    {}
)
AddCommand(
    "Close",
    {"exit"},
    "Just closes the game (i really dont know why whould you need it)",
    function()
        SendNotification("Game Shutdown", "Do you really want to close the game?", 9e9, "option", function(bool)
            if bool then
                game:Shutdown()
            end
        end)
    end,
    {}
)
AddCommand(
    "Fly",
    {"cframefly"},
    "makes you fly, type the speed you want after",
    function(Args) --Full credit to peyton#9148 and Infinite Yield
        CommandStates.Fly = not CommandStates.Fly
        local CFrameConnection = nil
        CFrameConnection = RunService.Heartbeat:Connect(function(deltaTime)
            if not CommandStates.Fly then
                CFrameConnection:Disconnect()
                Player.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
                local Head = Player.Character:WaitForChild("Head")
                Head.Anchored = false
                return
            end
            Player.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
            local Head = Player.Character:WaitForChild("Head")
            local moveDirection = Player.Character:FindFirstChildOfClass('Humanoid').MoveDirection * ((Args[1] or 20) * deltaTime)
            local headCFrame = Head.CFrame
            local cameraCFrame = workspace.CurrentCamera.CFrame
            local cameraOffset = headCFrame:ToObjectSpace(cameraCFrame).Position
            cameraCFrame = cameraCFrame * CFrame.new(-cameraOffset.X, -cameraOffset.Y, -cameraOffset.Z + 1)
            local cameraPosition = cameraCFrame.Position
            local headPosition = headCFrame.Position
            local objectSpaceVelocity = CFrame.new(cameraPosition, Vector3.new(headPosition.X, cameraPosition.Y, headPosition.Z)):VectorToObjectSpace(moveDirection)
            Head.CFrame = CFrame.new(headPosition) * (cameraCFrame - cameraPosition) * CFrame.new(objectSpaceVelocity)
        end)
    end,
    {"[Speed]"}
)
AddCommand(
    "AutoRejoin",
    {"arejoin", "autorj"},
    "Automatically rejoins you if the game kicks you",
    function()
        CommandStates.AutoRejoin = not CommandStates.AutoRejoin
        local RejoinConnection = nil
        RejoinConnection = game:GetService("CoreGui").DescendantAdded:Connect(function(Descendant)
            if not CommandStates.AutoRejoin then
                RejoinConnection:Disconnect()
                return
            end
            if Descendant.Name == "ErrorPrompt" then
                game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
            end
        end)
    end,
    {}
)
AddCommand(
    "NoClip",
    {"clip"},
    "Makes you go through solid parts",
    function()
        CommandStates.NoClip = not CommandStates.NoClip
        local ClipConnection = nil
        ClipConnection = RunService.Stepped:Connect(function() --It has to be Stepped, because it renders before the physic update
            if not CommandStates.NoClip then
                ClipConnection:Disconnect()
                return
            end
            local Char = Player.Character
            if Char then
                for i, v in pairs(Char:GetDescendants()) do
                    if v:IsA("BasePart") and (v.CanCollide == true) then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end,
    {}
)
AddCommand(
    "Teleport",
    {"tp", "goto"},
    "Teleports you to a player",
    function(Args)
        if Args[1] then
            local OtherPlayer = FindPlayer(Args[1])
            local PHrp = OtherPlayer.Character:FindFirstChild("HumanoidRootPart")
            local Hrp = Player.Character:FindFirstChild("HumanoidRootPart")
            if PHrp and Hrp then
                local Time = tonumber(Args[2]) or 5
                local tween = TweenService:Create(Hrp, Time, {CFrame = PHrp.CFrame})
                tween:Play()
                task.wait(Time)
            end
        end
    end,
    {"[PlayerName]"}
)
AddCommand( --Made by Moon and Courtney
    "DarkDex",
    {"dex"},
    "Opens Dark Dex",
    loadstring(game:HttpGet("https://gist.githubusercontent.com/DinosaurXxX/b757fe011e7e600c0873f967fe427dc2/raw/ee5324771f017073fc30e640323ac2a9b3bfc550/dark%2520dex%2520v4")),
    {}
)
AddCommand( --Made by Upbolt
    "RemoteSpy",
    {"rspy", "spy"},
    "Opens Hydroxide",
    function()
        local owner = "Upbolt"
        local branch = "revision"
        local function webImport(file)
            return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/Hydroxide/%s/%s.lua"):format(owner, branch, file)), file .. '.lua')()
        end
        webImport("init")
        webImport("ui/main")
    end,
    {}
)
AddCommand(
    "CopyPlaceId",
    {"placeid", "pid", "copyid"},
    "Copies the place id to your clipboard",
    function()
        if setclipboard then
            setclipboard(game.PlaceId)
            SendNotification("Id Copied", 'the PlaceId has been copied to your clipboard')
        else
            SendNotification("Injector not supported", 'the function "setclipboard" does not exist')
        end
    end,
    {}
)
AddCommand(
    "Rejoin",
    {"rj"},
    "Rejoins you in the same server",
    function() --Credits to Infinite Yield (altho there is not another way of writing this)
        local Players = game:GetService("Players")
        if #Players:GetPlayers() <= 1 then
            Player:Kick("\nRejoining...")
        else
            game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)
        end
    end,
    {}
)
AddCommand(
    "ServerHop",
    {"shop"},
    "Rejoins the same game in a different server",
    function() --Credits to Infinite Yield (altho there is not another way of writing this)
        local x = {}
        for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
            if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
                x[#x + 1] = v.id
            end
        end
        if #x > 0 then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
        else
            SendNotification("Error", "Couldn't find any server to join")
        end
    end,
    {}
)
AddCommand(
    "FpsBoost",
    {"fps", "potato", "badpc"},
    "Makes the game look really bad",
    function() --Straight from Infinite Yield (its the best optimization)
        SendNotification("Big F", "Potato pc", 5)
        workspace:FindFirstChildOfClass('Terrain').WaterWaveSize = 0
        workspace:FindFirstChildOfClass('Terrain').WaterWaveSpeed = 0
        workspace:FindFirstChildOfClass('Terrain').WaterReflectance = 0
        workspace:FindFirstChildOfClass('Terrain').WaterTransparency = 0
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").FogEnd = 9e9
        settings().Rendering.QualityLevel = 1
        for i,v in pairs(game:GetDescendants()) do
            if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
            elseif v:IsA("Decal") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            end
        end
        for i,v in pairs(game:GetService("Lighting"):GetDescendants()) do
            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                v.Enabled = false
            end
        end
        workspace.DescendantAdded:Connect(function(child)
            coroutine.wrap(function()
                if child:IsA('ForceField') then
                    game:GetService('RunService').Heartbeat:Wait()
                    child:Destroy()
                elseif child:IsA('Sparkles') then
                    game:GetService('RunService').Heartbeat:Wait()
                    child:Destroy()
                elseif child:IsA('Smoke') or child:IsA('Fire') then
                    game:GetService('RunService').Heartbeat:Wait()
                    child:Destroy()
                end
            end)()
        end)
    end,
    {}
)
AddCommand(
    "Spectate",
    {"view"},
    "Makes you spectate another player",
    function(Args)
        CommandStates.Spectate = not CommandStates.Spectate
        if not Args[1] then
            CommandStates.Spectate = false
        end
        local SpectateConnection = nil
        SpectateConnection = RunService.Stepped:Connect(function()
            local OtherPlayer = FindPlayer(Args[1])
            if CommandStates.Spectate then
                Camera.CameraSubject = OtherPlayer.Character:WaitForChild("Humanoid")
            else
                Camera.CameraSubject = Player.Character:WaitForChild("Humanoid")
                SpectateConnection:Disconnect()
            end
        end)
    end,
    {}
)
AddCommand(
    "Reset",
    {"rs"},
    "Breaks the joints of your character so you respawn",
    function()
        local Char = Player.Character or Player.CharacterAdded:Wait()
        Char:BreakJoints()
    end,
    {}
)
AddCommand(
    "MultiCommand",
    {"multicm"},
    "Makes you call more than one command at one time",
    function(Args)
        for i, v in pairs(Args) do
            for i, v1 in pairs(Commands) do
                if (v:lower() == v1.Name:lower()) or table.find(v1.Aliases, v:lower()) then
                    v1.Callback({})
                end
            end
        end
    end,
    {}
)
AddCommand(
    "GodMode",
    {"gm", "god"},
    "Makes you invincible in most games", --Basically the god command from IY
    function()
        local Cam = workspace.CurrentCamera
        local Pos, Char = Cam.CFrame, Player.Character
        local Human = Char and Char.FindFirstChildWhichIsA(Char, "Humanoid")
        local nHuman = Human.Clone(Human)
        nHuman.Parent, Player.Character = Char, nil
        nHuman.SetStateEnabled(nHuman, 15, false)
        nHuman.SetStateEnabled(nHuman, 1, false)
        nHuman.SetStateEnabled(nHuman, 0, false)
        nHuman.BreakJointsOnDeath, Human = true, Human.Destroy(Human)
        Player.Character, Cam.CameraSubject, Cam.CFrame = Char, nHuman, wait() and Pos
        nHuman.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        local Script = Char.FindFirstChild(Char, "Animate")
        if Script then
            Script.Disabled = true
            wait()
            Script.Disabled = false
        end
        nHuman.Health = nHuman.MaxHealth
    end,
    {}
)
if GameDetected == "FinalStand" then
    local NoSlowTable = {"Action", "Attacking", "Using", "hyper", "Hyper", "heavy", "KiBlasted", "Tele", "tele", "Killed", "Slow", "MoveStart", "Look", "Activity"}
    AddCommand(
        "NoSlow",
        {"ns"},
        "Lets you make more than one attack at once",
        function()
            CommandStates.NoSlowFinalStand = not CommandStates.NoSlowFinalStand
            local NoSlowConnection = nil
            NoSlowConnection = RunService.Stepped:Connect(function()
                if not CommandStates.NoSlowFinalStand then
                    NoSlowConnection:Disconnect()
                    return
                end
                local Char = Player.Character
                for i, v in pairs(NoSlowTable) do
                    local a = Char:FindFirstChild(v)
                    if a then
                        a:Destroy()
                    end
                end
            end)
        end,
        {}
    )
    AddCommand(
        "AutoFire",
        {"af"},
        "Makes every slot an autofire slot",
        function()
            CommandStates.AutoFireFinalStand = not CommandStates.AutoFireFinalStand
            local AutoFireConnection = nil
            AutoFireConnection = RunService.Heartbeat:Connect(function()
                if not CommandStates.AutoFireFinalStand then
                    AutoFireConnection:Disconnect()
                    return
                end
                local Char = Player.Character
                if Char:FindFirstChildWhichIsA("Tool") then
                    pcall(function()
                        Player.Backpack.ServerTraits.AutoFire:FireServer()
                    end)
                end
            end)
        end,
        {}
    )
    AddCommand(
        "ChangeSlot",
        {"slot"},
        "Lets you change your slot from anywhere",
        function()
            local Npc = workspace:FindFirstChild("Character Slot Changer", true)
            pcall(function()
                Player.Backpack.ServerTraits.ChatStart:FireServer(Npc)
            end)
        end,
        {}
    )
    AddCommand(
        "GodModeFinalStand",
        {"gmfs", "unigm"},
        "Makes you invincible (but you can't hurt others)",
        function()
            local Char = Player.Character
            local StatsFolder = Char:FindFirstChild("Stats")
            if StatsFolder then
                local a, b = StatsFolder:WaitForChild("Phys-Resist"), StatsFolder:WaitForChild("Ki-Resist")
                a:Destroy()
                b:Destroy()
            end
        end,
        {}
    )
    local KbTable = {"BodyVelocity", "KnockBacked", "NotHardBack", "creator", "Throw", "Flip"}
    AddCommand(
        "AntiKnockback",
        {"antikb", "kb"},
        "You can't be moved (exept for energy waves)",
        function()
            CommandStates.AntiKnockbackFinalStand = not CommandStates.AntiKnockbackFinalStand
            local KbConnection = nil
            KbConnection = RunService.Heartbeat:Connect(function()
                if not CommandStates.AntiKnockbackFinalStand then
                    KbConnection:Disconnect()
                    return
                end
                local Char = Player.Character
                for i, v in pairs(KbTable) do
                    local a = Char:FindFirstChild(v, true)
                    if a then
                        a:Destroy()
                    end
                end
            end)
        end,
        {}
    )
end

-- Some QOL additions

if hookmetamethod and getnamecallmethod and checkcaller then
    local OldNameCall = nil
    OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
        local NamecallMethod = getnamecallmethod()
        if (not checkcaller()) and (Self == Player) and (NamecallMethod == "Kick") then
            return nil
        end
        return OldNameCall(Self, ...)
    end)
end
local VirtualUser = game:GetService("VirtualUser")
Player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- The actual script that checks when the player types
ChattedConnection = Player.Chatted:Connect(function(message)
    local StartIndex = message:find(Prefix)
    if StartIndex == 1 then
        local CommandToCall = nil
        local Args = {}
        local Loops = 0
        for word in string.gmatch(message, "([^%s]+)") do
            Loops = Loops + 1
            if Loops > 2 then
                table.insert(Args, word:lower())
            end
            if Loops == 2 then
                for i, v in pairs(Commands) do
                    if (word:lower() == v.Name:lower()) or table.find(v.Aliases, word:lower()) then
                        CommandToCall = v
                    end
                end
            end
        end
        if CommandToCall then
            CommandToCall.Callback(Args or {})
        end
    end
end)