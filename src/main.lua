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
require("language")
require("mainstate")
require("mainmenu")
require("settings")
require("stats")
require("intro")
require("resources")
require("i18n")

resources = Resources("data/")
resources.words = {}
settings = Settings()
settings:load()

lang = Lang(settings:get("language", "en_US"))
function _(key) return lang:_(key) end
save_timer = 0

function loadWords(l)
    if not l then l = lang.currentLanguage end

    local words = {}
    local iter = love.filesystem.lines("data/words." .. l .. ".txt")
    for line in iter do
        table.insert(words, line)
    end
    resources.words = words
end

function reset()
    -- load word list
    loadWords()

    -- start game
    about = About()
    difficulty = Difficulty()
    pause = Pause()
    pietime = PieTime()
    gameover = GameOver()
    language = Language()
    main = MainState()
    menu = MainMenu()
    stats = Stats()
    intro = Intro()
    stack = GameStack()
    stack:push(intro)
end

function love.load()
    math.randomseed(os.time())

    -- load images
    resources:addImage("logo", "logo.png")
    resources:addImage("sandwich", "sandwich.png")
    resources:addImage("pizza", "pizza.png")
    resources:addImage("burger", "burger.png")
    resources:addImage("pie_small", "pie_small.png")
    resources:addImage("hotdog", "hotdog.png")
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

    reset()
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

function love.keypressed(k, s, r)
    stack:keypressed(k, s, r)
end

function love.quit()
    -- save the stats
    settings:save()
end
