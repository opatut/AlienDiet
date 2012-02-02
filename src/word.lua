require("helper")

Word = class("Word")

function Word:__init(word, font, x, y, autoreset)
    self.font = resources.fonts[font]
    self.word = word
    self.wordRest = word
    self.wordBegin = ""
    self.x = x or 0
    self.y = y or 0
    self.autoreset = autoreset
    self.callback = function() end
end

function Word:getWidthLeft()
    return self.font:getWidth(self.wordBegin)
end

function Word:getWidthRight()
    return self.font:getWidth(self.wordRest)
end

function Word:getWidth()
    return self:getWidthLeft() + self:getWidthRight()
end

function Word:typeLetter(letter)
    if not self.wordRest or self.wordRest == "" then
        return
    end

    if letter:lower() == self.wordRest:sub(1,1):lower() then
        self.wordBegin = self.wordBegin .. self.wordRest:sub(1,1)
        self.wordRest = self.wordRest:sub(2)

        if #self.wordRest == 0 and self.callback then
            self.callback()
            if self.autoreset then
                self:reset()
            end
        end
        return true
    end
    return false
end

function Word:draw(x, y)
    local y = self.y + (y or 0) - self.font:getHeight() / 2
    local x = self.x + (x or 0) - self:getWidth() / 2

    love.graphics.setFont(self.font)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print(self.wordBegin, x , y)
    love.graphics.setColor(255, 255, 255, 128)
    love.graphics.print(self.wordRest, x + self:getWidthLeft(), y)
end

function Word:reset()
    self.wordRest = self.word
    self.wordBegin = ""
end