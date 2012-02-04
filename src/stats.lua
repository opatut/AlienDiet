-- stats

require("gamestate")
require("resources")
require("genericmenu")

Stats = class("Stats", GameState)

function Stats:__init()
    self.menu = GenericMenu({"Reset", "Back"}, function(n,w)
            if w == "Reset" then
                settings:set("pressed", 0)
                settings:set("missed", 0)
                settings:set("minutes", 0)
                settings:set("completed", 0)
                settings:set("played", 0)
                settings:set("pies", 0)
                settings:set("maxtime", 0)
                settings:save()
            else
                stack:pop()
            end
        end)
end

function Stats:draw()
    -- background
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(resources.images.background, 0, 0)

    local l = {}
    table.insert(l, {settings:get("pressed", 0), "Keys pressed"})
    table.insert(l, {settings:get("missed", 0), "Keys missed"})
    table.insert(l, {string.format("%.1f", settings:get("minutes", 0)), "Minutes played"})
    table.insert(l, {settings:get("completed", 0), "Food items preserved"})
    table.insert(l, {settings:get("played", 0), "Times played"})
    table.insert(l, {string.format("%.1f", settings:get("maxtime", 0)), "seconds record"})
    table.insert(l, {"", ""})
    table.insert(l, {settings:get("pies", 0), "Pies eaten"})

    local b = 10
    local z = 100
    love.graphics.setFont(resources.fonts.small)
    for n,x in pairs(l) do
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.print(x[1], z - resources.fonts.small:getWidth(x[1]) - b / 2, 130 + 30 * (n-1))

        love.graphics.setColor(255, 255, 255, 128)
        love.graphics.print(x[2], z + b / 2, 130 + 30 * (n-1))
    end

    self.menu:draw(200, 510)
end

function Stats:keypressed(k, u)
    self.menu:keypressed(k, u)
end
