
-- Set hyper to ctrl + alt + cmd
-- Set hyperShift to ctrl + alt + cmd + shift
local hyper      = {'ctrl', 'cmd', 'alt'}
-- local hyper      = {'ctrl', 'cmd', 'alt', 'shift'}
local hyperShift = {'ctrl', 'alt', 'cmd', 'shift'}

-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")

k:bind({}, 'f', nil, function() hs.eventtap.keyStroke({"cmd","alt","shift","ctrl"}, 'f') end)

launch = function(appname)
  hs.application.launchOrFocus(appname)
  k.triggered = true
end

toggleApp = function(id)
  local app = hs.application.frontmostApplication()
  -- print(app:bundleID())
  if app and app:bundleID() == id then
    app:hide()
  else
    hs.application.launchOrFocusByBundleID(id)
  end
  k.triggered = true
end

bindApps = function(hotkey, apps)
  for key, app in pairs(apps) do
    if type(app) == 'function' then
      hotkey:bind({}, key, app)
    elseif #app > 0 then
      if string.find(app, "com.") then
        hotkey:bind({}, key, function() toggleApp(app); hotkey:exit(); end)
      else
        hotkey:bind({}, key, function() launch(app); hotkey:exit(); end)
      end
    end
    -- hotkey:bind({}, key, function() launch(app); hotkey:exit(); end)
  end
end

-- launch and focus applications
local key2App = {
    ['w'] = 'Safari',
    ['e'] = 'Atom',
    ['t'] = 'iTerm',
    ['g'] = 'Google Chrome',
    ['m'] = 'Airmail 3',
    ['s'] = 'Slack',
    ['1'] = 'com.googlecode.iterm2',
    ['2'] = 'com.google.Chrome',
}
bindApps(k, key2App)

-- Sequential keybindings, e.g. Hyper-a,f for Finder
a = hs.hotkey.modal.new({}, "F16")
apps = {
  ['d'] = 'Tweetbot',
  ['f'] = 'Finder',
}
bindApps(a, apps)

pressedA = function() a:enter() end
releasedA = function() end
k:bind({}, 'a', nil, pressedA, releasedA)

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)
