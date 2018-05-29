-- about

require("gamestate")
require("resources")

About = class("About", GameState)

function About:__init()
    self.menu = GenericMenu({_("back")}, function(n,w) stack:pop() end)
end

function About:draw()
    -- background
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(resources.images.background, 0, 0)

    local i = resources.images.logo
    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.draw(i, 200 - i:getWidth() / 2, 200 - i:getWidth() / 2)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(resources.fonts.small)
    l = {}
    table.insert(l, _("created_for"))
    table.insert(l, "http://reddit.com/r/love2d")
    table.insert(l, "")
    table.insert(l, _("programming"))
    table.insert(l, "Paul 'opatut' Bienkowski")
    table.insert(l, "")
    table.insert(l, _("music") .. " - hamsteralliance.com")
    table.insert(l, "Discovery Murdertaxi WorkItOut")
    table.insert(l, "")
    table.insert(l, _("special_thanks"))
    table.insert(l, "zetaron | Lauren Faust")

    local y1 = 400 - i:getWidth() + i:getHeight()
    for n,v in pairs(l) do
        local alpha = (n == 1 or n == 4 or n == 7 or n == 10) and 1 or 0.5
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.printf(v, 20, y1 + (n-1)*20, 360, "center")
    end

    self.menu:draw(200, 550)
end

function About:keypressed(k, s, r)
    self.menu:keypressed(k, s, r)
end
