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
        type = 'pot',
        texture = 'pots',
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 14
            }
        },
        frame = 14,
        width = 11,
        height = 11,
        solid = true,

        onCollide = function(self, room, k)
            if not self.used then
                if room.player.direction == 'left' then
                    if room.player.x > self.x + self.width / 2 then
                        room.player.x = self.x + (self.width / 2 + 6)
                    end

                elseif room.player.direction == 'right' then
                    if room.player.x < self.x then
                        room.player.x = self.x - (self.width / 2 + 9)
                    end

                elseif room.player.direction == 'up' then
                    if room.player.y > self.y - self.height / 2 then
                        room.player.y = self.y + (self.height / 2 - 5)
                    end

                elseif room.player.direction == 'down' then
                    if room.player.y < self.y  then
                        room.player.y = room.player.y - (self.height / 2 - 4.5)
                    end
                end

                if love.keyboard.isDown('return') and not room.player.carrying then
                    gSounds['pickup']:play() 
                    room.player:changeState('carry-pot-lift')
                    solid = false
                    self.used = true
                    room.player.carrying = true
                    table.insert(room.objects, Projectile({
                        type = 'pot',
                        texture = 'pots',
                        defaultState = 'unpressed',
                        states = {
                            ['unpressed'] = {
                                frame = 14
                            }
                        },
                        frame = 14,
                        width = 11,
                        height = 11,
                        solid = true,
                        room = room
                    },
                self.x, self.y))
                    table.remove(room.objects, k)
                end
            end
        end

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
            if room.player.health < 5 then
                room.player.health = room.player.health + 2
            elseif room.player.health == 5 then
                room.player.health = room.player.health + 1
            end
            table.remove(room.objects, k)
        end
    }
}