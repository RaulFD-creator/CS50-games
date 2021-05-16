-- Calling main libraries

Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

-- Loading main functions
require 'src/Util'
require 'src/Constants'
require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/PlayState'
require 'src/StateMachine'

-- Loading main assets
gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 44),
    ['huge'] = love.graphics.newFont('fonts/font.ttf', 80)
}

-- Loading main Textures
gTextures = {
    ['backgrounds'] =  {
        ['2'] = love.graphics.newImage('graphics/background.png'),
        ['1'] = love.graphics.newImage('graphics/background2.jpg')
    }
}
