PauseState = Class{__includes = BaseState}

function PauseState:enter(params)
    self.score = params.score
    sounds['music']:pause()
    sounds['pause']:play()
end

function PauseState:update(dt)
    if love.keyboard.wasPressed('p') then
        sounds['music']:play()
        sounds['pause']:play()
        gStateMachine:change('play', {
            score = self.score
        })
    end
end

function PauseState:render()
    love.graphics.setFont(hugeFont)
    love.graphics.printf("PAUSE", 0, 50, VIRTUAL_WIDTH, 'center')
end