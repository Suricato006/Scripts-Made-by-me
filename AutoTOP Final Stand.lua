local DefaultSettings = {
    Anchored = true,
    DoubleExpFreeze = true,
    TimeToWaitForForm = 3.9,
    Form = "h",
    LowGraphics = true,
    AutoExecuteTheScript = true, --Synapse only
    ResetWhenLowKi = true,
    Moves = {
        "Neo Wolf Fang Fist";
        "Final Blow";
        "Wolf Fang Fist";
        "Anger Rush";
        "Flash Strike";
        "Trash?";
        "Flash Skewer";
        "Meteor Crash";
        "Deadly Dance";
        "Trash???";
        "TS Molotov";
        "Sweep Kick";
        "God Slicer";
        }
    }

_G.TOPSettings = DefaultSettings

local AutoExec = false
if not game:IsLoaded() then
    AutoExec = true
    game.Loaded:Wait()
end

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local OwnScriptUrl = ""
if syn and not (OwnScriptUrl == "") then
    Player.OnTeleport:Connect(function(State)
        if State == Enum.TeleportState.Started then
            syn.queue_on_teleport(game:HttpGet(OwnScriptUrl))
        end
    end)

    local FileName = "AutoTop.CRAB"
    if isfile(FileName) then
        _G.TOPSettings = _G.TOPSettings or HttpService:JSONDecode(readfile(FileName))
    end
    local ToEncode = _G.TOPSettings or DefaultSettings
    writefile(FileName, HttpService:JSONEncode(ToEncode))
end

_G.TOPSettings = _G.TOPSettings or DefaultSettings

if AutoExec then
    Player.CharacterAdded:Wait()
end

coroutine.wrap(function()
    local Library = loadstring(game:HttpGet("https://pastebin.com/raw/GX28T0pH", true))()
    local Credits = Library:CreateWindow("Credits")

    Credits:AddLabel({text = "Who Created This Gui?"})

    Credits:AddLabel({text = "CrabGuy#8711"})

    Credits:AddLabel({text = "Nevertrack#4219"})

    Credits:AddLabel({text = "----DiscordServer----"})

    Credits:AddLabel({text = "discord.gg/5NYqSVwH9Q"})

    Credits:AddButton({text = "Join Discord Server", callback = function()
        pcall(function()
            syn.write_clipboard("https://discord.gg/5NYqSVwH9Q")
        end)
        local req = syn and syn.request or HttpService and HttpService.request or http_request or fluxus and fluxus.request or getgenv().request or request
        if req then
            req({
                Url = 'http://127.0.0.1:6463/rpc?v=1',
                Method = 'POST',
                Headers = {
                    ['Content-Type'] = 'application/json',
                    Origin = 'https://discord.com'
                },
                Body = HttpService:JSONEncode({
                    cmd = 'INVITE_BROWSER',
                    nonce = HttpService:GenerateGUID(false),
                    args = {code = '5NYqSVwH9Q'}
                })
            })
        end
    end})

    Library:Init()
end)()

local function ReturnToEarth()
    game:GetService("TeleportService"):Teleport(536102540, game.Players.LocalPlayer)
end

local HRP = Player.Character:WaitForChild("HumanoidRootPart")

if _G.TOPSettings.DoubleExpFreeze then
    game:GetService("RunService").Heartbeat:Connect(function()
        local TimerLabel = Player.PlayerGui:WaitForChild("HUD"):FindFirstChild("Timer", true)
        if TimerLabel then
            if TimerLabel.Visible and not (TimerLabel.Text == "") then
                local a = Player.Character:FindFirstChild("True")
                if a then
                    a:Destroy()
                end
            end
        end
    end)
end

if _G.TOPSettings.LowGraphics then
    workspace:FindFirstChildOfClass('Terrain').WaterWaveSize = 0
	workspace:FindFirstChildOfClass('Terrain').WaterWaveSpeed = 0
	workspace:FindFirstChildOfClass('Terrain').WaterReflectance = 0
	workspace:FindFirstChildOfClass('Terrain').WaterTransparency = 0
	game:GetService("Lighting").GlobalShadows = false
	game:GetService("Lighting").FogEnd = 9e9
	settings().Rendering.QualityLevel = 1
	for i,v in pairs(game:GetDescendants()) do
		if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
		elseif v:IsA("Decal") then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1
			v.BlastRadius = 1
		end
	end
	for i,v in pairs(game:GetService("Lighting"):GetDescendants()) do
		if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
			v.Enabled = false
		end
	end
	workspace.DescendantAdded:Connect(function(child)
		coroutine.wrap(function()
			if child:IsA('ForceField') then
				game:GetService('RunService').Heartbeat:Wait()
				child:Destroy()
			elseif child:IsA('Sparkles') then
				game:GetService('RunService').Heartbeat:Wait()
				child:Destroy()
			elseif child:IsA('Smoke') or child:IsA('Fire') then
				game:GetService('RunService').Heartbeat:Wait()
				child:Destroy()
			end
		end)()
	end)
end
local KiStat = Player.Character:WaitForChild("Ki")
local KiMax = KiStat.Value

local Insults = {"Damn bro, Z-Shuko scripts roblox in python bro", "Sypse gets clipped in brawlhalla", "Chris is a cool guy", "Cake autobroly is sooo bad :kekw:", "DiscoServer: .gg/5NYqSVwH9Q", "Nevertrack, what a clown", "Damn bro, Crab looks so fine, DRIP", "Black is a skid ;)"}

coroutine.wrap(function()
    while true do
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Insults[math.random(1,#Insults)], "All")
        task.wait(1)
    end
end)()


RunService.Heartbeat:Connect(function()
    if game:GetService("CoreGui").RobloxPromptGui:FindFirstChild("ErrorPrompt", true) then
        ReturnToEarth()
    end
end)

local MoveNames = {"Action", "Attacking", "Using", "hyper", "Hyper", "heavy", "KiBlasted", "Tele", "tele", "Killed", "Slow", "Blocked", "MoveStart", "NotHardBack", "SuperAction"}
RunService.Heartbeat:Connect(function()
    for i, v in pairs(MoveNames) do
        local a = Player.Character:FindFirstChild(v)
        if a then
            a:Destroy()
        end
    end
end)



if (game.PlaceId == 536102540) then
    local Humanoid = Player.Character.Humanoid
    while not (Humanoid.Sit) do task.wait()
        local Tile = game.Workspace:FindFirstChild("Tile", true)
        if not (Tile.Color == Color3.new(1, 1, 0)) then
            Tile.Parent:Destroy()
            Tile = game.Workspace:FindFirstChild("Tile", true)
        end
        Tile.Anchored = false
        Tile.CFrame = Player.Character.HumanoidRootPart.CFrame
    end
elseif (game.PlaceId == 535527772) then
    local function Pugno()
        Player.Backpack.ServerTraits.Input:FireServer({"m2"}, HRP.CFrame)
    end
    local function UseMove(Move)
        Move.Parent = Player.Character
        task.wait()
        Move:Activate()
        task.wait()
        Move:Deactivate()
        Move.Parent = Player.Backpack
    end
    local Android = (Player.Character:WaitForChild("Race").Value == "Android")
    local TransformEvent = Player.Backpack.ServerTraits.Transform
    local InputEvent = Player:FindFirstChild("Input", true)
    local GodForm = false
    local Humanoid = Player.Character.Humanoid
    local MaxHealth = Humanoid.MaxHealth

    while true do
        for i, Enemy in pairs(game.Workspace.Live:GetChildren()) do
            local EHum = Enemy:FindFirstChild("Humanoid")
            local EHRP = Enemy:FindFirstChild("HumanoidRootPart")
            local Jiren = (Enemy.Name == "Jiren")
            local JirenPos = EHRP.CFrame
            if EHum then
                if (EHum.Health > 0) then
                    while true do
                        local KiValue = KiStat.Value
                        local KiPercentage = (KiValue * 100 / KiMax)
                        local EHRP = Enemy:FindFirstChild("HumanoidRootPart")
                        if Humanoid.Health <= 1 then
                            repeat
                                task.wait()
                            until Humanoid.Health == Humanoid.MaxHealth
                            local tween = game:GetService("TweenService"):Create(HRP,TweenInfo.new(1,  Enum.EasingStyle.Quad),{CFrame = CFrame.new(100, 100, 100)})
                            tween:Play()
                            tween.Completed:Wait()
                        end
                        if (Player.Character.ExpGain.Value == 1) and (not Player.Character.Head:FindFirstChild("Ui1")) then
                            if Android then
                                if (KiPercentage <= 70) then
                                    TransformEvent:FireServer("g")
                                end
                            else
                                if InputEvent and TransformEvent then
                                    InputEvent:FireServer({[1] = "x"},CFrame.new(0,0,0),nil,false)
                                    task.wait(_G.TOPSettings.TimeToWaitForForm)
                                    TransformEvent:FireServer(_G.TOPSettings.Form)
                                    task.wait(1)
                                    InputEvent:FireServer({[1] = "xoff"},CFrame.new(0,0,0),nil,false)
                                end
                            end
                        end
                        if Jiren then
                            while (not Enemy:FindFirstChild("MoveStart")) do
                                HRP.CFrame = CFrame.new(Enemy.HumanoidRootPart.Position - Enemy.HumanoidRootPart.CFrame.LookVector/2, Enemy.HumanoidRootPart.Position)
                                local Throw = Player.Backpack:FindFirstChild("Dragon Crush") or Player.Backpack:FindFirstChild("Dragon Throw")
                                if not Throw then
                                    local ThrowMessage = Instance.new("Message", game:GetService("CoreGui"))
                                    ThrowMessage.Text = "You need to have Dragon Crush or Dragon Throw, rejoin and buy it. If this is an error then just rejoin"
                                    return
                                end
                                if Throw then
                                    Throw.Parent = Player.Character
                                    local b = Throw:FindFirstChild("Flip", true)
                                    if b then
                                        b:Destroy()
                                    end
                                    task.wait()
                                    Throw:Activate()
                                    task.wait()
                                    Throw:Deactivate()
                                    Throw.Parent = Player.Backpack
                                end
                                task.wait()
                            end
                        end
                        if KiValue > 32 then
                            for i, v in pairs(Player.Backpack:GetChildren()) do
                                if table.find(_G.TOPSettings.Moves, v.Name) then
                                    UseMove(v)
                                end
                            end
                        else
                            if not _G.TOPSettings.ResetWhenLowKi then
                                Pugno()
                            else
                                game:GetService("ReplicatedStorage").ResetChar:FireServer()
                            end
                            task.wait()
                        end
                        if (KiPercentage <= 5) and ((Humanoid.Health * 100 / MaxHealth) < 15) and not GodForm then
                            task.wait(0.2)
                            TransformEvent:FireServer("g")
                            GodForm = true
                        end
                        local EnemyHealth = math.floor(Enemy.Humanoid.Health)
                        if (EnemyHealth == 0) or not EHRP then
                            break
                        end
                        Player.Backpack.ServerTraits.EatSenzu:FireServer(true)
                        if Jiren then
                            Player.Character.HumanoidRootPart.Anchored = true
                            HRP.CFrame = JirenPos
                        else
                            HRP.CFrame = CFrame.new(Enemy.HumanoidRootPart.Position - Enemy.HumanoidRootPart.CFrame.LookVector/2, Enemy.HumanoidRootPart.Position)
                        end
                    end
                end
            end
        end
    end
end