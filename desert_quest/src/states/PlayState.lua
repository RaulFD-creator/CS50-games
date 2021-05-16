PlayState = Class{__includes = BaseState}

function PlayState:enter(params)

end

function PlayState:init()
    gSounds['musics']['title_screen']:stop()
    gSounds['musics']['play']:setLooping(true)
    gSounds['musics']['play']:play()
end

function PlayState:update(dt) 
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    love.graphics.draw(gTextures['backgrounds']['2'], 0, 0, 0, 
        VIRTUAL_WIDTH / gTextures['backgrounds']['2']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['backgrounds']['2']:getHeight())
end