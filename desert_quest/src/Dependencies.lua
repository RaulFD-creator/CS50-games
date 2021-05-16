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
require 'src/StateMachine'

-- Loading main assets
gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
}

