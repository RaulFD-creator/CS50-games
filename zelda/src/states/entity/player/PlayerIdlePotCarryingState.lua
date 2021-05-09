PlayerIdlePotCarryingState = Class{__includes = BaseState}

function PlayerIdlePotCarryingState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon
end

function PlayerIdlePotCarryingState:enter(params)
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.player.offsetY = 5
    self.player.offsetX = 0
end

function PlayerIdlePotCarryingState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.player:changeState('carry-pot')
    end

    if love.keyboard.wasPressed('return') then
        --self.entity:changeState('swing-sword')
        gSounds['pickup']:play()
    end
end