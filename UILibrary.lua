local UILibrary = {}

-- Themes
UILibrary.Themes = {
    Dark = {
        BackgroundColor = Color3.fromRGB(33, 33, 33),
        TextColor = Color3.fromRGB(255, 255, 255),
        ButtonColor = Color3.fromRGB(66, 66, 66),
        ToggleOnColor = Color3.fromRGB(0, 122, 255),
        ToggleOffColor = Color3.fromRGB(255, 0, 0)
    },
    Light = {
        BackgroundColor = Color3.fromRGB(255, 255, 255),
        TextColor = Color3.fromRGB(0, 0, 0),
        ButtonColor = Color3.fromRGB(200, 200, 200),
        ToggleOnColor = Color3.fromRGB(0, 122, 255),
        ToggleOffColor = Color3.fromRGB(255, 0, 0)
    },
    Rain = {
        BackgroundColor = Color3.fromRGB(135, 206, 250),
        TextColor = Color3.fromRGB(255, 255, 255),
        ButtonColor = Color3.fromRGB(0, 191, 255),
        ToggleOnColor = Color3.fromRGB(0, 122, 255),
        ToggleOffColor = Color3.fromRGB(255, 0, 0)
    }
}

-- Function to create the main UI window
function UILibrary:CreateWindow(title, theme)
    local screenGui = Instance.new("ScreenGui")
    local mainFrame = Instance.new("Frame")
    local titleLabel = Instance.new("TextLabel")
    local closeButton = Instance.new("TextButton")
    local tabContainer = Instance.new("Frame")

    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Main Frame
    mainFrame.Name = "MainFrame"
    mainFrame.Parent = screenGui
    mainFrame.BackgroundColor3 = self.Themes[theme].BackgroundColor
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    
    -- Title
    titleLabel.Name = "TitleLabel"
    titleLabel.Parent = mainFrame
    titleLabel.BackgroundColor3 = self.Themes[theme].BackgroundColor
    titleLabel.TextColor3 = self.Themes[theme].TextColor
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.SourceSans
    titleLabel.TextSize = 24
    
    -- Close Button
    closeButton.Name = "CloseButton"
    closeButton.Parent = mainFrame
    closeButton.Size = UDim2.new(0, 50, 0, 50)
    closeButton.Position = UDim2.new(1, -50, 0, 0)
    closeButton.Text = "X"
    closeButton.TextColor3 = self.Themes[theme].TextColor
    closeButton.BackgroundColor3 = self.Themes[theme].ButtonColor
    
    closeButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
    end)
    
    -- Tab Container
    tabContainer.Name = "TabContainer"
    tabContainer.Parent = mainFrame
    tabContainer.BackgroundColor3 = self.Themes[theme].BackgroundColor
    tabContainer.Size = UDim2.new(0, 200, 1, -50)
    tabContainer.Position = UDim2.new(0, 0, 0, 50)
    
    self.MainFrame = mainFrame
    self.TabContainer = tabContainer
    self.Tabs = {}
    
    return mainFrame
end

-- Function to create a button
function UILibrary:CreateButton(parent, text, theme, callback)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Size = UDim2.new(0, 200, 0, 50)
    button.BackgroundColor3 = self.Themes[theme].ButtonColor
    button.TextColor3 = self.Themes[theme].TextColor
    button.Text = text
    button.Font = Enum.Font.SourceSans
    button.TextSize = 24
    
    button.MouseButton1Click:Connect(callback)
    
    return button
end

-- Function to create a textbox
function UILibrary:CreateTextbox(parent, placeholderText, theme)
    local textbox = Instance.new("TextBox")
    textbox.Parent = parent
    textbox.Size = UDim2.new(0, 200, 0, 50)
    textbox.BackgroundColor3 = self.Themes[theme].ButtonColor
    textbox.TextColor3 = self.Themes[theme].TextColor
    textbox.PlaceholderText = placeholderText
    textbox.Font = Enum.Font.SourceSans
    textbox.TextSize = 24
    
    return textbox
end

-- Function to create a toggle
function UILibrary:CreateToggle(parent, text, theme, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Size = UDim2.new(0, 200, 0, 50)
    frame.BackgroundColor3 = self.Themes[theme].ButtonColor

    local toggle = Instance.new("TextButton")
    toggle.Parent = frame
    toggle.Size = UDim2.new(0, 50, 0, 50)
    toggle.Position = UDim2.new(1, -50, 0, 0)
    toggle.Text = ""
    toggle.BackgroundColor3 = self.Themes[theme].ToggleOffColor

    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(0, 150, 0, 50)
    label.TextColor3 = self.Themes[theme].TextColor
    label.Text = text
    label.Font = Enum.Font.SourceSans
    label.TextSize = 24
    
    local isOn = false
    toggle.MouseButton1Click:Connect(function()
        isOn = not isOn
        if isOn then
            toggle.BackgroundColor3 = self.Themes[theme].ToggleOnColor
        else
            toggle.BackgroundColor3 = self.Themes[theme].ToggleOffColor
        end
        callback(isOn)
    end)
    
    return frame
end

-- Function to create a tab
function UILibrary:CreateTab(text, theme)
    local tab = Instance.new("TextButton")
    tab.Parent = self.TabContainer
    tab.Size = UDim2.new(0, 200, 0, 50)
    tab.BackgroundColor3 = self.Themes[theme].ButtonColor
    tab.TextColor3 = self.Themes[theme].TextColor
    tab.Text = text
    tab.Font = Enum.Font.SourceSans
    tab.TextSize = 24
    
    local tabContent = Instance.new("Frame")
    tabContent.Parent = self.MainFrame
    tabContent.Size = UDim2.new(1, -200, 1, -50)
    tabContent.Position = UDim2.new(0, 200, 0, 50)
    tabContent.Visible = false
    tabContent.BackgroundColor3 = self.Themes[theme].BackgroundColor
    
    tab.MouseButton1Click:Connect(function()
        for _, t in pairs(self.Tabs) do
            t.Content.Visible = false
        end
        tabContent.Visible = true
    end)
    
    table.insert(self.Tabs, {Tab = tab, Content = tabContent})
    
    return tabContent
end

-- Function to load and run a script from a GitHub URL
function UILibrary:LoadScriptFromGitHub(parent, url)
    local httpService = game:GetService("HttpService")
    local response = httpService:GetAsync(url)
    local success, loadedScript = pcall(loadstring(response))
    
    if success then
        local env = setmetatable({
            scriptParent = parent
        }, {__index = _G})
        
        setfenv(loadedScript, env)
        pcall(loadedScript)
    else
        warn("Failed to load script from GitHub:", loadedScript)
    end
end

return UILibrary
