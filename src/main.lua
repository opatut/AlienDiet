-- Credits:
--   Programming, Graphics: Paul 'opatut' Bienkowski
-- Resources:
--   Sandwich drawing template: TeamFortress 2
--   Basic English Word List: http://www.langmaker.com/wordlist/basiclex.htm
--   Fonts: AEnigma Fonts (http://www.dafont.com/%C3%86nigma.d188)

require("gamestack")
require("mainstate")
require("mainmenu")
require("resources")

resources = Resources("data/")

function love.load()
    math.randomseed(os.time())

    -- load word list
    resources.words = {}
    for line in io.lines("data/words.txt") do
        table.insert(resources.words, line)
    end

    -- load images
    resources:addImage("sandwich", "sandwich.png")
    resources:addImage("zombie", "zombie.png")
    resources:addImage("heart", "heart.png")
    resources:addImage("background", "background.png")

    -- load fonts
    resources:addFont("giant", "acknowtt.ttf", 60)
    resources:addFont("large", "acknowtt.ttf", 40)
    resources:addFont("small", "visitor1.ttf", 20)

    resources:load()

    -- start game
    main = MainState()
    menu = MainMenu()
    stack = GameStack()
    stack:push(menu)
end

function love.update(dt)
    stack:update(dt)
end

function love.draw()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(resources.images.background, 0, 0)
    stack:draw()
end

function love.keypressed(k)
    stack:keypressed(k)
end

