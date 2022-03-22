
_G.AutoOre = _G.AutoOre or false
_G.AutoSkill = _G.AutoSkill or false
_G.SlillToUse = _G.SlillToUse or "B" -- either "A" or "B" or "C"
_G.SkillDelay = _G.SkillDelay or 0.5

_G.AutoFarm = _G.AutoFarm or true



local Player = game.Players.LocalPlayer

if fireclickdetector and firetouchinterest then
    coroutine.wrap(function()
        while _G.AutoOre do task.wait()
            for i, v in pairs(game:GetService("Workspace").Ore:GetDescendants()) do
                if v.Name == "Stone" then
                    local ClickDetector = v:FindFirstChild("ClickDetector")
                    if ClickDetector then
                        fireclickdetector(ClickDetector)
                    end
                end
            end
        end
    end)()
    coroutine.wrap(function()
        while _G.AutoOre do task.wait()
            for i, v in pairs(game.Workspace:GetChildren()) do
                if v:IsA("Tool") then
                    local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
                    if HRP then
                        firetouchinterest(HRP, v.Handle, 0)
                    end
                end
            end
        end
    end)()
else
    if _G.AutoOre then
        local SynapseMessage = Instance.new("Message", game:GetService("CoreGui"))
        SynapseMessage.Name = "SynapseMessage"
        SynapseMessage.Text = "AutoOre is synapse only unfortunately"
    else
        for i, v in pairs(game:GetService("CoreGui")) do
            if v.Name == "SynapseMessage" then
                v:Destroy()
            end
        end
    end
end
coroutine.wrap(function()
    while _G.AutoSkill do task.wait(_G.SkillDelay)
        game:GetService("ReplicatedStorage").SkillRemotes[Player.Stats.Bottle.Value][_G.SlillToUse]:FireServer()
    end
end)()
local function ServerHop()
    local x = {}
	for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
		if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
			x[#x + 1] = v.id
		end
	end
	if #x > 0 then
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
	end
end
coroutine.wrap(function()
    while _G.AutoFarm do
        local Found = false
        for i, v in pairs(game:GetService("Workspace").Mobs:GetDescendants()) do
            if v:IsA("Model") then
                local EHum = v:FindFirstChild("Humanoid")
                local EHRP = v:FindFirstChild("HumanoidRootPart")
                local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
                if EHum and EHRP and HRP then
                    if (EHum.Health > 0) then
                        Found = true
                        while _G.AutoFarm do task.wait()
                            if not (EHum.Health > 0) then break end
                            HRP.CFrame = CFrame.new(EHRP.Position - (EHRP.CFrame.LookVector*5), EHRP.Position)
                            game:GetService("ReplicatedStorage").SkillRemotes[Player.Stats.Bottle.Value][_G.SlillToUse]:FireServer()
                        end
                    end
                end
            end
        end
        if not Found then
            ServerHop()
        end
        task.wait()
    end
end)()

game:GetService("RunService").Heartbeat:Connect(function(deltatime)
    if deltatime > 3 then
        ServerHop()
    end
end)