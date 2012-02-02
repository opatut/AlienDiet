-- genericmenu

require("helper")
require("word")

GenericMenu = class("GenericMenu")

function GenericMenu:__init(list, callback)
    self.words = {}
    self.callback = callback
    for i=1,#list do
        table.insert(self.words, Word(list[i], "large", 0, 40 * (i-1), true))
        self.words[i].callback = function() self:complete(i) end
    end
end

function GenericMenu:complete(n)
    for k,w in pairs(self.words) do
        w:reset()
    end

    if self.callback then self.callback(n, self.words[n].word) end
end

function GenericMenu:draw(x, y)
    for k,w in pairs(self.words) do
        w:draw(x, y)
    end
end

function GenericMenu:keypressed(k)
    for key,w in pairs(self.words) do
        w:typeLetter(k)
    end
end
