require("helper")

Item = class("Item")

function Item:__init(image, word)
    self.image = image
    self.word = word
    self.wordRest = word
    self.wordBegin = ""
    local i = resources.images[self.image]
    local w = i:getWidth()
    self.x = math.random(w / 2, 400 - w / 2)
    self.y = -i:getHeight() / 2
end

function Item:typeLetter(letter)
    if #self.wordRest == 0 then
        return
    end

    if letter:lower() == self.wordRest:sub(1,1):lower() then
        self.wordRest = self.wordRest:sub(2)
        self.wordBegin = self.wordBegin .. letter
        return true
    end
    return false
end

function Item:draw()
    local i = resources.images[self.image]
    local font = resources.fonts["small"]
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(i, self.x - i:getWidth() / 2, self.y - i:getHeight() / 2)

    local w1 = font:getWidth(self.wordBegin)
    local w2 = font:getWidth(self.wordRest)

    -- keep the text inside the window
    local tx = self.x - (w1 + w2) / 2
    if tx < 0 then tx = 0 end
    if tx + w1 + w2 > 400 then tx = 400 - w1 - w2 end

    love.graphics.setFont(font)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print(self.wordBegin, tx , self.y - i:getHeight() / 2 - 20)
    love.graphics.setColor(255, 255, 255, 128)
    love.graphics.print(self.wordRest, tx + w1, self.y - i:getHeight() / 2 - 20)
end

function Item:update(dt)
    self.y = self.y + dt * 30
end
