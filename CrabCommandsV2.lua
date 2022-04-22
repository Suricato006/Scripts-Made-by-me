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

if _G.CrabCommand and not _G.CrabDebug then
    SendNotification("Already Running", "Crab Commands is already running sweetie <3")
end
_G.CrabCommand = true

local Player = game:GetService("Players").LocalPlayer
local InputLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/InputFunctions%20Library.lua"))()