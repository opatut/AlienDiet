-- main game state

require("gamestate")
require("item")
require("zombie")
require("resources")

MainState = class("MainState", GameState)

function MainState:__init()
    -- prepare variables
    self.items = {}
    self.zombies = {}

    self.score = 0
    self.lives = 3
    self.time = 0
    self.nextItem = 0
end

function MainState:createItem()
    -- select a random image and random word
    keys = {"sandwich"}
    table.insert(self.items, Item(keys[math.random(1, #keys)], resources.words[math.random(1, #resources.words)]))
end

function MainState:createZombie(shift)
    if not shift then shift = 0 end
    table.insert(self.zombies, Zombie(math.random(12, 388), shift))
end

function MainState:update(dt)
    self.time = self.time + dt
    self.nextItem = self.nextItem - dt
    if self.nextItem < 0 then
        self:createItem()
        self.nextItem = math.pow(0.99, math.floor(self.time)) * 4
    end

    for key,item in ipairs(self.items) do
        item:update(dt)
    end

    for key,item in ipairs(self.items) do
        if item.word.wordRest == "" then
            table.remove(self.items, key)
        end

        if item.y >= 530 then
            self.lives = self.lives - 1
            table.remove(self.items, key)
        end
    end

    for key,zombie in ipairs(self.zombies) do
        zombie:update(self.items, dt)
    end

    if self.time >= 314.1 then
        -- happy birthday! you won.
        print("You are great")
    end

    if self.lives < 0 then
        print("You lost")
    end
end

function MainState:draw()
    for key,zombie in ipairs(self.zombies) do
        zombie:draw()
    end

    for key,item in ipairs(self.items) do
        item:draw()
    end

    -- draw ground
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", 0, 550, 400, 50)

    -- draw lives
    for i=1,3 do
        if i > self.lives then
            love.graphics.setColor(50, 50, 50)
        else
            love.graphics.setColor(255, 255, 255)
        end
        love.graphics.draw(resources.images.heart, 390 - i * 32, 560)
    end

    love.graphics.setColor(255, 255, 255, 128)
    love.graphics.setFont(resources.fonts.large)
    love.graphics.print("Time: " .. string.format("%05.1f", self.time), 20, 555)
end

function MainState:start()
    love.graphics.setBackgroundColor(100, 100, 100)

    -- create some zombies
    self:createZombie(20)
    self:createZombie(0)
    self:createZombie(-20)
end

function MainState:stop()
end

function MainState:keypressed(k)
    if k == "escape" then
        stack:pop()
    end

    for key,item in ipairs(self.items) do
        item:typeLetter(k)
    end
end
