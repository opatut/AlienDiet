-- language menu

require("gamestate")
require("resources")
require("genericmenu")

Language = class("Language", GameState)

function Language:__init()
    self.menu = GenericMenu({"English", "Deutsch", "", _("back")}, function(n, w)
            if n == 4 then
                stack:pop()
            end

            local l = {"en_US", "de_DE"}
            lang:setLanguage(l[n])
            settings:set("language", l[n])
            reset() -- already goes to main menu
            stack:push(menu)
        end)
end

function Language:draw()
    -- background
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(resources.images.background, 0, 0)

    love.graphics.setFont(resources.fonts.large)
    local s = _("language")
    love.graphics.print(s, 200 - resources.fonts.large:getWidth(s) / 2, 160)

    self.menu:draw(200, 270)
end

function Language:keypressed(k, s, r)
    self.menu:keypressed(k, s, r)
end
