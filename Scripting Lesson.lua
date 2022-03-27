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