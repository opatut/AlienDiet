-- resources

require("helper")

Resources = class("Resources")

function Resources:__init(prefix)
    self.prefix = prefix
    self.imageQueue = {}
    self.fontQueue = {}

    self.images = {}
    self.fonts = {}
end

function Resources:addFont(name, src, size)
    self.fontQueue[name] = {src, size}
end

function Resources:addImage(name, src)
    self.imageQueue[name] = src
end

function Resources:load(threaded)
    for name, pair in pairs(self.fontQueue) do
        self.fonts[name] = love.graphics.newFont(self.prefix .. pair[1], pair[2])
        self.fontQueue[name] = nil
    end

    for name, src in pairs(self.imageQueue) do
        self.images[name] = love.graphics.newImage(self.prefix .. src)
        self.imageQueue[name] = nil
    end
end