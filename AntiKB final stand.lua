loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Functions%20and%20stuff.lua'),true))()

local function ChildCheck(String1, ...)
    local a = Player.Character:FindFirstChild(String1)
    if a then
        local c = {...}
        for i, v in pairs(c) do
            local z = a:FindFirstChild(v)
            if z then
                z:Destroy()
            end
        end
    end
end

_G.AntiKB = true

while _G.AntiKB do FastWait()
    ChildCheck("LowerTorso", "BodyVelocity", "KnockBacked")
    ChildCheck("Head", "KnockBacked", "NotHardBack")
    ChildCheck("Humanoid", "creator")
    ChildCheck("HumanoidRootPart", "Throw", "Flip")
    ChildCheck("LeftHand", "BodyVelocity")
end