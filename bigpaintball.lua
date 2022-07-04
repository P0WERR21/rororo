game.Loaded:Wait()

-- Big Paintball Silent Aim
local playerService = game:GetService'Players'
local playerCurrent = playerService.LocalPlayer
local Mouse = playerCurrent:GetMouse()
local Camera = workspace.CurrentCamera

local function getScreenPos(passedVector)
    local Pos = Camera.WorldToScreenPoint(Camera, passedVector)
    return Vector2.new(Pos.X, Pos.Y)
end

local function getDirection(Orig, Pos)
    return (Pos - Orig).Unit * 10000
end

local function teamCheck(player)
    if player.Team ~= playerCurrent.Team then
        return true
    end
    return false
end

local function getPlayerInstance()
    local closestPlayer = nil;
    local closestDistance = math.huge;
        for _, Player in next, playerService:GetPlayers() do
            if (Player ~= nil and Player ~= playerCurrent) and Player.Character and tostring(Player.Parent) ~= 'CharacterGraveyard' then
                local playerChar = Player.Character or nil
                local playerHum = playerChar:FindFirstChild'Humanoid' or nil
                local playerPart = playerChar.PrimaryPart or playerChar.HumanoidRootPart or nil
                if (playerHum and playerPart and playerChar.Humanoid.Health ~= 0) and teamCheck(Player) then
                    local ScreenPos = getScreenPos(playerPart.Position)
                    local mouseDist = (Vector2.new(Mouse.X, Mouse.Y) - ScreenPos).Magnitude
                    if mouseDist < closestDistance then
                        closestPlayer = Player
                        closestDistance = mouseDist
                    end
                 end
            end
        end
    return closestPlayer
end

local namecall; namecall = hookmetamethod(game, "__namecall", function(...)
    local Arguments = {...}
    local Method = getnamecallmethod()
    local self = Arguments[1]
    if (Method == 'FindPartOnRayWithWhitelist' and not checkcaller() and self == workspace) then
        local playerInstance = getPlayerInstance()
        local playerHum = playerInstance.Character.HumanoidRootPart
        if playerHum then
            local Origin = playerHum.Position + Vector3.new(0, 10, 0)
            local Direction = getDirection(Origin, playerHum.Position)
            Arguments[2] = Ray.new(Origin, Direction)
            setnamecallmethod('FindPartOnRayWithWhitelist')
            return namecall(unpack(Arguments))
        end
    end
    return namecall(...)
end)
