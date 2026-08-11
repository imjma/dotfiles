local This = {}

-- https://github.com/jhkuperus/dotfiles
local GRID_SIZE = 4
local HALF_GRID_SIZE = GRID_SIZE / 2
local MARGIN = 5
hs.grid.setGrid(GRID_SIZE .. 'x' .. GRID_SIZE)
hs.grid.setMargins({MARGIN, MARGIN})
hs.window.animationDuration = 0

-- Defining screen positions
local screenPositions       = {}
screenPositions.left        = {x = 0,              y = 0,              w = HALF_GRID_SIZE, h = GRID_SIZE     }
screenPositions.right       = {x = HALF_GRID_SIZE, y = 0,              w = HALF_GRID_SIZE, h = GRID_SIZE     }
screenPositions.top         = {x = 0,              y = 0,              w = GRID_SIZE,      h = HALF_GRID_SIZE}
screenPositions.bottom      = {x = 0,              y = HALF_GRID_SIZE, w = GRID_SIZE,      h = HALF_GRID_SIZE}

screenPositions.topLeft     = {x = 0,              y = 0,              w = HALF_GRID_SIZE, h = HALF_GRID_SIZE}
screenPositions.topRight    = {x = HALF_GRID_SIZE, y = 0,              w = HALF_GRID_SIZE, h = HALF_GRID_SIZE}
screenPositions.bottomLeft  = {x = 0,              y = HALF_GRID_SIZE, w = HALF_GRID_SIZE, h = HALF_GRID_SIZE}
screenPositions.bottomRight = {x = HALF_GRID_SIZE, y = HALF_GRID_SIZE, w = HALF_GRID_SIZE, h = HALF_GRID_SIZE}

screenPositions.leftOne   = {x = 0,            y = 0,              w = 1 , h = GRID_SIZE }
screenPositions.leftThree = {x = 0,            y = 0,              w = 3 , h = GRID_SIZE     }

screenPositions.rightOne= {x = 3,  y = 0,              w = 1, h = GRID_SIZE     }
screenPositions.rightThree= {x = 1,            y = 0,              w = GRID_SIZE - 1, h = GRID_SIZE     }

This.screenPositions = screenPositions

function This.windowMaxHeight(win)
    if win == nil then
        win = hs.window.focusedWindow()
    end
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.y = max.y+MARGIN
    f.h = max.h-MARGIN-MARGIN
    win:setFrameInScreenBounds(f, 0)
end

function This.moveCenter(win)
    if win == nil then
        win = hs.window.focusedWindow()
    end
    win:centerOnScreen()
end

-- This function will move either the specified or the focuesd
-- window to the requested screen position
function This.moveWindowToPosition(cell, window)
  if window == nil then
    window = hs.window.focusedWindow()
  end
  if window then
    local screen = window:screen()
    hs.grid.set(window, cell, screen)
  end
end

-- This function will move either the specified or the focused
-- window to the center of the sreen and let it fill up the
-- entire screen.
function This.windowMaximize(window)
    if window == nil then
        window = hs.window.focusedWindow()
    end
    hs.grid.maximizeWindow(window)
end

function This.moveWindowBetweenOneThirds(window)
  if window == nil then
    window = hs.window.focusedWindow()
  end
end

function This.cycleWindowLeft(window)
    if window == nil then
        window = hs.window.focusedWindow()
    end
    local current = hs.grid.get(window)

    if current.x ~= 0 or current.y ~= 0 or current.w >= GRID_SIZE - 1 then
        This.moveWindowToPosition(screenPositions.leftOne, window)
    else
        hs.grid.resizeWindowWider(window)
    end
end

function This.cycleWindowRight(window)
    if window == nil then
        window = hs.window.focusedWindow()
    end
    local current = hs.grid.get(window)

    if current.x <= 1 or current.y ~= 0 or current.w >= GRID_SIZE -1 then
        This.moveWindowToPosition(screenPositions.rightOne, window)
    else
        current.x = current.x - 1
        current.w = current.w + 1
        This.moveWindowToPosition(current)
    end
end

function This.moveToNextScreen(win)
    if win == nil then
        win = hs.window.focusedWindow()
    end
    if win then
        local screen = win:screen():next()
        win:moveToScreen(screen)
    end
end

function This.moveToPreviousScreen(win)
    if win == nil then
        win = hs.window.focusedWindow()
    end
    if win then
        local screen = win:screen():previous()
        win:moveToScreen(screen)
    end
end

function This.moveToLeft(win)
    if win == nil then
        win = hs.window.focusedWindow()
    end
    local f = win:frame()

    f.x = MARGIN

    win:setFrameInScreenBounds(f, 0)
end

function This.moveToRight(win)
    if win == nil then
        win = hs.window.focusedWindow()
    end
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.w-f.w-MARGIN

    win:setFrameInScreenBounds(f, 0)
end

return This
