-- Credits:
--   Programming, Graphics: Paul 'opatut' Bienkowski
-- Resources:
--   Sandwich drawing template: TeamFortress 2
--   Basic English Word List: http://www.langmaker.com/wordlist/basiclex.htm
--   Fonts: AEnigma Fonts (http://www.dafont.com/%C3%86nigma.d188)

require("about")
require("difficulty")
require("gamestack")
require("gameover")
require("pietime")
require("pause")
require("mainstate")
require("mainmenu")
require("settings")
require("stats")
require("intro")
require("resources")

resources = Resources("data/")
settings = Settings()
settings:load()

save_timer = 0

function love.load()
    math.randomseed(os.time())

    -- load word list
    resources.words = {}
    for line in io.lines("data/words.txt") do
        table.insert(resources.words, line)
    end

    -- load images
    resources:addImage("logo", "logo.png")
    resources:addImage("sandwich", "sandwich.png")
    resources:addImage("pizza", "pizza.png")
    resources:addImage("pie_small", "pie_small.png")
    resources:addImage("alien", "alien.png")
    resources:addImage("heart", "heart.png")
    resources:addImage("background", "background.png")
    resources:addImage("keyboard", "keyboard.png")
    resources:addImage("game_over", "game_over.png")
    resources:addImage("pie", "pie.png")

    -- load fonts
    resources:addFont("large", "acknowtt.ttf", 40)
    resources:addFont("medium", "visitor1.ttf", 30)
    resources:addFont("small", "visitor1.ttf", 20)
    resources:addFont("mini", "visitor1.ttf", 15)
    resources:addFont("tiny", "visitor1.ttf", 10)

    -- load music
    resources:addMusic("normal", "discovery.mp3")
    resources:addMusic("hacker", "murdertaxi.mp3")
    resources:addMusic("insane", "work-it-out.mp3")
    resources:addMusic("fanfare", "fanfare.mp3")

    resources:load()

    -- start game
    about = About()
    difficulty = Difficulty()
    pause = Pause()
    pietime = PieTime()
    gameover = GameOver()
    main = MainState()
    menu = MainMenu()
    stats = Stats()
    intro = Intro()
    stack = GameStack()
    stack:push(intro)
end

function love.update(dt)
    stack:update(dt)

    save_timer = save_timer - dt
    if save_timer < 0 then
        save_timer = 10
        settings:save()
    end
end

function love.draw()
    stack:draw()
    love.graphics.setFont(resources.fonts.tiny)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 5, 5)
end

function love.keypressed(k)
    stack:keypressed(k)
end

function love.quit()
    -- save the stats
    settings:save()
end
