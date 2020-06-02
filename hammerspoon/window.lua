-- Move window to center of screen
hs.hotkey.bind({'cmd', 'alt'}, 'c', function()
    hs.window.focusedWindow():centerOnScreen()
end)

appMaxHeight = function(center)
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.y = max.y
    f.h = max.h
    if center then
        win:setFrameInScreenBounds(f, 0)
    end
end

-- Maximize window height and move to center of screen
hs.hotkey.bind({'ctrl', 'alt', 'shift'}, 'c', function()
    appMaxHeight(true)
end)

-- Maximize window height
hs.hotkey.bind({'ctrl', 'alt', 'shift'}, 'up', function()
    appMaxHeight(false)
end)
