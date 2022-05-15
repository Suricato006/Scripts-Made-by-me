---@diagnostic disable: undefined-global

local DefaultSettings = {
    AutoCombat = false,
    AutoKiBlast = false,
    AutoDefence = false,
    AutoCharge = true,
    MinimumKi = 6
}

local AutoExec = false
if not game:IsLoaded() then
    AutoExec = true
    game.Loaded:Wait()
end

local OwnScriptUrl = ""
if syn and not (OwnScriptUrl == "") then
    local FileName = "DragonballRage.CRAB"
    if isfile(FileName) then
        _G.DragonballRageSettings = _G.DragonballRageSettings or HttpService:JSONDecode(readfile(FileName))
    end
    local ToEncode = _G.DragonballRageSettings or DefaultSettings
    writefile(FileName, HttpService:JSONEncode(ToEncode))
    if ToEncode == DefaultSettings then
        _G.DragonballRageSettings = DefaultSettings
    end
    if _G.DragonballRageSettings.AutoExecuteTheScript then
        Player.OnTeleport:Connect(function(State)
            if State == Enum.TeleportState.Started then
                syn.queue_on_teleport(game:HttpGet(OwnScriptUrl))
            end
        end)
    end
end
local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

_G.DragonballRageSettings = _G.DragonballRageSettings or DefaultSettings

if AutoExec then
    Player.CharacterAdded:Wait()
end

local Library = loadstring(game:HttpGet("https://pastebin.com/raw/GX28T0pH"))()
local Main = Library:CreateWindow("Dragonball Rage")

Main:AddToggle({text = "AutoCombat", state = _G.DragonballRageSettings.AutoCombat, callback = function(bool)
    _G.DragonballRageSettings.AutoCombat = bool
end})

Main:AddToggle({text = "AutoKiBlast", state = _G.DragonballRageSettings.AutoKiBlast, callback = function(bool)
    _G.DragonballRageSettings.AutoKiBlast = bool
end})

Main:AddToggle({text = "AutoDefence", state = _G.DragonballRageSettings.AutoDefence, callback = function(bool)
    _G.DragonballRageSettings.AutoDefence = bool
end})

Main:AddSlider({text = "Minimum ki", min = 0, max = 100, dual = false, value = _G.DragonballRageSettings.MinimumKi or 6, callback = function(number)
    _G.DragonballRageSettings.MinimumKi = number
end})

Main:AddToggle({text = "Charge Ki When Low", state = _G.DragonballRageSettings.AutoCharge, callback = function(bool)
    _G.DragonballRageSettings.AutoCharge = bool
end})

Main:AddButton({text = "Teleport To HTC", callback = function()
    game:GetService("TeleportService"):Teleport(3371469539, Player)
end})

Main:AddButton({text = "Teleport To Beerus", callback = function()
    game:GetService("TeleportService"):Teleport(3336119605, Player)
end})

local ModulePieceOfShit = game:GetService("ReplicatedStorage"):FindFirstChild("Network", true)
local RemoteHandler = require(ModulePieceOfShit)
RemoteHandler:FireServer("Combat")
local Charging = false
RunService.Heartbeat:Connect(function()
    local StateFolder = Player.Character:FindFirstChild("State")
    if StateFolder then
        local Energy = StateFolder:FindFirstChild("Energy")
        local MaxEnergy = StateFolder:FindFirstChild("MaxEnergy")
        if Energy and MaxEnergy then
            if _G.DragonballRageSettings.AutoCharge then
                if (Player.Character.State.Energy.Value <= _G.DragonballRageSettings.MinimumKi) then
                    RemoteHandler:InvokeServer("ChargeEnergy", true)
                    Charging = true
                elseif (Player.Character.State.Energy.Value == Player.Character.State.MaxEnergy.Value) and Charging then
                    InvokeServer("ChargeEnergy", false)
                    Charging = false
                end
            end
            if not Charging then
                if _G.DragonballRageSettings.AutoCombat then
                    RemoteHandler:FireServer("Combat")
                elseif _G.DragonballRageSettings.AutoKiBlast then
                    RemoteHandler:FireServer("KiBlast","Left")
                elseif _G.DragonballRageSettings.AutoDefence then
                    RemoteHandler:FireServer("DefenseTrain")
                end
            end
        end
    end
end)

local Credits = Library:CreateWindow("Credits")

Credits:AddLabel({text = "Who Created This Gui?"})

Credits:AddLabel({text = "CrabGuy#8711"})

Credits:AddLabel({text = "Nevertrack#4219"})

Credits:AddLabel({text = "noam#5887"})

Credits:AddLabel({text = "----DiscordServer----"})

Credits:AddLabel({text = "discord.gg/5NYqSVwH9Q"})

Credits:AddButton({text = "Join Discord Server", callback = function()
    local http = game:GetService('HttpService')
    pcall(function()
        syn.write_clipboard("https://discord.gg/5NYqSVwH9Q")
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