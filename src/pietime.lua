-- pietime state

require("gamestate")
require("resources")
require("genericmenu")

PieTime = class("PieTime", GameState)

function PieTime:__init()
    self.time = math.random(0, 100) * 0.1
    self.menu = GenericMenu({_("continue"), _("thanks_bye")}, function(n,w)
            stack:pop()
            if n == 2 then
                stack:pop()
            end
        end)
end

function PieTime:update(dt)
    self.time = self.time + dt * math.random(80,120) * 0.01
end

function PieTime:start()
    resources.music.fanfare:stop()
    resources.music.fanfare:play()
end

function PieTime:draw()
    -- background
    t = self.time
    local r,g,b = hsl2rgb( (t - math.floor(t)) * 255, 100, 100)
    love.graphics.setColor(r,g,b)
    love.graphics.draw(resources.images.background, 0, 0)

    love.graphics.setColor(255, 255, 255)
    local i = resources.images.pie
    love.graphics.draw(i, 200 - math.floor(i:getWidth() / 2), 230 - math.floor(i:getHeight() / 2))

    love.graphics.setFont(resources.fonts.large)
    local s = _("pie_time")
    love.graphics.print(s, 200 - resources.fonts.large:getWidth(s) / 2, 100)

    local l = _("pietime_text")
    love.graphics.setFont(resources.fonts.small)
    for n,s in pairs(l) do
        love.graphics.print(s, 200 - resources.fonts.small:getWidth(s) / 2, 320 + 20 * (n-1) )
    end

    self.menu:draw(200, 510)
end

function PieTime:keypressed(k, u)
    self.menu:keypressed(k, u)
end
