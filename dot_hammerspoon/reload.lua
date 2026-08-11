function reload_config(files)
    hs.reload()
end
hs.pathwatcher.new(os.getenv("HOME") .. "/dotfiles/hammerspoon/", reload_config):start()
hs.alert.show("Config loaded")
