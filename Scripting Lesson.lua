-- Variables

local Number = 1
local String = "String"
local Boolean = true -- true or false
local Nothing = nil
local Table = {
    NewTable = {"String", 1};
    NewTable2 = {true, false}
}

local Character = game.Players.LocalPlayer.Character
local HRP = Character.HumanoidRootPart

local function Stop()
    HRP.Anchored = true
end

local function Test()
    print("Test")
end

local ExampleTable = {}
ExampleTable.TestIndex = Test

ExampleTable:TestIndex()


-- Important Lua Statements
-- If, For, While

local AutoFarm = false

if AutoFarm == true then
    print("Start")
end

while AutoFarm == true do wait(0.5)
    print("Hit")
end

-- AutoFarm for Anime Clickers

_G.Ciao = true

while _G.Ciao == true do wait()
    local args = {
        [1] = false,
        [2] = "Clicker!"
    }
    game:GetService("ReplicatedStorage").Remotes.ClickRemote:FireServer(unpack(args))
end

--Tmrw: For, CFrame