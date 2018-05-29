-- menu

require("gamestate")
require("resources")
require("genericmenu")

MainMenu = class("MainMenu", GameState)

function MainMenu:__init()
    self.info = 0
    self.menu = GenericMenu({_("play"), _("language"), _("stats"), _("about"), _("quit")}, function(n,w)
            if n == 1 then
                stack:push(difficulty)
            elseif n == 2 then
                stack:push(language)
            elseif n == 3 then
                stack:push(stats)
            elseif n == 4 then
                stack:push(about)
            elseif n == 5 then
                love.event.push("quit")
            end
        end)
end

function MainMenu:draw()
    -- background
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(resources.images.background, 0, 0)

    local l = {}
    table.insert(l, {_("your_task"), _("task")})
    table.insert(l, {_("your_tools"),_("tools")})
    table.insert(l, {_("your_goal"), _("goal")})

    for n,x in pairs(l) do
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(resources.fonts.small)
        love.graphics.print(x[1], 200 - resources.fonts.small:getWidth(x[1]) / 2, 30 + 50 * (n-1))

        love.graphics.setColor(1, 1, 1, 0.5)
        love.graphics.setFont(resources.fonts.tiny)
        love.graphics.print(x[2], 200 - resources.fonts.tiny:getWidth(x[2]) / 2, 50 + 50 * (n-1))
    end

    self.menu:draw(200, 250)

    local i = resources.images.keyboard
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(i, 200 - i:getWidth() / 2, 550 - i:getHeight() / 2)
    love.graphics.setFont(resources.fonts.tiny)

    local s = _("keyboard_hints")
    love.graphics.print(s[self.info], 200 - resources.fonts.tiny:getWidth(s[self.info]) / 2, 570)
end

function MainMenu:keypressed(k, s, r)
    self.menu:keypressed(k, s, r)
end

function MainMenu:start()
    self.info = math.random(1, #_("keyboard_hints"))

    local s = resources.music.normal
    if love.audio.getSourceCount() == 0 then
        s:setLooping(true)
        s:play()
    end
end
