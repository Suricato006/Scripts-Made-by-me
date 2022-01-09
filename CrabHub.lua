--[[ 
CrabHub
Created by Suricato006#8711

if you are someone that wants some script for a game you want to exploit ask in the discord server (https://discord.gg/JSjpgSPs4v), i will make one for sure.

The script is open source so you can learn from it, not steal it. If you want to use my script you are free to do it, just credit me.
Much love and thanks for using my script <3


(hope to make someone learn from my scripts)]]

if not game:IsLoaded() then game.Loaded:Wait() end

_G.CrabHub = true

loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Functions%20and%20stuff.lua'),true))()

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

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Uwuware%20Ui%20Library.lua", true))()
local Main = Library:CreateWindow("CrabHub")
Main.canInit = false

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

Main:AddBind({text = "Toggle Gui", key = Enum.KeyCode.RightControl, hold = false, callback = function()
    Library:Close()
end})

local FinalStandIds = {536102540, 569994010, 882399924, 2046990924, 478132461, 3552157537, 2651456105, 3565304751, 882375367}

if table.find(FinalStandIds, game.PlaceId) then
    local Window = Library:CreateWindow("Final Stand")
    Window.canInit = false

    local function NoSlowFS(bool)
        _G.VariablesTable.NoSlowFS = bool
        SaveSettings()
        local Names = {"Slow", "Using", "hyper", "Action", "Attacking", "heavy"}
        while _G.VariablesTable.NoSlowFS do FastWait()
            if PlayerCheck() then
                for i, v in pairs(Names) do
                    local a = Player.Character:FindFirstChild(v)
                    if a then
                        a:Destroy()
                    end
                end
            end
        end
    end

    Window:AddToggle({text = "No Slow", state = _G.VariablesTable.NoSlowFS, callback = NoSlowFS})

    local function GodModeFS(bool)
        if game.PlaceId == 536102540 then
            _G.VariablesTable.GodModeFS = bool
            SaveSettings()
            while _G.VariablesTable.GodModeFS do FastWait()
                if PlayerCheck() and checkcaller then
                    firetouchinterest(Player.Character.HumanoidRootPart, game:GetService("Workspace").Touchy.Part, 0)
                    Player.PlayerGui:WaitForChild("Popup").Enabled = false
                    while PlayerCheck() and _G.ActiveCommands.GodModeFS.Active do FastWait()
                        if not Player.Character:FindFirstChild("i") then
                            firetouchinterest(Player.Character.HumanoidRootPart, game:GetService("Workspace").Touchy.Part, 1)
                            break
                        end
                    end
                end
            end
        end
    end

    Window:AddToggle({text = "God Mode (Buggy)", state = _G.VariablesTable.GodModeFS, callback = GodModeFS})

    local function ChatWait()
        while true do wait(0.5)
            if Player.PlayerGui:FindFirstChild("HUD") then
                if Player.PlayerGui.HUD:FindFirstChild("Bottom") then
                    if Player.PlayerGui.HUD.Bottom:FindFirstChild("ChatGui") then
                        if Player.PlayerGui.HUD.Bottom.ChatGui.Visible then 
                            break 
                        end
                    end
                end
            else
                break
            end
        end
    end

    local Slots = {"1", "2", "3"}
    Window:AddList({text = "Change Slot", values = Slots, value = Slots[1], callback = function(chosen)
        local CharacterSlotChanger = game:GetService("Workspace").FriendlyNPCs:FindFirstChild("Character Slot Changer")
        CharacterSlotChanger:FindFirstChild("ClickDetector").MaxActivationDistance = 9999999999999999
        game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatStart:FireServer(CharacterSlotChanger)
        ChatWait()
        game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance:FireServer({"Yes"})
        ChatWait()
        game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance:FireServer({"k"})
        ChatWait()
        game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance:FireServer({"Slot"..chosen})
        ChatWait()
        game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance:FireServer({"k"})
    end})

    Window:AddBind({text = "Hard Reset", key = Enum.KeyCode.L, hold = false, callback = function()
        local si, no = pcall(function()
            local HairStylist = game:GetService("Workspace").FriendlyNPCs:FindFirstChild("Hair Stylist")
            HairStylist:FindFirstChild("ClickDetector").MaxActivationDistance = 9999999999999999
            game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatStart:FireServer(HairStylist)
            ChatWait()
            game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance:FireServer({"Yes"})
            ChatWait()
            game:GetService("Players").LocalPlayer.Backpack.HairScript.RemoteEvent:FireServer("woah")
        end)
        if no then
            Player.Character:BreakJoints()
        end
    end})

    local function NoAuraFS(bool)
        _G.VariablesTable.NoAuraFS = bool
        SaveSettings()
        while _G.VariablesTable.NoAuraFS do FastWait()
            local HRP = PlayerCheck()
            if HRP then
                for i, v in pairs(HRP:GetChildren()) do
                    if v:IsA("ParticleEmitter") then
                        v.Enabled = false
                    end
                end
            end
        end
    end

    Window:AddToggle({text = "No Aura", state = _G.VariablesTable.NoAuraFS, callback = NoAuraFS})

    local function HideLevelFS(bool)
        _G.VariablesTable.HideLevelFS = bool
        SaveSettings()
        while _G.VariablesTable.HideLevelFS do FastWait()
            if PlayerCheck() then
                for i, v in pairs(Player.Character:GetChildren()) do
                    if v:IsA("Model") then
                        v:Destroy()
                    end
                end
            end
        end
    end

    Window:AddToggle({text = "Hide Level", state = _G.VariablesTable.HideLevelFS, callback = HideLevelFS})

    local function ThrowStuckFS(bool)
        _G.VariablesTable.ThrowStuckFS = bool
        SaveSettings()
        while _G.VariablesTable.ThrowStuckFS do FastWait()
            if PlayerCheck() then
                local a = Player.Character:FindFirstChild("Dragon Crush") or Player.Character:FindFirstChild("Dragon Throw")
                if a then
                    local b = a:FindFirstChild("Activator")
                    if b then
                        local c = b:FindFirstChild("Flip")
                        if c then
                            c:Destroy()
                        end
                    end
                end
            end
        end
    end

    Window:AddToggle({text = "Throw Stuck", state = _G.VariablesTable.ThrowStuckFS, callback = ThrowStuckFS})

    local NpcNameBox = Window:AddBox({text = "Npc To Farm", value = "", callback = function(typed)
        _G.VariablesTable.NpcNameFS = typed
    end})

    local function AutoFarmFS(bool)
        _G.VariablesTable.AutoFarmFS = bool
        SaveSettings()
        local function Pugno()
            local args = {
                [1] = {
                    [1] = "m2"
                },
                [2] = Player.Character.HumanoidRootPart.CFrame,
            }
        
            game:GetService("Players").LocalPlayer.Backpack.ServerTraits.Input:FireServer(unpack(args))
        end
        while _G.VariablesTable.AutoFarmFS do
            while _G.VariablesTable.AutoFarmFS do FastWait()
                local Yes, No = pcall(function()
                    for i, v in pairs(game:GetService("Workspace").Live:GetChildren()) do
                        if NameFind(v.Name, _G.VariablesTable.NpcNameFS) then
                            while _G.VariablesTable.AutoFarmFS and PlayerCheck() and v.Humanoid.Health > 0 do FastWait()
                                if (Player.Character.HumanoidRootPart.CFrame.Position - v.HumanoidRootPart.CFrame.Position).magnitude > 50 then
                                    LerpCFrame(v.HumanoidRootPart.CFrame)
                                else
                                    Player.Character.HumanoidRootPart.CFrame = CFrame.new(v.HumanoidRootPart.CFrame.Position - v.HumanoidRootPart.CFrame.LookVector, v.HumanoidRootPart.CFrame.Position)
                                end
                                Pugno()
                            end
                        end
                    end
                end)
                if No then
                    break
                end
            end
            wait(1)
        end
    end

    Window:AddToggle({text = "AutoFarm", state = _G.VariablesTable.AutoFarmFS, callback = AutoFarmFS})

    Window:AddButton({text = "Suggested Farm", callback = function()
        NpcNameBox:SetValue("Evil Saiyan")
    end})

    local function AutoHTCFS(state)
        _G.VariablesTable.AutoHTCFS = state 
        SaveSettings()
        


if not (game.PlaceId == 882375367) and  _G.VariablesTable.AutoHTCFS then
    Notify("Teleporting to HTC")
    game:GetService("TeleportService"):Teleport(882375367, LocalPlayer)
end

local function Pugno()
 
    local args = {
        [1] = {
            [1] = "m2"
        },
        [2] = Player.Character.HumanoidRootPart.CFrame,
    }
 
    Player.Backpack.ServerTraits.Input:FireServer(unpack(args))
end

local function Rejoin()
    local Players = game.Players
    if #Players:GetPlayers() <= 1 then
        Players.LocalPlayer:Kick("\nRejoining...")
        wait()
        game:GetService('TeleportService'):Teleport(game.PlaceId, Players.LocalPlayer)
    else
        game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
    end
end

spawn(function()
    while  _G.VariablesTable.AutoHTCFS do FastWait()
        if PlayerCheck() then
            local a = Player.Character:FindFirstChild("Dragon Crush") or Player.Character:FindFirstChild("Dragon Throw")
            if a then
                local b = a:FindFirstChild("Activator")
                if b then
                    local c = b:FindFirstChild("Flip")
                    if c then
                        c:Destroy()
                    end
                end
            end
        end
    end
end)

spawn(function()
    local Names = {"Slow", "Using", "hyper", "Action", "Attacking", "heavy"}
    while  _G.VariablesTable.AutoHTCFS do FastWait()
        if PlayerCheck() then
            for i, v in pairs(Names) do
                local a = Player.Character:FindFirstChild(v)
                if a then
                    a:Destroy()
                end
            end
        end
    end
end)

local LevelLabel = Player.PlayerGui:WaitForChild("HUD"):WaitForChild("Bottom"):WaitForChild("Stats"):WaitForChild("LVL"):WaitForChild("Val")

local function MoveSpam()
    local Moves = {"TS Molotov", "Wolf Fang Fist", "Mach Kick", "Flash Skewer", "Vital Strike", "Meteor Crash", "Neo Wolf Fang Fist","GOD Hakai","GOD Wrath","Trash","Strong Kick", "Combo Barrage", "Aerial Breaker"}
    while  _G.VariablesTable.AutoHTCFS do FastWait()
        if PlayerCheck() then
            Player.Character.HumanoidRootPart.Anchored = true
            local KiPercentage = Player.Character.Ki.Value/Player.Character.Stats["Ki-Max"].Value * 100
            print(KiPercentage)
            if KiPercentage > 10 then
                for i, v in pairs(Player.Backpack:GetChildren()) do
                    for _, Move in pairs(Moves) do
                        if v.Name == Move and PlayerCheck() then
                            v.Parent = Player.Character 
                            FastWait()
                            v:Activate()
                            FastWait()
                            v:Deactivate()
                            v.Parent = Player.Backpack
                        end
                    end
                end
            else
                Player.Backpack.ServerTraits.EatSenzu:FireServer(true)
                Pugno()
            end
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(-40, 244, 3)
        end
        if tonumber(LevelLabel.Text) == 101 or tonumber(LevelLabel.Text) == 181 or tonumber(LevelLabel.Text) == 251 or tonumber(LevelLabel.Text) == 321 then
            Notify("Rejoining...", "Wait a sec")
            local Players = game.Players
            if #Players:GetPlayers() <= 1 then
                Players.LocalPlayer:Kick("\nRejoining...")
                wait()
                game:GetService('TeleportService'):Teleport(game.PlaceId, Players.LocalPlayer)
            else
                game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
            end
        end
    end
end

if game.PlaceId == 882375367 and  _G.VariablesTable.AutoHTCFS then
    while not PlayerCheck() do wait() end
    local Goku = game:GetService("Workspace").Live:GetChildren()[1]
    Player.Character.HumanoidRootPart.CFrame = CFrame.new(Goku.HumanoidRootPart.CFrame.Position - Goku.HumanoidRootPart.CFrame.LookVector/2, Goku.HumanoidRootPart.CFrame.Position)
    local v = Player.Backpack:FindFirstChild("Dragon Throw")
    if v then
        v.Parent = Player.Character 
        FastWait()
        v:Activate()
        wait(0.5)
        v:Deactivate()
        v.Parent = Player.Backpack
    end
    wait(0.5)
    MoveSpam()
end
end
    Window:AddToggle({text = "AutoHTC", state = _G.VariablesTable.AutoHTCFS, callback = AutoHTCFS})

end


local Credits = Library:CreateWindow("Credits")
Credits.canInit = false

Credits:AddLabel({text = "Who Created This Gui?"})

Credits:AddButton({text = "Suricato006#8711", callback = function()
    Notify("Suricato006", "Tha Scripter")
end})

Credits:AddButton({text = "Wally", callback = function()
    Notify("The creator of the Ui library", "And its the best out there")
end})

Credits:AddButton({text = "Nevertrack#4219", callback = function()
    Notify("He was useless", "what a clown")
end})

Credits:AddButton({text = "Join Discord Server", callback = function()
    local http = game:GetService('HttpService') 
	Notify('Discord Invite', 'https://discord.gg/5NYqSVwH9Q')
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
end})

Library:Init()