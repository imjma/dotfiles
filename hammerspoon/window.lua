local This = {}

-- https://github.com/jhkuperus/dotfiles
local GRID_SIZE = 6
local HALF_GRID_SIZE = GRID_SIZE / 2
local THIRD_GRID_SIZE = GRID_SIZE / 3
hs.grid.setGrid(GRID_SIZE .. 'x' .. GRID_SIZE)
hs.grid.setMargins({5, 5})
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

screenPositions.leftOneThird  = {x = 0,            y = 0,              w = THIRD_GRID_SIZE, h = GRID_SIZE     }
screenPositions.leftTwoThirds = {x = 0,            y = 0,              w = THIRD_GRID_SIZE * 2, h = GRID_SIZE     }

screenPositions.rightOneThird  = {x = THIRD_GRID_SIZE * 2,  y = 0,              w = GRID_SIZE, h = GRID_SIZE     }
screenPositions.rightTwoThirds = {x = THIRD_GRID_SIZE,            y = 0,              w = GRID_SIZE , h = GRID_SIZE     }

This.screenPositions = screenPositions

function This.windowMaxHeight(win)
    if win == nil then
        win = hs.window.focusedWindow()
    end
    local current = hs.grid.get(win)
    current.y = 0
    current.h = GRID_SIZE
    This.moveWindowToPosition(current, win)
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
    local cell = screenPositions.leftOneThird

    if current == screenPositions.leftOneThird then
        cell = screenPositions.left
    elseif current == screenPositions.left then
        cell = screenPositions.leftTwoThirds
    end

    This.moveWindowToPosition(cell, window)
end

function This.cycleWindowRight(window)
    if window == nil then
        window = hs.window.focusedWindow()
    end
    local current = hs.grid.get(window)
    local cell = screenPositions.rightOneThird

    if current == screenPositions.rightOneThird then
        cell = screenPositions.right
    elseif current == screenPositions.right then
        cell = screenPositions.rightTwoThirds
    end

    This.moveWindowToPosition(cell, window)
end

return This
