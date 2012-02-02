-- menu

require("gamestate")
require("resources")
require("genericmenu")

MainMenu = class("MainMenu", GameState)

function MainMenu:__init()
    self.menu = GenericMenu({"Play", "Stats", "About", "Quit"}, function(n,w)
            if w == "Play" then
                stack:push(main)
            elseif w == "Quit" then
                love.event.push("q")
            end
        end)
end

function MainMenu:update(dt)
end

function MainMenu:draw()
    local l = {}
    table.insert(l, {"Your task", "Don't feed the aliens"})
    table.insert(l, {"Your tool","The magic of words"})
    table.insert(l, {"Your goal", "The cake is a lie, but we got Pie!"})

    for n,x in pairs(l) do
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.setFont(resources.fonts.large)
        love.graphics.print(x[1], 200 - resources.fonts.large:getWidth(x[1]) / 2, 50 + 70 * (n-1))

        love.graphics.setColor(255, 255, 255, 128)
        love.graphics.setFont(resources.fonts.small)
        love.graphics.print(x[2], 200 - resources.fonts.small:getWidth(x[2]) / 2, 90 + 70 * (n-1))
    end



    self.menu:draw(200, 350)
end

function MainMenu:start()
    love.graphics.setBackgroundColor(100, 100, 100)
end

function MainMenu:stop()
end

function MainMenu:keypressed(k)
    self.menu:keypressed(k)
end
