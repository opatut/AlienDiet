require("helper")
require("word")

Item = class("Item")

function Item:__init(image, word, speed)
    self.speed = speed
    self.fadeTime = 1
    self.word = Word(word, "small")
    self.image = image
    self.img = resources.images[self.image]
    local w = self.img:getWidth()
    self.x = math.random(w / 2, 400 - w / 2)
    self.y = -self.img:getHeight() / 2
end

function Item:keypressed(k, u)
    return self.word:keypressed(k, u)
end

function Item:draw()
    local font = resources.fonts["small"]
    local h = self.img:getHeight()
    local w = self.img:getWidth()
    local alpha = self.fadeTime * 255

    if self.y < 530 then
        love.graphics.setColor(255, 255, 255, alpha)
        love.graphics.draw(self.img, self.x - w / 2, self.y - h / 2)
    end

    -- keep the text inside the window
    local ww = self.word:getWidth()
    local tx = self.x
    if tx < ww / 2 then tx = ww / 2 end
    if tx > 400 - ww / 2 then tx = 400 - ww / 2 end

    -- draw the text
    self.word:draw(tx, self.y - h / 2 - 15, alpha)
end

function Item:update(dt)
    self.y = self.y + dt * self.speed

    if self.word.wordRest == "" then
        self.fadeTime = self.fadeTime - dt * 2
    end
end

function Item:alive()
    return (not self.word.wordRest == "") or self.fadeTime > 0
end
