_G.ResetSlot = _G.ResetSlot or "Slot3" --Slot that will get resetted
_G.Slot = _G.Slot or "Slot1" --Slot that will get the stats

--Shuko should learn lua and not script in python fr fr

if not game:IsLoaded() then
    game.Loaded:Wait()
end
local Player = game.Players.LocalPlayer
if not Player.Character then
    Player.CharacterAdded:Wait()
end
local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/Notification%20Library%20Optimization.lua"))()

if game.PlaceId == 552500546 then
    local RaceLabel = Player:WaitForChild("PlayerGui"):WaitForChild("Setup"):WaitForChild("Frame"):WaitForChild("Side"):WaitForChild("Race")
    while not (RaceLabel:WaitForChild("Set"):WaitForChild("Texter").Text == "Namekian") do
        game:GetService("Players").LocalPlayer.Backpack.Scripter.RemoteEvent:FireServer(RaceLabel, "up")
        task.wait(.5)
    end
    Player:WaitForChild("Backpack"):WaitForChild("Scripter"):WaitForChild("RemoteEvent"):FireServer("woah")
    return
end

if not (game.PlaceId == 536102540) then
    NotificationLibrary.CustomNotification("Wrong Game Buddy", "This is a final stand script")
    return
end

task.wait(3)

local function NpcTalk(Npc, CustomOption)
    local ChatGui = Player:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("Bottom"):WaitForChild("ChatGui")
    local TextLabel = ChatGui:WaitForChild("TextLabel")
    local Option1 = ChatGui:WaitForChild("Opt1")
    Player:WaitForChild("Backpack"):WaitForChild("ServerTraits"):WaitForChild("ChatStart"):FireServer(Npc)
    repeat
        task.wait()
    until ChatGui.Visible
    local Chat = Npc:FindFirstChildWhichIsA("Folder")
    local NextChat = Chat
    local ChatAdvance = Player.Backpack.ServerTraits.ChatAdvance
    while ChatGui.Visible do
        NextChat = NextChat:FindFirstChildWhichIsA("StringValue")
        if (NextChat.Name == "Quest") or (NextChat.Name == "ChatEvent") then
            repeat
                ChatAdvance:FireServer({"k"})
                task.wait()
            until not ChatGui.Visible
            break
        end
        while not (TextLabel.Text == NextChat.Value) and (ChatGui.Visible) do
            local OptionText = Option1.Text
            if OptionText == "Slot1" then
                OptionText = CustomOption or OptionText
            end
            local Argument = nil
            if Option1.Visible then
                Argument = OptionText
            else
                Argument = "k"
            end
            ChatAdvance:FireServer({Argument})
            task.wait()
        end
        task.wait(0.15)
    end
end

local function SlotChange(slot) --Im tired of this shit, i cant get it to work in a different way so i copied it, credits to justroberto
    local ChatGui = Player:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("Bottom"):WaitForChild("ChatGui")
    local TextLabel = ChatGui:WaitForChild("TextLabel")
    Player.Backpack.ServerTraits.ChatStart:FireServer(workspace.FriendlyNPCs["Character Slot Changer"])
    local ChatAdvance = Player.Backpack.ServerTraits.ChatAdvance
    repeat task.wait() ChatAdvance:FireServer({"Yes"}) until TextLabel.Text == "Alright"
    task.wait(.1)
    repeat task.wait() ChatAdvance:FireServer({"k"}) until TextLabel.Text == "Which slot would you like to play in?"
    task.wait(.1)
    repeat task.wait() ChatAdvance:FireServer({slot}) until TextLabel.Text == "Loading!"
end

local Camera = workspace:FindFirstChildWhichIsA("Camera")
local function GetTheStats()
    Player.Backpack.ServerTraits.ChatStart:FireServer(workspace.FriendlyNPCs['KAMI'])
    task.wait(.75)
    Player.Backpack.ServerTraits.ChatAdvance:FireServer({'k'})
    task.wait(.5)
    SlotChange(_G.Slot)
end

if not (Player.Character:WaitForChild("Race").Value == "Namekian") then
    SlotChange(_G.ResetSlot)
    Player.CharacterAdded:Wait()
end

if (tonumber(Player:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("Bottom"):WaitForChild("Stats"):WaitForChild("LVL"):WaitForChild("Val").Text) > 49) or not workspace.FriendlyNPCs:FindFirstChild("KAMI") then
    NpcTalk(workspace.FriendlyNPCs["Start New Game [Redo Character]"])
    return
end
--The thing that makes the game crash if you are in a public server
if #game.Players:GetChildren() > 1 then
    game:shutdown()
    print("Game Should Close")
    return
end

local function TakeQuest(QuestName)
    local QuestNpc = nil
    for i, v in pairs(game:GetService("Workspace").FriendlyNPCs:GetChildren()) do
        local QuestLabel = v:FindFirstChild("Quest", true)
        if QuestLabel and QuestLabel.Value == QuestName then
            QuestNpc = v
            break
        end
    end
    NpcTalk(QuestNpc)
end

local RedQuests = {
    Spaceship = "SpaceShip",
    ["Namekian Spaceship"] = "NamekianShip",
    Timemachine = "TimeMachine",
    ["Mr. Popo"] = "Popo",
    ["W.M.A.T. Worker"] = "Help Center"
}

local function FindNpc(NpcName)
	for i, v in pairs(workspace.Live:GetChildren()) do
		local NpcHum = v:FindFirstChild("Humanoid")
		local NpcHrp = v:FindFirstChild("HumanoidRootPart")
		if NpcHum and (NpcHum.Health > 0) and NpcHrp and (NpcHrp.Position.Y < 1600) then
			if string.find(v.Name, NpcName) == 1 then
                return v
            end
		end
	end
end
local TweenService = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/OptimizedTweenLibrary.lua"))()

local Touchy = workspace.Touchy.Part
game:GetService("RunService").RenderStepped:Connect(function()
    local Hrp = Player.Character:FindFirstChild("HumanoidRootPart")
    if Hrp then
        Touchy.CFrame = Hrp.CFrame
    end
end)

local NoSlowTable = {"Action", "Attacking", "Using", "hyper", "Hyper", "heavy", "KiBlasted", "Tele", "tele", "Killed", "Slow", "MoveStart", "Look", "Activity", "Killed"}
game:GetService("RunService").RenderStepped:Connect(function()
    local Char = Player.Character
    for i, v in pairs(NoSlowTable) do
        local a = Char:FindFirstChild(v)
        if a then
            a:Destroy()
        end
    end
end)

Player.PlayerGui.ChildAdded:Connect(function(Child)
    if Child.Name == "Popup" then
        Child:Destroy()
    end
end)

Player.PlayerGui.HUD.Bottom.Stats.StatPoints.Val:GetPropertyChangedSignal("Text"):Connect(function()
    Player.Backpack.ServerTraits.AttemptUpgrade:FireServer(Player.PlayerGui.HUD.Bottom.Stats:FindFirstChild("Phys-Damage"))
end)

local function KillNpc(NpcName)
    local Npc = nil
    while true do
        Npc = FindNpc(NpcName)
        if Npc then
            break
        end
        workspace.FriendlyNPCs.ChildAdded:Wait()
    end
    local NpcHum = Npc:WaitForChild("Humanoid")
    local NpcHrp = Npc:WaitForChild("HumanoidRootPart")
    local Hrp = Player.Character:WaitForChild("HumanoidRootPart")
    Player.Character:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
    local Distance = (Hrp.Position - NpcHrp.Position).Magnitude
    local TimeItTakes = Distance/1000
    local Tween = TweenService:Create(Hrp, TimeItTakes, {CFrame = NpcHrp.CFrame})
    Tween:Play()
    local NewDistance = 9e9
    repeat
        NewDistance = (Hrp.Position - NpcHrp.Position).Magnitude
        task.wait()
    until NewDistance <= 100
    Camera.CameraType = Enum.CameraType.Scriptable
    while (NpcHum.Health > 0) do
        Hrp.CFrame = CFrame.new(NpcHrp.Position + Vector3.new(0, 0, -3), NpcHrp.Position)
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

local function CompleteQuest(QuestName)
    NotificationLibrary.CustomNotification("Starting Quest", QuestName, 10)
    for i, v in pairs(Player.PlayerGui.HUD.FullSize.Quests:GetChildren()) do
        if v.Name == "Copy" then
            v:Destroy()
        end
    end
    TakeQuest(QuestName)
    local Copy = Player.PlayerGui.HUD.FullSize.Quests:FindFirstChild("Copy")
    if Copy and ((Copy.Text == "Find ") or (Copy.Text == "Talk to")) then
        task.wait(.75)
        local Npc = nil
        if RedQuests[Copy.Num.Text] then
            Npc = workspace.FriendlyNPCs:FindFirstChild(RedQuests[Copy.Num.Text])
        else
            Npc = workspace.FriendlyNPCs:FindFirstChild(Copy.Num.Text)
        end
        NpcTalk(Npc)
    elseif Copy and (string.find(Copy.Text, "Defeat") == 1) then
        local NpcName = string.gsub(Copy.Text, "Defeat ", "")
        if tonumber(Copy.Num.Text) > 1 then
            NpcName = string.sub(NpcName, 1, string.len(NpcName) - 1)
        end
        KillNpc(NpcName)
    end
end

local FindQuests = {"GoToNamek", "GoToFuture", "GoToSpace", "RoshiQuest", "KrillinQuest", "PopoQuest", "LostNamek", "WTQuest", "ImpCell"}
for i, v in pairs(FindQuests) do
    CompleteQuest(v)
    task.wait(.75)
    local MoneyString = string.sub(Player.PlayerGui.HUD.FullSize.Money.Text, 2)
    MoneyString = string.gsub(MoneyString, ",", "")
    if tonumber(MoneyString) > 10000 then
        NpcTalk(workspace.FriendlyNPCs["Elder Kai"])
        task.wait(.75)
    end
end
while true do
    local Level = tonumber(Player:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("Bottom"):WaitForChild("Stats"):WaitForChild("LVL"):WaitForChild("Val").Text)
    if Level >= 50 then
        break
    end
    task.wait()
end

GetTheStats()
Player.CharacterAdded:Wait()
local HUD = Player:WaitForChild("PlayerGui"):WaitForChild("HUD")
local Bottom = HUD:WaitForChild("Bottom")
Bottom.Visible = true
local Stats = Bottom:WaitForChild("Stats")
Stats.Visible = true
SlotChange(_G.ResetSlot)
Player.CharacterAdded:Wait()
NpcTalk(workspace.FriendlyNPCs["Start New Game [Redo Character]"])
task.wait(1)
game:GetService("TeleportService"):Teleport(552500546)