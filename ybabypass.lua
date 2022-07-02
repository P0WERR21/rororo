local pService = game:GetService'Players'.LocalPlayer
local charPlayer = pService.Character
repeat task.wait() until (pService.PlayerGui:FindFirstChild'LoadingScreen' or pService.PlayerGui:FindFirstChild'LoadingScreen1') and charPlayer

local function hitSkip()
    pcall(function()		
	local loadingScreen1 = pService.PlayerGui.LoadingScreen1
        firesignal(loadingScreen1.Frame.LoadingFrame.BarFrame.Skip.TextButton.MouseButton1Click)
    end)
end

local function hitPlay()
    pcall(function()
	local loadingScreen = pService.PlayerGui.LoadingScreen
        firesignal(loadingScreen.Play.MouseButton1Click)
    end)
end

pcall(function()
    hitSkip()
    hitPlay()
end)

loadstring(game:HttpGet('https://raw.githubusercontent.com/3bo3c0ewnj9hks/rororo/main/ActualServerHop.lua', true))()
task.wait()
local __namecall __namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local Args = {...}
	if getnamecallmethod() == "InvokeServer" and tostring(self) == 'Returner' then
	    return "  ___XP DE KEY"
	end
    return __namecall(self, ...)
end)

print(true)
