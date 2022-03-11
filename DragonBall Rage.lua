local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

if not syn then
    Player:Kick("\nSynapse Only Unfortunately :(")
end

while not iswindowactive() do
    task.wait()
end
local InputMessage = Instance.new("Message", game:GetService("CoreGui"))
InputMessage.Text = "Stay On This Window for a couple of seconds"
task.wait(3)
local OldNameCall = nil
local EventNumber = 0
OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
    local NamecallMethod = getnamecallmethod()

    if not checkcaller() and (NamecallMethod == "FireServer") then
        EventNumber += 1
        if EventNumber == 1 then
            Self.Name = "Combat"
        end
        if EventNumber == 2 then
            Self.Name = "KiBlast"
        end
        if EventNumber == 3 then
            Self.Name = "Defence"
        end
        if EventNumber == 4 then
            Self.Name = "Charge"
        end
    end

    return OldNameCall(Self, ...)
end)
InputMessage.Text = "Executing Checks"
local function PressButton(KeyCode)
    keypress(KeyCode)
    task.wait()
    keyrelease(KeyCode)
end
task.wait()
PressButton(0x45)
task.wait(1)
PressButton(0x51)
task.wait(1)
PressButton(0x52)
task.wait(1)
PressButton(0x43)
task.wait()
InputMessage.Text = "Checks Done"
task.wait(0.7)
InputMessage:Destroy()


local Library = loadstring(game:HttpGet("https://pastebin.com/raw/GX28T0pH"))()
local Main = Library:CreateWindow("Dragonball Rage")

Main:AddToggle({text = "AutoCombat", state = false, callback = function(bool)
    _G.AutoCombat = bool
end})

Main:AddToggle({text = "AutoKiBlast", state = false, callback = function(bool)
    _G.AutoKiBlast = bool
end})

Main:AddToggle({text = "AutoDefence", state = false, callback = function(bool)
    _G.AutoDefence = bool
end})

_G.MinimumKi = 6

Main:AddSlider({text = "Minimum ki", min = 0, max = 100, dual = false, value = _G.MinimumKi, callback = function(number)
    _G.MinimumKi = number
end})

Main:AddToggle({text = "Charge Ki When Low", state = true, callback = function(bool)
    _G.AutoCharge = bool
end})

local Charging = false
RunService.Heartbeat:Connect(function()
    local StateFolder = Player.Character:FindFirstChild("State")
    if StateFolder then
        local Energy = StateFolder:FindFirstChild("Energy")
        local MaxEnergy = StateFolder:FindFirstChild("MaxEnergy")
        if Energy and MaxEnergy then
            if _G.AutoCharge then
                if (Player.Character.State.Energy.Value <= _G.MinimumKi) then
                    game:GetService("ReplicatedStorage").Communication.Functions:FindFirstChild("Charge"):FireServer("\1", true)
                    Charging = true
                elseif (Player.Character.State.Energy.Value == Player.Character.State.MaxEnergy.Value) and Charging then
                    game:GetService("ReplicatedStorage").Communication.Functions:FindFirstChild("Charge"):FireServer("\1", false)
                    Charging = false
                end
            end
            if not Charging then
                if _G.AutoCombat then
                    game:GetService("ReplicatedStorage").Communication.Events:FindFirstChild("Combat"):FireServer()
                elseif _G.AutoKiBlast then
                    game:GetService("ReplicatedStorage").Communication.Events:FindFirstChild("KiBlast"):FireServer("Left")
                elseif _G.AutoDefence then
                    game:GetService("ReplicatedStorage").Communication.Events:FindFirstChild("Defence"):FireServer()
                end
            end
        end
    end
end)

Library:Init()