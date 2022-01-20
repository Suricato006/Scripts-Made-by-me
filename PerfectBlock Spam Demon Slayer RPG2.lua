loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Functions%20and%20stuff.lua'),true))()

_G.PerfectBlock = true

while _G.PerfectBlock do FastWait()
    game:GetService("ReplicatedStorage").All.Animations.CombatRemote.BLOCKING:FireServer("On")
    FastWait()
    game:GetService("ReplicatedStorage").All.Animations.CombatRemote.BLOCKING:FireServer("Off")
end
