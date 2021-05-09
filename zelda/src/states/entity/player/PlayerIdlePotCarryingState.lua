PlayerIdlePotCarryingState = Class{__includes = EntityIdleState}

function PlayerIdlePotCarryingState:enter(params)
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerIdlePotCarryingState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('carry-pot')
    end

    if love.keyboard.wasPressed('return') then
        --self.entity:changeState('swing-sword')
        gSounds['pickup']:play()
    end
end