-- main game state

require("gamestate")
require("item")
require("zombie")
require("resources")
require("settings")

MainState = class("MainState", GameState)

function MainState:__init()
    -- prepare variables
    self.difficulty = 1 -- 1 = normal, 2 = hacker, 3 = insane
    self:reset()
end

function MainState:createItem()
    -- select a random image and random word
    keys = {"sandwich", "pizza"}
    if self.time > 314.1 then table.insert(keys, "pie_small") end
    local s = {30, 40, 50}
    table.insert(self.items, Item(keys[math.random(1, #keys)], resources.words[math.random(1, #resources.words)], s[self.difficulty] + math.random(-100, 100) * 0.05))
end

function MainState:createZombie(shift)
    if not shift then shift = 0 end
    table.insert(self.zombies, Zombie(math.random(12, 388), shift))
end

function MainState:update(dt)
    self.time = self.time + dt
    settings:inc("minutes", dt / 60.0)

    if self.time > settings:get("maxtime", 0) then
        settings:set("maxtime", self.time)
    end

    self.nextItem = self.nextItem - dt
    if self.nextItem < 0 then
        self:createItem()
        local c = {5,3.5,2}
        self.nextItem = math.pow(0.997, math.floor(self.time)) * c[self.difficulty]
    end

    for key,item in ipairs(self.items) do
        item:update(dt)
    end

    for key,item in ipairs(self.items) do
        if item.word.wordRest == "" then
            table.remove(self.items, key)
            settings:inc("completed")
        end

        if item.y >= 530 then
            self.lives = self.lives - 1
            table.remove(self.items, key)
        end
    end

    for key,zombie in ipairs(self.zombies) do
        zombie:update(self.items, dt)
    end

    if self.time >= 314.1 and not self.pietime_done then
        self.pietime_done = true
        settings:inc("pies")
        stack:push(pietime)
    end

    if self.lives <= 0 then
        stack:pop()
        stack:push(gameover)
    end
end

function MainState:draw()
    -- background
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(resources.images.background, 0, 0)

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
    settings:inc("played")

    local m = {"normal", "hacker", "insane"}
    local s = resources.music[m[self.difficulty]]
    if s:isStopped() then
        love.audio.stop()
    end
    s:setLooping(true)
    s:play()
end

function MainState:reset()
    self.items = {}
    self.zombies = {}

    self.score = 0
    self.lives = 3
    self.time = 0
    self.nextItem = 0
    self.pietime_done = false

    -- create some zombies
    self:createZombie(20)
    self:createZombie(0)
    self:createZombie(-20)
end

function MainState:stop()
end

function MainState:keypressed(k)
    if k == "escape" then
        stack:push(pause)
    end

    hit = false
    for key,item in ipairs(self.items) do
        if item:typeLetter(k) then hit = true end
    end

    if not hit then settings:inc("missed") end
    settings:inc("pressed")
end
