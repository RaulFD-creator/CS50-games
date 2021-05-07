--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GAME_OBJECT_DEFS = {
    ['switch'] = {
        type = 'switch',
        texture = 'switches',
        frame = 2,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 2
            },
            ['pressed'] = {
                frame = 1
            }
        }
    },
    ['pot'] = {
        -- TODO
    },
    ['heart'] = {
        type = 'heart',
        texture = 'hearts',
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 5
            }
        },
        frame = 5,
        width = 16,
        height = 16,
        solid = true,  

        onCollide = function(self, room, k)
            gSounds['pickup']:play() 
            if room.player.health < 6 then
                room.player.health = room.player.health + 2
            end
            table.remove(room.objects, k)
        end
    }
}