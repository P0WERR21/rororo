local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))() -- UI Source
local Window = Library.CreateLib("Case Clicker", "BloodTheme") -- Blood Themed UI
local Tab1 = Window:NewTab("Auto Farm") -- Tab 1 (MAIN)
local Tab2 = Window:NewTab("Auto Upgrades") -- Tab 2 (UPGRADES)
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
local Section2 = Tab1:NewSection("Farming Setup")
local Section7 = Tab2:NewSection("Auto Upgrade")
Section2:NewDropdown("Case Type", "Choose a type of Case!",  {'Tier 1 Case', 'Tier 2 Case', 'Tier 3 Case', 'Tier 4 Case', 'Tier 5 Case', 'Tier 6 Case', 'Tier 7 Case', 'Tier 8 Case', 'Tier 9 Case', 'Tier 10 Case', 'Tier 11 Case', 'Animations Case', 'Radios Case', 'Tier 1 Premium Case', 'Tier 2 Premium Case'}, function(currentOption)
    CaseName = currentOption -- Redefines CaseName for Remote Later On
end)

-- Bypass
local MT = getrawmetatable(game)
local ONI = MT.__newindex

setreadonly(MT, false)

MT.__newindex = function(t, k, v)
   if k == "Source" then
       return error("")    
   end
   return ONI(t, k, v)
end

setreadonly(MT, true)
wait(.1)
local AllowedOpening = "" -- Creates Allowed Case Openings for People who can Open More!
Section2:NewTextBox("Number of Cases", "You get more cases by rebirthing! Default: 1", function(txt)
AllowedOpening = tonumber(txt) -- Redefines AllowedOpening
print(AllowedOpening) -- Prints it, press F9 to make sure you typed in a number!
end)
-- Config
local Config = {
    AutoOpenCases = false,
    AutoSellItems = false,
    AutoBPCUpgrade = false,
    AutoFCCase = false,
    AutoMPCap = false,
    AutoCCChance = false,
    AutoClicker = false,
}
local Section3 = Tab1:NewSection("Toggles")
Section3:NewToggle("Auto Open Cases", "Automatically opens cases for you!", function(CaseState)
    Config.AutoOpenCases=CaseState
end)
Section3:NewToggle("Auto Click", "Automatically clicks the money button for you!", function(ClickState)
    Config.AutoClicker=ClickState
end)
Section3:NewToggle("Auto Sell Everything", "Automatically sell everything in your inventory for you!", function(SellingState)
    Config.AutoSellItems=SellingState
end)
Section3:NewToggle("Auto Rebirth", "Automatically rebirthes for you!", function(RBState)
    Config.AutoRebirth=RBState
end)
Section7:NewToggle("Auto Bux Per Click", "Automatically upgrades your bux per click for you!", function(BPCState)
    Config.AutoBPCUpgrade=BPCState
end)
Section7:NewToggle("Auto Fast Case Open", "Automatically upgrades your faster case opening for you!", function(FCOState)
    Config.AutoFCCase=FCOState
end)
Section7:NewToggle("Auto Multiplier Cap", "Automatically upgrades your multiplier cap for you!", function(CMCState)
    Config.AutoMPCap=CMCState
end)
Section7:NewToggle("Auto Critical Chance", "Automatically upgrades your critical chance for you!", function(CCCState)
    Config.AutoCCChance=CCCState
end)
local Networking = require(game:GetService("ReplicatedStorage")["Game Objects"].Modules.Networking)
-- Looped Remotes
while wait() do
    if Config.AutoOpenCases then
        wait(.05)
        spawn(function()
            Networking:send("OpenCase", {
                CaseName,
                false,
               	tonumber(AllowedOpening)
            }, "RemoteFunction")
             end)
    end
     if Config.AutoClicker then
        wait(.05)
        spawn(function()
           Networking:send("Click")
             end)
    end
     if Config.AutoSellItems then
        wait(.05)
            spawn(function()
            Networking:send("SellByAmount", 1000000000000000000000000000000000000000)
            end)
            end
    if Config.AutoBPCUpgrade then
        wait(.05)
            spawn(function()
   
                local UpgradeList;
                for i,v in next, getgc(true) do
                    if type(v)=="table" and rawget(v, "BuxPerClick") then
                        UpgradeList = v
                    end
                end
                local ToUpgrade = "BuxPerClick"
                Networking:send("Upgrade", {
                    ToUpgrade, UpgradeList[ToUpgrade]
                })
      end)
    end
      if Config.AutoFCCase then
        wait(.05)
            spawn(function()

                local UpgradeList;
     
                for i,v in next, getgc(true) do
                    if type(v)=="table" and rawget(v, "CaseSpeed") then
                        UpgradeList = v
                    end
                end
                
                local ToUpgrade = "CaseSpeed"
                
                Networking:send("Upgrade", {
                    ToUpgrade, UpgradeList[ToUpgrade]
                })
                end)
            end
        if Config.AutoMPCap then
            wait(.05)
            spawn(function()
             
                local UpgradeList;
 
                for i,v in next, getgc(true) do
                    if type(v)=="table" and rawget(v, "MultiplierCap") then
                        UpgradeList = v
                    end
                end
                
                local ToUpgrade = "MultiplierCap"
                
                Networking:send("Upgrade", {
                    ToUpgrade, UpgradeList[ToUpgrade]
                })
 
            end)
        end
        if Config.AutoCCChance then
            wait(.05)
            spawn(function()

                local UpgradeList;
 
                for i,v in next, getgc(true) do
                    if type(v)=="table" and rawget(v, "CBMChance") then
                        UpgradeList = v
                    end
                end
                
                local ToUpgrade = "CBMChance"
                
                Networking:send("Upgrade", {
                    ToUpgrade, UpgradeList[ToUpgrade]
                })
 
            end)
        end
        if Config.AutoRebirth then
            wait(.06)
            spawn(function()
                Networking:send("Rebirth")
                end)
             end
        end
  
