-- Move window to center of screen
hs.hotkey.bind({'cmd', 'alt'}, 'c', function()
    hs.window.focusedWindow():centerOnScreen()
end)

-- Maximize window height and move to center of screen
hs.hotkey.bind({'ctrl', 'alt', 'shift'}, 'c', function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.y = max.y
    f.h = max.h
    win:setFrame(f, 0)
    win:centerOnScreen()
end)
