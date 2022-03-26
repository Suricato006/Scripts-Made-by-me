--[[ top_respawn = function(char)
    task.wait()
    char.SuperAction:Destroy();
    while wait(0.3) do
        game.TweenService:Create(char.HumanoidRootPart,TweenInfo.new(1,  Enum.EasingStyle.Quad),{CFrame = CFrame.new(100, 100, 100)}):Play()
        break;
    end;
end;
local oldnc;
oldnc = hookmetamethod(game, '__namecall', function(self,...)
    if self.Name == 'ResetChar' and getnamecallmethod() == 'FireServer' then
        coroutine.wrap(top_respawn)(game.Players.LocalPlayer.Character);
        warn('[Humanoid MaxHealth] - Set to nil');
    end;
    return oldnc(self,...);
end); ]]

local Player = game.Players.LocalPlayer
_G.TopRespawn = true
while _G.TopRespawn do task.wait()
    local SuperAction = Player.Character:FindFirstChild("SuperAction")
    if SuperAction then
        SuperAction:Destroy()
    end
end