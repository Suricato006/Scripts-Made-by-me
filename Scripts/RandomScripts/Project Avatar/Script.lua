local Player = game.Players.LocalPlayer

local OldIndex = nil
OldIndex = hookmetamethod(game, "__index", newcclosure(function(Self, Key)
    if (Self == Player.Character) and (Key == "Humanoid") and not checkcaller() then
        print("called the humanoid")
        print(getcallingscript())
    end
    return OldIndex(Self, Key)
end))

--Player.Character.Humanoid.WalkSpeed = 50


--[[ Player.Character.Humanoid:AddPropertyEmulator("WalkSpeed")
Player.Character.Humanoid:AddPropertyEmulator("JumpPower")

Player.Character.Humanoid.WalkSpeed = 100 --Change to whatever you want
Player.Character.Humanoid.JumpPower = 260 --Change to whatever you want ]]