_G.DummySlot = _G.DummySlot or "Slot3" --Slot that will get resetted
_G.Slot = _G.Slot or "Slot1" --Slot that will get the stats
local Lag = 0.2

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

local function NpcTalk(Npc, CustomOption)
    local ChatGui = Player:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("Bottom"):WaitForChild("ChatGui")
    local TextLabel = ChatGui:WaitForChild("TextLabel")
    local Option1 = ChatGui:WaitForChild("Opt1")
    Player:WaitForChild("Backpack"):WaitForChild("ServerTraits"):WaitForChild("ChatStart"):FireServer(Npc)
    repeat
        task.wait()
    until ChatGui.Visible
    local Chat = nil
    if Npc:IsA("Model") then
        Chat = Npc:FindFirstChildWhichIsA("Folder")
    else
        Chat = Npc
    end
    local NextChat = Chat
    local ChatAdvance = Player.Backpack.ServerTraits.ChatAdvance
    while ChatGui.Visible do
        NextChat = NextChat:FindFirstChildWhichIsA("StringValue")
        if NextChat.Name == "AltChat" then
            local OldNextChat = NextChat
            NextChat = NextChat.Parent:FindFirstChildWhichIsA("StringValue")
            OldNextChat:Destroy()
        end
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
        task.wait(.3)
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

local function GetTheStats()
    local Kami = workspace.FriendlyNPCs:FindFirstChild('KAMI') or game:GetService("ReplicatedStorage").Hidden:FindFirstChild("KAMI")
    SlotChange(_G.Slot)
    Player.Backpack.ServerTraits.ChatStart:FireServer(Kami.Chat)
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
    Timemachine = "TimeMachine"
}

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
        task.wait(1)
        local Npc = nil
        if RedQuests[Copy.Num.Text] then
            Npc = workspace.FriendlyNPCs:FindFirstChild(RedQuests[Copy.Num.Text])
        else
            Npc = workspace.FriendlyNPCs:FindFirstChild(Copy.Num.Text)
        end
        NpcTalk(Npc)
    end
end

local function GetToLevel50()
    local FindQuests = {"GoToNamek", "GoToFuture", "GoToSpace"}
    for i, v in pairs(FindQuests) do
        CompleteQuest(v)
        task.wait(.75)
    end
    NpcTalk(workspace.FriendlyNPCs["Elder Kai"])
    task.wait(.75)
    NpcTalk(workspace.FriendlyNPCs["Korin"].Chat.Chat)
    repeat
        task.wait()
    until tonumber(Player:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("Bottom"):WaitForChild("Stats"):WaitForChild("LVL"):WaitForChild("Val").Text) >= 50
end

local function GetRace()
    local RaceLabel = Player:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("Bottom"):WaitForChild("Stats"):WaitForChild("Race"):WaitForChild("Val")
    return RaceLabel.Text
end

local function WaitForCharacterToLoad()
    NotificationLibrary.CustomNotification("Character Check", "Waiting For Character", 1.5)
    local Char = Player.Character or Player.CharacterAdded:Wait()
    local Added = false
    local Connection = Char.DescendantAdded:Connect(function()
        Added = true
    end)
    while true do
        task.wait(1.5)
        if Added == false then
            Connection:Disconnect()
            return Char
        end
        Added = false
    end
end


if #game.Players:GetChildren() > 1 then
    Player:Kick("\nYou are in a public server.\nThis script only works in private ones.")
    return
end

local ChatGui = Player:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("Bottom"):WaitForChild("ChatGui")
local TextLabel = ChatGui:WaitForChild("TextLabel")
TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
    if string.find(TextLabel.Text:lower(), "popo") then
        NpcTalk(workspace.FriendlyNPCs["Start New Game [Redo Character]"])
    end
end)

--settings().Network.IncomingReplicationLag = Lag

WaitForCharacterToLoad()
if not (GetRace() == "Namekian") then
    SlotChange(_G.DummySlot)
end

while true do task.wait()
    print("Starting loop")
    NotificationLibrary.CustomNotification("Script is starting...", "Checking for Character")
    WaitForCharacterToLoad()
    Player:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("Bottom"):WaitForChild("Stats").Visible = true
    print("Show Stats")
    if GetRace() == "Namekian" then
        print("Namekian")
        local Level = tonumber(Player.PlayerGui.HUD.Bottom.Stats:WaitForChild("LVL"):WaitForChild("Val").Text)
        if Level < 50 then
            GetToLevel50()
            task.wait(1)
        end
        GetTheStats()
    else
        print("Now Namekian")
        SlotChange(_G.DummySlot)
    end
end