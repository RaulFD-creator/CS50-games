-- Calling main libraries
Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

-- Loading main functions
require 'src/Util'
require 'src/Constants'

-- Loading Play States
require 'src/StateMachine'
require 'src/states/BaseState'
require 'src/states/StartState'

-- Loading Classes


-- Loading Definitions


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
        ['1'] = love.graphics.newImage('graphics/backgrounds/background.jpg'),
        ['2'] = love.graphics.newImage('graphics/backgrounds/background2.png')
    },
    ['character'] = love.graphics.newImage('graphics/character/character_sprite.png'),
}

gFrames = {
    ['character-animations'] = GenerateQuads(gTextures['character'], 224, 112),
    ['background'] = GenerateQuads(gTextures['backgrounds']['2'], 1341, 277)
}

gSounds = {
    ['musics'] = {
        ['title_screen'] = love.audio.newSource('sounds/title_music.wav', 'static'),
        ['play'] = love.audio.newSource('sounds/play_music.wav', 'static')
    }
}

