-- difficulty menu

require("gamestate")
require("resources")
require("genericmenu")

Difficulty = class("Difficulty", GameState)

function Difficulty:__init()
    self.menu = GenericMenu({"Normal", "Hacker", "Insane", "", "Back"}, function(n,w)
            if n <= 3 then
                main.difficulty = n
                stack:pop() -- remove difficulty selector so you jump back into main menu
                main:reset() -- only reset when a new game is requested
                stack:push(main)
            elseif w == "Back" then
                stack:pop()
            end
        end)
end

function Difficulty:draw()
    -- background
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(resources.images.background, 0, 0)

    love.graphics.setFont(resources.fonts.large)
    local s = "Level of"
    love.graphics.print(s, 200 - resources.fonts.large:getWidth(s) / 2, 140)
    s = "badassery"
    love.graphics.print(s, 200 - resources.fonts.large:getWidth(s) / 2, 170)

    self.menu:draw(200, 270)
end

function Difficulty:keypressed(k, u)
    self.menu:keypressed(k, u)
end
