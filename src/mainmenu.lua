-- menu

require("gamestate")
require("resources")
require("genericmenu")

MainMenu = class("MainMenu", GameState)

function MainMenu:__init()
    self.info = 0
    self.menu = GenericMenu({"Play", "Stats", "About", "Quit"}, function(n,w)
            if w == "Play" then
                stack:push(difficulty)
            elseif w == "Stats" then
                stack:push(stats)
            elseif w == "About" then
                stack:push(about)
            elseif w == "Quit" then
                love.event.push("q")
            end
        end)
end

function MainMenu:draw()
    -- background
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(resources.images.background, 0, 0)

    local l = {}
    table.insert(l, {"Your task", "Help the aliens keep up their diet"})
    table.insert(l, {"Your tools","Powerful spells and common English words"})
    table.insert(l, {"Your goal", "The cake is a lie, but we got Pie!"})

    for n,x in pairs(l) do
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.setFont(resources.fonts.small)
        love.graphics.print(x[1], 200 - resources.fonts.small:getWidth(x[1]) / 2, 30 + 50 * (n-1))

        love.graphics.setColor(255, 255, 255, 128)
        love.graphics.setFont(resources.fonts.tiny)
        love.graphics.print(x[2], 200 - resources.fonts.tiny:getWidth(x[2]) / 2, 50 + 50 * (n-1))
    end

    self.menu:draw(200, 250)

    local i = resources.images.keyboard
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(i, 200 - i:getWidth() / 2, 550 - i:getHeight() / 2)
    love.graphics.setFont(resources.fonts.tiny)
    local s = {"Minimalist.", "Who needs a mouse here?", "Y U NO KEYBOARD?", "I like this *TYPE* of game!", "It's all under your fingertips..."}
    love.graphics.print(s[self.info], 200 - resources.fonts.tiny:getWidth(s[self.info]) / 2, 570)
end

function MainMenu:keypressed(k, u)
    self.menu:keypressed(k, u)
end

function MainMenu:start()
    self.info = math.random(1,5)

    local s = resources.music.normal
    if love.audio.getNumSources() == 0 then
        s:setLooping(true)
        s:play()
    end
end
