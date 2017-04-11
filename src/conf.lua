function love.conf(t)
    t.title = "Alien on a diet"
    t.author = "opatut"
    t.identity = "aliendiet"
    t.version = "0.10.2" -- Löve version
    t.console = false
    t.release = false
    t.window.width = 400
    t.window.height = 600
    t.window.fullscreen = false
    t.window.vsync = true
    t.window.fsaa = 0
    t.modules.joystick = true
    t.modules.audio = true
    t.modules.keyboard = true
    t.modules.event = true
    t.modules.image = true
    t.modules.graphics = true
    t.modules.timer = true
    t.modules.mouse = true
    t.modules.sound = true
    t.modules.physics = true
end

