local Library = {}
Library.__index = Library

Library.Create = function(Part, Time, GoalsTable)
    local Tween = {}
    Tween.Canceled = false
    Tween.Paused = false
    Tween.Thread = coroutine.create(function()
        for i, v in pairs(GoalsTable) do
            local StartPos = Part[i]
            local AverageFPS = workspace:GetRealPhysicsFPS()
            local OneFrame = 1/AverageFPS
            local Divisions = math.ceil(Time/OneFrame)
            for i1=0, Divisions do
                if Tween.Canceled then return end
                if Tween.Paused then
                    coroutine.yield()
                end
                Part[i] = StartPos:Lerp(v, i1/Divisions)
                game:GetService("RunService").RenderStepped:Wait()
            end
        end
    end)

    setmetatable(Tween, Library)
    return Tween
end

Library.Play = function(self)
    self.Paused = false
    coroutine.resume(self.Thread)
end

Library.Pause = function(self)
    self.Paused = true
end

Library.Cancel = function(self)
    self.Canceled = true
end

Library.Status = function(self)
    return coroutine.status(self.Thread)
end

return Library