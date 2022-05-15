--Demonfall esp

local ThingsToFarm = {"Mineral", "Gold Goblet", "Silver Jar", "Gold Jar", "Golden Ring", "Ancient Coin", "Golden Crown", "Red Jewel", "Green Jewel", "Perfect Crystal"}
local ColorDistance = 255
_G.ItemEsp = true


game:GetService("Lighting").FogEnd = math.huge
for i, v in pairs(game:GetService("Lighting"):GetDescendants()) do
    v:Destroy()
end

local function Esptuttecose(table)
    for i,v in pairs(table) do 
        for i1, v1 in pairs(ThingsToFarm) do 
            if v.Name == v1 then
                local Distance = "Broken"
                if v:IsA("Model") then
                    Distance = (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - v:GetModelCFrame().Position).Magnitude
                elseif v:IsA("BasePart") or v:IsA("MeshPart") then
                    Distance = (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude
                end

                if not v:FindFirstChild("BillboardGui") then
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

                    BillboardGui.Parent = v

                elseif v:FindFirstChild("BillboardGui") then
                    local TextLabel = v.BillboardGui.TextLabel
                    if Distance >= ColorDistance then
                        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        TextLabel.Text = "."
                    else
                        TextLabel.TextColor3 = Color3.fromRGB(0, 76, 255)
                        TextLabel.Text = "."
                    end
                end
            end
        end
    end
end

while _G.ItemEsp do wait()
    Esptuttecose(game.Workspace:GetChildren())
    Esptuttecose(game:GetService("Workspace").Map.Minerals:GetDescendants())
end

for i, v in pairs(game.Workspace:GetChildren()) do
    if v.Name == "BillboardGui" then
        v:Destroy()
    end
end