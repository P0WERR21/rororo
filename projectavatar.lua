--[[
    Written By: Hubert Blaine Wolfeschlegelstein#0001
]]--
-- Services
local Camera     = workspace.Camera
local SolarisLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/sol"))()

local win = SolarisLib:New({
   Name = "Project Avatar",
   FolderToSave = "ProjectAvatar"
})

local playerService =  game:GetService'Players'
local nameCheck = playerService.LocalPlayer.Name
SolarisLib:Notification("Hello,"..nameCheck, "Successfully launched PAvatar v1.0")

local tab = win:Tab("Auto Aim")

local sec = tab:Section("Setup")
local toggle = sec:Toggle("Auto Aim Toggle", false,"Toggle", function(t)
    shared.Toggle = t
end)

local PlayerTable = {}
for _, Player in next, playerService:GetPlayers() do
    table.insert(PlayerTable, Player.Name)
end

local playerDropdown = sec:Dropdown("Specify Player", PlayerTable,"","Dropdown", function(t)
    for _, Player in next, playerService:GetPlayers() do
        if string.match(string.lower(t), string.lower(Player.Name)) then
            shared.TargetChar = Player.Character
        end
    end
end)

-- Functions
local function screenPoint(_)
    local realPosition = (_['Left Leg'].Position)
    local Vector, Visible = Camera:WorldToScreenPoint(realPosition)
    return Vector, Visible;
end

local function moveAbsolute()
    local passedVector, isVisible = screenPoint(shared.TargetChar)
    if isVisible then
        local xAxis, yAxis = passedVector.X, passedVector.Y
        mousemoveabs(xAxis, yAxis)
    end
end



playerService.PlayerAdded:Connect(function(addedPlayer)
    table.insert(PlayerTable, addedPlayer.Name)
    playerDropdown:Refresh(PlayerTable, true)
end)

playerService.PlayerRemoving:Connect(function(removedPlayer)
    table.insert(PlayerTable, removedPlayer.Name)
    playerDropdown:Refresh(PlayerTable, true)
end)

sec:Bind("Hold Bind", Enum.KeyCode.E, true, "BindHold", function(t)
    shared.boolHold = t
    if not shared.Toggle then return end
    while (shared.boolHold) do
        moveAbsolute()
        task.wait()
    end
end) 
