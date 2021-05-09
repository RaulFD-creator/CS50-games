PlayerIdlePotCarryingState = Class{__includes = BaseState}

function PlayerIdlePotCarryingState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon
    self.player:changeAnimation('lift-' .. self.player.direction)
end

function PlayerIdlePotCarryingState:enter(params)
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.player.offsetY = 5
    self.player.offsetX = 0
    self.player.currentAnimation:refresh()
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

    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0
        self.player:changeState('carry-pot-idle')
    end
end

function PlayerIdlePotCarryingState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
end