local GuiService = game:GetService("GuiService")
_G.AutoFarm = not _G.AutoFarm

local function Rebirth()
    game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.StatsService.RebirthUp:FireServer()
end
local function Punch()
    local args = {
        [1] = {
            ["Type"] = 1,
            ["Began"] = true,
            ["CFrame"] = CFrame.new(),
            ["Aim"] = CFrame.new(),
            ["Camera"] = CFrame.new(),
            ["Name"] = "Combat",
            ["Target"] = workspace,
            ["IsHeavy"] = false,
            ["Velocity"] = Vector3.new()
        }
    }

    game:GetService("ReplicatedStorage").Remotes.SkillRemote:FireServer(unpack(args))

end

local Player = game.Players.LocalPlayer

local Multipliers = {
    ["Time Chamber"] = {
        ["Power"] = 50000,
        ["Rebirth"] = 0,
        Index = 1
    },
    ["Capsule Ship"] = {
        ["Power"] = 500000,
        ["Rebirth"] = 0,
        Index = 2
    },
    ["Korin Tower"] = {
        ["Power"] = 5000000,
        ["Rebirth"] = 0,
        Index = 3
    },
    ["King Kai's Planet"] = {
        Power = 25000000,
        Rebirth = 0,
        Index = 4
    }
}

local function FindZone()
    if not (game.PlaceId == 3177438863) then
        return "Starter Zone"
    end
    local RebirthStat = Player.Stats.Rebirth.Value
    local PowerStat = Player.Stats.Power.Value
    local ClosestIndex = 1
    local ClosestZone = ""
    for i, v in pairs(Multipliers) do
        if (v.Power < PowerStat) and (v.Rebirth < RebirthStat) and (v.Index > ClosestIndex) then
            ClosestIndex = v.Index
            ClosestZone = i
        end
    end
    return ClosestZone
end

game:GetService("RunService").Heartbeat:Connect(function()
    if not _G.AutoFarm then
        return
    end
    local Zone = workspace:FindFirstChild(FindZone(), true)
    Player.Character:WaitForChild("HumanoidRootPart").CFrame = Zone.CFrame
    Punch()
    Rebirth()
end)