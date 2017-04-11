-- intro

require("gamestate")
require("resources")

Intro = class("Intro", GameState)

function Intro:update(dt)
    self.time = self.time + dt

    if self.time >= 3 then
        stack:push(menu)
    end
end

function Intro:draw()
    local c = 0
    if self.time < 0 then
        c = 0
    elseif self.time < 1 then
        c = self.time * 255
    elseif self.time < 2 then
        c = 255
    elseif self.time < 3 then
        c = (3 - self.time) * 255
    else
        c = 0
    end

    love.graphics.setBackgroundColor(17, 17, 17)
    love.graphics.setColor(255, 255, 255, c)

    local i = resources.images.logo
    love.graphics.draw(i, 200 - i:getWidth() / 2, 300 - i:getHeight() / 2)
end

function Intro:start()
    self.time = -1
end

function Intro:keypressed(k, s, r)
    stack:push(menu)
end
