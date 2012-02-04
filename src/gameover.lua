-- gameover state

require("gamestate")
require("resources")
require("genericmenu")

GameOver = class("GameOver", GameState)

function GameOver:__init()
    self.menu = GenericMenu({"Try again", "Flee"}, function(n,w)
            stack:pop()
            if n == 1 then
                stack:push(difficulty)
            end
        end)
end

function GameOver:draw()
    -- background
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.draw(resources.images.background, 0, 0)

    love.graphics.setColor(255, 255, 255)
    local i = resources.images.game_over
    love.graphics.draw(i, 200 - math.floor(i:getWidth() / 2), 250 - math.floor(i:getHeight() / 2))


    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(resources.fonts.large)
    local s = "Game Over"
    love.graphics.print(s, 200 - resources.fonts.large:getWidth(s) / 2, 100)

    love.graphics.setFont(resources.fonts.small)
    local s = string.format("Time: %05.1f", main.time)
    love.graphics.print(s, 200 - resources.fonts.small:getWidth(s) / 2, 460)

    l = {}
    table.insert(l, "Oh noes, now mommy alien")
    table.insert(l, "is angry with you!")
    table.insert(l, "She doesn't want her")
    table.insert(l, "offspring to end up")
    table.insert(l, "obese like her...")

    love.graphics.setColor(255, 255, 255)
    for n,s in pairs(l) do
        love.graphics.print(s, 200 - resources.fonts.small:getWidth(s) / 2, 320 + 20 * (n-1) )
    end

    self.menu:draw(200, 510)
end

function GameOver:keypressed(k, u)
    self.menu:keypressed(k, u)
end
