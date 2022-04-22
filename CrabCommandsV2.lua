if not game:IsLoaded() then game.Loaded:Wait() end

local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Notification%20Library%20Optimization.lua"))()

local function SendNotification(TitleArg, DescriptionArg, TimeArg, TypeArg, AdditionalArg)
    local Table = {
        OutlineColor = Color3.fromHex("E981FF"),
        Time = TimeArg or 5,
        Type = TypeArg or "default"
    }
    local AdditionalTable = {}
    if TypeArg == "image" then
        AdditionalTable.Image = AdditionalArg
        AdditionalTable.ImageColor = Color3.fromHex("E981FF")
    elseif TypeArg == "option" then
        AdditionalTable.Callback = AdditionalArg
    end
    NotificationLibrary:Notify(
        {Title = TitleArg, Description = DescriptionArg},
        Table,
        AdditionalTable
    )
end

if _G.CrabCommand then
    SendNotification("Already Running", "Crab Commands is already running sweetie <3")
end
_G.CrabCommand = true

local Player = game:GetService("Players").LocalPlayer
local InputLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/InputFunctions%20Library.lua"))()
local Camera = workspace:FindFirstChildWhichIsA("Camera")

local Commands = {}
local Prefix = "/e"
local function AddCommand(NameArg, AliasesArg, DescriptionArg, CallbackArg)
    table.insert(Commands, {
        Name = NameArg,
        Aliases = AliasesArg,
        Description = DescriptionArg,
        Callback = CallbackArg
    })
end

AddCommand(
    "Test",
    {"ts", "testaggio"},
    "Solo per testare",
    function(Args)
        print("Testato e questi sono gli argomenti: ")
        for i, v in pairs(Args) do
            print(i,v)
        end
    end
)
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
        SendNotification("Unloaded", "The script is now unloaded, thanks for using it")
    end
)
AddCommand(
    "CommandHelp",
    {"cmdhelp"},
    "A command to see what other commands do",
    function(Args)
        local word = Args[1]
        for i, v in pairs(Commands) do
            if word:lower() == v.Name:lower() or table.find(v.Aliases, word:lower()) then
                SendNotification("CommandHelp", "CommandName: "..v.Name.."\nCommandDescription: "..v.Description)
            end
        end
    end
)
AddCommand(
    "Discord",
    {"help"},
    "Gives the server discord link",
    function(Args)
        if syn then
            syn.write_clipboard("https://discord.gg/5NYqSVwH9Q")
            SendNotification("Discord Server", "Copied to your clipboard", 5)
        end
        local req = syn and syn.request or game:GetService("HttpService") and game:GetService("HttpService").request or http_request or fluxus and fluxus.request or getgenv().request or request
        if req then
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
    SendNotification("D R I P", "Merch Link: bit.ly/3LcmBoC", 10)
)
AddCommand(
    "Notify",
    {"notification"},
    "Sends a notification with custom text",
    function(Args)
        if Args then
            SendNotification(Args[1], Args[2] or "")
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

ChattedConnection = Player.Chatted:Connect(function(message)
    local StartIndex = message:find("/e")
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
                    if word:lower() == v.Name:lower() or table.find(v.Aliases, word:lower()) then
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