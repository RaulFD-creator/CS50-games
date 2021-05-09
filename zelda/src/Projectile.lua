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
    self.remove = false
    self.crashed = false
    
    -- default empty collision callback
    self.onCollide = def.onCollide or function() end
    self.follow = def.follow or function() end
    self.counter = 0 
    self.counter2 = 0
    self.counter3 = 0
    self.thrown_speed = 2
end
    
function Projectile:update(dt)

    self.counter2 = self.counter2 + dt

    -- Crash after 4 tiles
    if not self.thrown then
        self.x = self.room.player.x 
        self.y = self.room.player.y - 12
    elseif self.direction_thrown == 'right' and self.counter < 4 *TILE_SIZE + 1 and not self.crashed then
        self.x = self.x + self.thrown_speed
        self.counter = self.counter + self.thrown_speed
    elseif self.direction_thrown == 'left' and self.counter < 4 *TILE_SIZE + 1 and not self.crashed then
        self.x = self.x - self.thrown_speed
        self.counter = self.counter + self.thrown_speed
    elseif self.direction_thrown == 'up' and self.counter < 4 *TILE_SIZE + 1 and not self.crashed then
        self.y = self.y - self.thrown_speed
        self.counter = self.counter + self.thrown_speed
    elseif self.direction_thrown == 'down' and self.counter < 4 *TILE_SIZE + 1 and not self.crashed then
        self.y = self.y + self.thrown_speed
        self.counter = self.counter + self.thrown_speed
    else
        self.crashed = true
    end

    -- boundary checking on all sides, allowing us to avoid collision detection on tiles
        
    if self.x <= MAP_RENDER_OFFSET_X + TILE_SIZE then 
        self.crashed = true
    end
    if self.x + self.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 then
        self.crashed = true
    end
    if self.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - self.height / 2 then 
        self.crashed = true
    end
    local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
        + MAP_RENDER_OFFSET_Y - TILE_SIZE

    if self.y + self.height >= bottomEdge then
        self.crashed = true
    end

    if self.crashed and self.thrown then
        self.counter3 = self.counter3 + dt
        self.state = 'shattered'
        if self.counter3 > 1.5 then
            self.remove = true
        end
    end

    if self.thrown and not self.crashed then
        hitboxWidth = 11
        hitboxHeight = 11
        if self.direction_thrown == 'left' then
            hitboxX = self.x - hitboxWidth
            hitboxY = self.y + 2
        elseif self.direction_thrown == 'right' then
            hitboxX = self.x + self.width
            hitboxY = self.y + 2
        elseif self.direction_thrown == 'up' then
            hitboxX = self.x
            hitboxY = self.y - hitboxHeight
        else
            hitboxX = self.x
            hitboxY = self.y + self.height
        end

        self.potHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)

        for k, entity in pairs(self.room.entities) do
            if entity:collides(self.potHitbox) then
                entity:damage(1)
                gSounds['hit-enemy']:play()
            end
        end    
    end

    if love.keyboard.isDown('return') and self.counter2 > 1 then
        self:throw(self.room.player.direction)   
    end
end

function Projectile:throw(direction)
    self.thrown = true
    self.room.player.carrying = false
    self.direction_thrown = direction
    self.room.player:changeState('idle')
    gSounds['sword']:play()
end

function Projectile:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY)
end
