loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Functions%20and%20stuff.lua'),true))()

local Names = {"ATTACKING", "COMBO", "EARLYATTACKING","STUN", "HeavyCD", "CancelAll", "Knocked", "BLOCKING", "USINGSKILL"}

_G.NoSlow = true

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