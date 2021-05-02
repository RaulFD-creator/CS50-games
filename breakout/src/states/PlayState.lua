--[[
    GD50
    Breakout Remake

    -- PlayState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents the state of the game in which we are actively playing;
    player should control the paddle, with the ball actively bouncing between
    the bricks, walls, and the paddle. If the ball goes below the paddle, then
    the player should lose one point of health and be taken either to the Game
    Over screen if at 0 health or the Serve screen otherwise.
]]

PlayState = Class{__includes = BaseState}

--[[
    We initialize what's in our PlayState via a state table that we pass between
    states as we go from playing to serving.
]]
function PlayState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.highScores = params.highScores
    self.ball = params.ball
    self.level = params.level

    self.recoverPoints = 5000

    -- give ball random starting velocity
    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)

    -- Initialising multiball powerup
    self.manyballs = Powerup()
    self.manyballs:init() 
    self.manyballs.skin = 9
    
    multiball = false
    timer_manyballs = 0
    flag = false

    self.ball2 = Ball()
    self.ball3 = Ball()
    self.ball2:init()
    self.ball3:init()

    self.ball2.dx = math.random(-200, 200)
    self.ball2.dy = math.random(-50, -60)
    self.ball3.dx = math.random(-200, 200)
    self.ball3.dy = math.random(-50, -60)


    self.ball2.skin = self.ball.skin
    self.ball3.skin = self.ball.skin

    self.enlargment_points = 0

    balls = {
        ['1'] = self.ball,
        ['2'] = self.ball2,
        ['3'] = self.ball3
    }

    for k, ball in pairs(balls) do 
        ball.x = self.ball.x
        ball.y = self.ball.y 
    end

    balls['1'].inPlay = true


    -- Initialising brick key powerup
    self.key = Powerup()
    self.key:init()
    self.key.skin = 10

    self.timer_key = 0 
    self.key_flag = false
end

function PlayState:update(dt)

    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
            gSounds['pause']:play()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        gSounds['pause']:play()
        return
    end

    -- update positions based on velocity
    self.paddle:update(dt)

    for k, ball in pairs(balls) do 
        if ball.inPlay then
            ball:update(dt)
        end
    end
    timer_manyballs = timer_manyballs + dt

    if timer_manyballs > math.random(10,50) and self.manyballs.inPlay == false and multiball == false then
        self.manyballs.inPlay = true
        timer = 0
    end

    self.timer_key = self.timer_key + dt

    if self.timer_key > math.random(20,40) and self.manyballs.inPlay == false and self.key_flag == false then
        self.key.inPlay = true
        self.timer_key = 0
    end
    
    if self.key.inPlay then
        self.key:update(dt)
    end

    if self.manyballs.inPlay == true then
        self.manyballs:update(dt)
    end

    if self.manyballs:collides(self.paddle) then
        multiball = true
        self.manyballs:reset()
        flag = true
        for k, ball in pairs(balls) do
            if ball.inPlay then 
                for k, ball2 in pairs(balls) do 
                    if ball2 == ball then
                    else
                        ball2.x = ball.x
                        ball2.y = ball.y
                        ball2.dx = math.random(-200,200) 
                        ball2.dy = math.random(-50,-60)
                    end
                end
            end
            ball.inPlay = true
        end
    end

    if self.key:collides(self.paddle) then
        self.key_flag = true
        self.key:reset()
        for k, brick in pairs(self.bricks) do
            if brick.locked then
                brick:unlock()
            end
        end
    end

    for k, ball in pairs(balls) do
        if ball.inPlay then 
            if ball:collides(self.paddle) then
                -- raise ball above paddle in case it goes below it, then reverse dy
                ball.y = self.paddle.y - 8
                ball.dy = -ball.dy

                -- if we hit the paddle on its left side while moving left...
                if balls[k].x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
                    balls[k].dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - balls[k].x))
                    
                -- else if we hit the paddle on its right side while moving right...
                elseif balls[k].x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
                    balls[k].dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - balls[k].x))
                end

                gSounds['paddle-hit']:play()
            end
        end
    end

    -- detect collision across all bricks with the ball
    for k, brick in pairs(self.bricks) do
        for k, ball in pairs(balls) do
        -- only check collision if we're in play
        if brick.inPlay and ball:collides(brick) then
            if brick.locked then 
            elseif brick.unlocked then
                self.score = self.score + 500
                self.paddle.enlargment_points = self.paddle.enlargment_points + 500
                brick:hit()
            else
                -- add to score
                self.score = self.score + (brick.tier * 200 + brick.color * 25)
                self.paddle.enlargment_points = self.paddle.enlargment_points + (brick.tier * 200 + brick.color * 25)
                brick:hit()
            end

            -- if we have enough points, recover a point of health
            if self.score > self.recoverPoints then
                -- can't go above 3 health
                self.health = math.min(3, self.health + 1)

                -- multiply recover points by 2
                self.recoverPoints = self.recoverPoints + math.min(100000, self.recoverPoints * 2)

                -- play recover sound effect
                gSounds['recover']:play()
            end

            -- go to our victory screen if there are no more bricks left
            if self:checkVictory() then
                gSounds['victory']:play()

                gStateMachine:change('victory', {
                    level = self.level,
                    paddle = self.paddle,
                    health = self.health,
                    score = self.score,
                    highScores = self.highScores,
                    ball = self.ball,
                    recoverPoints = self.recoverPoints
                })
            end

            --
            -- collision code for bricks
            --
            -- we check to see if the opposite side of our velocity is outside of the brick;
            -- if it is, we trigger a collision on that side. else we're within the X + width of
            -- the brick and should check to see if the top or bottom edge is outside of the brick,
            -- colliding on the top or bottom accordingly 
            --

            -- left edge; only check if we're moving right, and offset the check by a couple of pixels
            -- so that flush corner hits register as Y flips, not X flips
            if ball.x + 2 < brick.x and ball.dx > 0 then
                
                -- flip x velocity and reset position outside of brick
                ball.dx = -ball.dx
                ball.x = brick.x - 8
            
            -- right edge; only check if we're moving left, , and offset the check by a couple of pixels
            -- so that flush corner hits register as Y flips, not X flips
            elseif ball.x + 6 > brick.x + brick.width and ball.dx < 0 then
                
                -- flip x velocity and reset position outside of brick
                ball.dx = -ball.dx
                ball.x = brick.x + 32
            
            -- top edge if no X collisions, always check
            elseif ball.y < brick.y then
                
                -- flip y velocity and reset position outside of brick
                ball.dy = -ball.dy
                ball.y = brick.y - 8
            
            -- bottom edge if no X collisions or top collision, last possibility
            else
                
                -- flip y velocity and reset position outside of brick
                ball.dy = -ball.dy
                ball.y = brick.y + 16
            end

            -- slightly scale the y velocity to speed up the game, capping at +- 150
            if math.abs(ball.dy) < 150 then
                ball.dy = ball.dy * 1.02
            end

            -- only allow colliding with one brick, for corners
            break
        end
        end
    end
        
    -- Every time enough enlargement points have been accumulated,
    -- enlarge the paddle
    if self.paddle.enlargment_points > 750 then
        self.paddle:enlarge()
    end
    
    -- Initiating different flags
    counter = 0
    alive = false

    -- Eliminate balls that go below the paddle
    for k, ball in pairs(balls) do 
        if ball.y >= VIRTUAL_HEIGHT then
            ball.inPlay = false
            ball:reset()
            ball.dx = math.random(-200, 200)
            ball.dy = math.random(-50, -60)
            timer_manyballs = 0
        end
    end

    -- Examine wether there are balls in play
    for k, ball in pairs(balls) do 
        if ball.inPlay == true then
            alive = true
            counter = counter + 1
        end
    end

    -- Restart timer for manyballs Powerup when there is only
    -- one ball left
    if counter == 1 then
        flag = false
        multiball = false
    end

    -- If there are no balls in play reduce health
    if alive == false then
        self.health = self.health - 1
        self.paddle:shrink()
        gSounds['hurt']:play()
    end

    -- If there is no more health, then game over
    if self.health == 0 then
        gStateMachine:change('game-over', {
            score = self.score,
            highScores = self.highScores
        })

    -- If there is, indeed, health remaining but there are no more balls in play,
    -- then serve
    elseif alive == false and self.health > 0 then
        gStateMachine:change('serve', {
            paddle = self.paddle,
            bricks = self.bricks,
            health = self.health,
            score = self.score,
            highScores = self.highScores,
            level = self.level,
            recoverPoints = self.recoverPoints
        })
    end

    -- for rendering particle systems
    for k, brick in pairs(self.bricks) do
        brick:update(dt)
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

end

function PlayState:render()
    -- render bricks
    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    -- render all particle systems
    for k, brick in pairs(self.bricks) do
        brick:renderParticles()
    end

    self.paddle:render()
 
    self.manyballs:render()
    self.key:render()

    for k, ball in pairs(balls) do
        if ball.inPlay then
            ball:render()
        end
    end

    renderScore(self.score)
    renderHealth(self.health)

    -- pause text, if paused
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end

function PlayState:checkVictory()
    for k, brick in pairs(self.bricks) do
        if brick.inPlay then
            return false
        end 
    end

    return true
end