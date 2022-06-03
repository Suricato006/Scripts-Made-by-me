local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/Notification%20Library%20Optimization.lua"))()
if hookmetamethod and getnamecallmethod and checkcaller then
    local OldNameCall = nil
    OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
        local NamecallMethod = getnamecallmethod()
        if (not checkcaller()) and (Self == Player) and (NamecallMethod == "Kick") then
            return nil
        end
        return OldNameCall(Self, ...)
    end)
else
    NotificationLibrary.CustomNotification("Injector not supported", "Buy synapse")
    return
end
local Player = game.Players.LocalPlayer
local Cam = workspace.CurrentCamera
local Pos, Char = Cam.CFrame, Player.Character
local Human = Char and Char.FindFirstChildWhichIsA(Char, "Humanoid")
local nHuman = Human.Clone(Human)
nHuman.Parent, Player.Character = Char, nil
nHuman.SetStateEnabled(nHuman, 15, false)
nHuman.SetStateEnabled(nHuman, 1, false)
nHuman.SetStateEnabled(nHuman, 0, false)
nHuman.BreakJointsOnDeath, Human = true, Human.Destroy(Human)
Player.Character, Cam.CameraSubject, Cam.CFrame = Char, nHuman, wait() and Pos
nHuman.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
local Script = Char.FindFirstChild(Char, "Animate")
if Script then
    Script.Disabled = true
    wait()
    Script.Disabled = false
end
nHuman.Health = nHuman.MaxHealth