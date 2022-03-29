local ToggleKey = "U"
local Moves = {
    "Deadly Dance",
    "Anger Rush",
    "Meteor Crash",
    "TS Molotov",
    "Flash Skewer",
    "Vital Strike",
    "Demon Flash",
    "Wolf Fang Fist",
    "Neo Wolf Fang Fist",
    "Strong Kick"
}
_G.MoveSpam = false
_G.Noslow = true



local Player = game.Players.LocalPlayer
local Names = {"Action", "Attacking", "Using", "hyper", "Hyper", "heavy", "KiBlasted", "Tele", "tele", "Killed", "Slow", "Blocked", "MoveStart", "NotHardBack"}
coroutine.wrap(function()
    while true do task.wait()
        if Player.Character:FindFirstChild("HumanoidRootPart") then
            for i, v in pairs(Names) do
                local a = Player.Character:FindFirstChild(v)
                if a then
                    a:Destroy()
                end
            end
        end
    end
end)()
local function UseMove(Move)
    Move.Parent = Player.Character
    Move:Activate()
    task.wait()
    Move.Parent = Player.Backpack
end
local function MoveSpam()
    while _G.MoveSpam do
        for i, v in pairs(Player.Backpack:GetChildren()) do
            if table.find(Moves, v.Name) then
                UseMove(v)
            end
        end
    end
end

if _G.MoveSpam then
    MoveSpam()
end
game:GetService("UserInputService").InputBegan:Connect(function(key, typing)
    if (key.KeyCode == Enum.KeyCode[ToggleKey:upper()]) and not typing then
        _G.MoveSpam = not _G.MoveSpam
        MoveSpam()
    end
end)