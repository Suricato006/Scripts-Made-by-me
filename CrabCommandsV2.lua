if not game:IsLoaded() then game.Loaded:Wait() end

loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))() --I dont understand why both are required...
local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

if _G.CrabCommand then
    NotificationLibrary:Notify(
        {Title = "Already Running", Description = "Crab Commands is already running sweetie <3"},
        {OutlineColor = Color3.fromHex("E981FF"),Time = 5, Type = "default"}
    )
end
NotificationLibrary:Notify(
    {Title = "Already Running", Description = "Crab Commands is already running sweetie <3"},
    {OutlineColor = Color3.fromHex("E981FF"),Time = 9e9, Type = "default"}
)
--[[ NotificationLibrary:Notify(
    {Title = "TEXT TITLE", Description = "DESCRIPTION"},
    {OutlineColor = Color3.fromRGB(80, 80, 80),Time = 5, Type = "option"},
    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 84, 84), Callback = function(State) print(tostring(State)) end}
)
wait(1)
NotificationLibrary:Notify(
    {Title = "TEXT TITLE", Description = "DESCRIPTION"},
    {OutlineColor = Color3.fromRGB(80, 80, 80),Time = 5, Type = "image"},
    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 84, 84)}
)
wait(1)
NotificationLibrary:Notify(
    {Title = "TEXT TITLE", Description = "DESCRIPTION"},
    {OutlineColor = Color3.fromRGB(80, 80, 80),Time = 5, Type = "default"}
) ]]