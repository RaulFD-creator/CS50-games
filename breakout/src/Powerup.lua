Powerup = Class{}

function Powerup:init()
    self.width = 16
    self.height = 16
    self.dy = 20
    self.dx = 0
    self.skin = 8
    self.x = math.random(VIRTUAL_WIDTH - 16)
    self.y = math.random(100,130)
    self.inPlay = false
end

function Powerup:update(dt)
    if self.inPlay then
        self.y = self.y + self.dy * dt
        self:render()
        
        if self.y > VIRTUAL_HEIGHT then
            self:reset()
        end
    end
end

function Powerup:render()
    if self.inPlay then 
        love.graphics.draw(gTextures['main'], gFrames['powerups'][self.skin],
        self.x, self.y)
    end
end

function Powerup:reset()
    self.inPlay = false
    self.x = math.random(VIRTUAL_WIDTH)
    self.y = math.random(100,130)
end

function Powerup:collides(target)
    if self.inPlay then 
        if self.x > target.x + target.width or target.x > self.x + self.width then
            return false
        end
        if self.y > target.y + target.height or target.y > self.y + self.height then
            return false
        end 
        return true
    end
end