-- =================================================================
-- TOBOX AIM + ВХ ULTIMATE (MOBILE & PC)
-- Authors: Nazik & Jura
-- =================================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local PlayerGui = (gethui and gethui()) or LocalPlayer:WaitForChild("PlayerGui")
if PlayerGui:FindFirstChild("ToboxHub") then PlayerGui.ToboxHub:Destroy() end
pcall(function() 
    RunService:UnbindFromRenderStep("ToboxLoop") 
    RunService:UnbindFromRenderStep("ToboxFly")
end)

local Features = {
    Platform = "PC", -- "PC" або "Mobile"
    Aimbot = false, AimAssist = true, InstantLock = true, AimbotFOV = 150, TeamCheck = false, AimTarget = "Head",
    ESP_Box = false, ESP_BoxColor = Color3.fromRGB(118, 185, 0),
    ESP_FOVColor = Color3.fromRGB(118, 185, 0), ESP_Tracers = false, ESP_Names = false,
    SpeedHack = false, SpeedValue = 50, 
    JumpHack = false, JumpValue = 120, 
    Fly = false, FlySpeed = 50,
    Noclip = false, InfJump = false
}

local ColorPalette = {
    Color3.fromRGB(255, 50, 50), Color3.fromRGB(118, 185, 0), Color3.fromRGB(0, 150, 255),
    Color3.fromRGB(255, 220, 0), Color3.fromRGB(255, 130, 0), Color3.fromRGB(160, 32, 240),
    Color3.fromRGB(255, 105, 180), Color3.fromRGB(0, 230, 230), Color3.fromRGB(255, 255, 255), Color3.fromRGB(20, 20, 20)
}

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "ToboxHub"
ScreenGui.ResetOnSpawn = false

local function ApplySharpStyle(inst, bg, str)
    inst.BackgroundColor3 = bg or Color3.fromRGB(30, 30, 30)
    inst.BorderSizePixel = 0
    local stroke = Instance.new("UIStroke", inst)
    stroke.Color = str or Color3.fromRGB(60, 60, 60)
    stroke.Thickness = 1
end

--------------------------------------------------------------------
-- 1. ВІКНО ВИБОРУ ПЛАТФОРМИ (MOBILE / PC)
--------------------------------------------------------------------
local ModeFrame = Instance.new("Frame", ScreenGui)
ModeFrame.Size, ModeFrame.Position = UDim2.new(0, 360, 0, 220), UDim2.new(0.5, -180, 0.5, -110)
ModeFrame.ZIndex = 100
ApplySharpStyle(ModeFrame, Color3.fromRGB(25, 25, 25), Color3.fromRGB(118, 185, 0))

local ModeTitle = Instance.new("TextLabel", ModeFrame)
ModeTitle.Size, ModeTitle.Position = UDim2.new(1, 0, 0, 45), UDim2.new(0, 0, 0, 10)
ModeTitle.Text, ModeTitle.TextColor3, ModeTitle.Font, ModeTitle.TextSize = "ОБЕРІТЬ ПРИСТРІЙ / DEVICE", Color3.fromRGB(118, 185, 0), Enum.Font.SourceSansBold, 20
ModeTitle.BackgroundTransparency = 1

local PcBtn = Instance.new("TextButton", ModeFrame)
PcBtn.Size, PcBtn.Position = UDim2.new(0.42, 0, 0, 90), UDim2.new(0.06, 0, 0.38, 0)
PcBtn.Text, PcBtn.TextColor3, PcBtn.Font, PcBtn.TextSize = "💻 ПK (PC)", Color3.fromRGB(255, 255, 255), Enum.Font.SourceSansBold, 18
ApplySharpStyle(PcBtn, Color3.fromRGB(40, 40, 40), Color3.fromRGB(80, 80, 80))

local MobileBtn = Instance.new("TextButton", ModeFrame)
MobileBtn.Size, MobileBtn.Position = UDim2.new(0.42, 0, 0, 90), UDim2.new(0.52, 0, 0.38, 0)
MobileBtn.Text, MobileBtn.TextColor3, MobileBtn.Font, MobileBtn.TextSize = "📱 ТЕЛЕФОН", Color3.fromRGB(255, 255, 255), Enum.Font.SourceSansBold, 18
ApplySharpStyle(MobileBtn, Color3.fromRGB(40, 40, 40), Color3.fromRGB(80, 80, 80))

--------------------------------------------------------------------
-- 2. ГОЛОВНЕ МЕНЮ (TOBOX HUB)
--------------------------------------------------------------------
local Main = Instance.new("Frame", ScreenGui)
Main.Size, Main.Position = UDim2.new(0, 680, 0, 500), UDim2.new(0.5, -340, 0.5, -250)
Main.Active, Main.Draggable, Main.Visible = true, true, false
ApplySharpStyle(Main, Color3.fromRGB(30, 30, 30), Color3.fromRGB(70, 70, 70))

local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 40)
ApplySharpStyle(Header, Color3.fromRGB(20, 20, 20), Color3.fromRGB(50, 50, 50))

local Title = Instance.new("TextLabel", Header)
Title.Size, Title.Position, Title.BackgroundTransparency = UDim2.new(1, -50, 1, 0), UDim2.new(0, 15, 0, 0), 1
Title.Text, Title.TextColor3, Title.TextSize, Title.Font = "Tobox aim + вх", Color3.fromRGB(118, 185, 0), 18, Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size, CloseBtn.Position = UDim2.new(0, 40, 0, 40), UDim2.new(1, -40, 0, 0)
CloseBtn.Text, CloseBtn.TextColor3, CloseBtn.TextSize = "✕", Color3.fromRGB(200, 200, 200), 18
ApplySharpStyle(CloseBtn, Color3.fromRGB(40, 40, 40), Color3.fromRGB(60, 60, 60))
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

local OpenToggle = Instance.new("TextButton", ScreenGui)
OpenToggle.Size, OpenToggle.Position = UDim2.new(0, 90, 0, 40), UDim2.new(0, 10, 0.4, 0)
OpenToggle.Text, OpenToggle.TextColor3, OpenToggle.TextSize = "Tobox UI", Color3.fromRGB(255, 255, 255), 15
OpenToggle.Active, OpenToggle.Draggable, OpenToggle.Visible = true, true, false
ApplySharpStyle(OpenToggle, Color3.fromRGB(118, 185, 0), Color3.fromRGB(140, 210, 0))
OpenToggle.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

local function InitScript(mode)
    Features.Platform = mode
    ModeFrame:Destroy()
    Main.Visible = true
    OpenToggle.Visible = true
end

PcBtn.MouseButton1Click:Connect(function() InitScript("PC") end)
MobileBtn.MouseButton1Click:Connect(function() InitScript("Mobile") end)

-- Ліве меню вкладок
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size, Sidebar.Position = UDim2.new(0, 150, 1, -40), UDim2.new(0, 0, 0, 40)
ApplySharpStyle(Sidebar, Color3.fromRGB(25, 25, 25), Color3.fromRGB(45, 45, 45))

local SideList = Instance.new("UIListLayout", Sidebar)
SideList.SortOrder = Enum.SortOrder.LayoutOrder

local ContentHolder = Instance.new("Frame", Main)
ContentHolder.Size, ContentHolder.Position = UDim2.new(1, -150, 1, -40), UDim2.new(0, 150, 0, 40)
ContentHolder.BackgroundTransparency = 1

local Tabs = {}
local function CreateTab(name, iconText)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(1, 0, 0, 50)
    btn.Text = "  " .. iconText .. " " .. name
    btn.TextColor3, btn.TextSize, btn.Font = Color3.fromRGB(180, 180, 180), 15, Enum.Font.SourceSansBold
    btn.TextXAlignment = Enum.TextXAlignment.Left
    ApplySharpStyle(btn, Color3.fromRGB(25, 25, 25), Color3.fromRGB(35, 35, 35))

    local page = Instance.new("ScrollingFrame", ContentHolder)
    page.Size, page.Position, page.Visible = UDim2.new(1, -20, 1, -20), UDim2.new(0, 10, 0, 10), false
    page.BackgroundTransparency, page.ScrollBarThickness = 1, 5
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 8)

    Tabs[name] = {Btn = btn, Page = page}

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do
            t.Page.Visible = false
            t.Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            t.Btn.TextColor3 = Color3.fromRGB(180, 180, 180)
        end
        page.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(118, 185, 0)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    return page
end

local AimPage = CreateTab("Аімбот", "🎯")
local EspPage = CreateTab("ВХ / ESP", "👁️")
local CharPage = CreateTab("Персонаж", "🏃")
local SettPage = CreateTab("Налаштування", "⚙️")

Tabs["Аімбот"].Page.Visible = true
Tabs["Аімбот"].Btn.BackgroundColor3 = Color3.fromRGB(118, 185, 0)
Tabs["Аімбот"].Btn.TextColor3 = Color3.fromRGB(255, 255, 255)

--------------------------------------------------------------------
-- КОМПОНЕНТИ ІНТЕРФЕЙСУ (Тумблери, Слайдери, Вибір Кольору)
--------------------------------------------------------------------
local function AddToggle(page, name, key)
    local btn = Instance.new("TextButton", page)
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.Font, btn.TextSize = Enum.Font.SourceSansBold, 15
    
    local function update()
        if Features[key] then
            btn.Text = "[ УВІМКНЕНО ] " .. name
            ApplySharpStyle(btn, Color3.fromRGB(118, 185, 0), Color3.fromRGB(150, 220, 0))
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            btn.Text = "[ ВИМКНЕНО ] " .. name
            ApplySharpStyle(btn, Color3.fromRGB(45, 45, 45), Color3.fromRGB(65, 65, 65))
            btn.TextColor3 = Color3.fromRGB(170, 170, 170)
        end
    end
    btn.MouseButton1Click:Connect(function() Features[key] = not Features[key] update() end)
    update()
end

local function AddSlider(page, name, key, minVal, maxVal)
    local card = Instance.new("Frame", page)
    card.Size = UDim2.new(1, 0, 0, 50)
    ApplySharpStyle(card, Color3.fromRGB(40, 40, 40), Color3.fromRGB(60, 60, 60))

    local lbl = Instance.new("TextLabel", card)
    lbl.Size, lbl.Position, lbl.BackgroundTransparency = UDim2.new(1, -10, 0, 22), UDim2.new(0, 10, 0, 2), 1
    lbl.Text, lbl.TextColor3, lbl.Font, lbl.TextSize = name .. ": " .. tostring(Features[key]), Color3.fromRGB(255, 255, 255), Enum.Font.SourceSansBold, 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local sliderBg = Instance.new("Frame", card)
    sliderBg.Size, sliderBg.Position = UDim2.new(1, -20, 0, 12), UDim2.new(0, 10, 0, 28)
    ApplySharpStyle(sliderBg, Color3.fromRGB(20, 20, 20), Color3.fromRGB(50, 50, 50))

    local fill = Instance.new("Frame", sliderBg)
    local pct = (Features[key] - minVal) / (maxVal - minVal)
    fill.Size = UDim2.new(pct, 0, 1, 0)
    ApplySharpStyle(fill, Color3.fromRGB(118, 185, 0), Color3.fromRGB(150, 220, 0))

    local dragging = false
    local function updateSlider(input)
        local posX = math.clamp(input.Position.X - sliderBg.AbsolutePosition.X, 0, sliderBg.AbsoluteSize.X)
        local alpha = posX / sliderBg.AbsoluteSize.X
        local val = math.floor(minVal + (maxVal - minVal) * alpha)
        Features[key] = val
        fill.Size = UDim2.new(alpha, 0, 1, 0)
        lbl.Text = name .. ": " .. tostring(val)
    end

    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(input)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

local function AddDropdown(page, name, key, opts)
    local card = Instance.new("Frame", page)
    card.Size = UDim2.new(1, 0, 0, 42)
    ApplySharpStyle(card, Color3.fromRGB(40, 40, 40), Color3.fromRGB(60, 60, 60))

    local lbl = Instance.new("TextLabel", card)
    lbl.Size, lbl.Position, lbl.BackgroundTransparency = UDim2.new(0.5, 0, 1, 0), UDim2.new(0, 10, 0, 0), 1
    lbl.Text, lbl.TextColor3, lbl.Font, lbl.TextSize = name, Color3.fromRGB(255, 255, 255), Enum.Font.SourceSansBold, 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local btn = Instance.new("TextButton", card)
    btn.Size, btn.Position = UDim2.new(0.45, 0, 0.8, 0), UDim2.new(0.52, 0, 0.1, 0)
    btn.Text, btn.TextColor3, btn.Font, btn.TextSize = tostring(Features[key]), Color3.fromRGB(255, 255, 255), Enum.Font.SourceSansBold, 14
    ApplySharpStyle(btn, Color3.fromRGB(118, 185, 0), Color3.fromRGB(150, 220, 0))

    local idx = 1
    btn.MouseButton1Click:Connect(function()
        idx = idx % #opts + 1
        Features[key] = opts[idx]
        btn.Text = tostring(Features[key])
    end)
end

local function AddColorPicker(page, name, key)
    local card = Instance.new("Frame", page)
    card.Size = UDim2.new(1, 0, 0, 42)
    ApplySharpStyle(card, Color3.fromRGB(40, 40, 40), Color3.fromRGB(60, 60, 60))

    local lbl = Instance.new("TextLabel", card)
    lbl.Size, lbl.Position, lbl.BackgroundTransparency = UDim2.new(0.6, 0, 1, 0), UDim2.new(0, 10, 0, 0), 1
    lbl.Text, lbl.TextColor3, lbl.Font, lbl.TextSize = name, Color3.fromRGB(255, 255, 255), Enum.Font.SourceSansBold, 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local colorPreview = Instance.new("TextButton", card)
    colorPreview.Size, colorPreview.Position = UDim2.new(0, 30, 0, 28), UDim2.new(1, -38, 0, 7)
    colorPreview.Text = ""
    ApplySharpStyle(colorPreview, Features[key], Color3.fromRGB(255, 255, 255))

    local pickerFrame = Instance.new("Frame", ScreenGui)
    pickerFrame.Size, pickerFrame.Position, pickerFrame.Visible = UDim2.new(0, 170, 0, 75), UDim2.new(0.5, -85, 0.5, -37), false
    pickerFrame.ZIndex = 50
    ApplySharpStyle(pickerFrame, Color3.fromRGB(20, 20, 20), Color3.fromRGB(118, 185, 0))

    local grid = Instance.new("UIGridLayout", pickerFrame)
    grid.CellSize, grid.CellPadding = UDim2.new(0, 28, 0, 28), UDim2.new(0, 4, 0, 4)

    for _, color in ipairs(ColorPalette) do
        local sq = Instance.new("TextButton", pickerFrame)
        sq.Text, sq.ZIndex = "", 51
        ApplySharpStyle(sq, color, Color3.fromRGB(0, 0, 0))
        sq.MouseButton1Click:Connect(function()
            Features[key] = color
            colorPreview.BackgroundColor3 = color
            pickerFrame.Visible = false
        end)
    end

    colorPreview.MouseButton1Click:Connect(function()
        pickerFrame.Visible = not pickerFrame.Visible
    end)
end

--------------------------------------------------------------------
-- 3. НАПОВНЕННЯ ВКЛАДОК
--------------------------------------------------------------------
-- Аімбот
AddToggle(AimPage, "Аімбот Увімкнути", "Aimbot")
AddToggle(AimPage, "Аім Асист (Sticky Lock)", "AimAssist")
AddDropdown(AimPage, "Ціль Наведення", "AimTarget", {"Head", "HumanoidRootPart"})
AddToggle(AimPage, "Team Check (Перевірка Команди)", "TeamCheck")
AddSlider(AimPage, "Радіус FOV", "AimbotFOV", 30, 400)

-- ВХ / ESP
AddToggle(EspPage, "ESP Бокси", "ESP_Box")
AddToggle(EspPage, "ESP Лінії (Tracers)", "ESP_Tracers")
AddToggle(EspPage, "ESP Нікнейми", "ESP_Names")
AddColorPicker(EspPage, "Колір Боксів", "ESP_BoxColor")
AddColorPicker(EspPage, "Колір Кола FOV", "ESP_FOVColor")

-- Персонаж
AddToggle(CharPage, "SpeedHack (Швидкість)", "SpeedHack")
AddSlider(CharPage, "Значення Швидкості", "SpeedValue", 16, 300)

AddToggle(CharPage, "Super Jump (Стрибок)", "JumpHack")
AddSlider(CharPage, "Висота Стрибка", "JumpValue", 50, 400)

AddToggle(CharPage, "Fly (Політ)", "Fly")
AddSlider(CharPage, "Швидкість Польоту", "FlySpeed", 20, 250)

AddToggle(CharPage, "NoClip (Крізь Стіни)", "Noclip")
AddToggle(CharPage, "Inf Jump (Нескінченний Стрибок)", "InfJump")

-- Налаштування
local KillBtn = Instance.new("TextButton", SettPage)
KillBtn.Size = UDim2.new(1, 0, 0, 45)
KillBtn.Text = "🛑 ВИМКНУТИ СКРИПТ (KILL SWITCH)"
KillBtn.TextColor3, KillBtn.Font, KillBtn.TextSize = Color3.fromRGB(255, 255, 255), Enum.Font.SourceSansBold, 15
ApplySharpStyle(KillBtn, Color3.fromRGB(180, 40, 40), Color3.fromRGB(220, 50, 50))
KillBtn.MouseButton1Click:Connect(function()
    pcall(function() 
        RunService:UnbindFromRenderStep("ToboxLoop")
        RunService:UnbindFromRenderStep("ToboxFly") 
    end)
    ScreenGui:Destroy()
end)

local AuthorLabel = Instance.new("TextLabel", Main)
AuthorLabel.Size, AuthorLabel.Position = UDim2.new(1, -160, 0, 25), UDim2.new(0, 155, 1, -25)
AuthorLabel.BackgroundTransparency = 1
AuthorLabel.Text = "Autor by nazik and jura"
AuthorLabel.Font, AuthorLabel.TextSize = Enum.Font.SourceSansBold, 16
AuthorLabel.TextXAlignment = Enum.TextXAlignment.Right

task.spawn(function()
    local hue = 0
    while task.wait(0.03) do
        hue = (hue + 0.01) % 1
        AuthorLabel.TextColor3 = Color3.fromHSV(hue, 0.8, 1)
    end
end)

--------------------------------------------------------------------
-- 4. ЛОГІКА СКРИПТА (AIMBOT, FLY, ESP, NOCLIP)
--------------------------------------------------------------------
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness, FOVCircle.Filled, FOVCircle.Visible = 1.5, false, false

local ESP_Store = {}

-- Логіка Флай (Fly)
local bodyVelocity, bodyGyro
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if Features.Fly and root then
        if not bodyVelocity then
            bodyVelocity = Instance.new("BodyVelocity", root)
            bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bodyGyro = Instance.new("BodyGyro", root)
            bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
        end
        bodyGyro.CFrame = Camera.CFrame
        local moveDir = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0,1,0) end
        bodyVelocity.Velocity = moveDir * Features.FlySpeed
    else
        if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
        if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
    end
end)

-- Головний Цикл (Aimbot & ESP)
RunService:BindToRenderStep("ToboxLoop", Enum.RenderPriority.Camera.Value + 1, function()
    local mPos = UserInputService:GetMouseLocation()
    FOVCircle.Position, FOVCircle.Radius, FOVCircle.Color, FOVCircle.Visible = mPos, Features.AimbotFOV, Features.ESP_FOVColor, Features.Aimbot

    -- ESP
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            if not ESP_Store[p] then
                ESP_Store[p] = {Box = Drawing.new("Square"), Tracer = Drawing.new("Line"), Name = Drawing.new("Text")}
                ESP_Store[p].Box.Thickness, ESP_Store[p].Name.Size, ESP_Store[p].Name.Center = 1.5, 14, true
            end
            local e, ch = ESP_Store[p], p.Character
            local hum, root, head = ch and ch:FindFirstChildOfClass("Humanoid"), ch and ch:FindFirstChild("HumanoidRootPart"), ch and ch:FindFirstChild("Head")
            local valid = ch and root and head and hum and hum.Health > 0 and not (Features.TeamCheck and p.Team == LocalPlayer.Team)

            if valid then
                local v, onS = Camera:WorldToViewportPoint(root.Position)
                local hV, lV = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0)), Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))
                if onS then
                    local h = math.abs(hV.Y - lV.Y) local w = h / 1.8
                    e.Box.Visible, e.Box.Size, e.Box.Position, e.Box.Color = Features.ESP_Box, Vector2.new(w, h), Vector2.new(v.X - w/2, hV.Y), Features.ESP_BoxColor
                    e.Tracer.Visible, e.Tracer.From, e.Tracer.To, e.Tracer.Color = Features.ESP_Tracers, Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y), Vector2.new(v.X, lV.Y), Features.ESP_BoxColor
                    e.Name.Visible, e.Name.Text, e.Name.Position = Features.ESP_Names, p.Name, Vector2.new(v.X, hV.Y - 16)
                else e.Box.Visible, e.Tracer.Visible, e.Name.Visible = false, false, false end
            else if e.Box then e.Box.Visible, e.Tracer.Visible, e.Name.Visible = false, false, false end end
        end
    end

    -- Аімбот / Sticky Lock
    local isPressed = false
    if Features.Platform == "PC" then
        isPressed = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
    else
        isPressed = true -- Для мобільних замовчуванням при увімкненому аімботі
    end

    if Features.Aimbot and isPressed then
        local target, minD = nil, Features.AimbotFOV
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local targetPart = p.Character:FindFirstChild(Features.AimTarget) or p.Character:FindFirstChild("Head")
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if targetPart and hum and hum.Health > 0 and not (Features.TeamCheck and p.Team == LocalPlayer.Team) then
                    local pos, onS = Camera:WorldToViewportPoint(targetPart.Position)
                    if onS then
                        local d = (Vector2.new(pos.X, pos.Y) - mPos).Magnitude
                        if d < minD then minD = d target = targetPart end
                    end
                end
            end
        end
        if target then 
            if Features.AimAssist then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position) -- Наглухо приклеюється
            else
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Position), 0.25)
            end
        end
    end
end)

-- Фізика (Speed, Jump, Noclip)
RunService.Stepped:Connect(function()
    if LocalPlayer.Character and Features.Noclip then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if Features.SpeedHack then hum.WalkSpeed = Features.SpeedValue end
        if Features.JumpHack then hum.UseJumpPower = true hum.JumpPower = Features.JumpValue end
    end
end)

UserInputService.JumpRequest:Connect(function()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if Features.InfJump and hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end)