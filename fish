local ohNumber1 = 1

game:GetService("Players").LocalPlayer.Backpack[RodName].events.cast:FireServer(ohNumber1)

local GuiService = game:GetService("GuiService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Функция для проверки появления и последующего исчезновения "reel"
local function checkReel()
    while true do
        local reel
        -- Ждем появления "reel"
        repeat
            reel = playerGui:FindFirstChild("reel")
            wait(0.1)
        until reel
        -- Ждем удаления "reel"
        while reel do
            reel.AncestryChanged:Wait()
            reel = playerGui:FindFirstChild("reel")
        end
        print("reel deleted")
        -- Восстановление функции после удаления "reel"
        game:GetService("Players").LocalPlayer.Backpack[RodName].events.cast:FireServer(ohNumber1)
    end
end

-- Функция для проверки существования элемента в PlayerGui
local function checkForUI()
    if playerGui:FindFirstChild("shakeui") then
        local shakeui = playerGui.shakeui
        if shakeui:FindFirstChild("safezone") then
            local safezoneButton = shakeui.safezone:FindFirstChild("button")
            if safezoneButton then
                -- Выделение кнопки и симуляция нажатия Enter
                GuiService.SelectedObject = safezoneButton
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            end
        end
    end
end

-- Запуск функции проверки "reel" в отдельном потоке
spawn(checkReel)

-- Постоянная проверка существования интерфейса
while true do
    checkForUI()
    wait(0.1)
end
