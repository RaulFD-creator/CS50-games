StartState = Class{__includes = BaseState}

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end