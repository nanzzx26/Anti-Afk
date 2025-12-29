-- Anti AFK + AFK Timer
-- Developer : Nanzzxdev
-- Platform  : Roblox Delta (Mobile)

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local antiAFK = false
local idleConn
local startTime = 0

local function formatTime(sec)
    local h = math.floor(sec / 3600)
    local m = math.floor((sec % 3600) / 60)
    local s = sec % 60
    return string.format("%02d:%02d:%02d", h, m, s)
end

-- ON
local function ON()
    if antiAFK then return end
    antiAFK = true
    startTime = os.time()

    idleConn = player.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)

    warn("🟢 Anti AFK ON | Nanzzxdev")
end

-- OFF
local function OFF()
    if not antiAFK then return end
    antiAFK = false

    if idleConn then
        idleConn:Disconnect()
        idleConn = nil
    end

    local total = os.time() - startTime
    warn("🔴 Anti AFK OFF | Total AFK: "..formatTime(total))
end

-- Timer display (console)
RunService.Heartbeat:Connect(function()
    if antiAFK then
        local elapsed = os.time() - startTime
        task.spawn(function()
            print("⏱️ AFK Time:", formatTime(elapsed))
        end)
        task.wait(60) -- update tiap 60 detik
    end
end)

-- Toggle
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end

    if input.KeyCode == Enum.KeyCode.K
    or input.UserInputType == Enum.UserInputType.Touch then
        if antiAFK then
            OFF()
        else
            ON()
        end
    end
end)

print("✅ Anti AFK + Timer Loaded | Nanzzxdev")
