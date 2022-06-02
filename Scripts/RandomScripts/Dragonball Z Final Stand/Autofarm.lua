local Workspace = game:GetService("Workspace")
if not game:IsLoaded() then
    game.Loaded:Wait()
end
local Player = game.Players.LocalPlayer
local TweenService = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/OptimizedTweenLibrary.lua"))()
local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local Camera = workspace:FindFirstChildWhichIsA("Camera")
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

local function FindNpc()
	local NpcNames = {}
	for i, v in pairs(TextFieldsTable) do
		table.insert(NpcNames, v:GetText())
	end
	for i, v in pairs(workspace.Live:GetChildren()) do
		local NpcHum = v:FindFirstChild("Humanoid")
		local NpcHrp = v:FindFirstChild("HumanoidRootPart")
		if NpcHum and (NpcHum.Health > 0) and NpcHrp and (NpcHrp.Position.Y < 1600) then
			for i1, v1 in pairs(NpcNames) do
				if string.find(v.Name:lower(), v1:lower()) == 1 then
					return v
				end
			end
		end
	end
end

local AutoFarmToggle = AutoFarmTab.Toggle({
	Text = "AutoFarm",
	Callback = function(Value)
		_G.AutoFarm = Value
		Camera.CameraType = Enum.CameraType.Custom
        while _G.AutoFarm do task.wait()
			local Npc = nil
			while not Npc do task.wait()
				Npc = FindNpc()
			end
			local NpcHum = Npc:WaitForChild("Humanoid")
			local NpcHrp = Npc:WaitForChild("HumanoidRootPart")
			local Hrp = Player.Character:WaitForChild("HumanoidRootPart")
			Player.Character:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
			local Distance = (Hrp.Position - NpcHrp.Position).Magnitude
			local TimeItTakes = Distance/_G.Speed
			local Tween = TweenService:Create(Hrp, TimeItTakes, {CFrame = NpcHrp.CFrame})
			Tween:Play()
			task.wait(TimeItTakes + 0.2)
			Camera.CameraType = Enum.CameraType.Scriptable
			while _G.AutoFarm and (NpcHum.Health > 0) do
				Hrp.CFrame = CFrame.new(NpcHrp.Position + Vector3.new(3, 0, 0), NpcHrp.Position)
				Camera.CFrame = Hrp.CFrame * CFrame.new(0, 2, 15)
				task.wait()
				local yes, no = pcall(function()
					Player.Backpack.ServerTraits.Input:FireServer({"m2"}, CFrame.new(), nil, false)
				end)
				if no then warn(no) end
			end
			Camera.CameraType = Enum.CameraType.Custom
			Player.Character:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.Landed)
        end
	end,
	Enabled = false
})

local DefaultSpeed = 5000
_G.Speed = DefaultSpeed

AutoFarmTab.Slider({
	Text = "Speed to teleport",
	Callback = function(Value)
		_G.Speed = Value
	end,
	Min = 3000,
	Max = 10000,
	Def = DefaultSpeed
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

local DefaultNpc = {"Saiba", "Evil", "Chi Expert", "Kick Boxer"}
AutoFarmTab.Button({
	Text = "Load Default Settings",
	Callback = function()
		UpdateTextFields(4)
        for i, v in pairs(TextFieldsTable) do
            v:SetText(DefaultNpc[i])
        end
        AutoFarmToggle:SetState(true)
	end
})
