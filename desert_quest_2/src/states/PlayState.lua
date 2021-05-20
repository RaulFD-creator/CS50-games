PlayState = Class{__includes = BaseStart}

function PlayState:enter(params)

end

function PlayState:init()
    -- Play background music
    gSounds['musics']['title_screen']:stop()
    gSounds['musics']['play']:play()

    -- Initialise camera
    self.backgroundX = 0
    self.camX = 0
    self.camY = 0
end

function PlayState:update(dt)

    -- Debugging order
    if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        self.camX = self.camX + 10
    elseif love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        self.camX = self.camX - 10
    end

    -- Prevent background from looking bad
    self.backgroundX = (self.camX / 3) % 1341
end
