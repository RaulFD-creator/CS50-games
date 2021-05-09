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

    self.room = def.room
    
    -- default empty collision callback
    self.onCollide = def.onCollide or function() end
    self.follow = def.follow or function() end
end
    
function Projectile:update(dt)
    
    self.x = self.room.player.x 
    self.y = self.room.player.y - 12
    
end
    
function Projectile:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY)
end
