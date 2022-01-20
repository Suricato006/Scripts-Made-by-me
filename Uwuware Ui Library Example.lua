local Library = loadstring(game:HttpGet("https://pastebin.com/raw/GX28T0pH", true))()
local Main = Library:CreateWindow("Example Window")

Main:AddLabel({text = "Label"})

Main:AddToggle({text = "Toggle", state = false, callback = function(bool)
    print(bool)
end})

Main:AddButton({text = "Button", callback = function()
    print("Button Pressed")
end})

Main:AddBind({text = "Bind", key = Enum.KeyCode.L, hold = false, callback = function()
    print("Pressed the key")
end})

Main:AddSlider({text = "Slider", min = 0, max = 100, dual = false, value = 50, callback = function(number)
    print(number)
end})

local List = {"Hi", "Gm", "Cya", "Ily <3"}
Main:AddList({text = "List", values = List, value = List[1], callback = function(chosen)
    print(chosen)
end})

local Box = Main:AddBox({text = "Box", value = "", callback = function(typed)
    print(typed)
end})

Main:AddColor({text = "Color", color = Color3.new(255, 255, 255), callback = function(color)
    print(tostring(color))
end})

local Folder = Main:AddFolder("Folder")

Folder:AddButton({text = "Destroy Gui", callback = function()
    Library:Close()
end})

Folder:AddButton({text = "SetValue", callback = function()
    Box:SetValue("Got Set") -- or SetState() for toggles
end})

Library:Init()

--[[
    AddLabel
    AddToggle
    AddButton
    AddBind
    AddSlider
    AddList
    AddBox
    AddColor
    AddFolder
]]