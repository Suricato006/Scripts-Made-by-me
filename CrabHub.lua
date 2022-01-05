--[[ 

CrabHub
Created by Suricato006#8711

if you are someone that wants some script for a game you want to exploit ask in the discord server (https://discord.gg/5NYqSVwH9Q), i will make one for sure.

The script is open source so you can learn from it, not steal it. If you want to use my script you are free to do it, just credit me.
Much love and thanks for using my script <3


(hope to make someone learn from my scripts)]]

if not game:IsLoaded() then game.Loaded:Wait() end

if _G.CrabHub then
    for i, v in pairs(game:GetService("CoreGui"):GetChildren()) do
        if v.Name == "RobloxCrashHandler" then
            v:Destroy()
        end
    end
end

_G.CrabHub = true

loadstring(game:HttpGet(('https://pastebin.com/raw/5ksZRmMp'),true))()

local FileName = "CrabHub.JSON"
local function SaveSettings()
    writefile(FileName, game:GetService("HttpService"):JSONEncode(_G.VariablesTable))
end

local function LoadSettings()
    if isfile(FileName) then
        _G.VariablesTable = game:GetService("HttpService"):JSONDecode(readfile(FileName))
    end
end

_G.VariablesTable = {}
LoadSettings()

local Library = loadstring(game:HttpGet("https://sypse.xyz/other/nothing.lua.php", true))()
local Main = Library:CreateWindow("CrabHub")

Main:AddBox({text = "Tween To Player", value = "", callback = function(typed)
    if PlayerCheck() then
        for i, v in pairs(game.Players:GetChildren()) do
            if NameFind(v.Name, typed) then
                spawn(function()
                    LerpCFrame(v.Character.HumanoidRootPart.CFrame)
                end)
                break
            end
        end
    end
end})

local bb=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    if _G.VariablesTable.AntiAfk then
        bb:CaptureController()
        bb:ClickButton2(Vector2.new()) 
    end
end)

Main:AddToggle({text = "Anti Afk", state = _G.VariablesTable.AntiAfk, callback = function(bool)
    _G.VariablesTable.AntiAfk = bool
    SaveSettings()
end})

local function AutoRejoin(bool)
    _G.VariablesTable.AutoRejoin = bool
    SaveSettings()
    while _G.VariablesTable.AutoRejoin do wait(1)
        if game:GetService("CoreGui").RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt") then 
            game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
        end
    end
end

Main:AddToggle({text = "Auto Rejoin", state = _G.VariablesTable.AutoRejoin, callback = AutoRejoin})

Main:AddButton({text = "Rejoin", callback = function()
    Notify("Rejoining...", "Wait a sec")
    local Players = game.Players
    if #Players:GetPlayers() <= 1 then
        Players.LocalPlayer:Kick("\nRejoining...")
        wait()
        game:GetService('TeleportService'):Teleport(game.PlaceId, Players.LocalPlayer)
    else
        game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
    end
end})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.VariablesTable.InfiniteJump then
        local Hum = Player.Character:FindFirstChildWhichIsA("Humanoid")
        if Hum then
            Hum:ChangeState(3)
        end
    end
end)

Main:AddToggle({text = "Infinite Jump", state = _G.VariablesTable.InfiniteJump, callback = function(bool)
    _G.VariablesTable.InfiniteJump = bool
    SaveSettings()
end})

Main:AddSlider({text = "WalkSpeed", min = 16, max = 250, dual = false, value = 16, callback = function(number)
    if PlayerCheck() then
        Player.Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = number
    end
end})

Main:AddSlider({text = "JumpPower", min = 60, max = 500, dual = false, value = 60, callback = function(number)
    if PlayerCheck() then
        Player.Character:FindFirstChildWhichIsA("Humanoid").JumpPower = number
    end
end})

Main:AddButton({text = "FpsBoost", callback = function()
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
end})

Main:AddButton({text = "DarkDex", callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Neon-Fox/roblox-scripts/main/Dex-V3"))()
end})

Main:AddButton({text = "Remote Spy", callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/mXTQRUwk"))()
end})

Main:AddButton({text = "Delete Configuration", callback = function()
    if isfile(FileName) then
        delfile(FileName)
    end
end})

Main:AddButton({text = "Destroy Gui", callback = function()
    Library:Close()
end})














local Credits = Library:CreateWindow("Credits")

Credits:AddLabel({text = "Who Created This Gui?"})

Credits:AddButton({text = "Suricato006#8711", callback = function()
    Notify("Suricato006", "Tha Scripter")
end})

Credits:AddButton({text = "Sypse", callback = function()
    Notify("The creator of the Ui library", "And its the best out there")
end})

Credits:AddButton({text = "Nevertrack#4219", callback = function()
    Notify("He was useless", "what a clown")
end})

Credits:AddButton({text = "Join Discord Server", callback = function()
    local http = game:GetService('HttpService') 
	if toClipboard then
		toClipboard('https://discord.com/invite/dYHag43eeU')
		Notify('Discord Invite', 'Copied to clipboard!\nhttps://discord.gg/JSjpgSPs4v')
	else
		Notify('Discord Invite', 'https://discord.gg/JSjpgSPs4v')
	end
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
				args = {code = 'JSjpgSPs4v'}
			})
		})
	end
end})

Library:Init()