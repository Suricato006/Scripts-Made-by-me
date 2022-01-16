--No Slow Final Stand

loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Functions%20and%20stuff.lua'),true))()

_G.NoSlow = true
local Names = {"Action", "Attacking", "Using", "hyper", "Hyper", "heavy", "KiBlasted", "Tele", "tele", "Killed", "Slow"}

while _G.NoSlow do FastWait()
    if PlayerCheck() then
        for i, v in pairs(Names) do
            local a = Player.Character:FindFirstChild(v)
            if a then
                a:Destroy()
            end
        end
    end
end
