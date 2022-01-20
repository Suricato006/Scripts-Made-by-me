loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Functions%20and%20stuff.lua'),true))()

_G.InfiniteBreath = true
while _G.InfiniteBreath do FastWait()
    local a = Player.Character:FindFirstChild("Oxygen")
    if a then
        a.Value = math.huge
    end
end