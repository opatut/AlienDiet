-- Credits:
--   Programming, Graphics: Paul 'opatut' Bienkowski
-- Resources:
--   Sandwich drawing template: TeamFortress 2
--   Basic English Word List: http://www.langmaker.com/wordlist/basiclex.htm
--   Fonts: AEnigma Fonts (http://www.dafont.com/%C3%86nigma.d188)

require("gamestack")
require("mainstate")
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

    -- load fonts
    resources:addFont("large", "acknowtt.ttf", 40)
    resources:addFont("small", "visitor1.ttf", 20)

    resources:load()

    -- start game
    main = MainState()
    stack = GameStack()
    stack:push(main)
end

function love.update(dt)
    stack:update(dt)
end

function love.draw()
    stack:draw()
end

function love.keypressed(k)
    if k == "escape" then
        love.event.push("q");
    end

    main:keypressed(k)
end

