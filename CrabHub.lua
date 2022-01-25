--[[ 
CrabHub
Open Source so you can learn from the script. If you want to use a part of it then credit me or my discord in description.
Much love <3
Created by Suricato006#8711
]]

loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Functions%20and%20stuff.lua'),true))()

local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
    local Args = {...}
    local NamecallMethod = getnamecallmethod()
    if not checkcaller() and Self == Player and NamecallMethod == "Kick" then
        return nil
    end

    return OldNameCall(Self, ...)
end)

local FileName = "CrabHub.JSON"
local function SaveSettings()
    writefile(FileName, HttpService:JSONEncode(_G.CrabHub))
end

local function LoadSettings()
    if not isfile(FileName) then return end
    _G.CrabHub = HttpService:JSONDecode(readfile(FileName))
    return
end

_G.CrabHub = {}

if not syn then
    Notify("Synapse not found", "Some things are synapse only")
end
local Library = loadstring(game:HttpGet("https://pastebin.com/raw/GX28T0pH", true))()





-- Menu
local Main = Library:CreateWindow("CrabHub")



local Credits = Library:CreateWindow("Credits")
Credits.open = false

Credits:AddLabel({text = "Who Created This Gui?"})

Credits:AddButton({text = "Suricato006#8711", callback = function()
    Notify("Suricato006", "Tha Scripter")
end})

Credits:AddButton({text = "Wally", callback = function()
    Notify("The creator of the Ui library", "And its the best out there")
end})

Credits:AddButton({text = "Nevertrack#4219", callback = function()
    Notify("He was useless", "what a clown")
end})

Credits:AddButton({text = "Join Discord Server", callback = function()
    local http = game:GetService('HttpService') 
    Notify('Discord Invite', 'https://discord.gg/5NYqSVwH9Q')
    pcall(function()
        setclipboard("https://discord.gg/5NYqSVwH9Q")
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