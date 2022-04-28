local servicePlr = game:GetService'Players'
local serviceCGui = game:GetService'CoreGui'
local serviceTPS = game:GetService'TeleportService'
local serviceCPI = game:GetService'ContentProvider'
--
repeat task.wait() until game:IsLoaded() and servicePlr.LocalPlayer.Character and servicePlr.LocalPlayer.LoadedIn.Value
--

local plrLocal = servicePlr.LocalPlayer
local sameGame = game.PlaceId
local coolNumber = .3

loadstring(game:HttpGet'https://github.com/sannin9000/scripts/raw/main/Stand%20Upright%20Bypass.lua')() -- creds to sannin
-- Kick/Error Teleport
servicePlr.PlayerRemoving:Connect(function(Instance)
    if Instance == plrLocal then
        serviceTPS:Teleport(sameGame)
    end
end)

serviceCGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(realInstance)
    if tostring(realInstance) == "ErrorPrompt" and realInstance.MessageArea:FindFirstChild'ErrorFrame' then
        serviceTPS:Teleport(sameGame)
    end
end)
--
task.wait()
firesignal(plrLocal.PlayerGui.MenuGUI.Play.MouseButton1Click)
repeat task.wait() until not plrLocal.PlayerGui.MenuGUI.Enabled and plrLocal.Character
repeat
    for i, v in next, workspace.Items:GetChildren() do
        local newCFrame = v.Handle.CFrame + Vector3.new(0, -17.3849, 0)
        local TweenInfo = game.TweenService:Create(plrLocal.Character.HumanoidRootPart, TweenInfo.new(coolNumber, Enum.EasingStyle.Linear), {CFrame = newCFrame}, Enum.EasingDirection.Out, 0, false, 0):Play()
            task.wait(coolNumber)
        firetouchinterest(plrLocal.Character.HumanoidRootPart, v.Handle, 0)
    end
task.wait()
until #workspace.Items:GetChildren() == 0
loadstring(game:HttpGet'https://raw.githubusercontent.com/3bo3c0ewnj9hks/rororo/main/ActualServerHop.lua')()
Teleport()

