-- about

require("gamestate")
require("resources")

About = class("About", GameState)

function About:__init()
    self.menu = GenericMenu({"Back"}, function(n,w) stack:pop() end)
end

function About:draw()
    -- background
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(resources.images.background, 0, 0)

    local i = resources.images.logo
    love.graphics.setColor(255, 255, 255, 128)
    love.graphics.draw(i, 200 - i:getWidth() / 2, 200 - i:getWidth() / 2)

    self.menu:draw(200, 550)
end

function About:keypressed(k)
    self.menu:keypressed(k)
end
