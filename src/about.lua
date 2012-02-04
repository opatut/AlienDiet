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

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(resources.fonts.small)
    l = {}
    table.insert(l, "Created for LOVELY CONTEST #1")
    table.insert(l, "http://reddit.com/r/love2d")
    table.insert(l, "")
    table.insert(l, "Design, Programming, Graphics")
    table.insert(l, "Paul 'opatut' Bienkowski")
    table.insert(l, "")
    table.insert(l, "Music - hamsteralliance.com")
    table.insert(l, "Discovery Murdertaxi WorkItOut")
    table.insert(l, "")
    table.insert(l, "Special Thanks")
    table.insert(l, "zetaron | Lauren Faust")

    local y1 = 400 - i:getWidth() + i:getHeight()
    for n,v in pairs(l) do
        if n == 1 or n == 4 or n == 7 or n == 10 then
            love.graphics.setColor(255, 255, 255, 255)
        else
            love.graphics.setColor(255, 255, 255, 128)
        end
        love.graphics.printf(v, 20, y1 + (n-1)*20, 360, "center")
    end

    self.menu:draw(200, 550)
end

function About:keypressed(k, u)
    self.menu:keypressed(k, u)
end
