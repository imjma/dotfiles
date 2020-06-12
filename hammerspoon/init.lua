local hyper = require('hyper')
local wm = require('window')

-- reload
require './reload'

-- hyper
-- require './hyper'

-- app
require './app'

-- window
-- require './window'

hyper.bindShiftHotKey('up', function() wm.windowMaxHeight() end)
hyper.bindModsHotKey({'cmd', 'alt'}, 'c', function() wm.moveCenter() end)
hyper.bindShiftHotKey('c', function()
    wm.windowMaxHeight()
    wm.moveCenter()
end)
hyper.bindModsHotKey({'ctrl', 'alt'}, 'return', function() wm.windowMaximize() end)
hyper.bindModsHotKey({'ctrl', 'alt'}, 'left', function() wm.cycleWindowLeft() end)
hyper.bindModsHotKey({'ctrl', 'alt'}, 'right', function() wm.cycleWindowRight() end)
-- hyper.bindCmdShiftHotKey(']', function() 
    -- wm.moveWindowToPosition(wm.screenPositions.rightOneThird) 
-- end)
hyper.bindHotKey('left', function() wm.moveToNextScreen() end)
hyper.bindHotKey('right', function() wm.moveToPreviousScreen() end)


-- Show the bundleID of the currently open window
hyper.bindKey('b', function() 
    local bundleId = hs.window.focusedWindow():application():bundleID()
    hs.alert.show(bundleId)
    hs.pasteboard.setContents(bundleId)
    hyper.hyperMode:exit()
end)

apps = {
  ['f'] = 'org.mozilla.firefox',
  ['g'] = 'com.google.Chrome',
  ['m'] = 'com.freron.MailMate',
  ['n'] = 'notion.id',
  ['s'] = 'com.tinyspeck.slackmacgap',
  ['t'] = 'io.alacritty',
  ['w'] = 'com.apple.Safari',
}

hyper.bindApps(apps)
