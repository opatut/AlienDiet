-- gamestack

require("helper")

GameStack = class("GameStack")

function GameStack:__init()
    self.states = {}
end

function GameStack:current()
    if #self.states > 0 then
        return self.states[#self.states]
    else
        return nil
    end
end

function GameStack:push(state)
    if self:current() then self:current():stop() end
    table.insert(self.states, state)
    self:current():start()
end

function GameStack:pop()
    if not self:current() then return end
    self:current():stop()
    table.remove(self.states, #self.states)
    if self:current() then self:current():start() end
end

function GameStack:update(dt)
    if self:current() then self:current():update(dt) end
end

function GameStack:draw()
    if self:current() then self:current():draw() end
end

function GameStack:keypressed(k, s, r)
    if self:current() then self:current():keypressed(k, s, r) end
end
