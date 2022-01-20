local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
    local Args = {...}
    local NamecallMethod = getnamecallmethod()

    if not checkcaller() and Self == Player and NamecallMethod == "Kick" then
        return nil
    end

    return OldNameCall(Self, ...)
end)
