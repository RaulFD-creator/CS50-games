StartState = Class{__includes = BaseState}

function StartState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {
            score = 0,
            width = 100
        })
    end
end

function StartState:render()
    love.graphics.draw(gTextures['backgrounds']['1'], 0, 0, 0, 
        VIRTUAL_WIDTH / gTextures['backgrounds']['1']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['backgrounds']['1']:getHeight())

    love.graphics.setFont(gFonts['huge'])
    love.graphics.setColor(34/255, 34/255, 34/255, 1)
    love.graphics.printf('Desert Quest', 2, VIRTUAL_HEIGHT / 2 - 46, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setColor(175/255, 53/255, 42/255, 1)
    love.graphics.printf('Desert Quest', 0, VIRTUAL_HEIGHT / 2 - 48, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(gFonts['large'])
    love.graphics.setColor(34/255, 34/255, 34/255, 1)
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 30, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 32, VIRTUAL_WIDTH, 'center')
end