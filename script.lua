local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local camera = workspace.CurrentCamera
local isFollowing = false

function toggleFollowNearestPlayer()
    if isFollowing then
        isFollowing = false
        camera.CameraType = Enum.CameraType.Scriptable
    else
        isFollowing = true
        camera.CameraType = Enum.CameraType.Follow
    end
end

RunService:BindToRenderStep("ToggleFollow", Enum.RenderPriority.Last.Value, function()
    if isFollowing then
        local nearestPlayer = nil
        local nearestDistance = math.huge
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local distance = (player.Character.Head.Position - LocalPlayer:GetMouse().Hit.p).magnitude
                if distance < nearestDistance then
                    nearestDistance = distance
                    nearestPlayer = player
                end
            end
        end
        if nearestPlayer then
            camera.CFrame = nearestPlayer.Character.Head.CFrame
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if input.KeyCode == Enum.KeyCode.Q then
        toggleFollowNearestPlayer()
    end
end)
