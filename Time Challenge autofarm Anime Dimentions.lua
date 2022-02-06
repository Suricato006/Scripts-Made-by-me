loadstring(game:HttpGet(('https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Functions%20and%20stuff.lua'),true))()

_G.TimeChallenge = true
game:GetService("Players").LocalPlayer.PlayerGui.Modules.ClientSkillModule

Notify("By Suricato006#8711", "Thanks for using this script")

local AutoExec = false
if not game:IsLoaded() then
   game.Loaded:Wait()
   AutoExec = true
end

if not AutoExec then
   Player.CharacterAdded:wait()
else
   while not PlayerCheck() do FastWait() end
end

if (_G.TimeChallenge) and (not (game.PlaceId == 6990129309)) then
   Notify("Teleporting...")
   local args = {
      [1] = "TeleportToTimeChallenge"
   }
   game:GetService("ReplicatedStorage").RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
   return
end

local Mouse = Player:GetMouse()
local function Pugno()
   local a = {
      ["UserInputType"] = Enum.UserInputType.MouseButton1
   }
   for i, v in pairs(getconnections(game:GetService("UserInputService").InputBegan)) do
      v:Fire(a, false)
      print(i,v)
   end
end

while _G.TimeChallenge do FastWait()
   local HRP = PlayerCheck()
   if HRP then
      Pugno()
      HRP.CFrame = CFrame.new(Vector3.new(-66, 59, 104), Vector3.new(-66, 53, 104))
   end
end