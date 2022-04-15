local Library = {}

local TweenService = game:GetService("TweenService")
Library.TweenPart = function(PartToTween, TweenTime, CFrameToTweenTo, ...)
    local Hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local Tween = TweenService:Create(PartToTween or Hrp, TweenInfo.new(TweenTime, ...), {CFrame = CFrameToTweenTo})
    return Tween
end
local VirtualInputManager = game:GetService("VirtualInputManager")
Library.MouseClick = function(PositionX, PositionY, HoldTime)
    VirtualInputManager:SendMouseButtonEvent(PositionX, PositionY, 0, true, game, 0)
    if HoldTime then
        task.wait(HoldTime)
    end
    VirtualInputManager:SendMouseButtonEvent(PositionX, PositionY, 0, false, game, 0)
end

Library.MoveMouse = function(PositionX, PositionY)
    VirtualInputManager:SendMouseMoveEvent(PositionX, PositionY, game)
end

Library.PressKey = function(KeyCode, HoldTime)
    VirtualInputManager:SendKeyEvent(true, KeyCode, false, game)
    if HoldTime then
        task.wait(HoldTime)
    end
    VirtualInputManager:SendKeyEvent(false, KeyCode, false, game)
end

return Library