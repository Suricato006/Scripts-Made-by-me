local UI = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/Ui%20Library/Source.lua"))()
local Library = UI.library
local Main = Library.new("Main")

Main:AddSettings()

local Tab = Main:AddTab("Name", "Description", 0) -- Put a image link where the 0 is if you want a icon.
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