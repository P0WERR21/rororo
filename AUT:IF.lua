--[[ Example Usage:
    -- Defining Shared Variables (Global)
    shared.Toggled = true
    shared.AutoStore = true
    shared.tableToPickup = {
        "Meteor",
        "SandDebris"
    }
    loadstring(game:HttpGet('https://raw.githubusercontent.com/3bo3c0ewnj9hks/rororo/main/AUT-IF.lua', true))()
]]--

-- Made By Meraki

-- Defining Local-Player Variables
local playerService = game:GetService'Players'
local replService = game:GetService'ReplicatedStorage'

local playerClient = playerService.LocalPlayer

local playerChar = playerClient.Character

-- Turns off CanCollide for Named Instance
local function CanCollideToggle(_)
    if (_.Name == 'Meteor' or _.Name == 'SandDebris') and _.CanCollide == true then
        _.CanCollide = false
    end
end

-- Rewrites the variable for your player's character on death
playerClient.CharacterAdded:Connect(function()
    playerChar = playerClient.Character
end)

-- Disables World Collision (for underground purposes)
local function disableCollision()
    for _, Collision in pairs(workspace.Map.Layout.Collisions:GetChildren()) do
        if (Collision:IsA'BasePart' and Collision.CanCollide == true) then
            Collision.CanCollide = false
        end
    end
end

-- Renders The Sand/Meteor
local function renderDebris()
    disableCollision() -- Calls DisableCollision
    
    for _, Child in pairs(workspace.ItemSpawns:GetDescendants()) do
        CanCollideToggle(Child) -- Disables Collision for Item(s)
    end

    workspace.ItemSpawns.DescendantAdded:Connect(CanCollideToggle) -- DescendantAdded Connected with CanCollideToggle

    -- Creating a Platform for Assisted Item-Farm
    local newPart = Instance.new('Part', workspace)
    newPart.Name = game:GetService'HttpService':GenerateGUID(false)
    newPart.Anchored = true
    newPart.Position = Vector3.new(-535, 908, 640)
    newPart.CanCollide = true
    newPart.Size = Vector3.new(10000,0.5,10000)
    task.wait(1)
    newPart.Rotation = Vector3.new(0, 0, 0)
    
    local deathHold = newPart:Clone()
    deathHold.Position = Vector3.new(-535, 800, 640) -- Another Cloned Platform at a lower Y Axis (incase first one glitches)
    task.wait()

    playerChar:MoveTo(newPart.Position) -- Teleports you to a hotspot for rendering
end

renderDebris() -- Calls the function

repeat task.wait() until #workspace.ItemSpawns.Meteors:GetChildren() >= 1 -- Waits until game renders the desert area

shared.Debounce = true -- Globally Defines a Debounce Var

local function movePickup(_)
    if shared.Debounce then -- Classic Debounce Usage (So Loop Doesn't Break)
        shared.Debounce = false -- Turns off Debounce for Timing
        disableCollision() -- Disables all Collisions Again
        task.wait(.3)
        local realInstance = _.Parent.Parent;
        repeat 
            realInstance.CanCollide = false
            playerChar:MoveTo(realInstance.Position + Vector3.new(0, -4, 0)) -- Loop Teleports to Instance (Incase Instance is literally flying)
            fireproximityprompt(_) -- FireProximityPrompt is Documented in https://x.synapse.to/ Docs
            task.wait()
        until not realInstance or not realInstance.Parent -- Checks if the instance or its parent becomes nil and stops the loop
        shared.Debounce = true -- Turns on the Debounce for Timing
        task.wait(.1)
    end
end


local function startSearch()
    for _, Item in pairs(workspace.ItemSpawns:GetDescendants()) do
        if (Item:FindFirstChild'ProximityAttachment' and table.find(shared.tableToPickup, Item.Name)) then
            local interactionPrompt = Item:FindFirstChild'ProximityAttachment'.Interaction
            movePickup(interactionPrompt) -- (Fires the ProximityPrompt(s) while Teleporting to Instance)
        end     
    end
end

local function storeItems()
     for _, Tool in pairs(playerClient.Backpack:GetChildren()) do
        Tool.Parent = playerChar
        replService.Remotes.InventoryRemote:FireServer("ItemInventory", {["AddItems"] = true})
     end
end

task.spawn(function()
    while shared.Toggled do -- Loop firing startSearch()
        startSearch()
        task.wait()
    end
end)

task.spawn(function()
    while shared.AutoStore do
        storeItems()
        task.wait()
    end
end)
