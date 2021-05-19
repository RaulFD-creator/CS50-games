PlayState = Class{__includes = BaseState}

function PlayState:enter(params)

end

function PlayState:init()
    gSounds['musics']['title_screen']:stop()
    gSounds['musics']['play']:play()
    self.backgroundX = 0
    self.camX = 0
    self.camY = 0
end

function PlayState:update(dt) 
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        self.camX = self.camX + 10
    elseif love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        self.camX = self.camX - 10
    end
    self.backgroundX = (self.camX / 3) % 1341
end

function PlayState:render()
    love.graphics.push()
    love.graphics.draw(gTextures['backgrounds']['2'], gFrames['background'][1], math.floor(-self.backgroundX), 0)
    love.graphics.draw(gTextures['backgrounds']['2'], gFrames['background'][1], math.floor(-self.backgroundX),
        gTextures['backgrounds']['2']:getHeight(), 0, 1, 1)
    love.graphics.draw(gTextures['backgrounds']['2'], gFrames['background'][1], math.floor(-self.backgroundX + 1336), 0)
    love.graphics.draw(gTextures['backgrounds']['2'], gFrames['background'][1], math.floor(-self.backgroundX + 1336),
        gTextures['backgrounds']['2']:getHeight(), 0, 1, 1)
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    love.graphics.pop()
end