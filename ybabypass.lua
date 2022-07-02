local pService = game:GetService'Players'.LocalPlayer.Character
repeat task.wait() until game:IsLoaded() and pService and game.ContentProvider.RequestQueueSize == 0

loadstring(game:HttpGet('https://raw.githubusercontent.com/3bo3c0ewnj9hks/rororo/main/ActualServerHop.lua', true))()
task.wait()
local __namecall __namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local Args = {...}
	if getnamecallmethod() == "InvokeServer" and tostring(self) == 'Returner' then
	    return "  ___XP DE KEY"
	end
    return __namecall(self, ...)
end)
