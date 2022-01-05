-- Sword Factory AutoPress Script

-- Script made by ya boi Suricato006#8711 for Zero Two#3715 cuz he asked for it lmao

local Player = game:GetService("Players").LocalPlayer
local function FastWait()
    game:GetService("RunService").Heartbeat:wait()
end

_G.AutoSpawn = true

while _G.AutoSpawn do FastWait()
    fireclickdetector(game:GetService("Workspace")[Player.Name.."'s Base"].ItemMachine.SpawnItem.ClickDetector)
end