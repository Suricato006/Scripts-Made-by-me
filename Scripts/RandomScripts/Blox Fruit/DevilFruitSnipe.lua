if not game:IsLoaded() then game.Loaded:Wait() end
local Player = game.Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()

task.wait(0.5)

local args = {
    [1] = "OpenRengoku"
}

game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
local args = {
    [1] = "SetTeam",
    [2] = "Marines"
}

game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))

task.wait(1.5)


local function Teleport()
    --game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
    Player.PlayerGui.ServerBrowser.Enabled = true
    local Gui = Player.PlayerGui.ServerBrowser:WaitForChild("Frame"):WaitForChild("FakeScroll"):WaitForChild("Inside")
    for i, v in pairs(Gui:GetChildren()) do
        local a = v:FindFirstChild("Join")
        if a then
            game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", a:GetAttribute("Job"))
        end
    end
end

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if input.KeyCode == Enum.KeyCode.P then
        while true do task.wait()
            pcall(Teleport)
        end
    end
end)

for i, v in pairs(workspace:GetChildren()) do
    if string.find(v.Name, "Fruit") then
        local BillboardGui = Instance.new("BillboardGui")
        BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        BillboardGui.Active = true
        BillboardGui.LightInfluence = 1
        BillboardGui.AlwaysOnTop = true
        BillboardGui.Size = UDim2.new(0, 200, 0, 50)
        BillboardGui.ClipsDescendants = true

        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(0, 200, 0, 50)
        TextLabel.BackgroundTransparency = 1
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.FontSize = Enum.FontSize.Size14
        TextLabel.TextSize = 14
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.TextWrap = true
        TextLabel.Font = Enum.Font.Roboto
        TextLabel.TextWrapped = true
        TextLabel.TextScaled = true
        TextLabel.Parent = BillboardGui

        local Target = v
        if v:IsA("Tool") then
            Target = v:FindFirstChildWhichIsA("Part", true)
        end
        BillboardGui.Parent = Target
        TextLabel.Text = v.Name
        local OldParent = v.Parent
        while v.Parent == OldParent do
            if firetouchinterest then
                firetouchinterest(Char:WaitForChild("HumanoidRootPart"), v:FindFirstChildWhichIsA("Part", true), 0)
                task.wait()
                firetouchinterest(Char:WaitForChild("HumanoidRootPart"), v:FindFirstChildWhichIsA("Part", true), 1)
            else
                Char:WaitForChild("HumanoidRootPart").CFrame = v:FindFirstChildWhichIsA("Part").CFrame
                task.wait()
            end
        end
        task.wait(0.5)
        local args1 = {
            [1] = "StoreFruit",
            [2] = v:GetAttribute("OriginalName"),
            [3] = v
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args1))
    end
end

while true do task.wait()
    pcall(Teleport)
end
