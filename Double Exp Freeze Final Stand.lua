loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Functions%20and%20stuff.lua'),true))()

if not game:IsLoaded() then game.Loaded:Wait() end

local FinalStandTable = {536102540, 569994010, 882399924, 2046990924, 478132461, 3552157537, 2651456105, 3565304751, 882375367}

if not table.find(FinalStandTable, game.PlaceId) then return end

while not Player.Character do wait() end

wait(0.5)

while true do FastWait()
    local a = PlayerCheck("True")
    if a then
        a:Destroy()
    end
end