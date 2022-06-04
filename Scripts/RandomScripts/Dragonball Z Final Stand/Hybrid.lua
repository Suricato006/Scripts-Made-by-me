--HybridScript--
-------Settings-------
local HybridSlot = "Slot3"

-------Variables------

local Player = game.Players.LocalPlayer
local InputLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/InputFunctions%20Library.lua"))()
local Camera = workspace:FindFirstChildWhichIsA("Camera")
for i, v in pairs(InputLibrary) do
    print(i, v)
end
-------functions-------

local function respawn()
    coroutine.wrap(function()
        while Player.Character do
            Player.Backpack.HairScript.RemoteEvent:FireServer()
            task.wait()
        end
    end)()
    Player.Backpack.ServerTraits.ChatStart:FireServer(workspace.FriendlyNPCs["Hair Stylist"])
    task.wait(0.3)
    Player.Backpack.ServerTraits.ChatAdvance:FireServer({"Yes"})
end

local function ClickButton(Button)
    local a = false
    coroutine.wrap(function()
        while true do task.wait()
            if a then
                break
            end
            InputLibrary.PressButton(Button)
        end
    end)
    Button:GetPropertyChangedSignal("Text"):Wait()
    a = true
end

local function FindButton(Text)
    for i, v in pairs(Player.PlayerGui.HUD.Bottom.ChatGui:GetChildren()) do
        if v.Text == Text then
            return v
        end
    end
end

local function ClickSlotChanger(Proprety)
    local SlotChanger = workspace:FindFirstChild("Character Slot Changer", true)
    Camera.CameraType = Enum.CameraType.Scriptable
    Camera.CFrame = CFrame.new(SlotChanger:GetModelCFrame().Position + Vector3.new(15, 2, 0), SlotChanger:GetModelCFrame().Position)
    local a = false
    coroutine.wrap(function()
        while true do task.wait()
            if a then
                break
            end
            InputLibrary.MouseClick(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        end
    end)()
    Player.PlayerGui.HUD.Bottom.ChatGui:GetPropertyChangedSignal(Proprety):Wait()
    a = true
end

local function ChangeSlot()
    ClickSlotChanger("Visible")
    ClickButton(FindButton("Yes"))
    ClickSlotChanger("Text")
    ClickButton(FindButton(HybridSlot))
    ClickSlotChanger("Text")
end
--------Script--------
local TextLabel = Player:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("Bottom"):WaitForChild("ChatGui"):WaitForChild("TextLabel")
TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
    if TextLabel.Text == "Which slot would you like to play in?" then
        task.wait(0.6)
        respawn()
    end
end)
ChangeSlot()