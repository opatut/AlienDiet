-- difficulty menu

require("gamestate")
require("resources")
require("genericmenu")

Difficulty = class("Difficulty", GameState)

function Difficulty:__init()
    self.menu = GenericMenu({_("normal"), _("hacker"), _("insane"), "", _("back")}, function(n,w)
            if n <= 3 then
                main.difficulty = n
                stack:pop() -- remove difficulty selector so you jump back into main menu
                main:reset() -- only reset when a new game is requested
                stack:push(main)
            elseif n == 5 then
                stack:pop()
            end
        end)
end

function Difficulty:draw()
    -- background
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(resources.images.background, 0, 0)

    love.graphics.setFont(resources.fonts.large)
    local s = _("level_of")
    love.graphics.print(s, 200 - resources.fonts.large:getWidth(s) / 2, 140)
    s = _("badassery")
    love.graphics.print(s, 200 - resources.fonts.large:getWidth(s) / 2, 170)

    self.menu:draw(200, 270)
end

function Difficulty:keypressed(k, s, r)
    self.menu:keypressed(k, s, r)
end
