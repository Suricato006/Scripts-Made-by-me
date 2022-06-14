local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local Player = game.Players.LocalPlayer
local Camera = workspace:FindFirstChildWhichIsA("Camera")
local InputLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/InputFunctions%20Library.lua"))()

local CrabHub = Material.Load({
	Title = "CrabHub",
	Style = 3,
	SizeX = 500,
	SizeY = 350,
	Theme = "Light",
})

local AutoFarmTab = CrabHub.New({
	Title = "AutoFarm"
})

local Keys = {
    Enum.KeyCode.E,
    Enum.KeyCode.R,
    Enum.KeyCode.C,
    Enum.KeyCode.F
}

local BossTable = {}
AutoFarmTab.Toggle({
	Text = "Autofarm",
	Callback = function(Value)
		_G.AutoFarm = Value
        while _G.AutoFarm do task.wait()
            for i, v in pairs(BossTable) do
                if v and _G.AutoFarm then
                    local Npc = workspace.Spawns:FindFirstChild(i):FindFirstChild(i)
                    if Npc and Npc:FindFirstChild("Humanoid") and not (Npc.Humanoid.Health == 0) then
                        for i1, v1 in pairs(require(game:GetService("ReplicatedStorage").Modules.Quests)) do
                            if v1.Target == i then
                                for _, Folder in pairs(Player:GetChildren()) do
                                    if Folder:IsA("Folder") and (Folder.Name == "Quest") then
                                        Folder:Destroy()
                                    end
                                end
                                game:GetService("ReplicatedStorage").RemoteEvent:FireServer("GetQuest", i1)
                                Player:WaitForChild("Quest")
                                break
                            end
                        end
                        local EHum = Npc:WaitForChild("Humanoid")
                        local EHrp = Npc:WaitForChild("HumanoidRootPart")
                        while _G.AutoFarm do task.wait()
                            local Char = Player.Character or Player.CharacterAdded:Wait()
                            local Hrp = Char:WaitForChild("HumanoidRootPart")
                            if EHum.Health == 0 then
                                break
                            end
                            Camera.CameraType = Enum.CameraType.Scriptable
                            Hrp.CFrame = CFrame.new(EHrp.Position - EHrp.CFrame.LookVector * 3, EHrp.Position)
                            Camera.CFrame = CFrame.new(Hrp.Position - Hrp.CFrame.LookVector * 5 + Vector3.new(0, 10, 0), EHrp.Position)
                            InputLibrary.MoveMouse(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Punch", "Right")
                            for _, Key in pairs(Keys) do
                                InputLibrary.PressKey(Key)
                            end
                        end
                        Camera.CameraType = Enum.CameraType.Custom
                    end
                end
            end
        end
        Camera.CameraType = Enum.CameraType.Custom
	end,
	Enabled = false
})

for i, v in pairs(require(game:GetService("ReplicatedStorage").Modules.Quests)) do
    if v.Amount == 1 then
        BossTable[v.Target] = false
    end
end

AutoFarmTab.DataTable({
	Text = "Chipping away",
	Callback = function(ChipSet)
        for i, v in pairs(ChipSet) do
            BossTable[i] = v
        end
	end,
	Options = BossTable
})

local SpinTab = CrabHub.New({
	Title = "AutoSpin"
})

local SpinTable = {}
local SpinToggle = nil
SpinToggle = SpinTab.Toggle({
	Text = "AutoSpin",
	Callback = function(Value)
		_G.AutoSpin = Value
        while _G.AutoSpin do task.wait()
            game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer()
            for i, v in pairs(SpinTable) do
                if SpinTable[Player.Stats.Class.Value] then
                    SpinToggle:SetState(false)
                    break
                end
            end
        end
	end,
	Enabled = false
})

for i, v in pairs(require(game:GetService("ReplicatedStorage").Modules.Classes).Lucky) do
    SpinTable[v.Item] = false
end

SpinTab.DataTable({
	Text = "Chipping away",
	Callback = function(ChipSet)
        for i, v in pairs(ChipSet) do
            SpinTable[i] = v
        end
	end,
	Options = SpinTable
})