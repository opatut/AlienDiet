require("helper")
require("resources")

Zombie = class("Zombie")

function Zombie:__init(x, shift)
    self.x = x
    self.shift = shift
    self.dx = 0
    self.img = resources.images.alien

    w = self.img:getWidth()
    h = self.img:getHeight()
    self.frames = {}
    self.frames[1] = love.graphics.newQuad( 0,  0, 24, 22, w, h)
    self.frames[4] = love.graphics.newQuad( 0, 22, 24, 22, w, h)
    self.frames[3] = love.graphics.newQuad(24,  0, 24, 22, w, h)
    self.frames[2] = love.graphics.newQuad(24, 22, 24, 22, w, h)
    self.shoe = love.graphics.newQuad(0, 44, 9, 4, w, h)

    self.totalTime = 0
    self.time = 0
    self.target_x = 0
    self.targetTime = 0
    self.speed = 0
    self.speedTime = 0
    self.animationTime = math.random(20, 200) * 0.1
end

function Zombie:update(items, dt)
    old_x = self.x
    my_x = self.x + self.shift
    self.totalTime = self.totalTime + dt * self.speed * 0.3

    self.targetTime = self.targetTime - dt
    if self.targetTime < 0 then
        self.targetTime = math.random(150, 350) * 0.01
        self.target_x = math.random(12, 388)
    end

    self.speedTime = self.speedTime - dt
    if self.speedTime < 0 then
        self.speedTime = math.random(200, 1000) * 0.01
        self.speed = math.random(200, 1000) * 0.1
    end

    self.animationTime = self.animationTime - dt
    if self.animationTime < 0 then
        self:playAnimation()
        self.animationTime = math.random(20, 200) * 0.1
    end

    -- get closest x item
    closest = nil
    for k,i in pairs(items) do
        if closest == nil or math.abs(closest.x - my_x) > math.abs(i.x - my_x) then
            if i.y > 300 then
                closest = i
            end
        end
    end

    if closest then
        self.target_x = closest.x
    end

    if self.target_x > my_x then
        self.x = self.x + math.min(self.target_x - my_x, self.speed * dt)
    else
        self.x = self.x - math.min(my_x - self.target_x, self.speed * dt)
    end

    self.time = self.time - dt
    if self.time < 0 then self.time = 0 end

    if self.x < 12 then self.x = 12 end
    if self.x > 388 then self.x = 388 end

    self.dx = self.x - old_x
end

function Zombie:playAnimation()
    self.time = 1.2
end

function Zombie:draw()
    local y = 528 - 2
    local x = self.x - 12
    local sx = 1
    if self.dx > 0 then sx = -1 end
    local sy = 1

    love.graphics.setColor(1, 1, 1, 1)

    local q = self.frames[ 1 + math.floor(self.time * 3) ]
    love.graphics.draw(self.img, q, x, y, 0, sx, sy)

    ys = 550 - 4
    if not dx == 0 then ys = ys - 2 end
    t = self.totalTime
    if self.dx < 0 then t = -t end
    if self.dx == 0 then t = 0 end
    love.graphics.draw(self.img, self.shoe, self.x - 11 + math.cos(t), ys + math.sin(t), 0, sx, sy)
    love.graphics.draw(self.img, self.shoe, self.x + 2 - math.cos(t), ys - math.sin(t), 0, sx, sy)
end
