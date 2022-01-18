local ToggleKey = "U"

local Moves = {
'Deadly Dance','Blaster Meteor','Anger Rush','Meteor Crash',"TS Molotov","Flash Skewer","Vital Strike",
'Demon Flash','Wolf Fang Fist','Neo Wolf Fang Fist','Trash???',"Trash?","Strong Kick","Strong Kick",
};


local Player = game:GetService("Players").LocalPlayer
local function PlayerCheck()
    if Player.Character:FindFirstChild("HumanoidRootPart") then
        return true
    else
        return nil
    end
end

local function FastWait()
    game:GetService("RunService").Heartbeat:wait()
end

_G.MoveSpamCheck = true
_G.MoveSpam = true

local function movespamfunction()
    while _G.MoveSpam do FastWait()
        for i, v in pairs(Player.Backpack:GetChildren()) do
            for _, Move in pairs(Moves) do
                if v.Name == Move and PlayerCheck() then
                    v.Parent = Player.Character 
                    FastWait()
                    v:Activate()
                    FastWait()
                    v:Deactivate()
                    v.Parent = Player.Backpack
                end
            end
        end
    end
end

if _G.MoveSpam then
    movespamfunction()
end;

game:GetService("UserInputService").InputBegan:connect(function(key, owadij)
    if key.KeyCode == Enum.KeyCode[string.upper(ToggleKey)] and _G.MoveSpamCheck and not owadij then 
        _G.MoveSpam = not _G.MoveSpam
        movespamfunction()
    end
end)