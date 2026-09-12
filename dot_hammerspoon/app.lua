local function moveMouseToFocusedWindow(appObject)
    if not appObject:isFrontmost() then
        return
    end

    local window = appObject:focusedWindow()
    if not window then
        return
    end

    local frame = window:frame()
    local mouse = hs.mouse.absolutePosition()
    local mouseIsInsideWindow = mouse.x >= frame.x
        and mouse.x <= frame.x + frame.w
        and mouse.y >= frame.y
        and mouse.y <= frame.y + frame.h

    if not mouseIsInsideWindow then
        hs.mouse.absolutePosition({
            x = frame.x + frame.w / 2,
            y = frame.y + frame.h / 2,
        })
    end
end

local function applicationWatcher(appName, eventType, appObject)
    if eventType ~= hs.application.watcher.activated then
        return
    end

    if appName == "Finder" then
        -- Bring all Finder windows forward when one gets activated
        appObject:selectMenuItem({ "Window", "Bring All to Front" })
    end

    -- Activation can arrive before macOS has assigned the focused window.
    hs.timer.doAfter(0.05, function()
        moveMouseToFocusedWindow(appObject)
    end)
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
