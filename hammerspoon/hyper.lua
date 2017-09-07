
-- Set hyper to ctrl + alt + cmd
-- Set hyperShift to ctrl + alt + cmd + shift
local hyper      = {'ctrl', 'cmd', 'alt'}
-- local hyper      = {'ctrl', 'cmd', 'alt', 'shift'}
local hyperShift = {'ctrl', 'alt', 'cmd', 'shift'}

-- osascript -e 'id of app "Finder"'
-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new(hyperShift, 'k')

toggleApp = function(hotkey, id)
  local app = hs.application.frontmostApplication()
  -- print(app:bundleID())
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
  hotkey:bind({}, 'escape', function() hotkey:exit() end)
end

-- launch and focus applications
local key2App = {
    ['w'] = 'com.apple.Safari',
    ['t'] = 'com.googlecode.iterm2',
    ['g'] = 'com.google.Chrome',
    ['m'] = 'com.freron.MailMate',
    ['n'] = 'net.elasticthreads.nv',
    ['s'] = 'com.tinyspeck.slackmacgap',
    ['z'] = 'todoist.mac.Todoist',
    ['1'] = 'com.googlecode.iterm2',
    ['2'] = 'com.google.Chrome',
}
-- bindApps(k, key2App)

-- Sequential keybindings, e.g. Hyper-a,f for Finder
a = hs.hotkey.modal.new(hyperShift, 'a')
apps = {
  ['c'] = 'com.tencent.xinWeChat',
  ['d'] = 'com.tapbots.TweetbotMac',
  ['e'] = 'com.sublimetext.3',
  ['f'] = 'com.apple.finder',
  ['w'] = 'com.apple.Safari',
  ['t'] = 'com.googlecode.iterm2',
  ['g'] = 'com.google.Chrome',
  ['m'] = 'com.freron.MailMate',
  ['n'] = 'net.elasticthreads.nv',
  ['s'] = 'com.tinyspeck.slackmacgap',
  ['1'] = 'com.googlecode.iterm2',
  ['2'] = 'com.google.Chrome',
}
bindApps(a, apps)

-- Move Mouse to center of next Monitor
hs.hotkey.bind(hyperShift, '`', function()
    local screen = hs.mouse.getCurrentScreen()
    local nextScreen = screen:next()
    local rect = nextScreen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)

    hs.mouse.setAbsolutePosition(center)
end)
