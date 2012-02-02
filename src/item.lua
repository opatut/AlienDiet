require("helper")
require("word")

Item = class("Item")

function Item:__init(image, word)
    self.word = Word(word, "small")
    self.image = image
    self.img = resources.images[self.image]
    local w = self.img:getWidth()
    self.x = math.random(w / 2, 400 - w / 2)
    self.y = -self.img:getHeight() / 2
end

function Item:typeLetter(letter)
    self.word:typeLetter(letter)
end

function Item:draw()
    local font = resources.fonts["small"]
    local h = self.img:getHeight()
    local w = self.img:getWidth()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(self.img, self.x - w / 2, self.y - h / 2)

    -- keep the text inside the window
    local ww = self.word:getWidth()
    local tx = self.x
    if tx < ww / 2 then tx = ww / 2 end
    if tx > 400 - ww / 2 then tx = 400 - ww / 2 end

    -- draw the text
    self.word:draw(tx, self.y - h / 2 - 15)
end

function Item:update(dt)
    self.y = self.y + dt * 30
end
