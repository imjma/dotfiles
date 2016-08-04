-- Set hyper to ctrl + alt + cmd
-- Set hyperShift to ctrl + alt + cmd + shift
local hyper      = {'ctrl', 'cmd', 'alt'}
-- local hyper      = {'ctrl', 'cmd', 'alt', 'shift'}
local hyperShift = {'ctrl', 'alt', 'cmd', 'shift'}

-- reload configka
-- hs.hotkey.bind(hyper, "r", function()
--     removeCaffeine()
--     hs.reload()
-- end)
-- hs.alert.show("Config loaded")

function reload_config(files)
    hs.reload()
end
hs.pathwatcher.new(os.getenv("HOME") .. "/dotfiles/hammerspoon/", reload_config):start()
hs.alert.show("Config loaded")

-- replace caffeine
-- local caffeine = hs.menubar.new()
-- function setCaffeineDisplay(state)
--     if state then
--         -- caffeine:setTitle("A") -- AWAKE
--         caffeine:setIcon("caffeine-active.png")
--         hs.alert("Caffeine enabled", 1)
--     else
--         -- caffeine:setTitle("S") -- SLEEPY
--         caffeine:setIcon("caffeine-inactive.png")
--         hs.alert("Caffeine disabled", 1)
--     end
-- end

-- function toggleCaffeine()
--     setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
-- end

-- function removeCaffeine()
--     caffeine:delete()
--     caffeine = nil
-- end

-- if caffeine then
--     caffeine:setClickCallback(toggleCaffeine)
--     -- hs.caffeinate.set("displayIdle", true)  -- default to turn caffeinate on
--     setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
-- end
-- /replace caffeine

-- launch and focus applications
local key2App = {
    ["a"] = "App Store",
    ["w"] = "Safari",
    ["e"] = "Atom",
    ["r"] = "RubyMine",
    ["f"] = "Finder",
    ["t"] = "iTerm",
    ["g"] = "Google Chrome",
    ["m"] = "Airmail 3",
    ["s"] = "Slack"
}
for key, app in pairs(key2App) do
    hs.hotkey.bind(hyperShift, key, function() hs.application.launchOrFocus(app) end)
end

-- Simple triggers
-- triggers = {
--   {hyper, "s", "Slack"}
-- }
-- for _, trigger in pairs(triggers) do
  -- local mods = trigger[1]
  -- local key = trigger[2]
  -- local applicationName = trigger[3]

  -- hs.hotkey.bind(mods, key, function()
    -- hs.application.launchOrFocus(applicationName)
  -- end)
-- end

-- Hints
hs.hotkey.bind(hyperShift, '\\', function() 
    hs.hints.windowHints()
end)

-- Move Mouse to center of next Monitor
hs.hotkey.bind(hyperShift, '`', function()
    local screen = hs.mouse.getCurrentScreen()
    local nextScreen = screen:next()
    local rect = nextScreen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)

    -- hs.mouse.setRelativePosition(center, nextScreen)
    hs.mouse.setAbsolutePosition(center)
end)

-- Move Mouse to center of current Window
-- hs.hotkey.bind(hyperShift, '/', function()
--     local win = hs.window.focusedWindow()
--     local rect = win:frame()
--     local center = hs.geometry.rectMidPoint(rect)

    -- hs.mouse.setRelativePosition(center, nextScreen)
--     hs.mouse.setAbsolutePosition(center)
-- end)

-- hs.hotkey.bind(hyper, '/', toggleCaffeine)
