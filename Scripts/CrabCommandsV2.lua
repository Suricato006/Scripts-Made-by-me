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
        else

        end
    end)
    return
end
_G.CrabCommand = true

local Player = game:GetService("Players").LocalPlayer
local InputLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/InputFunctions%20Library.lua"))()
local Camera = workspace:FindFirstChildWhichIsA("Camera")
local RunService = game:GetService("RunService")

local Commands = {}
_G.CommandStates = {}
SendNotification("CrabCommands", 'Thanks for using the script.\nType '..Prefix.." and then a command name or aliases", 10)
SendNotification("Documentation", 'Type "'..Prefix..' cmds" to get a list of all the commands', 10)
local function AddCommand(NameArg, AliasesArg, DescriptionArg, CallbackArg)
    table.insert(Commands, {
        Name = NameArg,
        Aliases = AliasesArg,
        Description = DescriptionArg,
        Callback = CallbackArg
    })
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

local ChattedConnection = nil
AddCommand(
    "Unload",
    {"disconnect"},
    "A command to unload the script, wont work anymore",
    function(Args)
        if ChattedConnection then
            ChattedConnection:Disconnect()
        end
        _G.CrabCommand = false
        _G.CommandStates = {}
        task.wait()
        _G.CommandStates = nil
        SendNotification("Unloaded", "The script is now unloaded, thanks for using it")
    end
)
AddCommand(
    "CommandHelp",
    {"cmdhelp"},
    "A command to see what other commands do",
    function(Args)
        if not Args[1] then
            return
        end
        local word = Args[1]
        for i, v in pairs(Commands) do
            if word:lower() == v.Name:lower() or table.find(v.Aliases, word:lower()) then
                SendNotification("CommandHelp", "CommandName: "..v.Name.."\nCommandDescription: "..v.Description, 10)
            end
        end
    end
)
AddCommand(
    "Discord",
    {"help", "support"},
    "Gives the server discord link",
    function(Args)
        if syn then
            syn.write_clipboard("https://discord.gg/5NYqSVwH9Q")
            SendNotification("Discord Server", "Copied to your clipboard", 5)
        end
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
        SendNotification("Discord Server", "Server Link: discord.gg/5NYqSVwH9Q", 10)
    end
)
AddCommand(
    "Merch",
    {},
    "A link to the sickest drip of roblox",
    function()
        SendNotification("D R I P", "Merch Link: bit.ly/3LcmBoC", 20)
    end
)
AddCommand(
    "Notify",
    {"notification"},
    "Sends a notification with custom text",
    function(Args)
        if Args then
            local TextString = ""
            for i, v in pairs(Args) do
                if not (i == 1) then
                    TextString = TextString.." "..v
                end
            end
            SendNotification(Args[1], TextString)
        end
    end
)
AddCommand(
    "Close",
    {"exit"},
    "Just closes the game (i really dont know why whould you need it)",
    function(Args)
        SendNotification("Game Shutdown", "Do you really want to close the game?", 9e9, "option", function(bool)
            if bool then
                game:Shutdown()
            end
        end)
    end
)
AddCommand(
    "AllCommands",
    {"allcmds", "cmds"},
    "A list of all the available commands",
    function()
        SendNotification("Printed", "All of the commands got printed.\nPress F9 to see them")
        for i, v in pairs(Commands) do
            if not (i == 1) then
                print("----------------")
            end
            print("Name: "..v.Name)
            local AliasesString = ""
            for i1, v1 in pairs(v.Aliases) do
               AliasesString = AliasesString..v1..", "
            end
            print("Can also type: "..AliasesString)
            print("Description: "..v.Description)
        end
    end
)
local CFloop
AddCommand(
    "Fly",
    {"cframefly"},
    "makes you fly, type the speed you want after",
    function(Args) --Full credit to peyton#9148 and Infinite Yield
        _G.CommandStates.Fly = not _G.CommandStates.Fly
        if _G.CommandStates.Fly then
            Player.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
            local Head = Player.Character:WaitForChild("Head")
            Head.Anchored = true
            CFloop = RunService.Heartbeat:Connect(function(deltaTime)
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
        else
            if CFloop then
                CFloop:Disconnect()
                Player.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
                local Head = Player.Character:WaitForChild("Head")
                Head.Anchored = false
            end
        end
    end
)
local NoClipConnection
AddCommand(
    "NoClip",
    {"clip"},
    "Makes you go through solid objects",
    function()
        _G.CommandStates.NoClip = not _G.CommandStates.NoClip
        if _G.CommandStates.NoClip then
            NoClipConnection = RunService.Stepped:Connect(function() --It has to be Stepped, because it renders before the physic update
                local Char = Player.Character
                if Char then
                    for i, v in pairs(Char:GetDescendants()) do
                        if v:IsA("BasePart") and (v.CanCollide == true) then
                            v.CanCollide = false
                        end
                    end
                end
            end)
        else
            if NoClipConnection then
                NoClipConnection:Disconnect()
            end
        end
    end
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
                Hrp.Anchored = true
                local tween = InputLibrary.TweenPart(Hrp, tonumber(Args[2]) or 5, PHrp.CFrame)
                tween:Play()
                tween.Completed:Wait()
                Hrp.Anchored = false
            end
        end
    end
)
AddCommand(
    "DarkDex",
    {"dex"},
    "Opens Dark Dex",
    loadstring(game:HttpGet("https://gist.githubusercontent.com/DinosaurXxX/b757fe011e7e600c0873f967fe427dc2/raw/ee5324771f017073fc30e640323ac2a9b3bfc550/dark%2520dex%2520v4"))
)
AddCommand(
    "RemoteSpy",
    {"rspy", "spy"},
    "Opens MrSpy",
    loadstring(game:HttpGet("https://pastebin.com/raw/DU2RTZkq"))
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
    end
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
    end
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
    end
)
AddCommand(
    "ToggleNotification",
    {"tnotify", "togglenotify"},
    "Chooses if commands send a notification on execution",
    function(Args)
        _G.CommandStates.ToggleNotification = not _G.CommandStates.ToggleNotification
    end
)
_G.CommandStates.LastCommandUsed = {}
AddCommand(
    "LastCommand",
    {"last", "l"},
    "Executes the last command",
    function()
        if (type(_G.CommandStates.LastCommandUsed.Callback) == "function") and not (_G.CommandStates.LastCommandUsed.Name == "LastCommand") then
            _G.CommandStates.LastCommandUsed.Callback(_G.CommandStates.LastCommandUsed.Args)
        end
    end
)
AddCommand(
    "FpsBoost",
    {"fps", "potato", "badpc"},
    "Makes the game look really bad",
    function() --Straight from Infinite Yield (its the best optimization)
        SendNotification("U noob", "Potato pc", 5)
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
    end
)
local SpectateConnection
AddCommand(
    "Spectate",
    {"view"},
    "Makes you spectate another player",
    function(Args)
        _G.CommandStates.Spectate = not _G.CommandStates.Spectate
        if not Args[1] then
            _G.CommandStates.Spectate = false
        end
        if _G.CommandStates.Spectate then
            local OtherPlayer = FindPlayer(Args[1])
            SpectateConnection = RunService.Heartbeat:Connect(function()
                if _G.CommandStates.Spectate then
                    Camera.CameraSubject = OtherPlayer.Character:WaitForChild("Humanoid")
                else
                    Camera.CameraSubject = Player.Character:WaitForChild("Humanoid")
                    SpectateConnection:Disconnect()
                end
            end)
        end
    end
)


-- Some QOL additions

RunService.Heartbeat:Connect(function()
    if game:GetService("CoreGui").RobloxPromptGui:FindFirstChild("ErrorPrompt", true) then
        game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
    end
end)
if syn then
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
            if _G.CommandStates.ToggleNotification then
                SendNotification("Command Called", "Command "..CommandToCall.Name.." has been called.", 3)
            end
            local success, notsuccess = pcall(CommandToCall.Callback, Args or {})
            _G.CommandStates.LastCommandUsed = {
                Name = CommandToCall.Name,
                Callback = CommandToCall.Callback,
                Args = Args or {}
            }
            if notsuccess then
                SendNotification("An error as occurred", "Error: "..notsuccess, 20)
            end
        end
    end
end)