local OldNameCall = nil
local Player = game.Players.LocalPlayer
OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
    local NamecallMethod = getnamecallmethod()
    if (not checkcaller()) and (Self == Player) and (NamecallMethod == "Kick") then
        return nil
    end

    return OldNameCall(Self, ...)
end)

local VirtualUser = game:GetService("VirtualUser")
Player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)