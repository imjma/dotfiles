local This = {}

local hyper      = {'ctrl', 'cmd', 'alt'}
local hyperShift = {'ctrl', 'alt', 'shift'}
local hyperCmdShift = {'ctrl', 'alt', 'cmd', 'shift'}

function This.bindHotKey(key, handler)
    hs.hotkey.bind(hyper, key, handler)
end

function This.bindShiftHotKey(key, handler)
    hs.hotkey.bind(hyperShift, key, handler)
end

function This.bindCmdShiftHotKey(key, handler)
    hs.hotkey.bind(hyperCmdShift, key, handler)
end

function This.bindModsHotKey(mods, key, handler)
    hs.hotkey.bind(mods, key, handler)
end

This.hyperMode = hs.hotkey.modal.new(hyperCmdShift, 'a')
This.hyperMode:bind({}, 'escape', function() This.hyperMode:exit() end)

function This.bindKey(key, handler)
    This.hyperMode:bind({}, key, handler)
end

function This.bindShiftKey(key, handler)
    This.hyperMode:bind({'shift'}, key, handler)
end

-- osascript -e 'id of app "Finder"'
-- A global variable for the Hyper Mode
-- k = hs.hotkey.modal.new(hyperShift, 'k')

toggleApp = function(hotkey, id)
  local app = hs.application.frontmostApplication()
  if app and app:bundleID() == id then
    app:hide()
  else
    hs.application.launchOrFocusByBundleID(id)
  end
  hotkey:exit()
end

bindApps = function(hotkey, apps)
  for key, app in pairs(apps) do
    if type(app) == 'function' then
      hotkey:bind({}, key, app)
    elseif #app > 0 then
      hotkey:bind({}, key, function() toggleApp(hotkey, app) end)
    end
  end
end

function This.bindApps(apps)
  for key, app in pairs(apps) do
    if type(app) == 'function' then
      This.bindKey(key, app)
    elseif #app > 0 then
      This.bindKey(key, function() toggleApp(This.hyperMode, app) end)
    end
  end
end


-- Sequential keybindings, e.g. Hyper-a,f for Finder
-- a = hs.hotkey.modal.new(hyperCmdShift, 'a')
apps = {
  -- ['b'] = 'net.shinyfrog.bear',
  -- ['c'] = 'com.tencent.xinWeChat',
  -- ['d'] = 'com.tapbots.TweetbotMac',
  -- ['e'] = 'com.sublimetext.3',
  ['f'] = 'com.apple.finder',
  ['w'] = 'com.apple.Safari',
  ['t'] = 'io.alacritty',
  ['g'] = 'com.google.Chrome',
  ['m'] = 'com.freron.MailMate',
  ['n'] = 'notion.id',
  ['s'] = 'com.tinyspeck.slackmacgap',
  -- ['1'] = 'com.googlecode.iterm2',
  -- ['2'] = 'com.google.Chrome',
}
-- bindApps(a, apps)

-- Move Mouse to center of next Monitor
hs.hotkey.bind(hyperCmdShift, '`', function()
    local screen = hs.mouse.getCurrentScreen()
    local nextScreen = screen:next()
    local rect = nextScreen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)

    hs.mouse.setAbsolutePosition(center)
end)

-- launch and focus applications
local key2BundleID = {
    -- ['p'] = 'com.jetbrains.PhpStorm'
}
for key, bundleID in pairs(key2BundleID) do
    hs.hotkey.bind(hyperShift, key, function() hs.application.launchOrFocusByBundleID(bundleID) end)
end

return This
