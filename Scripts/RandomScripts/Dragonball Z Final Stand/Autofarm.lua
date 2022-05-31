if not game:IsLoaded() then
    game.Loaded:Wait()
end
local Player = game.Players.LocalPlayer
local TweenService = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/OptimizedTweenLibrary.lua"))()
local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local Hub = Material.Load({
	Title = "Crab AutoFarm",
	Style = 3,
	SizeX = 500,
	SizeY = 350,
	Theme = "Light"
})

local AutoFarmTab = Hub.New({
	Title = "AutoFarm"
})

local TextFieldsTable = {}

local AutoFarmToggle = AutoFarmTab.Toggle({
	Text = "AutoFarm",
	Callback = function(Value)
		_G.AutoFarm = Value
        while _G.AutoFarm do task.wait()

        end
	end,
	Enabled = false
})

local TimeSlider = AutoFarmTab.Slider({
	Text = "Time it takes to goto the npc",
	Callback = function(Value)
		_G.Timer = Value
	end,
	Min = 1,
	Max = 10,
	Def = 5
})

local function UpdateTextFields(Value)
    TextFieldsTable = {}
    for i, v in pairs(game:GetService("CoreGui")["Crab AutoFarm"].MainFrame.Content.AUTOFARM:GetChildren()) do
        if v.Name == "TextField" then
            v:Destroy()
        end
    end
    for i=1, Value do
        local a = AutoFarmTab.TextField({
            Text = "Npc Name"
        })
        table.insert(TextFieldsTable, a)
    end
end

AutoFarmTab.Dropdown({
	Text = "Number of npcs",
	Callback = UpdateTextFields,
	Options = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
})

local DefaultNpc = {"Saiba", "Saiyan", "Chi Expert", "Kick Boxer"}
AutoFarmTab.Button({
	Text = "Load Default Settings",
	Callback = function()
		UpdateTextFields(4)
        for i, v in pairs(TextFieldsTable) do
            v.SetText(DefaultNpc[i])
        end
        TimeSlider.SetText(5)
        AutoFarmToggle.SetState(true)
	end
})
