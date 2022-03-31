_G.Help = true
_G.PlayerToHelp = "suricato006"

local Player = game.Players.LocalPlayer
local HelpedPlayer = game.Players:FindFirstChild(_G.PlayerToHelp)
if not HelpedPlayer then return end
while _G.Help do task.wait()
    local Hrp = Player.Character:FindFirstChild("HumanoidRootPart")
    local HelpHrp = HelpedPlayer.Character:FindFirstChild("HumanoidRootPart")
    local PowerOutput = Player.Character:FindFirstChild("PowerOutput")
    if PowerOutput then
        PowerOutput:Destroy()
    end
    if Hrp and HelpHrp then
        Hrp.CFrame = HelpHrp.CFrame * CFrame.new(0, 10, 0)
    end
    local SenzuEvent = Player.Backpack:FindFirstChild("EatSenzu", true)
    if SenzuEvent then
        SenzuEvent:FireServer(true)
    end
end