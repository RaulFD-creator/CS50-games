-- Calling main libraries

Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

-- Loading main functions
require 'src/Util'
require 'src/Constants'

-- Loading Play States
require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/PlayState'
require 'src/StateMachine'

-- Loading Classes
require 'src/classes/Entity'

-- Loading Definitions
require 'src/data/entity_defs'

-- Loading Fonts
gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 44),
    ['huge'] = love.graphics.newFont('fonts/font.ttf', 80)
}

-- Loading Textures
gTextures = {
    ['backgrounds'] =  {
        ['2'] = love.graphics.newImage('graphics/background.png'),
        ['1'] = love.graphics.newImage('graphics/background2.jpg')
    }
}

gSounds = {
    ['musics'] = {
        ['title_screen'] = love.audio.newSource('sounds/title_music.wav', 'static'),
        ['play'] = love.audio.newSource('sounds/play_music.wav', 'static')
    }
}
