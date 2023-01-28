local Player = game.Players.LocalPlayer
local InputLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/InputFunctions%20Library.lua"))()

local Distance = 15
local NpcNames = {"Thug"}
_G.Active = not _G.Active
print(_G.Active)


while _G.Active do
    local Char = Player.Character or Player.CharacterAdded:Wait()
    wait(1) --wait dopo che respawna
    for i, v in pairs(workspace.Living:GetChildren()) do
        local Display = v:FindFirstChild("Display", true)
        if Display and table.find(NpcNames, Display.Text) then
            local Hrp = v:FindFirstChild("HumanoidRootPart")
            if Hrp and (not (v == Char))  then
                if isnetworkowner(Hrp) then
                    Hrp.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(0, 0, -Distance))
                end
            end
        end
    end
    InputLibrary.PressKey(Enum.KeyCode.H)
    wait(5) --wait prima di resettarsi
    Char.Humanoid.Health = 0
end