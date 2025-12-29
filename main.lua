--[[
    Anti AFK Toggle Script
    Developer : Nanzzxdev
    Platform  : Roblox (Delta Executor / Mobile)
]]

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local antiAFK = false
local idleConnection

local function enableAntiAFK()
    if antiAFK then return end
    antiAFK = true

    idleConnection = player.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)

    warn("🟢 Anti AFK ON | Developer: Nanzzxdev")
end

local function disableAntiAFK()
    if not antiAFK then return end
    antiAFK = false

    if idleConnection then
        idleConnection:Disconnect()
        idleConnection = nil
    end

    warn("🔴 Anti AFK OFF | Developer: Nanzzxdev")
end

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end

    if input.KeyCode == Enum.KeyCode.K or input.UserInputType == Enum.UserInputType.Touch then
        if antiAFK then
            disableAntiAFK()
        else
            enableAntiAFK()
        end
    end
end)

print("✅ Anti AFK Toggle Loaded | Nanzzxdev")
