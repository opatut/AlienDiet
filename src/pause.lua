-- pause state

require("gamestate")
require("resources")
require("genericmenu")

Pause = class("Pause", GameState)

function Pause:__init()
    self.menu = GenericMenu({_("continue"), _("main_menu")}, function(n,w)
            if n == 1 then
                stack:pop()
            elseif n == 2 then
                stack:pop()
                stack:pop()
            end
        end)
end

function Pause:draw()
    main:draw()

    love.graphics.setColor(0, 0, 0, 200)
    love.graphics.rectangle("fill", 0, 0, 400, 600)

    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(resources.fonts.large)
    local s = _("game_paused")
    love.graphics.print(s, 200 - resources.fonts.large:getWidth(s) / 2, 140)

    self.menu:draw(200, 270)
end

function Pause:keypressed(k, s, r)
    self.menu:keypressed(k, s, r)
end
