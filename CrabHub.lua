if not game:IsLoaded() then game.Loaded:Wait() end
loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Functions%20and%20stuff.lua'),true))()
local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local FileName = "CrabHub.JSON"
local function SaveSettings()
    writefile(FileName, game:GetService("HttpService"):JSONEncode(_G.CrabHub))
end

local function LoadSettings()
    if isfile(FileName) then
        _G.CrabHub = game:GetService("HttpService"):JSONDecode(readfile(FileName))
    end
end

_G.CrabHub = {}
LoadSettings()

local CrabHubUI = Material.Load({
	Title = "CrabHub",
	Style = 2,
	SizeX = 690,
	SizeY = 690,
	Theme = "Light"
})

local General = CrabHubUI.New({
    Title = "General",
    ImageID = 8496586222
})

local DefaultFOV = math.floor(workspace.CurrentCamera.FieldOfView)

workspace.CurrentCamera.FieldOfView = _G.CrabHub.FieldOfView or DefaultFOV

General.Slider({Text = "Field Of View",
	Callback = function(Value)
		workspace.CurrentCamera.FieldOfView = Value
	end,
	Min = 1,
	Max = 120,
	Def = _G.CrabHub.FieldOfView or DefaultFOV
})

local bb=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    if _G.CrabHub.AntiAfk then
        bb:CaptureController()
        bb:ClickButton2(Vector2.new()) 
    end
end)

General.Toggle({Text = "Anti Afk", Enabled = _G.CrabHub.AntiAfk, Callback = function(bool)
    _G.CrabHub.AntiAfk = bool
    SaveSettings()
end})

local function FullBright(bool)
    _G.CrabHub.FullBright = bool
    SaveSettings()
    while _G.CrabHub.FullBright do FastWait()
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").ClockTime = 14
        game:GetService("Lighting").FogEnd = 100000
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    end
end

General.Toggle({Text = "Full Brightness", Enabled = _G.CrabHub.FullBright, Callback = FullBright})

local function AutoRejoin(bool)
    _G.CrabHub.AutoRejoin = bool
    SaveSettings()
    while _G.CrabHub.AutoRejoin do wait(1)
        if game:GetService("CoreGui").RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt") then 
            game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
        end
    end
end

General.Toggle({Text = "AutoRejoin", Enabled = _G.CrabHub.AutoRejoin, Callback = AutoRejoin})

General.Button({Text = "Fps Boost",
	Callback = function()
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
        Notify("Potato Pc")
	end,
	Menu = {
		Information = function(self)
			CrabHubUI.Banner({
				Text = "This makes the game look ugly but boosts the fps by a lot."
			})
		end
	}
})

General.Button({Text = "Delete Configuration",
	Callback = function()
		if isfile(FileName) then
            delfile(FileName)
        end
	end,
	Menu = {
		Information = function(self)
			CrabHubUI.Banner({
				Text = "Every thing you do on the GUI get saved, this resets all of the saves to default"
			})
		end
	}
})

if (game.PlaceId == 6461766546) then
    local AHD = CrabHubUI.New({Title = "A Hero Destiny", ImageID = 8496586222})

    local function AutoFarmAHD(bool)
        spawn(function()
            _G.CrabHub.AutoFarmAHD = bool
            SaveSettings()
            local PlayerLevelInstance = Player:WaitForChild("Stats"):WaitForChild("Level")
            while _G.CrabHub.AutoFarmAHD do FastWait()
                for i, v in pairs(game:GetService("Workspace").Spawns:GetChildren()) do
                    if _G.CrabHub.ChosenNpcListAHD[v.Name] then
                        local NpcInstance = v:FindFirstChild(v.Name)
                        if NpcInstance then
                            local QuestNumber = 0
                            local QuestMod = require(game:GetService("ReplicatedStorage").Modules.Quests)
                            for i, v in pairs(QuestMod) do
                                if v.Target == NpcInstance.Name then
                                    QuestNumber = i
                                    break
                                end
                            end
                            local NpcHuman = NpcInstance:FindFirstChild("Humanoid")
                            local NpcHRP = NpcInstance:FindFirstChild("HumanoidRootPart")
                            if NpcHuman and NpcHRP then
                                while _G.CrabHub.AutoFarmAHD and not (NpcInstance.Parent == nil) do FastWait()
                                    local PlayerHRP = PlayerCheck()
                                    if PlayerHRP then
                                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("GetQuest", QuestNumber)
                                        PlayerHRP.CFrame = CFrame.new(NpcHRP.Position - (NpcHRP.CFrame.LookVector * 1.5), NpcHRP.Position)
                                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Punch", "Right")
                                        if Player.Stats.Class.Value == "Angel" then
                                            Player.Stats.Class.Value = "PuriPuri"
                                        end
                                        for i=1, 5 do
                                            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(string.gsub(Player.Stats.Class.Value.. "Attack"..i, " ", ""), NpcHRP.Position)
                                        end
                                        if PlayerCheck() and PlayerLevelInstance.Value >= 200 then
                                            while Player.Character:FindFirstChild("Form") and _G.CrabHub.AutoFarmAHD do 
                                                if PlayerCheck() then
                                                    local AttackMod = require(Player.PlayerGui.Cooldown.CooldownBackground.Input.LocalAttacks)
                                                    if Player.Character.Form.Value == nil or Player.Character.Form.Value == "" or Player.Character.Form.Value == " " then
                                                        AttackMod[string.gsub(Player.Stats.Class.Value.. "Attack"..6, " ", "")]()
                                                        wait(0.5)
                                                    else
                                                        break
                                                    end
                                                    FastWait()
                                                else break
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end

    AHD.Toggle({Text = "AutoFarm", Callback = AutoFarmAHD, Enabled = _G.CrabHub.AutoFarmAHD})

    if not _G.CrabHub.ChosenNpcListAHD then
        _G.CrabHub.ChosenNpcListAHD = {}
        for i, v in pairs(game:GetService("Workspace").Spawns:GetChildren()) do
            local QuestMod = require(game:GetService("ReplicatedStorage").Modules.Quests)
            for i1, v1 in pairs(QuestMod) do
                if (v1.Target == v.Name) and (v1.Amount == 1) then
                    _G.CrabHub.ChosenNpcListAHD[v.Name] = false
                    break
                end
            end
        end
    end

    local NpcTable = _G.CrabHub.ChosenNpcListAHD

    AHD.DataTable({Text = "Choose the Npcs", Options = NpcTable, Callback = function(NpcTableTemp)
        table.foreach(NpcTableTemp, function(Option, Value)
            _G.CrabHub.ChosenNpcListAHD[Option] = Value
            SaveSettings()
        end)
    end})
end

local Credits = CrabHubUI.New({Title = "Credits", ImageID = 8496586222})

Credits.Dropdown({Text = "Creators",
	Callback = function(string)
        if (string == "Suricato") then
		    Notify("Suricato006", "Tha scripter")
        elseif (string == "Wally") then
            Notify("Wally-rblx", "Ui Library")
        elseif (string == "Nevertrack") then
            Notify("Clown", "*clown music intensifies*")
        end
	end,
	Options = {
		"Suricato",
		"Wally",
		"Nevertrack"
	}
})

Credits.Button({
	Text = "Discord Server",
	Callback = function()
		local http = game:GetService('HttpService') 
        Notify('Discord Invite', 'discord.gg/5NYqSVwH9Q')
        local req = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request
        if req then
            req({
                Url = 'http://127.0.0.1:6463/rpc?v=1',
                Method = 'POST',
                Headers = {
                    ['Content-Type'] = 'application/json',
                    Origin = 'https://discord.com'
                },
                Body = http:JSONEncode({
                    cmd = 'INVITE_BROWSER',
                    nonce = http:GenerateGUID(false),
                    args = {code = '5NYqSVwH9Q'}
                })
            })
        end
	end,
	Menu = {
		Information = function(self)
			General.Banner({
				Text = "Click to join the discord, if it doesnt work then try buying synapse ;)"
			})
		end
	}
})