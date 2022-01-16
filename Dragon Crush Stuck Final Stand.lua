--YEET
loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Functions%20and%20stuff.lua'),true))()

_G.YEET = true

while _G.YEET do FastWait()
    if PlayerCheck() then
        local a = Player.Character:FindFirstChild("Dragon Crush") or Player.Character:FindFirstChild("Dragon Throw")
        if a then
            local b = a:FindFirstChild("Activator")
            if b then
                local c = b:FindFirstChild("Flip")
                if c then
                    c:Destroy()
                end
            end
        end
    end
end