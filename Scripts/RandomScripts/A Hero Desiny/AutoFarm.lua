local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local Player = game.Players.LocalPlayer

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

local function RemoteAttack(Number, AttackPosition)
    if Player.Stats.Class.Value == "Angel" then
        Player.Stats.Class.Value = "Puri Puri"
    end
    if Player.Stats.Class.Value == "Broly" then
        Player.Stats.Class.Value = "Toxin"
    end 
    local ClassString = string.gsub(Player.Stats.Class.Value, " ", "")
    local AttackArg = ClassString.."Attack"..tostring(Number)
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(AttackArg, AttackPosition)
end

Player.CharacterAdded:Connect(function()
    task.wait(2)
    RemoteAttack(6)
end)

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
                            Hrp.CFrame = CFrame.new(EHrp.Position - EHrp.CFrame.LookVector * 3, EHrp.Position)
                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Punch", "Right")
                            for Number=1, 5 do
                                RemoteAttack(Number, EHrp.Position)
                            end
                        end
                    end
                end
            end
        end
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