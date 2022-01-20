loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Functions%20and%20stuff.lua'),true))()

local Library = loadstring(game:HttpGet("https://pastebin.com/raw/GX28T0pH", true))()
local Main = Library:CreateWindow("Demon Slayer RPG 2")

local function NoSlowDSRPG(bool)
    local Names = {"ATTACKING", "COMBO", "EARLYATTACKING","STUN", "HeavyCD", "CancelAll", "Knocked", "BLOCKING", "USINGSKILL", "PERFECTBLOCKED", "GAURDBREAK"}
    _G.NoSlowDSRPG = bool

    while _G.NoSlowDSRPG do FastWait()
        if PlayerCheck() then
            for i, v in pairs(Names) do
                local a = Player.Character:FindFirstChild(v)
                if a then
                    a:Destroy()
                end
            end
        end
    end
end

Main:AddToggle({text = "No Slow", state = false, callback = NoSlowDSRPG})

local function PerfBlockDSRPG(bool)
    _G.PerfBlockDSRPG = bool
    while _G.PerfBlockDSRPG do FastWait()
        game:GetService("ReplicatedStorage").All.Animations.CombatRemote.BLOCKING:FireServer("On")
        FastWait()
        game:GetService("ReplicatedStorage").All.Animations.CombatRemote.BLOCKING:FireServer("Off")
    end
end

Main:AddToggle({text = "Perfect Block", state = false, callback = PerfBlockDSRPG})

local function InfiniteBreathDSRPG(bool)
    _G.InfiniteBreathDSRPG = bool
    while _G.InfiniteBreathDSRPG do FastWait()
        local a = Player.Character:FindFirstChild("Oxygen")
        if a then
            a.Value = math.huge
        end
    end
end

Main:AddToggle({text = "Infinite Breath", state = false, callback = InfiniteBreathDSRPG})




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