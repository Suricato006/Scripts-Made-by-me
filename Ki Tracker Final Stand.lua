local Library = loadstring(game:HttpGet("https://pastebin.com/raw/GX28T0pH"))()
local Main = Library:CreateWindow("Ki Tracker")

local function Hit(Part)
    for i, v in pairs(game.Workspace.Live:GetChildren()) do
        if string.find(v.Name:lower(), _G.TrackerName:lower()) then
            local Hrp = v:FindFirstChild("HumanoidRootPart")
            local Hum = v:FindFirstChild("Humanoid")
            if Hrp and Hum then
                if (Hum.Health > 0) then
                    Part.CFrame = Hrp.CFrame
                end
            end
        end
    end
    
end

local function TableHit(Folder)
    for i, v in pairs(Folder:GetChildren()) do
        if v:FindFirstChild("Ki") and v:FindFirstChild("Mesh") then
            Hit(v)
        end
    end
end

Main:AddToggle({text = "Ki tracking", state = _G.Toggle, callback = function(bool)
    _G.Toggle = bool
    while _G.Toggle do task.wait()
        TableHit(game.Players.LocalPlayer.Character)
        TableHit(game.Workspace.Effects)
        TableHit(game.Workspace)
        TableHit(game.Players.LocalPlayer.Character.Humanoid)
    end
end})

Main:AddBox({text = "Npc or Player Name", value = "", callback = function(typed)
    _G.TrackerName = typed
end})

local DestroyButton = Main:AddFolder("DestroyGui")
DestroyButton:AddButton({text = "Destroy Gui", callback = function()
    Library:Close()
end})


Library:Init()