local Library = {}

local TweenService = game:GetService("TweenService")
local Camera = workspace:FindFirstChildWhichIsA("Camera")
Library.TweenPart = function(PartToTween, TweenTime, CFrameToTweenTo, ...)
    local Hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local Tween = TweenService:Create(PartToTween or Hrp, TweenInfo.new(TweenTime, ...), {CFrame = CFrameToTweenTo})
    return Tween
end
local VirtualInputManager = game:GetService("VirtualInputManager")
Library.MouseClick = function(PositionX, PositionY, HoldTime)
    VirtualInputManager:SendMouseButtonEvent(PositionX, PositionY, 0, true, nil, 0)
    if HoldTime then
        task.wait(HoldTime)
    end
    VirtualInputManager:SendMouseButtonEvent(PositionX, PositionY, 0, false, nil, 0)
end

Library.MoveMouse = function(PositionX, PositionY)
    VirtualInputManager:SendMouseMoveEvent(PositionX, PositionY, nil)
end

Library.PressKey = function(KeyCode, HoldTime)
    VirtualInputManager:SendKeyEvent(true, KeyCode, false, nil)
    if HoldTime then
        task.wait(HoldTime)
    end
    VirtualInputManager:SendKeyEvent(false, KeyCode, false, nil)
end

Library.PressButton = function(ButtonLabel)
    Library.MouseClick(ButtonLabel.AbsolutePosition.X + ButtonLabel.AbsoluteSize.X/2, ButtonLabel.AbsolutePosition.Y + ButtonLabel.AbsoluteSize.Y*3/2)
end

Library.CenterMouseClick = function()
    Library.MouseClick(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
end

return Library