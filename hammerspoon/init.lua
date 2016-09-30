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

function reload_config(files)
    hs.reload()
end
hs.pathwatcher.new(os.getenv("HOME") .. "/dotfiles/hammerspoon/", reload_config):start()
hs.alert.show("Config loaded")

-- launch and focus applications
local key2App = {
    ['w'] = 'Safari',
    ['e'] = 'Atom',
    ['t'] = 'iTerm',
    ['g'] = 'Google Chrome',
    ['m'] = 'Airmail 3',
    ['s'] = 'Slack',
}
for key, app in pairs(key2App) do
    k:bind({}, key, function() launch(app); k:exit(); end)
end

-- Sequential keybindings, e.g. Hyper-a,f for Finder
a = hs.hotkey.modal.new({}, "F16")
apps = {
  {'d', 'Tweetbot'},
  {'f', 'Finder'},
}
for i, app in ipairs(apps) do
  a:bind({}, app[1], function() launch(app[2]); a:exit(); end)
end

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

