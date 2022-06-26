local UI = loadstring(game:HttpGetAsync("https://projectevo.xyz/script/utils/libraryv3.lua"))()
local Library = UI.library
local Main = Library.new("Main")

Main:AddSettings()

local Tab = Main:AddTab("Name", "Description", "https://cdn.discordapp.com/attachments/781200320184320002/990577395855687741/avatar.jpg") -- Put a image link where the 0 is if you want a icon.
Main:AddProfile()
local Panel = Tab:AddPanel("Panel")
local Status = false
local BoxText = ""
local Value = 0
local Unused = 0
Panel:AddLabel("Label", "Gotham") --  You can change the font if you want, or you can leave it blank for a default of Gotham
Panel:AddStatusLabel("Status Label", tostring(Status))
Panel:AddClipboardLabel("Copy my name to your clipboard", "SyndiCat")
Panel:AddToggle(
    "Toggle",
    function(state)
        Status = state
    end
)
Panel:AddSlider(
    "Slider",
    function(a)
        Value = a
    end
)
Panel:AddBox(
    "Textbox",
    function(a)
        BoxText = a
    end
)
Panel:AddButton(
    "Print Textbox/Slider",
    function(a)
        print("Textbox: " .. BoxText)
        print("Slider: " .. Value)
    end
)
Panel:AddDropdown(
    "Dropdown",
    function(a)
        Unused = a
    end,
    {items = {1, 2, 3, 4, 5}}
)