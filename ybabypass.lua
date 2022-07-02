local pService = game:GetService'Players'.LocalPlayer
local charPlayer = pService.Character
repeat task.wait() until (pService.PlayerGui:WaitForChild('Skip', true))

local function hitSkip()
    pcall(function()		
	local loadingScreen1 = pService.PlayerGui.LoadingScreen1
        firesignal(loadingScreen1.Frame.LoadingFrame.BarFrame.Skip.TextButton.MouseButton1Click)
    end)
end

hitSkip()

repeat task.wait() until pService.PlayerGui:WaitForChild('Play', true)

local function hitPlay()
    pcall(function()
	local loadingScreen = pService.PlayerGui.LoadingScreen.Play
        firesignal(loadingScreen.MouseButton1Click)
    end)
end

hitPlay()

loadstring(game:HttpGet('https://raw.githubusercontent.com/3bo3c0ewnj9hks/rororo/main/ActualServerHop.lua', true))()
task.wait()
local __namecall __namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local Args = {...}
	if getnamecallmethod() == "InvokeServer" and tostring(self) == 'Returner' then
	    return "  ___XP DE KEY"
	end
    return __namecall(self, ...)
end)

repeat task.wait() until game:IsLoaded() and charPlayer
