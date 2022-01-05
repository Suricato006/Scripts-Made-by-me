--YEET
loadstring(game:HttpGet(('https://pastebin.com/raw/5ksZRmMp'),true))()

_G.YEET = true
local names = {"Flip"}


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