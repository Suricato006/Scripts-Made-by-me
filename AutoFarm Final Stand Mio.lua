loadstring(game:HttpGet(('https://pastebin.com/raw/5ksZRmMp'),true))()

Notify("Thanks for using my script", "Luv u <3", 4)
_G.AutoFarm = true
if not _G.NpcName then
	_G.NpcName = "Evil Saiyan"
end

local function Pugno()

    local args = {
        [1] = {
            [1] = "m2"
        },
        [2] = Player.Character.HumanoidRootPart.CFrame,
    }

    game:GetService("Players").LocalPlayer.Backpack.ServerTraits.Input:FireServer(unpack(args))
end
spawn(function()
    local Names = {"Slow", "Using", "hyper", "Action", "Attacking", "heavy"}
    while _G.AutoFarm do FastWait()
        if PlayerCheck() then
            for i, v in pairs(Names) do
                local a = Player.Character:FindFirstChild(v)
                if a then
                    a:Destroy()
                end
            end
        end
    end
end)
while _G.AutoFarm do
    while _G.AutoFarm do FastWait()
        local Yes, No = pcall(function()
            for i, v in pairs(game:GetService("Workspace").Live:GetChildren()) do
                if NameFind(v.Name, _G.NpcName) then
                    while _G.AutoFarm and PlayerCheck() and v.Humanoid.Health > 0 do FastWait()
                        if (Player.Character.HumanoidRootPart.CFrame.Position - v.HumanoidRootPart.CFrame.Position).magnitude > 50 then
                            LerpCFrame(v.HumanoidRootPart.CFrame)
                        else
                            Player.Character.HumanoidRootPart.CFrame = CFrame.new(v.HumanoidRootPart.CFrame.Position - v.HumanoidRootPart.CFrame.LookVector, v.HumanoidRootPart.CFrame.Position)
                        end
                        Pugno()
                    end
                end
            end
        end)
        if No then
            break
        end
    end
    wait(1)
end