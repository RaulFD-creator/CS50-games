--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Projectile = Class{}

function Projectile:init(def, x, y)
        
    -- string identifying this object type
    self.type = def.type
    
    self.texture = def.texture
    self.frame = def.frame or 1
    
    -- whether it acts as an obstacle or not
    self.solid = def.solid
    
    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states
    
    -- dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height
    self.thrown = false
    self.room = def.room
    
    -- default empty collision callback
    self.onCollide = def.onCollide or function() end
    self.follow = def.follow or function() end
    self.counter = 0 
    self.counter2 = 0
end
    
function Projectile:update(dt)

    self.counter2 = self.counter2 + dt

    if not self.thrown  then
        self.x = self.room.player.x 
        self.y = self.room.player.y - 12
    elseif self.direction_thrown == 'right' and self.counter < 4 *TILE_SIZE + 1 then
        self.x = self.x + 1
        self.counter = self.counter + 1
    elseif self.direction_thrown == 'left' and self.counter < 4 *TILE_SIZE + 1 then
        self.x = self.x - 1
        self.counter = self.counter + 1
    elseif self.direction_thrown == 'up' and self.counter < 4 *TILE_SIZE + 1 then
        self.y = self.y - 1
        self.counter = self.counter + 1
    elseif self.direction_thrown == 'down' and self.counter < 4 *TILE_SIZE + 1 then
        self.y = self.y + 1
        self.counter = self.counter + 1 
    end

    
    if love.keyboard.isDown('return') and self.counter2 > 2 then
        self:throw(self.room.player.direction)   
    end
end

function Projectile:throw(direction)
    self.thrown = true
    self.direction_thrown = direction
    self.carrying = false
    self.room.player:changeState('idle')
end

function Projectile:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY)
end
