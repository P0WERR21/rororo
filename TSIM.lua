local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))() -- UI Source
local Window = Library.CreateLib("Trading Simulator", "BloodTheme") -- Blood Themed UI
local Tab1 = Window:NewTab("Auto Farm") -- Tab 1 (MAIN)
local Tab3 = Window:NewTab("Credits") -- Tab 3 (CREDITS)
local Section4 = Tab3:NewSection("UI - xHeptc") -- Creds 1
local Section5 = Tab3:NewSection("Script - Franie") -- Creds 2
local Section1 = Tab1:NewSection("Farming Utilities")
Section1:NewButton("Anti-AFK", "Makes sure you don't get kicked when idle.", function() -- Anti-AFK Function
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
wait(1)
VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
end)
Section1:NewButton("Rejoin", "Use this button if you errored suddenly.", function() -- Rejoin Function
game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end)
local CaseName = "" -- Creates CaseName
local Section2 = Tab1:NewSection("Auto-Farm Setup")
Section2:NewDropdown("Case Type", "Choose a type of Case!", {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Omega", "Insane", "Unclassified", "Freedom", "Parvus"}, function(currentOption)
    CaseName = currentOption -- Redefines CaseName for Remote Later On
end)
local AllowedOpening = "" -- Creates Allowed Case Openings
Section2:NewTextBox("Number of Cases", "Check the number of cases by looking at the upgrades tab!", function(txt)
	AllowedOpening = tonumber(txt) -- Redefines AllowedOpening
	print(AllowedOpening) -- Prints it, press F9 to make sure you typed in a number!
end)
-- Config
local Config = {
    AutoOpenCases = false,
    AutoSellItems = false,
    AutoCaseUpgrade = false,
}
local Section3 = Tab1:NewSection("Toggles")
Section3:NewToggle("Auto Open Cases", "Automatically opens cases for you!", function(CaseState)
    Config.AutoOpenCases=CaseState
end)
Section3:NewToggle("Auto Sell All", "Automatically sells all your inventory for you!", function(SellState)
    Config.AutoSellItems=SellState
end)
Section3:NewToggle("Auto Case Slots", "Automatically upgrades and inceases case capacity for you!", function(SlotState)
    Config.AutoCaseUpgrade=SlotState
end)
-- Auto Detect
local MenuFrames = game:FindFirstChild("Menu Frames", true)
local BConn = getconnections(MenuFrames.Backpack.Confirm.Yes.MouseButton1Click)
local X = BConn[1].Function
local Arg = 0
for i,v in next, getupvalues(X) do
  if type(v)=="number" and v>100 then
    Arg = v
  end
end

-- Looped Remotes
-- for remote spying you can use simplespy
-- loadstring(game:HttpGet("https://github.com/exxtremestuffs/SimpleSpySource/raw/master/SimpleSpy.lua"))()
-- credits simple spy 


while wait() do
    if Config.AutoOpenCases then
        wait(.06)
        spawn(function()
             function getNil(name,class) for _,v in pairs(getnilinstances())do if v.ClassName==class and v.Name==name then return v;end end end
            local CaseArgs = {
                    [1] = getNil("Value", "LocalScript"),
                    [2] = Arg,
                    [3] = CaseName,
                    [4] = AllowedOpening,
                    [5] = AllowedOpening + 1,
            }
            game:GetService("ReplicatedStorage")["Game Objects"].Remotes["Wipe Inventory"]:InvokeServer(unpack(CaseArgs))
        end)
    end
     if Config.AutoSellItems then
        wait(.06)
            spawn(function()

                function getNil(name,class) for _,v in pairs(getnilinstances())do if v.ClassName==class and v.Name==name then return v;end end end

            local args = {
              [1] = getNil("Value", "LocalScript"),
                  [2] = Arg,
                          [3] = 50000000000
                    }

game:GetService("ReplicatedStorage")["Game Objects"].Remotes.Sellall:FireServer(unpack(args))

            end)
             end
    if Config.AutoCaseUpgrade then
        wait(.06)
            spawn(function()

        function getNil(name,class) for _,v in pairs(getnilinstances())do if v.ClassName==class and v.Name==name then return v;end end end
        local args = {
          [1] = getNil("Value", "LocalScript"),
             [2] = Arg,
                [3] = "Cases"
            }

        game:GetService("ReplicatedStorage")["Game Objects"].Remotes.Upgrade:FireServer(unpack(args))

end)
end
end
