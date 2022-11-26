_G.GodMode = not _G.GodMode
if not _G.GodMode then return end

local Player = game.Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()

local Connection = nil
local function DestroyBlock()
    if not _G.GodMode then Connection:Disconnect() return end
    local Blocking = Char:WaitForChild("Data", 10):WaitForChild("Blocking", 10)
    if Blocking then
        print("GodMode Active")
        Blocking:Destroy()
    end
end
DestroyBlock()

Connection = Player.CharacterAdded:Connect(DestroyBlock)