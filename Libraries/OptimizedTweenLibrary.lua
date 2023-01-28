local Library = {}
Library.__index = Library

Library.Create = function(Table, Part, Time, GoalsTable)
    local Tween = {}
    Tween.PlaybackState = Enum.PlaybackState.Begin
    Tween.Thread = coroutine.create(function()
        for i, v in pairs(GoalsTable) do
            local StartPos = Part[i]
            local TimePassed = 0
            while true do
                local Delta = game:GetService("RunService").Heartbeat:Wait()
                TimePassed = TimePassed + Delta
                local Divition = TimePassed/Time
                if (Tween.PlaybackState == Enum.PlaybackState.Cancelled) then return end
                if Tween.PlaybackState == Enum.PlaybackState.Paused then
                    coroutine.yield()
                end
                Part[i] = StartPos:Lerp(v, math.min(Divition, 1))
                if TimePassed >= 1 then
                    break
                end
            end
        end
        Tween.PlaybackState = Enum.PlaybackState.Completed
        --[[ for i, v in pairs(GoalsTable) do
            local StartPos = Part[i]
            local AverageFPS = workspace:GetRealPhysicsFPS()
            local OneFrame = 1/AverageFPS
            local Divisions = math.ceil(Time/OneFrame)
            for i1=0, Divisions do
                if (Tween.PlaybackState == Enum.PlaybackState.Cancelled) then return end
                if Tween.PlaybackState == Enum.PlaybackState.Paused then
                    coroutine.yield()
                end
                Part[i] = StartPos:Lerp(v, i1/Divisions)
                game:GetService("RunService").RenderStepped:Wait()
            end
        end
        Tween.PlaybackState = Enum.PlaybackState.Completed ]]
    end)
    setmetatable(Tween, Library)
    return Tween
end

Library.Play = function(self)
    self.PlaybackState = Enum.PlaybackState.Playing
    coroutine.resume(self.Thread)
end

Library.Pause = function(self)
    self.PlaybackState = Enum.PlaybackState.Paused
end

Library.Cancel = function(self)
    self.PlaybackState = Enum.PlaybackState.Cancelled
end

return Library